
  include "conn3.php";
  

  if(isset($_REQUEST["auth"]))
  {
    $authkey = $_REQUEST["auth"];
    if($authkey == "kjgdkhdfldfguttedfgr")

    {
        $json["data"] = array();
        $sql = "SELECT lat, lng FROM t_latlng order by id limit 50";
        $res = mysqli_query($link, $sql);
        $numrows = mysqli_num_rows($res);

        while($array = mysqli_fetch_assoc($res))
        {
          array_push($return["data"], $array);
        }
        mysqli_close($link);
        header('Content-Type: application/json');
    }

        else
        {
        $return["error"] = true;
        $return["msg"] = "Authentication error.";
        }
    }

    else{
        $return["error"]  = true;
        $return["msg"] = "Send auth key.";
        }

    header('Content-Type: application/json');
    echo json_encode($return);
    ?>
