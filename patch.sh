echo =============== begin to patch source code ===============
for i in patches/*.patch
do
	echo -e "\033[01;33mapply $i...\033[00m"
	patch -f -p1 <$i
	res=$?
	if [ $res -ne 0 ]; then
		echo -e "\033[01;31mfailed\033[00m"
		echo -e " \033[01;33mtry to reverse apply $i...\033[00m"
		patch -f -p1 -R <$i && patch -f -p1 <$i
		res1=$?
		if [ $res1 -ne 0 ]; then
			echo -e " \033[01;31mfailed, please check your patch: [$i]\033[00m"
			exit -1
		else
			echo -e " \033[01;32msuccess\033[00m"
		fi
	else
		echo -e "\033[01;32msuccess\033[00m"
	fi
done
echo =============== finished patch source code ===============
