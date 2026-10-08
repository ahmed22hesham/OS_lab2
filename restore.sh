#!/bin/bash
dir=$1
malicious_dir=$2
whitelist=$3
shopt -s nullglob #AI helped me with it to make the empty list emppty instead of having 1
while true
do

files=("$malicious_dir"/*)

if [ "${#files[@]}" -lt 1 ]
then 
echo  "No malicious files to review"
break
fi


ls "$malicious_dir"
read -p "choose file" number
if [ "$number" -gt "${#files[@]}" ]
then
	echo "file doesnot exist"
	continue
fi

echo "Choose option:"
echo "1) Restore this file back into dir"
echo "2) Permanently delete this file"
echo "3) Leave as-is and go back to the list"
read -p "> " choice

case "$choice" in 
	"1")
	cp "${files[$((number - 1))]}" "$dir"
	cp "${files[$((number - 1))]}" "$whitelist" 
	rm  "${files[$((number - 1))]}"
	echo "Restored < ${files[$((number - 1))]} > to <$dir> "
	;;
	"2")
	rm  "${files[$((number - 1))]}" 
	echo "< ${files[$((number - 1))]} > permanentaly deleted"
	;;
	"3")
	continue
	;;
esac
done
