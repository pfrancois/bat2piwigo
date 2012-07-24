echo off
 setlocal
 set "str1=%cd%"
 set str | findstr "\^^^^^@">nul && (
   set "str1=%str1:^^^^^@=@%"
 )
 if ["%str1:"=^^^^^@%"] NEQ "" (
     %~d1
     cd "%~pn1"
 )
if not exist reduit md reduit
if not exist "%~n1" md "%~n1"
echo reduction des photos
nconvert -out jpeg -i -opthuff -o reduit\%~n1\%% -q 80 -ratio -rtype lanczos -opthuff -keepfiledate -buildexifthumb -resize 800 600 -rflag orient *.jpg
nconvert -out jpeg -rmeta -keepfiledate -rexifthumb -opthuff -o %~n1\%%-th.jpg -i -q 60 -ratio -rtype lanczos -resize 144 144 -rflag orient *.jpg
rem on met les fichiers afin de d'eviter toute piratage plus tard
copy "d:\bat\index_rep_photos_pwg.php" .\reduit\%~n1\index.php
copy "d:\bat\index_rep_photos_pwg.php" .\%~n1\index.php
echo %ERRORLEVEL%
if %ERRORLEVEL% NEQ 0 goto fin
:quasifin
pause

:fin
endlocal