
#!/bin/bash
clear
echo -e "\n\033[1;36mINICIANDO INSTALAÇÃO \033[1;33mAGUARDE..."
apt-get install figlet -y > /dev/null 2>&1
pip3 install flask > /dev/null 2>&1
rm /bin/chuser > /dev/null 2>&1
sleep 5
cd /bin || exit
wget https://github.com/alfainternet/SSHPLUS/raw/main/checkuser4g/chuser > /dev/null 2>&1
wget https://github.com/alfainternet/SSHPLUS/raw/main/checkuser4g/user/userscheck > /dev/null 2>&1
chmod 777 chuser > /dev/null 2>&1
chmod 777 userscheck > /dev/null 2>&1
clear
mkdir /etc/rec > /dev/null 2>&1
echo -e 'By: @ALFAINTERNET' > /etc/rec/licence
echo -e 'By: @ALFAINTERNET' > /usr/lib/licence
mkdir /usr/lib/checkuser > /dev/null 2>&1
cd /usr/lib/checkuser || exit
rm checkuser.py > /dev/null 2>&1
wget https://github.com/alfainternet/SSHPLUS/raw/main/checkuser4g/checkuser.py > /dev/null 2>&1
chmod 777 checkuser.py > /dev/null 2>&1
clear
echo -e "        \033[1;33m • \033[1;32mINSTALAÇÃO CONCLUÍDA\033[1;33m • \033[0m"
sleep 2
clear
echo ""
echo -e "\033[1;31m \033[1;33mCOMANDO PRINCIPAL: \033[1;32mchuser\033[0m"
echo ""
echo -e "\033[1;33m MAIS INFORMAÇÕES \033[1;31m(\033[1;36mTELEGRAM\033[1;31m): \033[1;37m@ALFAINTERNET\033[0m"
cat /dev/null > ~/.bash_history && history -c
exit
