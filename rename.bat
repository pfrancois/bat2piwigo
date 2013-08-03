@echo off
rem on va vers le repertoire de lancement
d:\bat\jhead -ft -autorot -exonly "%~1"
rem -preserve : preserve date time, --composite dont calculate composite tag, -F Fix the base for maker notes offset
echo "%~1"
exiftool  -progress -preserve -overwrite_original -fixbase --composite -fast2 -ext jpg -ext jpeg -ignoreMinorErrors "-FileName<DateTimeOriginal" -dateformat "%%Y%%m%%d_%%H%%M%%S%%%%-c.%%%%e" "%~1"