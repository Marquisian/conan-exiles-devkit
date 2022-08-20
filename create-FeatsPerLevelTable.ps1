 
 $infile  = "D:\dev\ConanExiles\DT_FeatsPerLevel.json"
 $outfile = "D:\dev\ConanExiles\DT_FeatsPerLevel2.json"

 $json = Get-Content $infile | ConvertFrom-Json
 foreach ($row in $json)
 {
    $rownumber = [int]$row.Rowname
    $rownumber += 60
    $row.Rowname = "$($rownumber)"
 }
    
 $outjson = $json | ConvertTo-Json  

 if (test-path -path $outfile) {remove-item -path $outfile}
 $outjson | Out-File $outfile -NoClobber