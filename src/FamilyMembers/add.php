<?php
include '../db.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $first_name = $_POST['first_name'];
    $last_name = $_POST['last_name'];
    $birthdate = $_POST['birthdate'];
    $SSN = $_POST['SSN'];
    $medicare = $_POST['medicare'];
    $phone_number = $_POST['phone_number'];
    $address = $_POST['address'];
    $city = $_POST['city'];
    $province = $_POST['province'];
    $postal_code = $_POST['postal_code'];
    $email_address = $_POST['email_address'];

    $sql = " 
        INSERT INTO family_members (
            first_name, 
            last_name, 
            birthdate, 
            SSN, 
            medicare, 
            phone_number, 
            address, 
            city, 
            province,
            postal_code, 
            email_address
        )
        VALUES (
            '$first_name',
            '$last_name',
            '$birthdate',
            '$SSN',
            '$medicare',
            '$phone_number', 
            '$address',
            '$city',
            '$province',
            '$postal_code',
            '$email_address'
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
    <title>Add Family Member</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Add New Family Member</h1>
    <form method="POST">
        <label for="first_name">First Name:</label><br>
        <input type="text" id="first_name" name="first_name" value="<?= $table['first_name'] ?>" required><br><br>

        <label for="last_name">Last Name:</label><br>
        <input type="text" id="last_name" name="last_name" value="<?= $table['last_name'] ?>" required><br><br>

        <label for="birthdate">Date of Birth:</label><br>
        <input type="text" id="birthdate" name="birthdate" value="<?= $table['birthdate'] ?>" required><br><br>

        <label for="SSN">SSN:</label><br>
        <input type="text" id="SSN" name="SSN" value="<?= $table['SSN'] ?>" required><br><br>

        <label for="medicare">Medicare #:</label><br>
        <input type="text" id="medicare" name="medicare" value="<?= $table['medicare'] ?>" required><br><br>

        <label for="phone_number">Phone Number:</label><br>
        <input type="text" id="phone_number" name="phone_number" value="<?= $table['phone_number'] ?>" required><br><br>

        <label for="address">Address:</label><br>
        <input type="text" id="address" name="address" value="<?= $table['address'] ?>" required><br><br>

        <label for="city">City:</label><br>
        <input type="text" id="city" name="city" value="<?= $table['city'] ?>" required><br><br>

        <label for="province">Province:</label><br>
        <input type="text" id="province" name="province" value="<?= $table['province'] ?>" required><br><br>

        <label for="postal_code">Postal Code:</label><br>
        <input type="text" id="postal_code" name="postal_code" value="<?= $table['postal_code'] ?>" required><br><br>

        <label for="email_address">Email:</label><br>
        <input type="text" id="email_address" name="email_address" value="<?= $table['email_address'] ?>" required><br><br>


        <input type="submit" value="Add New Family Member">
    </form>
    <br>
        <a href="index.php">Back to Family Member List</a>
    </br>
</body>
</html>