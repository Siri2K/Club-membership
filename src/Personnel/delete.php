<?php
include '../db.php';


if (isset($_GET['id'])) {
    $id = $_GET['id'];
    
    $sql1 = "DELETE FROM personnels_in_locations WHERE personnel_SSN=$id";

    $sql = "DELETE FROM personnels WHERE SSN=$id";
    
    /* Delete Children */
    if ($conn->query($sql1) === TRUE) {
        ob_start();
    } 
    else {
        echo "Error: " . $sql1 . "<br>" . $conn->error;
    }

    /* Delete Club Member */
    if ($conn->query($sql) === TRUE) {
        ob_start();
        header('Location: index.php');
    } 
    else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
    
}
?>