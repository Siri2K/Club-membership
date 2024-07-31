<?php 
    require_once '../db.php';

    //backend code
    $page_title="Sessions"; 
    $query = 'SELECT * FROM sessions AS sessions';
    $statement = $conn->query($query);
?>


<!DOCTYPE html>
<html>
    <div class="w3-top">
        <div class="w3-bar w3-red w3-card w3-center-align w3-large">
            <a href="../" class="w3-bar-item w3-button w3-padding-large w3-white">Home</a>
        </div>
    </div>
<body>

</body>

</html>