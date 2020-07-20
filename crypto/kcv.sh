#!/usr/bin/env bash
#https://ricardoanderegg.com/posts/bash_wrap_functions/
#https://linuxhint.com/wait_command_linux/

function check_key_exists()
{
	if [ -e key ]
	then
		echo using key `cat key`
	else
		perl -E "print '0' x 48" > key
		echo 'created null 3des key'
	fi
}

function generate_nulls()
{
	perl -E "print \"\x00\" x 64" > .nulls
}

function calculate_kcv()
{
	KCV=$(openssl enc -K `cat key` -in .nulls -des-ede3 | xxd -g 3 -l 3 -u -p)
	echo "KCV: $KCV"
}

check_key_exists & generate_nulls
wait
calculate_kcv
rm -f .nulls