 
 
 $infile  = "D:\dev\ConanExiles\DT_ExperienceSystemLevel.json"
 $outfile = "D:\dev\ConanExiles\DT_ExperienceSystemLevel2.json"

 $json = Get-Content $infile | ConvertFrom-Json
 foreach ($row in $json)
 {
    $rownumber = [int]$row.Rowname
    $rownumber += 60
    $row.Rowname = "$($rownumber)"
    # just get the last value of the row (we only need the very last one..)
    $lastvalue =  $row.LevelEnd_6_6DE74A5048197309D14E318BF1A70E8E
 }
    
 $outjson = $json | ConvertTo-Json  

 if (test-path -path $outfile) {remove-item -path $outfile}
 $outjson | Out-File $outfile -NoClobber

# let's load the file again to edit it:
$infile = "D:\dev\ConanExiles\DT_ExperienceSystemLevel2.json"
$outfile = "D:\dev\ConanExiles\DT_ExperienceSystemLevel3.json"
$csvfile = "D:\dev\ConanExiles\newexperiencelevels.csv"

$json = Get-Content $infile | ConvertFrom-Json

# let's get the new values too:
$exp = import-csv -Path $csvfile -Delimiter ";"

foreach ($row in $json)
{
   $newvaluestart = $exp | where-object rowname -eq $row.rowname | select-object LevelStart_3_AA3E06CB4FFAD3E976865EA2C0357977 -ExpandProperty LevelStart_3_AA3E06CB4FFAD3E976865EA2C0357977
   $newvalueEnd = $exp | where-object rowname -eq $row.rowname | select-object LevelEnd_6_6DE74A5048197309D14E318BF1A70E8E -ExpandProperty LevelEnd_6_6DE74A5048197309D14E318BF1A70E8E

   write-host "$($newvaluestart) - $($newvalueEnd)"

   # here we need to put the lastvalue recorded:
   if ($row.Rowname -eq "61")
   {
      $row.LevelStart_3_AA3E06CB4FFAD3E976865EA2C0357977 = [int]$lastvalue
   }
   else
   {
      $row.LevelStart_3_AA3E06CB4FFAD3E976865EA2C0357977 = [int]$newvaluestart
   }
   
   $row.LevelEnd_6_6DE74A5048197309D14E318BF1A70E8E   = [int]$newvalueEnd
}

$outjson = $json | ConvertTo-Json 
if (test-path -path $outfile) {remove-item -path $outfile}
$outjson | Out-File $outfile -NoClobber
