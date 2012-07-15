rem echo off
setlocal
set "str1=@%1"
set str | findstr "\^^^^^@">nul && (
  set "str1=%str1:^^^^^@=@%"
)
if ["%str1:"=^^^^^@%"] NEQ "" (
    %~d1
    cd "%~pn1"
)
if not exist reduit md reduit
cd reduit
cd ..
echo rotation 
d:\bat\jhead -ft -autorot -exonly *.*
echo reduction des photos
nconvert -out jpeg -i -opthuff -o reduit\%% -q 80 -ratio -rtype lanczos -opthuff -keepfiledate -buildexifthumb -resize 800 600 -rflag orient *.jpg

rem on met les fichiers afin de d'eviter toute piratage plus tard
rem cd reduit
rem if not exist thumbnail md thumbnail
rem cd ..

copy "d:\bat\index_rep_photos_pwg.php" .\index.php
rem copy "index_rep_photos_pwg.php" .\thumbnail\index.php
rem nconvert -out jpeg -rmeta -keepfiledate -rexifthumb -opthuff -o thumbnail\TN-%% -i -q 60 -ratio -rtype lanczos -resize 128 128 -rflag orient *.jpg

if %ERRORLEVEL% NEQ 0 goto fin
pause

:fin
endlocal