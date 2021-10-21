function Unzip([string]$sourceFile, [string]$targetFolder)
{
    if(!(Test-Path $targetFolder))
    {
        mkdir $targetFolder
    }
    $sourceFile = Resolve-Path $sourceFile
    $targetFolder = Resolve-Path $targetFolder
    $shellApp = New-Object -ComObject Shell.Application
    $zipFiles = $shellApp.NameSpace($sourceFile).Items()
    $shellApp.NameSpace($targetFolder).CopyHere($zipFiles, 0x10)
}

if(!(Test-Path "openssl-1.1.1l"))
{
    Unzip "openssl-1.1.1l.zip" "openssl-1.1.1l"
}
