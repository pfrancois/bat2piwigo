rem ffmpeg.exe -i %1 -vcodec wmv1 -acodec wmav1 %1.wmv
@echo off
ffmpeg.exe -i %1 %1.mpeg
if not errorlevel 1 goto fin
pause
:fin
