Write-Host "PWD: $(Get-Location)"
Write-Host "JAVA_HOME=$env:JAVA_HOME"
Write-Host "PATH contains WindowsApps:"; $env:PATH -split ';' | Where-Object { $_ -match 'WindowsApps' }
Write-Host "--- java command ---"
Get-Command java -ErrorAction SilentlyContinue | Format-List *
Write-Host "--- java.exe files ---"
$roots = @('C:\Program Files','C:\Program Files (x86)','C:\Users\MARVIN 256\AppData\Local\Programs','C:\Users\MARVIN 256\AppData\Local\Android','C:\Users\MARVIN 256\AppData\Local\Android\sdk')
foreach ($root in $roots) {
    if (Test-Path $root) {
        Write-Host "SEARCH ROOT: $root"
        Get-ChildItem -LiteralPath $root -Filter java.exe -Recurse -ErrorAction SilentlyContinue | Select-Object -First 50 FullName | ForEach-Object { Write-Host $_.FullName }
    } else {
        Write-Host "MISSING ROOT: $root"
    }
}
Write-Host "--- JDK dirs ---"
$dirs = @('C:\Program Files\Java','C:\Program Files (x86)\Java','C:\Program Files\OpenJDK','C:\Program Files\AdoptOpenJDK','C:\Program Files\Temurin','C:\Program Files\Amazon Corretto','C:\Program Files\Zulu','C:\Users\MARVIN 256\AppData\Local\Programs')
foreach ($dir in $dirs) {
    if (Test-Path $dir) {
        Write-Host "DIR: $dir"
        Get-ChildItem -LiteralPath $dir -Directory -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.Name -match 'jdk|openjdk|temurin|corretto|zulu|microsoft|java' } | Select-Object -First 50 FullName | ForEach-Object { Write-Host $_.FullName }
    }
}
Write-Host "--- Android Studio JBR ---"
$studiopaths = @('C:\Program Files\Android\Android Studio\jbr','C:\Program Files\Android\Android Studio1\jbr')
foreach ($p in $studiopaths) {
    if (Test-Path $p) {
        Write-Host "JBR PATH: $p"
        Get-ChildItem -LiteralPath $p -File -ErrorAction SilentlyContinue | Select-Object Name,Length | ForEach-Object { Write-Host $_.Name $_.Length }
        if (Test-Path (Join-Path $p 'release')) {
            Write-Host "--- release file ---"
            Get-Content -LiteralPath (Join-Path $p 'release') | ForEach-Object { Write-Host $_ }
        }
    }
}
Write-Host "--- HKLM Java registry ---"
$roots = @('HKLM:\SOFTWARE\JavaSoft\Java Development Kit','HKLM:\SOFTWARE\Wow6432Node\JavaSoft\Java Development Kit','HKLM:\SOFTWARE\JavaSoft\Java Runtime Environment','HKLM:\SOFTWARE\Wow6432Node\JavaSoft\Java Runtime Environment')
foreach ($r in $roots) {
    if (Test-Path $r) {
        Write-Host "REG: $r"
        Get-ChildItem $r | ForEach-Object { Get-ItemProperty $_.PsPath | Select-Object PSChildName,JavaHome | ForEach-Object { Write-Host "  $($_.PSChildName): $($_.JavaHome)" } }
    }
}
