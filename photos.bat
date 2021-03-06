@echo off
rem on va vers le repertoire de lancement
setlocal
set "str1=@%1"
set str | findstr "\^^^^^@">nul && (
  set "str1=%str1:^^^^^@=@%"
)
if ["%str1:"=^^^^^@%"] NEQ "" (
    %~d1
    cd "%~pn1"
)
:start
rem echo off
echo ajout de commentaire exif
set choice=
rem set /p choice=1. rien 2. francois pegory 3. quitter
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='2' exiftool -L -lang fr -e -v0 -m -fast2 -P -overwrite_original "-UserComment=FRANCOIS PEGORY" "-Artist=FRANCOIS PEGORY" "-copyright=FRANCOIS PEGORY" .
if '%choice%'=='3' goto EOL
echo rotation 
d:\bat\jhead -ft -autorot -exonly .\**

echo modification du nom du fichier
set choice=1
set /p choice=1. deplacement repertoire 2. uniquement renomage 3. quitter
if '%choice%'=='3' goto EOL
rem -r: recurse dir -preserve : preserVe date time, -e dont calculate composite tag, -F Fix the base for maker notes offset
if '%choice%'=='2' exiftool -r -progress -preserve -overwrite_original -fixbase --composite -fast2 -ignoreMinorErrors "-FileName<DateTimeOriginal" -dateformat "%%Y%%m%%d_%%H%%M%%S%%%%-c.%%%%e" .
if '%choice%'=='1' exiftool -r -progress -preserve -overwrite_original -fixbase --composite -fast2 -ignoreMinorErrors "-FileName<DateTimeOriginal" -dateformat "%%Y/%%m_%%d/%%Y%%m%%d_%%H%%M%%S%%%%-c.%%%%e" .

echo modification du nom des fichier video
if '%choice%'=='2' exiftool -preserve -overwrite_original -fixbase -progress --composite -fast2 -ignoreMinorErrors -ext avi -ext mov -ext 3gp -ext asf -ext flac -ext flv -ext mp4 -ext mpg -r "-FileName<DateTimeOriginal" -dateformat "%%Y%%m%%d_%%H%%M%%S%%%%-c.%%%%e" .
if '%choice%'=='1' exiftool -preserve -overwrite_original -fixbase -progress --composite -fast2 -ignoreMinorErrors -ext avi -ext mov -ext 3gp -ext asf -ext flac -ext flv -ext mp4 -ext mpg -r "-FileName<DateTimeOriginal" -dateformat "%%Y/%%m_%%d/%%Y%%m%%d_%%H%%M%%S%%%%-c.%%%%e" .
rem exiftool -preserve -overwrite_original -fixbase -progress --composite -fast2 -ignoreMinorErrors -ext mov -r "-FileName<CreateDate" -dateformat "%%Y/%%m_%%d/%%Y%%m%%d_%%H%%M%%S%%%%-c.%%%%e" .
rem quelques petits ajustemment
del *.thm 
del *.tmp
pause
:EOL