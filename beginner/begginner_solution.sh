#! /bin/bash
## Emmanuel Cruz
## 01-07-2020
## Linux Challenge - beginner

## Create random temporary files
file1=$(mktemp random_XXXXX.txt)
file2=$(mktemp random_a_XXXXX.txt)
temp=$(mktemp random_sorted_XXXXX.tmp)

## Generate a random line of strings and numbers
## until the size of the random temporary file reaches 1 Mib
until [[ $(du -sb $file1 | awk '{print $1}') -ge 1048576 ]]
do
## Retrieve first five lines from /dev/urandom, delete anything that is not alphanumeric
## cut the first 15 characters and save them to temporary file1
  head -5 /dev/urandom | tr -cd '[:alpha:]' | cut -c -15 >> $file1
done

## Sort file and save all lines starting with an "a" save them to file2
sort $file1  |egrep '^[Aa]' > $file2

## Sort file and remove all lines starting with an "a" save them to file2
sort $file1 > $temp
sed /^[Aa]/d $temp > $file1

## Print how many lines starting with "a" where removed
echo "$(wc -l $file2 |awk '{print $1}') lines starting with 'a' where removed"

## remove temp file
rm -f $temp