dir *.jpg /s /b > dir.txt
sed -e "s/G:\\Documents and Settings\\francois\\Mes documents\\dta\\fb\\/http:\\\\/" -e "s/\\/\//g"  -e "s/_s/_n/" dir.txt > dir2.txt
wget --random-wait -w 1 -nv -i dir2.txt
del dir.txt dir2.txt