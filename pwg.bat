if not exist thumbnail md thumbnail
rem on met les fichiers afin de d'eviter toute piratage plus tard
copy "G:\Documents and Settings\francois\bat\index_rep_photos_pwg.php" .\index.php
copy "G:\Documents and Settings\francois\bat\index_rep_photos_pwg.php" .\thumbnail\index.php
nconvert -out jpeg -rmeta -keepfiledate -rexifthumb -opthuff -o thumbnail\TN-%% -i -q 60 -ratio -rtype lanczos -resize 128 128 -rflag orient *.jpg
if not errorlevel 1 goto fin
pause
:fin
