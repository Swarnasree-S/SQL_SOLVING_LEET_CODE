<?php

ob_start();
require_once('includes/load.php');
include_once('connection/CurlClient.php');
//require_once('Influxconn.php');

date_default_timezone_set("Asia/Kolkata");
$day = date('d');
//$day = "03";
$month = date('m');
$year = date('y');
$yearFull = date('Y');
$totalDays = getDaysOfMonth($month,$yearFull);
if($day == $totalDays){$nextday = 01;$nextmonth = $month+1;}else{$nextday = $day + 1; $nextmonth = $month;}
$tsStarting = $yearFull."-".$month."-".$day;
$tsEnding=$yearFull."-".$nextmonth."-".$nextday;
$tsStartingTimestamp = strtotime($tsStarting);
$tsEndingTimestamp = strtotime($tsEnding);

function getPassword($plantid)
{
	$Influxdata = find_by_plantid('influxdbdata',$plantid);
	return $Influxdata['password'];
}
function getinfluxdbname($plantid)
{
	$Influxdata = find_by_plantid('influxdbdata',$plantid);
	return $Influxdata['dbname'];
}
function getInvData($dataloggerid,$plantid,$did,$field,$tsStartingTimestamp,$tsEndingTimestamp,$option)
{
	$url = "https://influxdb.renewgrid.in/query";
	$username = "";
	$password = getPassword($plantid);
	$influxdb = getinfluxdbname($plantid);
	$query = "SELECT last(value) FROM wattmon_std_mv WHERE (\"dlid\"='".$dataloggerid."' AND \"did\"='".$did."' AND \"f\"='".$field."') AND time > ".$tsStartingTimestamp."s AND time < ".$tsEndingTimestamp."s group by time(1d),did fill(null) tz('Asia/Kolkata');";
	$curlClient = new CurlClient($url, $username, $password);
	$data = array(
	'db' => $influxdb,
	'q' => $query
	);
	$response = $curlClient->post($data);
	
			// Decode JSON data
			$influx_results = json_decode($response, true);
			//print_r($influx_results);exit;
		// Initialize an array to store time-based rows
		$rows = [];
			// Iterate through each series
			foreach ($influx_results['results'] as $statement_id => $statements) {
				if(count($statements['series']) != 0){
					foreach ($statements['series'] as $series) {
						//$series_name = $series['tags']['dlid']. '_' . $series['tags']['did']. '_' .$series['tags']['f'];
						// Iterate through the values
						foreach ($series['values'] as $value) {
								 $time = $value[0];
								 $mean = $value[1];
								// Create a new row if the time doesn't exist
								if (!isset($rows[$time])) {
									$rows['time'] = $time;
								}
								// Add the series data to the corresponding time row
								$rows[$time]['value'] = $mean;
								//print_r($rows);exit;
								$date1 = explode('T',$rows['time']);
								$date2 = explode('+',$date1[1]);
								$currDate =strtotime($date1[0]);
								$dayEnergy =  $mean;
								if($option=='time'){
									return date('d-M-Y',$currDate).' '.$date2[0];
									
								}elseif($option=='data'){
									
									return $dayEnergy; 
								}
						
					}
					
				}

			}	
	}
}	
//plant information 
$plantsql = "select p.plantid, p.name,p.orgId,d.devicetype,d.devicename,d.Capacity,d.dataloggerid from plantinfo as p INNER JOIN deviceinfo as d ON p.plantid =d.plantid where d.devicename='Inverter' order by d.plantid asc";
$plantDetails = find_by_sql($plantsql);	
//print_r($plantDetails);exit;
foreach($plantDetails as $plantinfo)
{
	$dataloggerid = $plantinfo['dataloggerid'];
	$devicename = $plantinfo['devicename'];
	$deviceType = $plantinfo['devicetype'];
	$plantId =  $plantinfo['plantid'];
	$orgid = $plantinfo['orgId'];
	$plantName = $plantinfo['name'];
	$capacity = $plantinfo['Capacity'];
	$url = "https://influxdb.renewgrid.in/query";
	$username = "";
	$password = getPassword($plantId);
	$influxdb = getinfluxdbname($plantId);
	$lastComm = getInvData($dataloggerid,$plantId,$deviceType,'AC_Active_Power',$tsStartingTimestamp,$tsEndingTimestamp,'time');
	$currDate = strtotime($lastComm);
	$invCurrent01 =getInvData($dataloggerid,$plantId,$deviceType,'AC_Current_A',$tsStartingTimestamp,$tsEndingTimestamp,'data');
	$invCurrent02 = getInvData($dataloggerid,$plantId,$deviceType,'AC_Current_B',$tsStartingTimestamp,$tsEndingTimestamp,'data');
	$invCurrent03 = getInvData($dataloggerid,$plantId,$deviceType,'AC_Current_C',$tsStartingTimestamp,$tsEndingTimestamp,'data');
	$totalInvCurrent = number_format((($invCurrent01+$invCurrent02+$invCurrent03)/3),1);
	$sql ="SELECT createddate,plantid FROM `invreport` WHERE `devicetype`='{$deviceType}' AND  plantid = '{$plantId}' AND createddate='{$currDate}' ORDER BY `createddate` DESC LIMIT 1";
	$plnGenDetails = find_by_sql($sql);
	$plantDate = $plnGenDetails[0]['createddate'];
	$invplantId = $plnGenDetails[0]['plantid'];
	if($currDate!=$plantDate){	
		$insertQuery="INSERT INTO invreport(plantid,orgid,plantname,dataloggerid,devicename,devicetype,current,createddate)
		VALUES ('{$plantId}','{$orgid}','{$plantName}','{$dataloggerid}','{$devicename}','{$deviceType}','{$totalInvCurrent}','{$currDate}')";
		if($db->query($insertQuery)){
			echo "succssfully inserted";
		} else{
			echo "Something went wrong. Please try again later.";
		} 
	}
	 else{ 
		$updateQuery="UPDATE invreport SET current= '{$totalInvCurrent}' WHERE devicetype ='{$deviceType}' AND plantid = '{$plantId}' and createddate='{$currDate}'"; 
		if($db->query($updateQuery)){
			echo "succssfully Updated";
		} else{
			echo "Something went wrong. Please try again later.";
		}
	}
						
}			
$curlClient->close();				
?>
