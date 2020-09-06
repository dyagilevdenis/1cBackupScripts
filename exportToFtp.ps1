set-alias sz "$env:ProgramFiles\7-Zip\7z.exe" 

# var
$temporaryFolder = "C:\1cTemporary" 
$base = "E:\восстановление 1с\Fregat\Base\WorkBase 1Cv7"
$name = "1cbase $((Get-Date).toString("yyyy-MM-dd HH-mm"))"

$zipName = "$($name).zip"
$zipPath = "$($temporaryFolder)\$($zipName)"

$textFile = "$($name)OK.txt"
$textPath = "$($temporaryFolder)\$($textFile)"

sz a -tzip $zipPath $base -mx3 -ssw
New-Item $textPath

#ftp 
 
$ftp = "ftp://192.168.1.60/files/" 
$user = ""
$pass = ""
 
$webclient = New-Object System.Net.WebClient 
 
$webclient.Credentials = New-Object System.Net.NetworkCredential($user,$pass)  
 
$uri = New-Object System.Uri($ftp+$zipName) 
$webclient.UploadFile($uri, $zipPath ) 
 
$uri2 = New-Object System.Uri($ftp+$textFile) 
$webclient.UploadFile($uri2, $textPath ) 

# Clear

Remove-Item -Path $zipPath -Force
Remove-Item -Path $textPath -Force
