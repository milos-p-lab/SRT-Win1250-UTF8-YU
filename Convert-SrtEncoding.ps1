#requires -Version 5.1

<#
.SYNOPSIS
    en: Converts .srt files in the specified directory and its subdirectories from Windows-1250 to UTF-8 encoding.
    yu: Konvertuje .srt fajlove u zadatom direktorijumu i njegovim poddirektorijumima iz Windows-1250 u UTF-8 kodiranje.
.DESCRIPTION
    en: This script scans the specified directory and its subdirectories for .srt files, checks if they are already in UTF-8 encoding, and converts them to UTF-8 if they are not. It handles file attributes like ReadOnly and Hidden to ensure successful conversion.
    yu: Ova skripta pretražuje zadati direktorijum i njegove poddirektorijume za .srt fajlove, provjerava da li su već u UTF-8 kodiranju i konvertuje ih u UTF-8 ako nijesu. Rukuje atributima fajlova kao što su ReadOnly i Hidden kako bi osigurala uspješnu konverziju.
.EXAMPLE
    .\Convert-SrtEncoding.ps1 -Path "C:\path\to\directory"
.NOTES
    Author: Miloš Perunović
    Version: 1.2.0
    Date: 2025-07-13
#>

[CmdletBinding()]
param(
    [string]$Path = $PSScriptRoot
)

Clear-Host
Set-Location $Path

Write-Host "Pretvaram .srt fajlove u folderu i podfolderima: $Path" -ForegroundColor Cyan

#  ---------------------------------------------------------------------------

Get-ChildItem -Path $Path -Filter *.srt -File -Recurse -Force | ForEach-Object {

    $file = $_.FullName
    $attributes = $_.Attributes

    if (IsUtf8Encoded $file) {
        Write-Host "⏭  Preskačem (već UTF-8): $file" -ForegroundColor DarkGray
    }
    else {
        Write-Host "🔄 Konvertujem: $file"

        try {
            # Ukloni ReadOnly i Hidden ako su postavljeni, da bi bilo moguće pisati u fajl
            $newAttributes = $attributes
            if ($attributes -band [System.IO.FileAttributes]::ReadOnly) {
                $newAttributes = $newAttributes -bxor [System.IO.FileAttributes]::ReadOnly
            }
            if ($attributes -band [System.IO.FileAttributes]::Hidden) {
                $newAttributes = $newAttributes -bxor [System.IO.FileAttributes]::Hidden
            }
            Set-ItemProperty -Path $file -Name Attributes -Value $newAttributes

            # 🆕 Kreiraj .bak fajl prije konverzije
            $bakFile = "$file.bak"
            [System.IO.File]::Copy($file, $bakFile, $true)
            Write-Host "📝 Backup fajl napravljen: $bakFile" -ForegroundColor Yellow

            # Učitaj sadržaj i konvertuj encoding
            $bytes = [System.IO.File]::ReadAllBytes($file)
            $text = [System.Text.Encoding]::GetEncoding("windows-1250").GetString($bytes)
            [System.IO.File]::WriteAllText($file, $text, [System.Text.Encoding]::UTF8)

            # Vrati originalne atribute
            Set-ItemProperty -Path $file -Name Attributes -Value $attributes

            Write-Host "✔  Gotovo: $file"
        }
        catch {
            $err = $_ | Out-String
            Write-Warning "❌ Greška prilikom konverzije fajla ${file}: $err"
        }
    }
}

Write-Host "✅ Svi .srt fajlovi su konvertovani u UTF-8 kodiranje." -ForegroundColor Green

function IsUtf8Encoded($filePath) {
    <#
    .SYNOPSIS
        en: Checks if a file is encoded in UTF-8.
        yu: Provjerava da li je fajl kodiran u UTF-8.
    .DESCRIPTION
        en: Reads the first few bytes of the file to check for UTF-8 BOM or invalid characters.
        yu: Čita prvih nekoliko bajtova fajla da bi provjerio da li ima UTF-8 BOM ili nevalidne karaktere.
    .PARAMETER filePath
        en: The path to the file to check.
        yu: Putanja do fajla koji se provjerava.
    .RETURNVALUE
        en: Returns $true if the file is UTF-8 encoded, otherwise $false.
        yu: Vraća $true ako je fajl kodiran u UTF-8, inače $false.
    #>
    try {
        $bytes = [System.IO.File]::ReadAllBytes($filePath)

        if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
            return $true
        }

        $text = [System.Text.Encoding]::UTF8.GetString($bytes)

        if ($text.Contains("�")) {
            return $false
        }

        return $true
    }
    catch {
        return $false
    }
}
