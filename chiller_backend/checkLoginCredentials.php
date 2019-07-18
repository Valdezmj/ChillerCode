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

$sql = "SELECT * FROM Users where username='$username' and password='$password'";
#echo "SQL<br>";
#echo $sql;
#echo "<br><br>";
$result = $conn->query($sql);
if ($result->num_rows == 1) {
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
