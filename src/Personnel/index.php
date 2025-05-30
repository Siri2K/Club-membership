<!-- Backend code -->
<?php 
    include '../db.php';
    include '../queries.php';

    
    $page_title="Personnel"; 
    
    /* Queries */
    $query = "
        SELECT * FROM personnels AS Personnel
        ORDER BY SSN
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
        <title>Personnel List</title>
    </head>

    <body>
    <!-- Table -->
    <h1>Personnel List</h1>
    <table border="1">
        <!-- Column Names -->
        <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Date of Birth</th>
            <th>SSN</th>
            <th>Medicare #</th>
            <th>Phone #</th>
            <th>Address</th>
            <th>City</th>
            <th>Province</th>
            <th>Postal Code</th>
            <th>Email Address</th>
            <th>Personnel Role</th>
            <th>Mandate</th>
        </tr>

        <!-- Populate Rows -->
        <?php while($row = $result->fetch_assoc()): ?>
            <tr>
                <!-- Column Values -->
                <td><?=$row['first_name']?></td>
                <td><?=$row['last_name']?></td>
                <td><?=$row['birthdate']?></td>
                <td><?=$row['SSN']?></td>
                <td><?=$row['medicare']?></td>
                <td><?=$row['phone_number']?></td>
                <td><?=$row['address']?></td>
                <td><?=$row['city']?></td>
                <td><?=$row['province']?></td>
                <td><?=$row['postal_code']?></td>
                <td><?=$row['email_address']?></td>
                <td><?=$row['personnel_role']?></td>
                <td><?=$row['mandate']?></td>

                <!-- Edit and Delete Button -->
                <td>
                    <a href="edit.php?id=<?= $row['SSN'] ?>">Edit</a>
                    <a href="delete.php?id=<?= $row['SSN'] ?>">Delete</a>
                </td>
            </tr>
        <?php endwhile; ?>
        
        <!-- Add Button -->
        <br>
            <a href="add.php">Add New Personnel</a>
        </br>
        
    </table>

    <!-- Table -->
    <h1>Presidential List</h1>
    <table border="1">
        <!-- Column Names -->
        <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Start Date</th>
            <th>End Date</th>
        </tr>

        <!-- Populate Rows -->
        <?php while($row = $result_query17->fetch_assoc()): ?>
            <tr>
                <!-- Column Values -->
                <td><?=$row['first_name']?></td>
                <td><?=$row['last_name']?></td>
                <td><?=$row['start_date_as_president']?></td>
                <td><?=$row['end_date_as_president']?></td>
            </tr>
        <?php endwhile; ?>
    </table>

    <h1>Volunteer List</h1>
    <table border="1">
        <!-- Column Names -->
        <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Phone Number</th>
            <th>Email Address</th>
            <th>Location</th>
            <th>Role</th>
        </tr>

        <!-- Populate Rows -->
        <?php while($row = $result_query18->fetch_assoc()): ?>
            <tr>
                <!-- Column Values -->
                <td><?=$row['first_name']?></td>
                <td><?=$row['last_name']?></td>
                <td><?=$row['phone_number']?></td>
                <td><?=$row['email_address']?></td>
                <td><?=$row['location_name']?></td>
                <td><?=$row['personnel_role']?></td>
            </tr>
        <?php endwhile; ?>
    </table>
    </body>

</html>