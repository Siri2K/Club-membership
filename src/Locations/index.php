<!-- Backend code -->
<?php 
    include '../db.php';

    
    $page_title="Locations"; 
    
    /* Queries */
    $query = "
        SELECT * FROM locations AS Locations
        ORDER BY location_id
    ";
    
    /* Results */
    $result = $conn->query($query);
?>


<!DOCTYPE html>
<html lang="en">
    <!-- Return Home Button -->
    <div class="w3-top">
        <div class="w3-bar w3-red w3-card w3-center-align w3-large">
            <a href="../" class="w3-bar-item w3-button w3-padding-large w3-white">Home</a>
        </div>
    </div>

    <head>
        <meta charset="UTF-8">
        <title>Location List</title>
    </head>

    <body>
    <!-- Title -->
    <h1>Location List</h1>

    <!-- Table -->
    <table border="1">
        <!-- Column Names -->
        <tr>
            <th>ID</th>
            <th>Location Names</th>
            <th>Address</th>
            <th>City</th>
            <th>Province</th>
            <th>Postal-code</th>
            <th>Phone number</th>
            <th>Web address</th>
            <th>Type </th>
            <th>Capacity</th>
        </tr>

        <!-- Populate Rows -->
        <?php while($row = $result->fetch_assoc()): ?>
            <tr>
                <!-- Column Values -->
                <td><?=$row['location_id']?></td>
                <td><?=$row['location_name']?></td>
                <td><?=$row['address']?></td>
                <td><?=$row['city']?></td>
                <td><?=$row['province']?></td>
                <td><?=$row['postal_code']?></td>
                <td><?=$row['phone_number']?></td>
                <td><?=$row['web_address']?></td>
                <td><?=$row['location_type']?></td>
                <td><?=$row['capacity']?></td>

                <!-- Edit and Delete Button -->
                <td>
                    <a href="edit.php?id=<?= $row['location_id'] ?>">Edit</a>
                    <a href="delete.php?id=<?= $row['location_id'] ?>">Delete</a>
                </td>
            </tr>
        <?php endwhile; ?>
        
        <!-- Add Button -->
        <br>
            <a href="add.php">Add New Location</a>
        </br>
    </table>
    </body>

</html>