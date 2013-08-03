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
rem on cree l'infrastructure
cd ..
if not exist reduit md reduit
cd reduit
if not exist "%~n1" md "%~n1"
rem if not exist thumb md thumb
rem cd thumb
if not exist "%~n1" md "%~n1"
rem on revient au repertoire de depart
if ["%str1:"=^^^^^@%"] NEQ "" (
    %~d1
    cd "%~pn1"
)

echo reduction des photos
nconvert -out jpeg -i -opthuff -o "..\reduit\%~n1\%%" -q 80 -ratio -rtype lanczos -opthuff -keepfiledate -buildexifthumb -resize 1280 960 -rflag orient *.jpg
rem nconvert -out jpeg -rmeta -keepfiledate -rexifthumb -opthuff -o "..\reduit\thumb\%~n1\%%-th.jpg" -i -q 60 -ratio -rtype lanczos -resize 144 144 -rflag orient *.jpg
rem nconvert -out jpeg -rmeta -keepfiledate -rexifthumb -opthuff -o "..\reduit\thumb\%~n1\%%-la.jpg" -i -q 60 -ratio -rtype lanczos -resize 756 756 -rflag orient *.jpg
rem nconvert -out jpeg -rmeta -keepfiledate -rexifthumb -opthuff -o "..\reduit\thumb\%~n1\%%-me.jpg" -i -q 60 -ratio -rtype lanczos -resize 324 324 -rflag orient *.jpg
rem on met les fichiers afin de d'eviter toute piratage plus tard
rem copy "d:\bat\index_rep_photos_pwg.php" "..\reduit\%~n1\index.php"
rem copy "d:\bat\index_rep_photos_pwg.php" "..\reduit\thumb\%~n1\index.php"
xcopy "..\reduit\%~n1" "D:\Dropbox\Photos\%~n1" /I /Y
if '%ERRORLEVEL%' = '0' goto fin
:quasifin
pause

:fin
endlocal