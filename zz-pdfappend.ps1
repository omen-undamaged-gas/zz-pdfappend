# Usage:
# PowerShell.exe -File .\zz-pdfappend.ps1 -lang <en|jp> -f <path>
param([string]$lang, [string]$f="")
$ver="1.0"

$pdf_append_en="$env:HOMEPATH\Documents\append_en.pdf"
$pdf_append_jp="$env:HOMEPATH\Documents\append_jp.pdf"

Switch ($lang) {
    {$_ -eq "en"} {$pdf_append=$pdf_append_en}
    {$_ -eq "jp"} {$pdf_append=$pdf_append_jp}
    Default {$pdf_append=$pdf_append_en}
}

if ( -not (Get-Module -ListAvailable -Name PSWritePDF) ) {
    Write-Host "PSWritePDF module is not installed."
    Write-Host "Installing..."
    Install-Module PSWritePDF -Force -Scope CurrentUser
}

$f_is_file=$false
if ($f) {
    Write-Host "Lang:$lang"
    Write-Host $pdf_append
    Write-Host $f
    if ((Test-Path -Path $f -PathType Leaf) -and ((Get-Item $f).Extension -eq ".pdf") ) {
        $f_is_file=$true
    }
    else {
        Write-Host "Not a valid file, or path contains invalid symbols. Exit." -Foregroundcolor Red
        pause; exit
    }
}
else {
    Write-Host "No inputs. Exit." -Foregroundcolor Red
    pause; exit
}

if ($f_is_file) {
    $pdf_out=(Get-Item $f).DirectoryName+"\"+(Get-Item $f).Basename+"+tob_"+$lang+".pdf"
    Merge-PDF -InputFile $f, $pdf_append -OutputFile $pdf_out
    Write-Host $pdf_out
}
pause; exit
