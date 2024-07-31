<?php 
    require_once '../db.php';

    //backend code
    $page_title="Locations"; 
    
    $query = "
        SELECT * FROM locations AS Locations
        ORDER BY province,city ASC
    ";
    
    
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
            <th>Location Name</th>
        </tr>

        <!-- Populate Rows -->
        <?php while($row = $result->fetch_assoc()): ?>
            <tr>
                <!-- Column Values -->
                <td><?=$row['location_name']?></td>

                <!-- Edit and Delete Button -->
                <td>
                    <a href="edit.php?id=<?= $row['id'] ?>">Edit</a>
                    <a href="delete.php?id=<?= $row['id'] ?>">Delete</a>
                </td>
            </tr>
        <?php endwhile; ?>
    </table>
    
    <br>
        <a href="add.php">Add New Location</a>
    </br>

    </body>

</html>