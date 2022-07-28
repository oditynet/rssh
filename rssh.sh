#!/bin/bash
echo $1 ": dir src"
echo $2 ": dir dst"
echo "Parallels: $3"
echo "host:" $4
echo "Prepare lists..."
find $1 -type f -print > in
count=$(cat in|wc -l)
count_1=$((count/$3))
echo $count" - > "$count_1

for i in $(seq 2 $3); do
	sed -n '1,'$count_1'p' in > in$i
	sed -i '1,'$count_1'd' in
done
sed -n '1,$ p' in > in1
#sed -i '1,$ d' in
rm in
echo "Start copy..."
for i in $(seq 1 $3); do
	l=""
	while read -r line;
	do
		l=$line" "$l
	done < in$i
	#echo "File: "in$i
	#$(cat in$i| xargs -P1 -iz scp -i 44_rsa z $4:$2) &
	scp -i 44_rsa $(echo $l) $4:$2 &
done
ps aux|grep scp
wait

rm -rf in*
