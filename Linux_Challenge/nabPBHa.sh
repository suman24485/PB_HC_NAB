#!/bin/bash
#read -p "Enter repo name:" repo_name
#read -p "Enter tag1:" tag1
#read -p "Enter tag2:" tag2
#echo "Repo $repo_name, Tag1 $tag1, Tag2 $tag2"
#cd $repo_name
#git diff $tag1 $tag2 --name-only > fileList.txt
rm -rf finalFileList.txt
for i in `cat fileList.txt`
do
	nameCheck=`echo \`basename $i\` | sed -e 's/^\(.\{4\}\).*/\1/'`
	if [[ "$nameCheck" != "Disp" ]]; then
		echo $nameCheck
		echo $i >> finalFileList.txt
	fi
done
	count=0
for i in `cat finalFileList.txt`
do
	grep GOOGLE_URL $i
	if [ $? == 0 ]; then
		sed -i "s/GOOGLE_URL/https\:\/\/localhost\:8443/g" $i
		((count = count + 1 ))
	fi
done
	echo $count
	if [ $count == 0 ]; then
		echo "No files have the string GOOGLE_URL"
	fi
rm -rf testPayload.json
cat << EOF >> testPayload.json
{
"status": "success",
"url" : https://google.com:443
}
EOF
cat testPayload.json
curl -vX POST https://google.com:443 -d @testPayload.json --header "Content-Type: application/json" > /dev/null
echo "status:" $?
