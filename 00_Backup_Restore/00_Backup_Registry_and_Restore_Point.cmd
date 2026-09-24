@echo off
chcp 65001 >nul
REM --- KANAO: ขอสิทธิ์ Administrator อัตโนมัติ ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

REM สำรอง Registry ส่วนที่สคริปต์ในชุดนี้แก้ไข + สร้าง System Restore Point
REM ไฟล์สำรองอยู่ที่ %ProgramData%\KANAO-Gaming-Scripts\backup-<วันเวลา>

for /f %%t in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd-HHmmss"') do set STAMP=%%t
set "DEST=%ProgramData%\KANAO-Gaming-Scripts\backup-%STAMP%"
mkdir "%DEST%" >nul 2>&1

echo [1/2] กำลังสร้าง System Restore Point...
powershell -NoProfile -Command "Enable-ComputerRestore -Drive $env:SystemDrive -ErrorAction SilentlyContinue; Checkpoint-Computer -Description 'KANAO Gaming Scripts' -RestorePointType MODIFY_SETTINGS" >nul 2>&1
if %errorLevel% equ 0 (echo       [สำเร็จ]) else (echo       [ข้าม] Windows อนุญาตให้สร้างได้วันละ 1 ครั้ง หรือปิด System Protection ไว้)

echo [2/2] กำลังสำรอง Registry ไปที่ %DEST%
reg export "HKLM\SYSTEM\CurrentControlSet\Control" "%DEST%\HKLM_Control.reg" /y >nul
reg export "HKLM\SYSTEM\CurrentControlSet\Services" "%DEST%\HKLM_Services.reg" /y >nul
reg export "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia" "%DEST%\HKLM_Multimedia.reg" /y >nul
reg export "HKLM\SOFTWARE\Policies" "%DEST%\HKLM_Policies.reg" /y >nul
reg export "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies" "%DEST%\HKLM_CV_Policies.reg" /y >nul
reg export "HKCU\Control Panel" "%DEST%\HKCU_ControlPanel.reg" /y >nul
reg export "HKCU\Software\Microsoft\Windows\CurrentVersion" "%DEST%\HKCU_CurrentVersion.reg" /y >nul
reg export "HKCU\System\GameConfigStore" "%DEST%\HKCU_GameConfigStore.reg" /y >nul 2>&1
powercfg /getactivescheme > "%DEST%\power_scheme.txt"

echo.
echo [เสร็จ] สำรองไว้ที่: %DEST%
echo คืนค่าได้ด้วย 00_Restore_Registry.cmd
echo.
pause
