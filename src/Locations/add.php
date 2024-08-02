<?php
include '../db.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $location_name = $_POST['location_name'];
    $address = $_POST['address'];
    $city = $_POST['city'];
    $province = $_POST['province'];
    $postal_code = $_POST['postal_code'];
    $phone_number = $_POST['phone_number'];
    $web_address = $_POST['web_address'];
    $location_type = $_POST['location_type'];
    $capacity = $_POST['capacity'];

    $sql = " 
        INSERT INTO locations (
            location_name, 
            address, 
            city, 
            province, 
            postal_code, 
            phone_number, 
            web_address, 
            location_type, 
            capacity
        )
        VALUES (
            '$location_name',
            '$address',
            '$city',
            '$province',
            '$postal_code',
            '$phone_number', 
            '$web_address',
            '$location_type',
            '$capacity'
        )";
    if ($conn->query($sql) === TRUE) {
        header('Location: index.php');
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Location</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Add New Location</h1>
    <form method="POST">
        <label for="location_name">Name:</label><br>
        <input type="text" id="location_name" name="location_name" value="<?= $table['location_name'] ?>" required><br><br>

        <label for="address">Address:</label><br>
        <input type="text" id="address" name="address" value="<?= $table['address'] ?>" required><br><br>

        <label for="City">City:</label><br>
        <input type="text" id="city" name="city" value="<?= $table['city'] ?>" required><br><br>

        <label for="province">Province:</label><br>
        <input type="text" id="province" name="province" value="<?= $table['province'] ?>" required><br><br>

        <label for="postal_code">Postal Code:</label><br>
        <input type="text" id="postal_code" name="postal_code" value="<?= $table['postal_code'] ?>" required><br><br>

        <label for="phone_number">Phone Number:</label><br>
        <input type="text" id="phone_number" name="phone_number" value="<?= $table['phone_number'] ?>" required><br><br>

        <label for="web_address">Web Address:</label><br>
        <input type="text" id="web_address" name="web_address" value="<?= $table['web_address'] ?>" required><br><br>

        <label for="location_type">Type:</label><br>
        <input type="text" id="location_type" name="location_type" value="<?= $table['location_type'] ?>" required><br><br>

        <label for="capacity">Capacity:</label><br>
        <input type="text" id="capacity" name="capacity" value="<?= $table['capacity'] ?>" required><br><br>


        <input type="submit" value="Add Location">
    </form>
    <br>
        <a href="index.php">Back to Location List</a>
    </br>
</body>
</html>