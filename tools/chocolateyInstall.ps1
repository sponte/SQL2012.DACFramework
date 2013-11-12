$package = 'SQL2012.DACFramework'

try {
  $params = @{
    packageName = $package;
    fileType = 'msi';
    silentArgs = '/quiet';
    url = 'http://download.microsoft.com/download/9/2/C/92CBE583-5250-4AFD-A87A-DA707065CB9E/ENU/x86/DACFramework.msi';
    url64bit = 'http://download.microsoft.com/download/9/2/C/92CBE583-5250-4AFD-A87A-DA707065CB9E/ENU/x64/DACFramework.msi';
  }

  Install-ChocolateyPackage @params

  # install both x86 and x64 editions of SMO since x64 supports both
  # to install both variants of powershell, both variants of SMO must be present
  $IsSytem32Bit = (($Env:PROCESSOR_ARCHITECTURE -eq 'x86') -and `
    ($Env:PROCESSOR_ARCHITEW6432 -eq $null))
  if (!$IsSytem32Bit)
  {
    $params.url64bit = $params.url
    Install-ChocolateyPackage @params
  }

  Write-ChocolateySuccess $package
} catch {
  Write-ChocolateyFailure $package "$($_.Exception.Message)"
  throw
}
