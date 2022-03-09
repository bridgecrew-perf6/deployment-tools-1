param (
    $Source = "C:\Temp" # The location you will copy archives and installers to
)

# Iterate and unzip archives 
Foreach ($Archive in (Get-Item $Source\* -Include "*.zip", "*.7z")) {
    Write-Host "Extracting $(Archive.Basename)..."
    7z e $Archive -y -o"C:\Packerize\"
    # Alternatively, comment the above and uncomment the below if not using 7z
    # Expand-Archive $Archive "C:\Packerize"
}

# Temporarily break IE so no Install can open its manual page and hang the script
takeown /f "C:\Program Files\Internet Explorer\iexplore.exe" /a
Gat-Acl "C:\Program Files\7-Zip\7z.exe" | Set-Acl "C:\Program Files\Internet Explorer\iexplore.exe"
Rename-Item "C:\Program Files\Internet Explorer\iexplore.exe" "C:\Program Files\Internet Explorer\iexplore.exe.bak"

# Iterate and run installs
Foreach ($Install in (Get-Item C:\Packerize\* -Include "*.exe", "*.msi")) {
    Write-Host "Installing $(Install.Basename)..."
    # If .exe, use every possible quiet/silent switch as superfulous swtiches are ignored 
    If ($Install.Extension -eq ".exe") {
        Start-Process $Install -ArgumentList "/q /Q /s /S /quiet /silent /v/qn" -Wait
    }
    # If .msi, only use /q as superfulous switches cause an error
    If ($Install.Extension -eq ".msi") { 
        Start-Process $Install -ArgumentList "/q" -Wait
    }
}

Rename-Item "C:\Program Files\Internet Explorer\iexplore.exe.bak" "C:\Program Files\Internet Explorer\iexplore.exe"
Remove-Item C:\Packerize -Recurse -Force