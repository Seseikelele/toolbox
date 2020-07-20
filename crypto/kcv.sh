if [ -e key ]
then
	echo using key `cat key`
else
	perl -E "print '0' x 48" > key
	echo 'created null 3des key'
fi
perl -E "print \"\x00\" x 64" > .nulls
KCV=$(openssl enc -K `cat key` -in .nulls -des-ede3 | xxd -g 3 -l 3 -u -p)
echo "KCV: $KCV"
rm -f .nulls