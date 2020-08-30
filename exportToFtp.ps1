set-alias sz "$env:ProgramFiles\7-Zip\7z.exe" 

$base = "E:\восстановление 1с\Fregat\Base\WorkBase 1Cv7"
$temporaryFolder = "C:\1cTemporary" 
$zipName = "1cbase $((Get-Date).toString("yyyy-MM-dd HH-mm")).zip"
$zipPath = "$($temporaryFolder)\$($zipName)"
sz a -tzip $zipPath $base -mx3 -ssw

# Auth
$Username = "temp"
$Password = "@132456!"

# Files/Paths
$LatestTextFile = $zipPath
$RemoteFile = "ftp://192.168.1.60/files/$($zipName)"

# Create FTP Request Object
$FTPRequest = [System.Net.FtpWebRequest]::Create("$RemoteFile")
$FTPRequest = [System.Net.FtpWebRequest]$FTPRequest
$FTPRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
$FTPRequest.Credentials = new-object System.Net.NetworkCredential($Username, $Password)
$FTPRequest.UseBinary = $true
$FTPRequest.UsePassive = $true
# Read the File for Upload
$FileContent = Get-Content -Encoding Byte -Path $LatestTextFile.FullName
$FTPRequest.ContentLength = $FileContent.Length
# Get Stream Request by bytes
$Run = $FTPRequest.GetRequestStream()
$Run.Write($FileContent, 0, $FileContent.Length)
# Cleanup
$Run.Close()
$Run.Dispose()