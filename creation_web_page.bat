echo off
rem on va dans le bon repertoire
 setlocal
 set "str1=%cd%"
 set str | findstr "\^^^^^@">nul && (
   set "str1=%str1:^^^^^@=@%"
 )
 if ["%str1:"=^^^^^@%"] NEQ "" (
     %~d1
     cd "%~pn1"
 )
 rem creation des repertoires
if not exist reduit md reduit
cd reduit
if not exist thumbnail md thumbnail
cd ..

echo reduction des photos
nconvert -out jpeg -i -opthuff -o reduit\%% -q 80 -ratio -rtype lanczos -opthuff -keepfiledate -buildexifthumb -resize 800 600 -rflag orient *.jpg
nconvert -out jpeg -rmeta -keepfiledate -rexifthumb -opthuff -o reduit\thumbnail\%%-th.jpg -i -q 60 -ratio -rtype lanczos -resize 144 144 -rflag orient *.jpg
rem on met le fichier anti piratage dans thumbnails
copy "d:\bat\index_rep_photos_pwg.php" .\reduit\thumbnail\index.php
rem on met le fichier principal
copy "d:\bat\index_photo_simple.php" .\reduit\index.php