using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using System;

namespace KMeans
{
    class KMeans
    {

        static void Main(string[] args)
        {

            #region Setup 
            string[] Location =
            new string[] { "Transaction Amount", "Location" };


            //Tenp place holder for db instertion
            double[][] dataFrame = new double[20][];

            dataFrame[0] = new double[] { 75, 1 };
            dataFrame[1] = new double[] { 21, 1 };
            dataFrame[2] = new double[] { 91, 1 };
            dataFrame[3] = new double[] { 65, 1 };
            dataFrame[4] = new double[] { 185, 2 };
            dataFrame[5] = new double[] { 113, 2 };
            dataFrame[6] = new double[] { 185, 1 };
            dataFrame[7] = new double[] { 60, 1 };
            dataFrame[8] = new double[] { 11, 1 };
            dataFrame[9] = new double[] { 90, 1 };
            dataFrame[10] = new double[] { 115, 1 };
            dataFrame[11] = new double[] { 225, 2 };
            dataFrame[12] = new double[] { 42, 2 };
            dataFrame[13] = new double[] { 185, 1 };
            dataFrame[14] = new double[] { 32, 1 };
            dataFrame[15] = new double[] { 550, 2 };
            dataFrame[16] = new double[] { 42, 1 };
            dataFrame[17] = new double[] { 750, 2 };
            dataFrame[18] = new double[] { 17.50, 1 };
            dataFrame[19] = new double[] { 75, 1 };
            #endregion

            //show the user the data
            Console.WriteLine("Transaction Data:\tTransaction Amount\tLocation");
            PrintDataFrame(dataFrame);

            #region Cluster Setup //setup clustering config - # attributes, # clusters, and # iterations
            int numClusters = 2;    //either fraud or no fraud, right? (or here or not here)
            int numAttributes = Location.Length;
            int maxIterations = 100;
            #endregion

            //Begin clustering data with k = {0} and iterations <= {1}


            int[] clustering = Cluster(dataFrame, numClusters, maxIterations, numAttributes);

            //Clustering formatting 
            ShowVector(clustering);
            ShowClustering(dataFrame, numClusters, clustering);





            Console.ReadLine();

        }

        private static void ShowClustering(double[][] dataFrame, int numClusters, int[] clustering)
        {

            for (int x = 0; x < numClusters; x++)   //display each cluster
            {
                for (int y = 0; y < dataFrame.Length; y++)  //display each transaction within a cluster
                {
                    if (clustering[y] == x) //current transaction y belongs to current cluster x
                    {
                        Console.Write("[{0}]\t", y.ToString().PadLeft(2));
                        for (int z = 0; z < dataFrame[y].Length; z++)
                            Console.Write(dataFrame[y][z].ToString("F1").PadLeft(6) + " ");
                        Console.WriteLine("");
                    }
                }
            }


        }

        private static void ShowVector(int[] vector)
        {
            for (int i = 0; i < vector.Length; i++)
                Console.Write(vector[i] + " ");

        }

        static void PrintDataFrame(double[][] dataframe)
        {
            for (int i = 0; i < dataframe.Length; i++)
            {
                //this basically is our indexer: 0, 1, 2...
                Console.Write("[{0}]\t", i.ToString().PadLeft(2));

                //this loops through all attributes j within index i (amount/location)
                for (int j = 0; j < dataframe[i].Length; j++)
                {
                    Console.Write("\t" + dataframe[i][j].ToString("F1") + "  ");
                }
            }
        }


        static int[] Cluster(double[][] data, int numClusters, int maxIterations, int numAttributes)
        {
            bool isChanged = true;  //we use this to tell if we hit min mean prior to maxIterations
            int count = 0;          // while (count <= maxCount)


            int[] clustering = InitializeCluster(data.Length, numClusters);


            double[][] means = Allocate(numClusters, numAttributes);
            double[][] centroids = Allocate(numClusters, numAttributes);

            //after allocating space for the arrays, update the means and the centroids
            UpdateMeans(data, clustering, means);
            UpdateCentroids(data, clustering, means, centroids);

            while (isChanged && count < maxIterations)
            {
                count++;
                isChanged = Assign(data, clustering, centroids);

                //update means and centroids with new clustering
                UpdateMeans(data, clustering, means);
                UpdateCentroids(data, clustering, means, centroids);
            }

            return clustering;
        }


        private static bool Assign(double[][] data, int[] clustering, double[][] centroids)
        {
            int numClusters = centroids.Length; //there are as many clusters as there are centers of clusters
            bool wasChanged = false; 

            double[] distances = new double[numClusters];
            for (int i = 0; i < data.Length; i++)
            {
                for (int k = 0; k < numClusters; k++)
                    distances[k] = Distance(data[i], centroids[k]);

                int newCluster = MinIndex(distances);

                //Assigned to different cluster?
                if (newCluster != clustering[i])
                {
                    wasChanged = true;
                    clustering[i] = newCluster;
                }
            }

            return wasChanged;
        }

        private static int MinIndex(double[] distances)
        {
            int index = 0;
            double shortestDistance = distances[0];

            for (int i = 0; i < distances.Length; i++)
            {
                if (distances[i] < shortestDistance)
                {
                    shortestDistance = distances[i];
                    index = i;
                }
            }

            return index;
        }

        private static void UpdateCentroids(double[][] data, int[] clustering, double[][] means, double[][] centroids)
        {
            //update all centroids by calling helper that updates individual centroids. 
            for (int k = 0; k < centroids.Length; k++)
            {
                double[] centroid = ComputeCentroid(data, clustering, k, means);
                centroids[k] = centroid;
            }
        }


        private static double[] ComputeCentroid(double[][] data, int[] clustering, int currentCluster, double[][] means)
        {
            int numAttributes = means[0].Length;
            double[] centroid = new double[numAttributes];
            double minDistance = double.MaxValue;

            for (int i = 0; i < data.Length; i++)   //goes through eachtransaction
            {
                int c = clustering[i];  //if the current transaction isn't in our current cluster, continue
                if (c != currentCluster) continue;

                double currentDistance = Distance(data[i], means[currentCluster]);

                if (currentDistance < minDistance)
                {
                    //best centroid
                    minDistance = currentDistance;

                    for (int j = 0; j < centroid.Length; j++)
                        centroid[j] = data[i][j];
                }
            }

            return centroid;
        }


        private static double Distance(double[] dataRow, double[] clusterMean)
        {
            double sumSquaredDif = 0.0;
            for (int i = 0; i < dataRow.Length; i++)
                sumSquaredDif += Math.Pow((dataRow[i] - clusterMean[i]), 2);

            return Math.Sqrt(sumSquaredDif);
        }

        private static void UpdateMeans(double[][] data, int[] clustering, double[][] means)
        {
            int numClusters = means.Length;

            //put in zeroes for each mean
            for (int j = 0; j < means.Length; j++)
                for (int k = 0; k < means[j].Length; k++)
                    means[j][k] = 0.0;

            //array to hold the count of transactions in each cluster
            int[] clusterCounts = new int[numClusters];

            //loop through each transaction 
            for (int i = 0; i < data.Length; i++)
            {
                int currentCluster = clustering[i];
                clusterCounts[currentCluster]++;

                for (int j = 0; j < data[i].Length; j++)
                    means[currentCluster][j] += data[i][j];
            }

            //now that we have the sum, divide by the count ina  cluster to get the mean
            for (int j = 0; j < means.Length; j++)
                for (int k = 0; k < means[j].Length; k++)
                    means[j][k] /= clusterCounts[k];

            return;
        }


        private static double[][] Allocate(int numClusters, int numAttributes)
        {
            double[][] result = new double[numClusters][];

            for (int k = 0; k < numClusters; k++)
                result[k] = new double[numAttributes];

            return result;
        }

        private static int[] InitializeCluster(int numTransaction, int numClusters)
        {
            int randomSeed = (int)DateTime.Now.ToFileTime();
            Random randomInt = new Random(randomSeed);
            int[] cluster = new int[numTransaction];

            //assign transaction
            for (int i = 0; i < numClusters; i++)
                cluster[i] = i;

            //now assign the rest randomly
            for (int i = numClusters; i < cluster.Length; i++)
                cluster[i] = randomInt.Next(0, numClusters);

            return cluster;
        }
    }
}