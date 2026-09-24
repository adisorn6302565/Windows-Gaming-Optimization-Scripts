@echo off
chcp 65001 >nul
REM --- KANAO: ขอสิทธิ์ Administrator อัตโนมัติ ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน

echo กำลังปรับค่า Flip Queue Size...
echo.
echo [หมายเหตุ] สคริปต์นี้ตั้งค่าสำหรับ NVIDIA GPU
echo.

REM ตั้งค่า Flip Queue Size เป็น 3
REM Flip Queue Size กำหนดจำนวน Frames ที่ GPU เตรียมไว้ล่วงหน้า
REM ค่า 3 เป็นค่าที่แนะนำสำหรับความสมดุลระหว่างประสิทธิภาพและ Latency

reg add "HKEY_CURRENT_USER\Software\NVIDIA Corporation\Direct3D" /v FlipQueueSize /t REG_DWORD /d 3 /f >nul 2>&1

REM ตั้งค่า Maximum Pre-Rendered Frames
reg add "HKEY_CURRENT_USER\Software\NVIDIA Corporation\Global\NVTweak" /v PreRenderLimit /t REG_DWORD /d 3 /f >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ปรับค่า Flip Queue Size เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้ หรือไม่ได้ติดตั้ง NVIDIA GPU
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
