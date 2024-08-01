<?php
include '../db.php';


if (isset($_GET['id'])) {
    $id = $_GET['id'];
    
    $sql1 = "DELETE FROM family_enrolled_in_locations WHERE family_SSN=$id";
    $sql2 = "DELETE FROM family_enrolled_members WHERE family_SSN=$id";
    $sql3 = "DELETE FROM secondary_family_members WHERE family_SSN=$id";
    
    $sql = "DELETE FROM family_members WHERE SSN=$id";
    
    /* Delete Children */
    if ($conn->query($sql1) === TRUE) {
        ob_start();
    } 
    else {
        echo "Error: " . $sql1 . "<br>" . $conn->error;
    }

    if ($conn->query($sql2) === TRUE) {
        ob_start();
    } 
    else {
        echo "Error: " . $sql2 . "<br>" . $conn->error;
    }

    if ($conn->query($sql3) === TRUE) {
        ob_start();
    } 
    else {
        echo "Error: " . $sql3 . "<br>" . $conn->error;
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