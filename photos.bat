@echo off

:start
rem echo off
echo ajout de commentaire exif
set choice=
rem set /p choice=1. rien 2. francois pegory 3. quitter
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='2' exiftool -L -lang fr -e -v0 -m -fast2 -P -overwrite_original "-UserComment=FRANCOIS PEGORY" "-Artist=FRANCOIS PEGORY" "-copyright=FRANCOIS PEGORY" .
if '%choice%'=='3' goto EOL
echo rotation 
d:\bat\jhead -ft -autorot -exonly *.*

echo modification du nom du fichier
rem -preserve : preserbe date time, -e dont calculate composite tag, -F Fix the base for maker notes offset
exiftool -r -progress -preserve -overwrite_original -fixbase --composite -fast2 -ignoreMinorErrors "-FileName<DateTimeOriginal" -dateformat "%%Y/%%m_%%d/%%Y%%m%%d_%%H%%M%%S%%%%-c.%%%%e" .
modification du nom des fichier video
exiftool -preserve -overwrite_original -fixbase -progress --composite -fast2 -ignoreMinorErrors -ext avi -r "-FileName<DateTimeOriginal" -dateformat "%%Y/%%m_%%d/%%Y%%m%%d_%%H%%M%%S%%%%-c.%%%%e" .
exiftool -preserve -overwrite_original -fixbase -progress --composite -fast2 -ignoreMinorErrors -ext mov -r "-FileName<CreateDate" -dateformat "%%Y/%%m_%%d/%%Y%%m%%d_%%H%%M%%S%%%%-c.%%%%e" .

rem quelques petits ajustemment
del *.thm 
del *.tmp
if %ERRORLEVEL% NEQ 0 goto EOL
pause
:EOL