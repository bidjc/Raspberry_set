#########################################################################
# File Name: upload.sh
# Author: dengguangjie
# mail: 563200085@qq.com
# Created Time: 2016年04月04日 星期一 11时14分47秒
#########################################################################
#!/bin/bash
Nmb=$#
a=($@)
nnum=0;

CheckVarNum(){
	if [ $1 == "0" ] ;then
	    echo -e "eg: upload.sh add filename\nupload.sh init"
   	 	exit
	else
    	echo "do $1"
	fi
}
CheckCmd(){
		#echo "aa = ${a[$num]}"
	var=${a[$nnum]}
	echo "Check cmd:$var"
	echo "current var: $var"
	if [ $var == "test" ];then
    	echo "ssh -T git@github.com"
    	ssh -T git@github.com   #测试是否连接github成功
		nnum=$[$nnum+1]
	elif [ $var == "init" ];then
    	echo "git init"
	    git init  #此时git会在这个文件夹下创建一个隐藏目录，这个目录就是本地库了
		nnum=$[$nnum+1]
	elif [ $var == "bound" ];then
    	if [ ! -n "${a[$nnum+1]}" -o ! -n "${a[$nnum+2]}" ];then
        	echo "eg: upload.sh bound bidjc Raspberry"
	        exit
	    fi  
		git remote add origin git@github.com:"$2"/"$3".git
		nnum=$[$nnum+3]
	elif [ $var == "down" ];then
    	git pull origin master
		nnum=$[$nnum+1]
	elif [ $var == "add" ];then
		value1=${a[$nnum+1]}
		value2=${a[$nnum+2]}
    	if [ ! -n "$value1" -o ! -n "$value2" ];then
        	echo "eg: upload.sh add filename file discribe"
	        exit
    	fi  
	    git add $value1
    	git commit -m "$value2"
	    git push origin master
		nnum=$[$nnum+3]
	elif [ $var == "addall" ];then
		value1=${a[$nnum+1]}
    	if [ ! -n "$value1" ];then
	        echo "eg: upload.sh addall discribe"
    	    exit
	    fi  
    	git add .
	    git commit -m "$value1"
    	git push origin master
		nnum=$[$nnum+2]
	else
		nnum=$[$nnum+1]
fi
}
PrintVar(){
	num=1
	#local aa=($1)
	#for i in ${aa[*]};do
#	for i in ${a[*]};do
#		echo "var $num: $i"
#		CheckCmd
#		
#		let num+=1
#	done
	while [[ $nnum < $Nmb ]]
	do
		a1=${a[$nnum]}
		echo "var $num: $a1"
		CheckCmd
		let num+=1
	#	echo "nnum=[$nnum]	$Nmb=[$Nmb]"
	done
}
CheckVarNum $Nmb

PrintVar "${a[*]}"

#git remote add origin git@github.com:bidjc/Raspberry.git
#git pull origin master
