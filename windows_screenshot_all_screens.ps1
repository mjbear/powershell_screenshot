# @author: Michael Bear
# @date: 2024/10/03
#        2024/10/15 - updated to open destination directory
#
# Inspired by an itprotoday.com post
# ref: https://www.itprotoday.com/powershell/powershell-screen-capture-how-to-automate-screenshots-in-your-scripts
#
# ref: https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.screen?view=windowsdesktop-8.0

Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms
$BasePath = "C:\Temp"
$BaseImg = "$BasePath\PowerShellScreenCapture_"

# Examples accessing AllScreens object:
# Write-Output([System.Windows.Forms.Screen]::AllScreens)
# Write-Output([System.Windows.Forms.Screen]::AllScreens[0])

foreach ($screen in $([System.Windows.Forms.Screen]::AllScreens))
{
    $ScreenResolution = $screen.Bounds
    $Bitmap = New-Object System.Drawing.Bitmap $ScreenResolution.Width, $ScreenResolution.Height
    $Graphics = [System.Drawing.Graphics]::FromImage($Bitmap)
    $Graphics.CopyFromScreen($ScreenResolution.Location, [System.Drawing.Point]::Empty, $ScreenResolution.Size)
    $OutputPath = $BaseImg + $screen.DeviceName.Replace("\\.\", "") + ".jpg"
    Write-Output($OutputPath)
    $Bitmap.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $Graphics.Dispose()
    $Bitmap.Dispose()
}

# Open BasePath in Windows Explorer
Invoke-Item -Path $BasePath
