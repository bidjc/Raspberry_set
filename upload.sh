#########################################################################
# File Name: upload.sh
# Author: dengguangjie
# mail: 563200085@qq.com
# Created Time: 2016年04月04日 星期一 11时14分47秒
#########################################################################
#!/bin/bash
Nmb=$#
PrintVar(){
	aa=$1
	for i in $1[@];do
		echo $i
	done
}
a=($@)
PrintVar $a
echo "number is $Nmb"
echo $1
if [ ! -n "$1" ] ;then
	echo "eg: upload.sh add filename\nupload.sh init"
	exit
else
	echo "do $1"
fi
if [ $1 == "test" ];then
	echo "ssh -T git@github.com"
	ssh -T git@github.com   #测试是否连接github成功
elif [ $1 == "init" ];then
	echo "git init"
	git init  #此时git会在这个文件夹下创建一个隐藏目录，这个目录就是本地库了
elif [ $1 == "bound" ];then
	if [ ! -n "$2" -o ! -n "$3" ];then
		echo "eg: upload.sh bound bidjc Raspberry"
		exit
	fi
	git remote add origin git@github.com:"$2"/"$3".git
elif [ $1 == "down" ];then
	git pull origin master
elif [ $1 == "add" ];then
	if [ ! -n "$2" -o ! -n "$3" ];then
        echo "eg: upload.sh add filename file discribe"
        exit
    fi	
	git add $2
	git commit -m "$3"
	git push origin master
elif [ $1 == "addall" ];then
    if [ ! -n "$2" ];then
        echo "eg: upload.sh addall discribe"
        exit
    fi  
    git add .
    git commit -m "$2"
    git push origin master
fi

#git remote add origin git@github.com:bidjc/Raspberry.git
#git pull origin master
