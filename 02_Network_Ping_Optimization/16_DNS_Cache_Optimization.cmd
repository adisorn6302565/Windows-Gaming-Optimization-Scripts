@echo off
REM คำเตือน: ไฟล์นี้จะแก้ไขการตั้งค่าระบบ Windows โปรดสำรอง Registry ก่อนใช้งาน

REM ตรวจสอบสิทธิ์ Administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ต้องรันด้วยสิทธิ์ Administrator
    echo กดคลิกขวาที่ไฟล์แล้วเลือก "Run as administrator"
    pause
    exit /b 1
)

echo กำลังเพิ่มประสิทธิภาพของ DNS Cache...
echo.

REM ตั้งค่า Max Cache Entry TTL Limit เป็น 300 วินาที (5 นาที)
REM ช่วยให้ระบบแคช DNS Records ได้นานขึ้น
REM ลดเวลาในการ Resolve Domain Names

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v MaxCacheEntryTtlLimit /t REG_DWORD /d 300 /f >nul 2>&1

REM ตั้งค่า Max SOA Cache Entry TTL Limit
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v MaxSOACacheEntryTtlLimit /t REG_DWORD /d 300 /f >nul 2>&1

REM เพิ่มขนาด Cache
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v CacheHashTableBucketSize /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v CacheHashTableSize /t REG_DWORD /d 384 /f >nul 2>&1

REM ล้าง DNS Cache ปัจจุบัน
ipconfig /flushdns >nul 2>&1

if %errorLevel% equ 0 (
    echo [สำเร็จ] เพิ่มประสิทธิภาพ DNS Cache เรียบร้อยแล้ว
) else (
    echo [ผิดพลาด] ไม่สามารถตั้งค่าได้
)

echo.
echo การตั้งค่าเสร็จสิ้น. กดปุ่มใดก็ได้เพื่อปิดหน้าต่าง...
pause >nul
