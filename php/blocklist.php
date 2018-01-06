<?php

include('IP2CIDR.php');

$URL1='http://list.iblocklist.com/?list=ydxerpxkpcfqjaybcssw&fileformat=p2p&archiveformat=gz';
$ch = curl_init($URL1);
$fp = fopen("level1.p2p.gz", "w");

curl_setopt($ch, CURLOPT_FILE, $fp);
curl_setopt($ch, CURLOPT_HEADER, 0);
curl_setopt($ch, CURLOPT_TIMEOUT, 300);
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
curl_setopt($ch, CURLOPT_MAXREDIRS, 10);

curl_exec($ch);
#print curl_getinfo($ch, CURLINFO_HTTP_CODE)."\n";
#print curl_errno($ch)."\n";
#print curl_error($ch);
curl_close($ch);
fclose($fp);

$fp = gzopen("level1.p2p.gz", "r");
$fpout = fopen('level1.p2p', "w");
while($data = fread($fp, 64 * 1024)) {
  fwrite($fpout, $data);
}
gzclose($fp);
fclose($fpout);

$fp = fopen('level1.p2p', "r");
$ip2cidr = new IP2CIDR();
$regex='/(.*):(\d+.\d+.\d+.\d+\-\d+.\d+.\d+.\d+)$/';
while($line = fgets($fp)) {
  $lnew = preg_replace('/\r/','',$line);
  $line = $lnew;
  $order = array('\r\n','\n','\r');
  $lnew = str_replace($order,'',$line);
  $line = $lnew;
  if(substr($line,0,1)!='#'&&strlen($line)>0) {
    $m=preg_match($regex, $line, $matches);
    if($m==1) {
      $range=$matches[2];
    #  print "matches[1]=".$matches[1]."\n";
      #  print "matches[2]=".$matches[2]."\n";
      $regex2='/(\d+.\d+.\d+.\d+)\-(\d+.\d+.\d+.\d+)/';
      preg_match($regex2, $range, $r);
      $rs=$r[1];$re=$r[2];
      $arr_cidr = $ip2cidr->solveCIDR($rs,$re);
      foreach ($arr_cidr as &$cidr) {
        print $cidr."\n";
      }
    } else {
      #print "NOMATCH \"".$line."\"\n";
    }
  }
}
?>

