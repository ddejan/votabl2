Write-Host "Enter jtwist to continue..."
$foo = Read-Host
if ($foo -ne "jtwist")
{
	Write-Host "Nope!"
	exit
} 

$m = azure account list | where { $_.Contains("4040ae04-b877-412d-b6cf-c38e7cd8dbb0") } | measure

if ($m.Count -eq 0) {
	azure account import %HOMEPATH%/Downloads/build.publishsettings
}

$svc = 'votabl2'

$l = azure mobile list | where { $_.Contains($svc) } | measure

if ($l.Count -gt 0) {
	azure mobile delete -q -d $svc
} 

cd ..

git reset --hard
git clean --force

cd setup

start -WorkingDirectory ..\client\html -ArgumentList "-p 8080" http-server

xcopy .\images $HOME\Pictures\ /Y

rm -Recurse -Force c:\temp\votabl2