<?php
    // Concordia Server Database
    $server = 'hoc353.encs.concordia.ca';
    $userName = 'hoc353_1';
    $password = 'databas3';
    $databaseName = 'hoc353_1';
    
    // Setup Database Connection
    $conn = new mysqli($server, $userName, $password, $databaseName);
    $message = "";
    if ($conn->connect_error) {
        $message = "Connection failed: " . $conn->connect_error;
        die(message);
    }
    else{
        $message = "Connection Successful";
    }
?>