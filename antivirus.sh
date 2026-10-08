#!/bin/sh
dir=$1
malicious_dir=$2
interval_secs=$3

ls -l "$dir" > directory-info.last

while true
do
   ls -l "$dir" > directory-info.new

   if ! cmp -s directory-info.last directory-info.new  
   then
	for file in "$dir"/*
	do

	    case "$file" in   #Asked AI in the  flagged extension part
   	       *.exe|*.bat|*.vbs|*.scr|*.ps1)
       		cp "$file" "$malicious_dir"
		rm  "$file"
		echo "<$file> is malicious and it is DELETED"
		continue
       		;;
	    esac

	    if grep -E "virus|trojan|malware|worm|ransomware" "$file" 
	    then
		cp  "$file" "$malicious_dir"
		rm "$file"
		echo "<$file> is malicious and it is DELETED"
	    fi
	done
	cp directory-info.new directory-info.last
    fi
	sleep "$interval_secs"
done

