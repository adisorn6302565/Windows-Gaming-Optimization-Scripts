@echo off
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน

echo กำลังปรับแต่งการตั้งค่า Anisotropic Filtering...
echo.
echo [หมายเหตุ] สคริปต์นี้ตั้งค่าสำหรับ NVIDIA GPU
echo.

REM ตั้งค่า Anisotropic Filtering เป็น 16x (ค่าสูงสุด)
REM Anisotropic Filtering ช่วยให้เท็กซ์เจอร์คมชัดมากขึ้นที่มุมมองต่างๆ
REM ค่า 16 = 16x AF (คุณภาพสูงสุด)

reg add "HKEY_CURRENT_USER\Software\NVIDIA Corporation\Global\OpenGL" /v AnisotropicFiltering /t REG_DWORD /d 16 /f >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] ตั้งค่า Anisotropic Filtering เป็น 16x เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้ หรือไม่ได้ติดตั้ง NVIDIA GPU
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
