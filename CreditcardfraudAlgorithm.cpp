#include <iostream>
#include <cmath>
using namespace std;

float calculateSD(float data[]);

int main() {
    int i;
    float data[5];
    float sum = 0.0;
    float mean;
    
    cout << "Enter 5 purchases: ";
    for (i = 0; i < 5; ++i) { // calculates mean/average
        cin >> data[i];
    }
  
    for (i = 0; i < 5; ++i) {
        sum += data[i];
    }

    mean = sum / 5;

    cout << endl << "Mean/Average = " << mean;
    cout << endl << "Standard Deviation = " << calculateSD(data);
   

    if (((data[i]) < (mean - (calculateSD(data) * 2))) || (data[i]) > (mean + (calculateSD(data) * 2))) //determining if 2 standard deviations to left or right of mean/average is prevalent 
    {
        cout << endl << "Fraudulent Activity Has Been Detected";
    }

    return 0;
}


float calculateSD(float data[]) {   //calculate standard deviation 
    float sum = 0.0, mean, standardDeviation = 0.0;
    int i;

    for (i = 0; i < 5; ++i) {
        sum += data[i];
    }

    mean = sum / 5;

    for (i = 0; i < 5; ++i) {
        standardDeviation += pow(data[i] - mean, 2);
    }

    return sqrt(standardDeviation / 5);

   
}
