<?php
session_start();

    include("connection.php");
    include("functions.php");


        if($_SERVER['REQUEST_METHOD'] == "POST")
        {
            //something was posted
            $username = $_POST['username'];
            $password = $_POST['password'];

            if(!empty($username) && !empty($password) && !is_numeric($username))
            {

                //save to DataBase
                $userid = random_num(100);
                $query = "insert into users (userid,username,password) values ('$userid','$username','$password')";
                
                mysqli_query($con, $query);

                //header("Location: login.php");
                //die;
            }else
            {
                echo "Please enter valid information";

            }
        }

?>


<!DOCTYPE html>
<html>
    <head>
        <title>Signup</title>
</head>
<body>
    <style type="text/css">
#text{
    height: 25px;
    border-radius: 5px;
    padding: 4px;
    border: solid thing #aaa;    
}
#button{
    padding: 10px;
    width: 100px;
    color: white;
    background-color: lightblue;
    border: none;
}
#box{
    background-color: grey;
    margin: auto;
    width: 300px;
    padding: 20px;
}    

    </style>

    <div id="box">
        <form method="post">
            <div style="font-size: 20px;margin: 10px;">Signup</div>
            
            <input id="text" type="text" name="username"><br><br>
            <input type="password" name="password"><br><br>

            <input id="button" type="submit" value="Signup"><br><br>

            <a href="login.php">Click to Login</a><br><br>
        </form>
    </div>

</body>
</html>

