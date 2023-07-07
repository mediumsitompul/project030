<?php
$timezone = "Asia/Jakarta";
if(function_exists('date_default_timezone_set')) date_default_timezone_set($timezone);
?>


<?php
include "connection.php";

$lat = $_POST['lat'];
$lng = $_POST['lng'];
$date = date('Y-m-d');
$time = date('H:i:s');


    if($lat != NULL) {
        $result2 = mysqli_query($conn,
        "insert into t_latlng_static
        (date, time, lat, lng) values ('$date', '$time', '$lat', '$lng') "
        );
        echo json_encode('success');
        }
?>
