@echo off
chcp 65001 >nul
REM --- KANAO: ขอสิทธิ์ Administrator อัตโนมัติ ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน

echo กำลังปิดการใช้งาน Shader Cache...
echo.
echo [หมายเหตุ] สคริปต์นี้ตั้งค่าสำหรับ NVIDIA GPU
echo.

REM ปิด Shader Cache สำหรับ NVIDIA
REM Shader Cache เก็บ Compiled Shaders เพื่อโหลดเร็วขึ้น
REM การปิดอาจช่วยแก้ปัญหา Stuttering ในบางเกม

reg add "HKEY_CURRENT_USER\Software\NVIDIA Corporation\Global\ShaderCache" /v EnableShaderCache /t REG_DWORD /d 0 /f >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ปิด Shader Cache เรียบร้อยแล้ว
    echo [หมายเหตุ] การปิด Shader Cache อาจทำให้เกมโหลดช้าลงในครั้งแรก
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้ หรือไม่ได้ติดตั้ง NVIDIA GPU
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
