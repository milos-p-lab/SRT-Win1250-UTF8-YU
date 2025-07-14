# 🎬 SRT Encoding Converter (PowerShell)

A PowerShell script that scans a folder (and subfolders) for `.srt` subtitle files and converts them from Windows-1250 (Central European) encoding to UTF-8.  
Automatically creates backup `.bak` files before converting.

Ideal for fixing character encoding issues in media players like VLC, Plex, and Kodi.

> ✍️ **Author:** Miloš Perunović  
> 🗓️ **Date:** 2025-07-13

---

## 🌍 Opis na našem jeziku

PowerShell skripta koja pretražuje folder i podfoldere, pronalazi `.srt` fajlove i automatski ih konvertuje iz Windows-1250 (često korišćen kod starijih titlova na ex-YU prostoru) u UTF-8. Ako je fajl već u UTF-8, skripta ga preskače.

Koristite ovu skriptu kako bi:
- riješili probleme sa prikazom slova (č, ć, š, ž, đ…)
- pripremili titlove za moderni softver i uređaje (Plex, Kodi, VLC…)

> 📝 **Napomena:** Ako imate titlove u drugim kodiranjima (npr. Windows-1252), prilagodite skriptu u skladu s tim.

---

## 🚀 Features

- Automatically detects if `.srt` file is already UTF-8 encoded.
- Converts all `.srt` files in a folder (including subfolders).
- Helps avoid character encoding issues in media players.
- Ideal for subtitle collections in ex-YU languages.

---

## ⚙️ Usage

Run the script in PowerShell:

```powershell
.\Convert-SrtEncoding.ps1 -Path "D:\Movies"
```

---

## ✅ How It Works

- The script scans all `.srt` files under the specified folder.
- Checks the current encoding of each file.
- If file is Windows-1250:
  - Creates a backup of the original file with a `.bak` extension.
  - Converts the content to UTF-8.
  - Overwrites the original `.srt` file.
- Prints a summary of converted files.

---

## 💡 Why Convert to UTF-8?

UTF-8:
- works everywhere (Windows, macOS, Linux)
- avoids garbled characters like Ä, æ, etc.
- is supported by modern media players like Plex, Kodi, VLC

Many older subtitles from ex-YU scene groups are still encoded in Windows-1250. Converting them to UTF-8 ensures correct display of all special characters.

---

## 🔧 Requirements

- Windows PowerShell 5.1 or PowerShell Core (7.x)
- No additional modules required

---

## 🤝 Contributing

Contributions, suggestions, and improvements are welcome!
- Open an Issue if you encounter bugs or have feature ideas.
- Create a Pull Request if you'd like to improve the script.
- Share feedback or examples of how you're using the script!

---

## ℹ️ Note

This script is tailored for Windows-1250 subtitles typical for ex-YU languages.
If you have subtitles in other encodings (e.g. Windows-1252), adjust the script accordingly.

> ✅ **Backup:**  
> Before converting, the script automatically creates a `.bak` backup for each `.srt` file that needs conversion.  
> Keep or delete these backup files as needed once you verify your subtitles are working correctly.

---

## Keywords

- SRT
- subtitles
- encoding
- converter
- convertor
- PowerShell
- UTF-8
- Windows-1250
- ex-YU

---

## 📜 License

MIT License – © 2025 Miloš Perunović

<!--
Related terms:
srt encoding converter, srt encoding convertor, srt convertor, powershell srt cp1250 to utf8, convert srt cp1250 to utf8,
subtitle encoding converter, subtitle convertor, ex-yu subtitles
-->
