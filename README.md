# Windows Batch Tools 🛠️

A collection of Windows batch scripts and utilities designed to streamline system maintenance, perform network resets, and provide quick access to system tools and administrative settings.

---

## 📌 Core Components

---

### 1. Main_batch.bat (Main Menu)
Offers an interactive command-line interface to easily launch maintenance routines, icon fixes, and system utilities.

![Main Menu](https://github.com/user-attachments/assets/4b0c7b53-e154-436c-986b-5c980163ca34)

#### Key Options Menu Structure:
1. **Active Windows & Office (`MAS_AIO.cmd`)**: Active Your Windows and Office
2. **Create Special Folders (`Special_Folders.bat`)**: Generates CLSID system shortcuts and launch scripts.
3. **Refresh Icons (`refresh_icons.bat`)**: Rebuilds the icon cache and thumbnail databases.
4. **Windows Maintenance (`windows_maintenance_script.bat`)**: Runs full system cleanup, temp file removal, and network optimization.
5. **Chris Titus Tech's Windows Utility (`winutil.ps1`)**: Launches the PowerShell WinUtil GUI for system tweaks, software management, and debloating.
6. **System Repairs (SFC / DISM)**: Executes system file integrity checks (`sfc /scannow`) and DISM image health cleanup/restoration (`CheckHealth`, `ScanHealth`, `RestoreHealth`).
7. **Restart Audio Services**: Resets and restarts `audiosrv` and `AudioEndpointBuilder` services to fix audio playback issues.
8. **Quick Scan Drive C (CHKDSK)**: Performs a non-destructive drive error scan (`chkdsk C:`) to check for file system anomalies.
0. **Exit**: Closes the script menu interface.

---

### Option 1: MAS_AIO.cmd (Active Windows & Office)

![Active Windows & Office](https://github.com/user-attachments/assets/344eaa1f-77ff-4d0d-831a-df6b7da4811a)

#### Operations Performed:
- **Automated PowerShell Execution:**
  - Configures execution policy bypass to run activation scripts seamlessly without security prompts.
- **Online Script Retrieval:**
  - Fetches and executes the latest official [Microsoft Activation Scripts (MAS)](https://github.com/massgravel/Microsoft-Activation-Scripts) via `https://get.activated.win`.
- **HWID & Ohook Activation Support:**
  - Triggers the official interactive MAS CLI menu for permanent Digital License (HWID) activation for Windows and Ohook permanent activation for Microsoft Office.
- **KMS / License Renewal:**
  - Provides fallback options for KMS38 and Online KMS activation routines for legacy and volume-licensed systems.

---

### Option 2: Special_Folders.bat (Special Folders & System Launchers)

![Special Folders](https://github.com/user-attachments/assets/a70b8446-d3d3-4cd9-ac77-02d555b5fa4f)

#### Operations Performed:
- **Custom Directory Selection:**
  - Allows the user to specify a custom target path or press `[ENTER]` to default to the script's directory.
- **Folder Customization:**
  - Generates a `desktop.ini` file to apply a Control Panel-style folder icon.
- **CLSID System Shortcuts Generation:**
  - God Mode (`{ED7BA470-8E54-465E-825C-99712043E01C}`)
  - Action Center (`{D555645E-D4F8-4c29-A827-D93C859C4F2A}`)
  - Network Connections (`{7007ACC7-3202-11D1-AAD2-00805FC1270E}`)
  - Devices and Printers (`{A8A91A66-3A7D-4424-8D24-04E180695C7A}`)
  - Programs and Features (`{7b81be6a-ce2b-4676-a29e-eb907a5126c5}`)
  - Windows Firewall (`{4026492F-2F69-46B8-B9BF-5654FC07E423}`)
  - Troubleshooting (`{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}`)
  - Credential Manager (`{1206F5F1-0569-412C-8FEC-3204630DFB70}`)
  - AutoPlay (`{9C60DE1E-E5FC-40f4-A487-460851A8D915}`)
  - Administrative Tools (`{D20EA4E1-3957-11d2-A40B-0C5020524153}`)
  - System (`{BB06C0E4-D293-4f75-8A90-CB05B6477EEE}`)
  - Personalization (`{ED834ED6-4B5A-4bfe-8F11-A626DCB6A921}`)
  - Power Options (`{025A5937-A6BE-4686-A844-36FE4BEC8B6D}`)
  - User Accounts (`{60632754-c523-4b62-b45c-4172da012619}`)
  - RemoteApp and Desktop Connections (`{241D7C96-F8BF-4F85-B01F-E2B043341A4B}`)
- **Batch Launcher Creation:**
  - Date and Time (`timedate.cpl`)
  - Display Settings (`ms-settings:display`)
  - Folder Options (`control folders`)
  - Keyboard Properties (`control keyboard`)
  - Mouse Properties (`control mouse`)
  - Mobility Center (`mblctr`)
  - Performance Monitor (`perfmon.msc`)
  - Windows Update (`ms-settings:windowsupdate`)

---

### Option 3: refresh_icons.bat (Icon & Cache Refresh)

![Refresh Icons](https://github.com/user-attachments/assets/05f97b7e-b1e2-4637-add3-4e613151d13a)

#### Operations Performed:
- Terminates `explorer.exe` process.
- Clears read-only/hidden attributes and deletes `%localappdata%\IconCache.db`.
- Clears read-only/hidden attributes and deletes icon cache files in `%localappdata%\Microsoft\Windows\Explorer\iconcache*.db`.
- Clears thumbnail cache databases (`thumbcache*.db`).
- Restarts `explorer.exe` process.

---

### Option 4: windows_maintenance_script.bat (System Maintenance)

![Windows Maintenance](https://github.com/user-attachments/assets/05b112c5-5a2f-488b-9ab7-8a9497e9525a)

> ⚠️ **IMPORTANT USER WARNING:**  
> This script permanently empties the **Recycle Bin** across all drives (`rd /s /q C:\$Recycle.Bin`). If you have deleted files in the Recycle Bin that you may need later, **restore them before running this script**.

#### Operations Performed:

- **Recycle Bin Cleanup:**
  - Permanently deletes all contents in the Recycle Bin.

- **System & User Temp Cleanup:**
  - Clears System Temp files (`C:\Windows\Temp\*.*`).
  - Clears User Temp files (`%temp%\*.*`).

- **Windows Update Cache Cleanup:**
  - Temporarily stops `wuauserv` and `bits` services.
  - Purges `C:\Windows\SoftwareDistribution\Download\*.*`.
  - Restarts `wuauserv` and `bits` services.

- **Delivery Optimization & Prefetch Cleanup:**
  - Stops `dosvc` service and clears Delivery Optimization cache.
  - Clears Windows Prefetch folder (`C:\Windows\Prefetch\*.*`).

- **Network Reset & DNS Flush:**
  - Flushes DNS Resolver cache (`ipconfig /flushdns`).
  - Re-registers DNS names (`ipconfig /registerdns`).
  - Releases and renews IP address configurations (`ipconfig /release`, `ipconfig /renew`).
  - Resets Winsock catalog to restore network sockets (`netsh winsock reset`).

- **Logging & Verification:**
  - Outputs execution results step-by-step into a dedicated log file (`%SystemDrive%\maintenance_log.txt`).
  - Prompts option to view the detailed log file upon completion.

---

### Option 5: Windows Utility & System Tweaks (winutil & Winhance)

![Chris Titus Tech Utility](https://github.com/user-attachments/assets/c554a9cc-9e01-45cc-b013-889f8580e849)
![Winhance Utility](https://github.com/user-attachments/assets/02efbe6a-e4d4-4d71-903d-34a69f42fb79)

#### Operations Performed:
- **Chris Titus Tech Windows Utility (CTT WinUtil):**
  - **Automated PowerShell Launch:** Downloads and executes the CTT GUI directly using `iwr -useb https://christitus.com/win | iex`.
  - **Software Installation:** Streamlines mass installation of essential software packages and desktop applications via Winget and Chocolatey.
  - **System Tweaks & Debloating:** Provides core OS optimizations, telemetries removal, background services control, and power scheme enhancements.
  - **Windows Update Management:** Offers advanced controls to delay, security-lock, or restore default Windows Update policies.

- **Winhance System Optimization Utility:**
  - **Automated PowerShell Launch:** Fetches and runs the latest release directly via `iwr -useb https://winhance.net | iex`.
  - **Modern UI & Fine-Grained Tweaks:** Provides an intuitive interface for advanced Windows 10/11 customization and privacy enhancements.
  - **Bloatware Removal:** Scans and purges unwanted pre-installed UWP apps and system components.
  - **Performance & Gaming Tuning:** Applies targeted registry modifications to reduce input latency, optimize resource allocation, and disable telemetry services.

---

### Option 6: System Repairs (SFC / DISM)

![System Repairs](https://github.com/user-attachments/assets/040b879e-48f2-4010-b684-8ff691028e7a)

#### Operations Performed:
- **System File Checker (SFC):**
  - Runs `sfc /scannow` to verify system file integrity and automatically replace corrupted files with cached copies.
- **Deployment Image Servicing and Management (DISM):**
  - Runs `DISM /Online /Cleanup-Image /CheckHealth` to detect existing component store corruption.
  - Runs `DISM /Online /Cleanup-Image /ScanHealth` to perform an in-depth scan of the Windows image.
  - Runs `DISM /Online /Cleanup-Image /RestoreHealth` to repair system image corruption using Windows Update sources.

---

### Option 7: Restart Audio Services

![Restart Audio Services](https://github.com/user-attachments/assets/b384c7a9-a6ae-4fa1-bc26-56cb32bcd716)

#### Operations Performed:
- Stops the Windows Audio Endpoint Builder service (`net stop AudioEndpointBuilder`).
- Stops the main Windows Audio service (`net stop audiosrv`).
- Restarts both services (`net start audiosrv` & `net start AudioEndpointBuilder`) to resolve sound output/input bugs, missing audio devices, or unfreeze silent playback issues.

---

### Option 8: Quick Scan Drive C (CHKDSK)

![Quick Scan Drive C](https://github.com/user-attachments/assets/a0264c4d-6ac5-48a2-be96-0878c5920c7c)

#### Operations Performed:
- Executes `chkdsk C:` in read-only mode.
- Performs a non-destructive check on Drive C to detect file system errors, bad sectors, or metadata corruption without locking or unmounting the drive.

---

## 🚀 Usage Instructions

1. Right-click `Main_batch.bat` and select **Run as Administrator** to ensure all privileges are granted.
2. Choose your desired option from the menu (`0-7`).
3. Follow the on-screen prompts in the command window.
