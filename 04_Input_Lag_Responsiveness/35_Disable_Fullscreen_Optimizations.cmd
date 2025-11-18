@echo off
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน

echo กำลังปิดการใช้งาน Fullscreen Optimizations...
echo.

REM ปิด Fullscreen Optimizations
REM ฟีเจอร์นี้อาจเพิ่ม Input Lag ในบางเกม
REM การปิดช่วยให้เกมทำงานในโหมด Fullscreen แบบดั้งเดิม

reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_DXGIHonorFSEWindowsCompatible /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_FSEBehaviorMode /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_HonorUserFSEBehaviorMode /t REG_DWORD /d 1 /f >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ปิด Fullscreen Optimizations เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
