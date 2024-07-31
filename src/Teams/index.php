<?php 
    require_once '../db.php';

    //backend code
    $page_title="Team Formations"; 
    
    $query = "
        SELECT * FROM teams AS TeamFormations
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
        <title>Team Formation List</title>
    </head>

    <body>
    <!-- Title -->
    <h1>Team Formation List</h1>

    <!-- Table -->
    <table border="1">
        <!-- Column Names -->
        <tr>
            <th>Team Name</th>
        </tr>

        <!-- Populate Rows -->
        <?php while($row = $result->fetch_assoc()): ?>
            <tr>
                <!-- Column Values -->
                <td><?=$row['team_name']?></td>

                <!-- Edit and Delete Button -->
                <td>
                    <a href="edit.php?id=<?= $row['id'] ?>">Edit</a>
                    <a href="delete.php?id=<?= $row['id'] ?>">Delete</a>
                </td>
            </tr>
        <?php endwhile; ?>
    </table>
    
    <br>
        <a href="add.php">Add New Team Formation</a>
    </br>

    </body>

</html>