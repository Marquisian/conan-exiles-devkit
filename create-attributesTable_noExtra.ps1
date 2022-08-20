 
 
 $infile  = "D:\dev\ConanExiles\DT_AttributeSystem.json"
 $outfile = "D:\dev\ConanExiles\DT_AttributeSystem3.json"

 $json = Get-Content $infile | ConvertFrom-Json
 foreach ($row in $json)
 {
    $rownumber = [int]$row.Rowname
    if ($rownumber -eq 0)
    {
        [int]$row.CostPerPoint_2_19121D85471D863F5D89E185442B259F = 1
        [int]$row.RewardPerLevel_5_B3143ACB49D5D4BEBB07AB82D6420E85 = 1
    }
    Else
    {
        [int]$row.CostPerPoint_2_19121D85471D863F5D89E185442B259F = 1
        [int]$row.RewardPerLevel_5_B3143ACB49D5D4BEBB07AB82D6420E85 = 0
    }

    $rownumber += 60
    $row.Rowname = "$($rownumber)"

 }
    
 $outjson = $json | ConvertTo-Json  

 if (test-path -path $outfile) {remove-item -path $outfile}
 $outjson | Out-File $outfile -NoClobber