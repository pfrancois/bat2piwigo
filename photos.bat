@echo off
rem 1.2.1 21 03 2010 
rem ajout d'une option quitter
rem v1.2 le 09 02 2010
rem passage a nconvert
rem choice
rem v1.1 le 25 11 2008
rem changement nom de renomage avec des - 
rem remplacment de sample par resize dans convert
if not exist reduit md reduit
rem rajout d'un commentaire exif  avec mon id parano
rem copie des fichers dans le repertoire transfert avec le repertoire à la bonne date
:start
echo ajout de commentaire exif
set choice=
set /p choice=1. parano 2. francois pegory 3. quitter
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' exiftool -v0 -m -fast2 -UserComment=alpha-75982 -Artist=alpha-75982 -copyright=alpha-75982 *.jpg
if '%choice%'=='2' exiftool -v0 -m -fast2 "-UserComment=FRANCOIS PEGORY" "-Artist=FRANCOIS PEGORY" "-copyright=FRANCOIS PEGORY" *.jpg
if '%choice%'=='3' goto EOL
rem copie reduction 
echo reduction des photos
nconvert -out jpeg -i -opthuff -o reduit\%% -q 80 -ratio -rtype lanczos -resize 800 600 -rflag orient *.jpg
echo rotation auto de la photo avec la date de prise en date de modif du fichier
jhead -ft -autorot *.jpg
echo modification du nom du fichier
exiftool -v0 -m -fast2 -d %%Y/%%m_%%d/%%Y-%%m-%%d_%%H-%%M-%%S.jpg "-filename<DateTimeOriginal" *.jpg
echo idem images reduites
jhead -ft -autorot reduit\*.jpg
exiftool -v0 -m -fast2 -d %%Y/%%m_%%d/%%Y%%m%%d/%%Y-%%m-%%d_%%H-%%M-%%S.jpg "-filename<DateTimeOriginal" reduit\*.jpg
del *.jpg_original
rmdir reduit
pause
:EOL