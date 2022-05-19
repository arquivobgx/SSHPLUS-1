#!/bin/bash
IP=$(wget -qO- ipv4.icanhazip.com)
verif_ptrs() {
		porta=$1
		PT=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" | grep -v "COMMAND" | grep "LISTEN")
		for pton in $(echo -e "$PT" | cut -d: -f2 | cut -d' ' -f1 | uniq); do
			svcs=$(echo -e "$PT" | grep -w "$pton" | awk '{print $1}' | uniq)
			[[ "$porta" = "$pton" ]] && {
				echo -e "\n\033[1;31mPORTA \033[1;33m$porta \033[1;31mEM USO PELO \033[1;37m$svcs\033[0m"
				sleep 3
				fun_chuser
			}
		done
	}
fun_bar() {
		comando[0]="$1"
		comando[1]="$2"
		(
			[[ -e $HOME/fim ]] && rm $HOME/fim
			[[ ! -d /etc/SSHPlus ]] && rm -rf /bin/menu
			${comando[0]} >/dev/null 2>&1
			${comando[1]} >/dev/null 2>&1
			touch $HOME/fim
		) >/dev/null 2>&1 &
		tput civis
		echo -ne "\033[1;33mAGUARDE \033[1;37m- \033[1;33m["
		while true; do
			for ((i = 0; i < 18; i++)); do
				echo -ne "\033[1;31m#"
				sleep 0.1s
			done
			[[ -e $HOME/fim ]] && rm $HOME/fim && break
			echo -e "\033[1;33m]"
			sleep 1s
			tput cuu1
			tput dl1
			echo -ne "\033[1;33mAGUARDE \033[1;37m- \033[1;33m["
		done
		echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
		tput cnorm
	}
clear
fun_chuser() {
    clear
echo -e "\033[1;37m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
    echo -e "\E[44;1;37m            GERENCIAR CHECKUSER             \E[0m"
echo -e "\033[1;37m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    [[ $(netstat -nplt | grep -wc 'python3') != '0' ]] && {
			sks='\033[1;32mON'
			echo -e "\033[1;33mLink para o app http://$IP\033[1;37m:\033[1;32m$(netstat -nplt | grep 'python3' | awk {'print $4'} | cut -d: -f2 | xargs)/checkUser"
			echo ""
			echo -e "\033[1;33mLink para o app http://DOMINIODESSAVPS\033[1;37m:\033[1;32m$(netstat -nplt | grep 'python3' | awk {'print $4'} | cut -d: -f2 | xargs)/checkUser"
			echo ""
		} || {
			sks='\033[1;31mOFF'
		}
	[[ $(screen -list | grep -wc 'checkuser') != '0' ]] && var_sks1="\033[1;32m◉" || var_sks1="\033[1;31m○"
    echo ""
    echo -e "\033[1;31m[\033[1;36m1\033[1;31m] \033[1;37m• \033[1;33mATIVAR CHECKUSER $var_sks1 \033[0m"
    echo -e "\033[1;31m[\033[1;36m0\033[1;31m] \033[1;37m• \033[1;33mVOLTAR\033[0m"
    echo ""
    echo -ne "\033[1;32mO QUE DESEJA FAZER \033[1;33m?\033[1;37m "
    read resposta
    if [[ "$resposta" = '1' ]]; then
	if ps x | grep -w checkuser | grep -v grep 1>/dev/null 2>/dev/null; then
				clear
				echo -e "\E[41;1;37m             CHECKUSER              \E[0m"
				echo ""
				fun_socksoff() {
					for pidcheckuser in $(screen -ls | grep ".checkuser" | awk {'print $1'}); do
						screen -r -S "$pidcheckuser" -X quit
					done
					[[ $(grep -wc "checkuser" /etc/autostart) != '0' ]] && {
						sed -i '/checkuser/d' /etc/autostart
					}
					sleep 1
					screen -wipe >/dev/null
				}
				echo -e "\033[1;32mDESATIVANDO O CHECKUSER\033[1;33m"
				echo ""
				fun_bar 'fun_socksoff'
				echo ""
				echo -e "\033[1;32mCHECKUSER DESATIVADO COM SUCESSO!\033[1;33m"
				sleep 3
				fun_chuser
			else
				clear
				echo -e "\E[44;1;37m             CHECKUSER              \E[0m"
				echo ""
				echo -ne "\033[1;32mQUAL PORTA DESEJA ULTILIZAR \033[1;33m?\033[1;37m: "
				read porta
				[[ -z "$porta" ]] && {
					echo ""
					echo -e "\033[1;31mPorta inválida!"
					sleep 3
					clear
					fun_chuser
				}
				verif_ptrs $porta
				fun_inisocks() {
					sleep 1
					screen -dmS checkuser python3 /usr/lib/checkuser $porta;
					[[ $(grep -wc "checkuser" /etc/autostart) = '0' ]] && {
						echo -e "netstat -tlpn | grep -w $porta > /dev/null || {  screen -r -S 'checkuser' -X quit;  screen -dmS checkuser python3 /usr/lib/checkuser $porta; }" >>/etc/autostart
					} || {
						sed -i '/checkuser/d' /etc/autostart
						echo -e "netstat -tlpn | grep -w $porta > /dev/null || {  screen -r -S 'checkuser' -X quit;  screen -dmS checkuser python3 /usr/lib/checkuser $porta; }" >>/etc/autostart
					}
				}
				echo ""
				echo -e "\033[1;32mINICIANDO O CHECKUSER\033[1;33m"
				echo ""
				fun_bar 'fun_inisocks'
				echo ""
				echo -e "\033[1;32mCHECKUSER ATIVADO COM SUCESSO\033[1;33m"
				sleep 3
				fun_chuser
			fi
   elif [[ "$resposta" = '0' ]]; then
        echo ""
        echo -e "\033[1;31mSaindo...\033[0m"
        sleep 1
		clear
        menu
    else
        echo ""
        echo -e "\033[1;31mOpção inválida!\033[0m"
        sleep 1
        fun_chuser
    fi
}
fun_chuser
