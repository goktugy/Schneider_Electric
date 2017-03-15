
$Today=(Get-Date).ToString('_dd_MM_yyyy')

$source = 'C:\SchneiderElectricData\OASyS\Servers\DNA\RealTimeOGXTesting\Log' 

$logFiles = Get-ChildItem $source

$destination = "C:\SchneiderElectricData\OASyS\Servers\DNA\RealTimeOGXTesting\Log" 

foreach ($logFile in $logFiles){
          
          $Rename_File= $logFile.Name.Substring(0,$logFile.Name.length - 15)  
          if(-Not $logFile.name.StartsWith("TestReport")) 
               {$Rename_File=$Rename_File+$Today+".log"}
          else
              {$Rename_File=$Rename_File+$Today+".csv"} 

          $Destination_File=$destination+"\"+$logFile.Name
          Rename-Item $Destination_File $Rename_File
 }

$temporary="C:\tmp\Automation_Logs"+$Today+".zip";
$destination_zip= $destination+"\"+"Automation_Logs"+$Today+".zip";

If(Test-path $destination_zip) {Remove-item $destination_zip}

If(Test-path $temporary) {Remove-item $temporary}

Add-Type -assembly "system.io.compression.filesystem"

[io.compression.zipfile]::CreateFromDirectory($source, $temporary)
 
Copy-Item $temporary $destination_zip