<?php
$servername = "baymaar.com";
$username = "marlie_admin";
$password = "l0rdl0rd";
$dbname = "marlie_baymaar";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 
#mysql_connect("baymaar.com","marlie_admin","l0rdl0rd");
#mysql_select_db("marlie_baymaar");

$username = $_POST["username"];
$password = $_POST["password"];#TODO salt the passwd
$password = md5(md5("suckit".$password."hackers"));
$email    = $_POST["email"];
$first    = $_POST["firstname"];
$last     = $_POST["lastname"];
$day      = $_POST["day"];
$month    = $_POST["month"];
$year     = $_POST["year"];
$active   = $_POST["active"];

$sql = "INSERT INTO Users (username,password,email,first_name,last_name,dob_day,dob_month,dob_year,active) VALUES ('$username','$password','$email','$first','$last','$day','$month','$year','$active')";

#echo "SQL<br>";
#echo $sql;
#echo "<br><br>";

if ($conn->query($sql) === TRUE) {
    #echo "New record created successfully";
    $response = ["result" => "1"];
    echo json_encode($response);
} else {
    $response = ["result" => "0"];
    echo json_encode($response);
    #echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
