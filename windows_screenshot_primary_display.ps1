# ref: https://www.itprotoday.com/powershell/powershell-screen-capture-how-to-automate-screenshots-in-your-scripts

Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms
$OutputPath = "C:\Temp\PowerShellScreenCapture.jpg"
$ScreenResolution = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$Bitmap = New-Object System.Drawing.Bitmap $ScreenResolution.Width, $ScreenResolution.Height
$Graphics = [System.Drawing.Graphics]::FromImage($Bitmap)
$Graphics.CopyFromScreen($ScreenResolution.Location, [System.Drawing.Point]::Empty, $ScreenResolution.Size)
$Bitmap.Save($OutputPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
$Graphics.Dispose()
$Bitmap.Dispose()