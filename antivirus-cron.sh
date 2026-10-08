#!/bin/sh
dir=$1
malicious_dir=$2
last=$3
whitelist=$4

   ls -l "$dir" > directory-info.new
   if ! cmp -s "$last" directory-info.new  
   then
        for file in "$dir"/*
        do
	name=$(basename "$file")
	if [ ! -e "$whitelist/$name" ]
	then
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
	fi
        done
	ls -l "$dir" > directory-info.new
        cp directory-info.new "$last"
    fi
