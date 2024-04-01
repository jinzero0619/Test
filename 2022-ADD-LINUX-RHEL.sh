# 01 start
#================================================================================
# U-01 root 계정 원격접속 제한
# 시스템 정책에 root 계정의 원격터미널 접속차단 설정이 적용되어 있는지 점검

echo "KB-AU-01" > $BingoDIR/01.title

echo "YES" > $BingoDIR/01.result

echo "" > $BingoDIR/01.msg

echo "$LOG_SECTION" > $BingoDIR/01.log

if [ `ps -ef | grep "telnet" | grep -v "grep" | wc -l` -ge 1 ]
then
	if [ -f /etc/securetty ]
	then
		if [ `cat /etc/securetty | grep -i 'pts' | wc -l` -eq 0 ]
		then
			if [ `cat /etc/pam.d/login | grep -i "auth" | grep -i "required" | grep -i "/lib/security/pam_securetty.so" | grep -v "^ *#" | wc -l` -eq 1 ]
			then
				echo "YES" >> $BingoDIR/01.result
                echo "------------------------------" >> $BingoDIR/01.log
                echo "File: /etc/pam.d/login" >> $BingoDIR/01.log
                echo "------------------------------" >> $BingoDIR/01.log
                cat /etc/pam.d/login | grep -i "auth" | grep -i "required" | grep -i "/lib/security/pam_securetty.so" >> $BingoDIR/01.log
            elif [ `cat /etc/pam.d/login | grep -i "auth" | grep -i "required" | grep -i "/lib64/security/pam_securetty.so" | grep -v "^ *#" | wc -l` -eq 1 ]
			then
                echo "YES" >> $BingoDIR/01.result
                echo "------------------------------" >> $BingoDIR/01.log
                echo "File: /etc/pam.d/login" >> $BingoDIR/01.log
                echo "------------------------------" >> $BingoDIR/01.log
                cat /etc/pam.d/login | grep -i "auth" | grep -i "required" | grep -i "/lib64/security/pam_securetty.so" >> $BingoDIR/01.log
			else
				echo "NO" >> $BingoDIR/01.result
                echo "KB-AU-01-N-01" >> $BingoDIR/01.msg
                echo "------------------------------" >> $BingoDIR/01.log
                echo "File: /etc/pam.d/login" >> $BingoDIR/01.log
                echo "------------------------------" >> $BingoDIR/01.log
                cat /etc/pam.d/login | grep -i "auth" | grep -i "required" | grep -i "/lib/security/pam_securetty.so" >> $BingoDIR/01.log
                cat /etc/pam.d/login | grep -i "auth" | grep -i "required" | grep -i "/lib64/security/pam_securetty.so" >> $BingoDIR/01.log
			fi
		else
			echo "NO" >> $BingoDIR/01.result
			echo "KB-AU-01-N-02" > $BingoDIR/01.msg
			if [ `cat /etc/pam.d/login | grep -i "auth" | grep -i "required" | grep -i "/lib/security/pam_securetty.so" | grep -v "^ *#" | wc -l` -eq 1 ]
			then
				echo "YES" >> $BingoDIR/01.result
                echo "------------------------------" >> $BingoDIR/01.log
                echo "File: /etc/securetty" >> $BingoDIR/01.log
                echo "------------------------------" >> $BingoDIR/01.log
                cat /etc/securetty | grep -i 'pts' > $BingoDIR/01.log
                echo "------------------------------" >> $BingoDIR/01.log
                echo "File: /etc/pam.d/login" >> $BingoDIR/01.log
                echo "------------------------------" >> $BingoDIR/01.log
                cat /etc/pam.d/login | grep -i "auth" | grep -i "required" | grep -i "/lib/security/pam_securetty.so" >> $BingoDIR/01.log
			elif [ `cat /etc/pam.d/login | grep -i "auth" | grep -i "required" | grep -i "/lib64/security/pam_securetty.so" | grep -v "^ *#" | wc -l` -eq 1 ]
			then
				echo "YES" >> $BingoDIR/01.result
                echo "------------------------------" >> $BingoDIR/01.log
                echo "File: /etc/securetty" >> $BingoDIR/01.log
                echo "------------------------------" >> $BingoDIR/01.log
                cat /etc/securetty | grep -i 'pts' > $BingoDIR/01.log
                echo "------------------------------" >> $BingoDIR/01.log
                echo "File: /etc/pam.d/login" >> $BingoDIR/01.log
                echo "------------------------------" >> $BingoDIR/01.log
                cat /etc/pam.d/login | grep -i "auth" | grep -i "required" | grep -i "/lib64/security/pam_securetty.so" >> $BingoDIR/01.log
            else
				echo "NO" >> $BingoDIR/01.result
				echo "KB-AU-01-N-01" >> $BingoDIR/01.msg
                echo "------------------------------" >> $BingoDIR/01.log
                echo "File: /etc/securetty" >> $BingoDIR/01.log
                echo "------------------------------" >> $BingoDIR/01.log
                cat /etc/securetty | grep -i 'pts' > $BingoDIR/01.log
                echo "------------------------------" >> $BingoDIR/01.log
                echo "File: /etc/pam.d/login" >> $BingoDIR/01.log
                echo "------------------------------" >> $BingoDIR/01.log
                cat /etc/pam.d/login | grep -i "auth" | grep -i "required" | grep -i "/lib/security/pam_securetty.so" >> $BingoDIR/01.log
                cat /etc/pam.d/login | grep -i "auth" | grep -i "required" | grep -i "/lib64/security/pam_securetty.so" >> $BingoDIR/01.log
			fi
		fi
	else 
		echo "MANUAL" >> $BingoDIR/01.result
		echo "KB-AU-01-M-01" > $BingoDIR/01.msg
        echo "------------------------------" >> $BingoDIR/01.log
        echo "File: /etc/securetty" >> $BingoDIR/01.log
        echo "------------------------------" >> $BingoDIR/01.log
        echo "NO FILE" >> $BingoDIR/01.log
	fi
else 
    echo "YES" >> $BingoDIR/01.result
    echo "KB-AU-01-Y-01" > $BingoDIR/01.msg
fi

if [ -f /etc/ssh/sshd_config ]
then
	if [ `cat /etc/ssh/sshd_config | grep -i "permitrootlogin" | grep -i "no" | grep -v "^ *#" | wc -l` -eq 1 ]
	then
		echo "YES" >> $BingoDIR/01.result
        echo "------------------------------" >> $BingoDIR/01.log
        echo "File: /etc/ssh/sshd_config" >> $BingoDIR/01.log
        echo "------------------------------" >> $BingoDIR/01.log
        cat /etc/ssh/sshd_config | grep -i "permitrootlogin" >> $BingoDIR/01.log 
	else
		echo "NO" >> $BingoDIR/01.result
		echo "KB-AU-01-N-03" >> $BingoDIR/01.msg
        echo "------------------------------" >> $BingoDIR/01.log
        echo "File: /etc/ssh/sshd_config" >> $BingoDIR/01.log
        echo "------------------------------" >> $BingoDIR/01.log
        cat /etc/ssh/sshd_config | grep -i "permitrootlogin" >> $BingoDIR/01.log 
	fi
else
	echo "MANUAL" >> $BingoDIR/01.result
	echo "KB-AU-01-M-02" >> $BingoDIR/01.msg
fi

if [ `cat $BingoDIR/01.result | grep -i "MANUAL" | wc -l` -eq 1 ]
then 
    echo "MANUAL" > $BingoDIR/01.result
elif [ `cat $BingoDIR/01.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/01.result
else 
    echo "YES" > $BingoDIR/01.result
    echo "KB-AU-01-Y-02" >> $BingoDIR/01.msg
fi

# 전체파일출력
echo "$LOG_ALL" >> $BingoDIR/01.log
if [ -f /etc/securetty ]
then
    echo "------------------------------" >> $BingoDIR/01.log
    echo "File: /etc/securetty" >> $BingoDIR/01.log
    echo "------------------------------" >> $BingoDIR/01.log
    cat /etc/securetty >> $BingoDIR/01.log
else
    echo "------------------------------" >> $BingoDIR/01.log
    echo "File: /etc/securetty" >> $BingoDIR/01.log
    echo "------------------------------" >> $BingoDIR/01.log
    echo "NO FILE" >> $BingoDIR/01.log
fi

echo "------------------------------" >> $BingoDIR/01.log
echo "File: /etc/pam.d/login" >> $BingoDIR/01.log
echo "------------------------------" >> $BingoDIR/01.log
cat /etc/pam.d/login >> $BingoDIR/01.log
echo "------------------------------" >> $BingoDIR/01.log
echo "File: /etc/ssh/sshd_config" >> $BingoDIR/01.log
echo "------------------------------" >> $BingoDIR/01.log
cat /etc/ssh/sshd_config >> $BingoDIR/01.log 

# 01 end

# 02 start
#================================================================================
# U-02 비밀번호 복잡성 설정
# 시스템 정책에 사용자 계정(root 및 일반계정 모두 해당) 패스워드 복잡성 관련 설정이 되어 있는지 점검
echo "KB-AU-02" > $BingoDIR/02.title

echo "YES" > $BingoDIR/02.result

echo "" > $BingoDIR/02.msg

echo "$LOG_SECTION" > $BingoDIR/02.log

if [ "$((LV))" -le 6 ]
then
    if [ `cat /etc/pam.d/system-auth | grep -i "password" | grep -i "requisite" | grep -i "/lib/security/" | grep -i "pam_cracklib.so" | grep -iv "^ *#" | wc -l` -ge 1 ]
    then
        echo "------------------------------" >> $BingoDIR/02.log
        echo "File: /etc/pam.d/system-auth" >> $BingoDIR/02.log
        echo "------------------------------" >> $BingoDIR/02.log

        echo "YES" >> $BingoDIR/02.result
        cat /etc/pam.d/system-auth | grep -i "password" | grep -i "requisite" | grep -i "/lib/security/" | grep -i "pam_cracklib.so" | grep -iv "^ *#" >> $BingoDIR/02.system-auth
    elif [ `cat /etc/pam.d/system-auth | grep -i "password" | grep -i "requisite" | grep -i "/lib64/security/" | grep -i "pam_cracklib.so" | grep -iv "^ *#" | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/02.result
        
        echo "------------------------------" >> $BingoDIR/02.log
        echo "File: /etc/pam.d/system-auth" >> $BingoDIR/02.log
        echo "------------------------------" >> $BingoDIR/02.log
        cat /etc/pam.d/system-auth | grep -i "password" | grep -i "requisite" | grep -i "/lib64/security/" | grep -i "pam_cracklib.so" | grep -iv "^ *#" >> $BingoDIR/02.system-auth
    else
        echo "NO" >> $BingoDIR/02.result
        echo "KB-AU-02-N-01" > $BingoDIR/02.msg

        echo "------------------------------" >> $BingoDIR/02.log
        echo "File: /etc/pam.d/system-auth" >> $BingoDIR/02.log
        echo "------------------------------" >> $BingoDIR/02.log
        cat /etc/pam.d/system-auth | grep -i "password" | grep -i "requisite" | grep -i "/lib/security/" | grep -i "pam_cracklib.so" | grep -iv "^ *#" >> $BingoDIR/02.system-auth
        cat /etc/pam.d/system-auth | grep -i "password" | grep -i "requisite" | grep -i "/lib64/security/" | grep -i "pam_cracklib.so" | grep -iv "^ *#" >> $BingoDIR/02.system-auth
    fi
    
    if [ `cat /etc/pam.d/system-auth | grep -i "minlen" | grep "9" | grep -iv "^ *#" | wc -l` -ge 1 ]
	then
        echo "YES" >> $BingoDIR/02.result
        cat /etc/pam.d/system-auth | grep -i "minlen" | grep "9" | grep -iv "^ *#" >> $BingoDIR/02.system-auth
    else 
        echo "NO" >> $BingoDIR/02.result
        echo "KB-AU-02-N-02" >> $BingoDIR/02.msg
        cat /etc/pam.d/system-auth | grep -i "minlen" >> $BingoDIR/02.system-auth
    fi

    if [ `cat /etc/pam.d/system-auth | grep -i "retry" | grep "3" | grep -iv "^ *#" | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/02.result
        cat /etc/pam.d/system-auth | grep -i "retry" | grep "3" | grep -iv "^ *#" >> $BingoDIR/02.system-auth
    else 
        echo "NO" >> $BingoDIR/02.result
        echo "KB-AU-02-N-03" >> $BingoDIR/02.msg
        cat /etc/pam.d/system-auth | grep -i "retry" >> $BingoDIR/02.system-auth
    fi

    if [ `cat /etc/pam.d/system-auth | grep -i "lcredit" | grep "\-1" | grep -iv "^ *#" | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/02.result
        cat /etc/pam.d/system-auth | grep -i "lcredit" | grep "\-1" | grep -iv "^ *#" >> $BingoDIR/02.system-auth
    else 
        echo "NO" >> $BingoDIR/02.result
        echo "KB-AU-02-N-04" >> $BingoDIR/02.msg
        cat /etc/pam.d/system-auth | grep -i "lcredit" >> $BingoDIR/02.system-auth
    fi

    if [ `cat /etc/pam.d/system-auth | grep -i "ucredit" | grep "\-1" | grep -iv "^ *#" | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/02.result
        cat /etc/pam.d/system-auth | grep -i "ucredit" | grep "\-1" | grep -iv "^ *#" >> $BingoDIR/02.system-auth
    else 
        echo "NO" >> $BingoDIR/02.result
        echo "KB-AU-02-N-05" >> $BingoDIR/02.msg
        cat /etc/pam.d/system-auth | grep -i "ucredit" >> $BingoDIR/02.system-auth
    fi

    if [ `cat /etc/pam.d/system-auth | grep -i "dcredit" | grep "\-1" | grep -iv "^ *#" | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/02.result
        cat /etc/pam.d/system-auth | grep -i "dcredit" | grep "\-1" | grep -iv "^ *#" >> $BingoDIR/02.system-auth
    else 
        echo "NO" >> $BingoDIR/02.result
        echo "KB-AU-02-N-06" >> $BingoDIR/02.msg
        cat /etc/pam.d/system-auth | grep -i "dcredit" >> $BingoDIR/02.system-auth
    fi

    if [ `cat /etc/pam.d/system-auth | grep -i "ocredit" | grep "\-1" | grep -iv "^ *#" | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/02.result
        cat /etc/pam.d/system-auth | grep -i "ocredit" | grep "\-1" | grep -iv "^ *#" >> $BingoDIR/02.system-auth
    else 
        echo "NO" >> $BingoDIR/02.result
        echo "KB-AU-02-N-07" >> $BingoDIR/02.msg
        cat /etc/pam.d/system-auth | grep -i "ocredit" >> $BingoDIR/02.system-auth
    fi
    # 중복값 제거 후 log 파일에 저장
    sort -u $BingoDIR/02.system-auth >> $BingoDIR/02.log

    # RHEL 5 이하 전체파일 출력
    echo "$LOG_ALL" >> $BingoDIR/02.log
    echo "------------------------------" >> $BingoDIR/02.log
    echo "File: /etc/pam.d/system-auth" >> $BingoDIR/02.log
    echo "------------------------------" >> $BingoDIR/02.log
    cat /etc/pam.d/system-auth >> $BingoDIR/02.log

elif [ "$((LV))" -ge 7 ]
then
    if [ `cat /etc/pam.d/system-auth | grep -i 'password' | grep -i 'required' | grep -i "pam_pwquality.so" | wc -l` -eq 1 ]
    then
        echo "YES" >> $BingoDIR/02.result
        echo "------------------------------" >> $BingoDIR/02.log
        echo "File: /etc/pam.d/system-auth" >> $BingoDIR/02.log
        echo "------------------------------" >> $BingoDIR/02.log
        cat /etc/pam.d/system-auth | grep -i 'password' | grep -i 'required' | grep -i "pam_pwquality.so" >> $BingoDIR/02.system-auth
    else 
        echo "NO" >> $BingoDIR/02.result
        echo "KB-AU-02-N-08" >> $BingoDIR/02.msg
        echo "------------------------------" >> $BingoDIR/02.log
        echo "File: /etc/pam.d/system-auth" >> $BingoDIR/02.log
        echo "------------------------------" >> $BingoDIR/02.log
        cat /etc/pam.d/system-auth | grep -i 'password' | grep -i 'required' | grep -i "pam_pwquality.so" >> $BingoDIR/02.system-auth
    fi

    if [ `cat /etc/pam.d/system-auth | grep -i 'password' | grep -i 'required' | grep -i "enforce_for_root" | wc -l` -eq 1 ]
    then
        echo "YES" >> $BingoDIR/02.result
        cat /etc/pam.d/system-auth | grep -i 'password' | grep -i 'required' | grep -i "enforce_for_root" >> $BingoDIR/02.system-auth
    else 
        echo "NO" >> $BingoDIR/02.result
        echo "KB-AU-02-N-09" >> $BingoDIR/02.msg
        cat /etc/pam.d/system-auth | grep -i 'password' | grep -i 'required' | grep -i "enforce_for_root" >> $BingoDIR/02.system-auth
    fi

    if [ `cat /etc/pam.d/system-auth | grep -i 'password' | grep -i 'required' | grep -i "retry" | grep "3" | grep -iv "^ *#" | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/02.result
        cat /etc/pam.d/system-auth | grep -i 'password' | grep -i 'required' | grep -i "retry" >> $BingoDIR/02.system-auth
    else 
        echo "NO" >> $BingoDIR/02.result
        echo "KB-AU-02-N-18" >> $BingoDIR/02.msg
        cat /etc/pam.d/system-auth | grep -i 'password' | grep -i 'required' | grep -i "retry" >> $BingoDIR/02.system-auth
    fi

    # 중복값 제거 후 log 파일에 저장
    sort -u $BingoDIR/02.system-auth >> $BingoDIR/02.log

    if [ `cat /etc/pam.d/password-auth | grep -i 'password' | grep -i 'required' | grep -i "pam_pwquality.so" | wc -l` -eq 1 ]
    then
        echo "YES" >> $BingoDIR/02.result
        echo "------------------------------" >> $BingoDIR/02.log
        echo "File: /etc/pam.d/password-auth" >> $BingoDIR/02.log
        echo "------------------------------" >> $BingoDIR/02.log
        cat /etc/pam.d/password-auth | grep -i 'password' | grep -i 'required' | grep -i "pam_pwquality.so" >> $BingoDIR/02.password-auth
    else 
        echo "NO" >> $BingoDIR/02.result
        echo "KB-AU-02-N-10" >> $BingoDIR/02.msg
        echo "------------------------------" >> $BingoDIR/02.log
        echo "File: /etc/pam.d/password-auth" >> $BingoDIR/02.log
        echo "------------------------------" >> $BingoDIR/02.log
        cat /etc/pam.d/password-auth | grep -i 'password' | grep -i 'required' | grep -i "pam_pwquality.so" >> $BingoDIR/02.password-auth
    fi

    if [ `cat /etc/pam.d/password-auth | grep -i 'password' | grep -i 'required' | grep -i "enforce_for_root" | wc -l` -eq 1 ]
    then
        echo "YES" >> $BingoDIR/02.result
        cat /etc/pam.d/password-auth | grep -i 'password' | grep -i 'required' | grep -i "enforce_for_root" >> $BingoDIR/02.password-auth
    else 
        echo "NO" >> $BingoDIR/02.result
        echo "KB-AU-02-N-11" >> $BingoDIR/02.msg
        cat /etc/pam.d/password-auth | grep -i 'password' | grep -i 'required' | grep -i "enforce_for_root" >> $BingoDIR/02.password-auth
    fi

    if [ `cat /etc/pam.d/password-auth | grep -i 'password' | grep -i 'required' | grep -i "retry" | grep "3" | grep -iv "^ *#" | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/02.result
        cat /etc/pam.d/password-auth | grep -i 'password' | grep -i 'required' | grep -i "retry" >> $BingoDIR/02.password-auth
    else 
        echo "NO" >> $BingoDIR/02.result
        echo "KB-AU-02-N-12" >> $BingoDIR/02.msg
        cat /etc/pam.d/password-auth | grep -i 'password' | grep -i 'required' | grep -i "retry" >> $BingoDIR/02.password-auth
    fi

    # 중복값 제거 후 log 파일에 저장
    sort -u $BingoDIR/02.password-auth >> $BingoDIR/02.log

    if [ `cat /etc/security/pwquality.conf | grep -i "minlen" | grep "9" | grep -iv "^ *#" | wc -l` -eq 1 ]
    then
        echo "YES" >> $BingoDIR/02.result
        echo "------------------------------" >> $BingoDIR/02.log
        echo "File: /etc/security/pwquality.conf" >> $BingoDIR/02.log
        echo "------------------------------" >> $BingoDIR/02.log
        cat /etc/security/pwquality.conf | grep -i "minlen" | grep "9" | grep -iv "^ *#" >> $BingoDIR/02.pwquality.conf
    else 
        echo "NO" >> $BingoDIR/02.result
        echo "KB-AU-02-N-13" >> $BingoDIR/02.msg
        echo "------------------------------" >> $BingoDIR/02.log
        echo "File: /etc/security/pwquality.conf" >> $BingoDIR/02.log
        echo "------------------------------" >> $BingoDIR/02.log
        cat /etc/security/pwquality.conf | grep -i "minlen" >> $BingoDIR/02.pwquality.conf
    fi

    if [ `cat /etc/security/pwquality.conf | grep -i "lcredit" | grep "\-1" | grep -iv "^ *#" | wc -l` -eq 1 ]
    then
        echo "YES" >> $BingoDIR/02.result
        cat /etc/security/pwquality.conf | grep -i "lcredit" | grep "\-1" | grep -iv "^ *#" >> $BingoDIR/02.pwquality.conf
    else 
        echo "NO" >> $BingoDIR/02.result
        echo "KB-AU-02-N-14" >> $BingoDIR/02.msg
        cat /etc/security/pwquality.conf | grep -i "lcredit" >> $BingoDIR/02.pwquality.conf
    fi

    if [ `cat /etc/security/pwquality.conf | grep -i "ucredit" | grep "\-1" | grep -iv "^ *#" | wc -l` -eq 1 ]
    then
        echo "YES" >> $BingoDIR/02.result
        cat /etc/security/pwquality.conf | grep -i "ucredit" | grep "\-1" | grep -iv "^ *#" >> $BingoDIR/02.pwquality.conf
    else 
        echo "NO" >> $BingoDIR/02.result
        echo "KB-AU-02-N-15" >> $BingoDIR/02.msg
        cat /etc/security/pwquality.conf | grep -i "ucredit"  >> $BingoDIR/02.pwquality.conf
    fi

    if [ `cat /etc/security/pwquality.conf | grep -i "dcredit" | grep "\-1" | grep -iv "^ *#" | wc -l` -eq 1 ]
    then
        echo "YES" >> $BingoDIR/02.result
        cat /etc/security/pwquality.conf | grep -i "dcredit" | grep "\-1" | grep -iv "^ *#" >> $BingoDIR/02.pwquality.conf
    else 
        echo "NO" >> $BingoDIR/02.result
        echo "KB-AU-02-N-16" >> $BingoDIR/02.msg
        cat /etc/security/pwquality.conf | grep -i "dcredit" >> $BingoDIR/02.pwquality.conf
    fi

    if [ `cat /etc/security/pwquality.conf | grep -i "ocredit" | grep "\-1" | grep -iv "^ *#" | wc -l` -eq 1 ]
    then
        echo "YES" >> $BingoDIR/02.result
        cat /etc/security/pwquality.conf | grep -i "ocredit" | grep "\-1" | grep -iv "^ *#" >> $BingoDIR/02.pwquality.conf
    else 
        echo "NO" >> $BingoDIR/02.result
        echo "KB-AU-02-N-17" >> $BingoDIR/02.msg
        cat /etc/security/pwquality.conf | grep -i "ocredit" >> $BingoDIR/02.pwquality.conf
    fi
    # 중복값 제거 후 log 파일에 저장
    sort -u $BingoDIR/02.pwquality.conf >> $BingoDIR/02.log

    # RHEL 7 이상 전체 파일 출력
    echo "$LOG_ALL" >> $BingoDIR/02.log
    echo "------------------------------" >> $BingoDIR/02.log
    echo "File: /etc/pam.d/system-auth" >> $BingoDIR/02.log
    echo "------------------------------" >> $BingoDIR/02.log
    cat /etc/pam.d/system-auth >> $BingoDIR/02.log
    echo "------------------------------" >> $BingoDIR/02.log
    echo "File: /etc/pam.d/password-auth" >> $BingoDIR/02.log
    echo "------------------------------" >> $BingoDIR/02.log
    cat /etc/pam.d/password-auth >> $BingoDIR/02.log
    echo "------------------------------" >> $BingoDIR/02.log
    echo "File: /etc/security/pwquality.conf" >> $BingoDIR/02.log
    echo "------------------------------" >> $BingoDIR/02.log
    cat /etc/security/pwquality.conf >> $BingoDIR/02.log

else
	echo "MANUAL" >> $BingoDIR/02.result
	echo "KB-AU-02-M-01" > $BingoDIR/02.msg
    cat /etc/*release* > $BingoDIR/02.log
fi

if [ `cat $BingoDIR/02.result | grep -i "MANUAL" | wc -l` -ge 1 ]
then 
    echo ""MANUAL > $BingoDIR/02.result
elif [ `cat $BingoDIR/02.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/02.result
else 
    echo "YES" > $BingoDIR/02.result
    echo "KB-AU-02-Y-01" > $BingoDIR/02.msg
fi

unset LINUX_VER
# 02 end

# 03 start
#================================================================================
# U-03 계정 짐금 임계값 설정
# 사용자 계정 로그인 실패 시 계정잠금 임계값이 설정되어 있는지 점검
echo "KB-AU-03" > $BingoDIR/03.title

echo "YES" > $BingoDIR/03.result

echo "" > $BingoDIR/03.msg

echo "$LOG_SECTION" > $BingoDIR/03.log

if [ "$((LV))" -le 5 ]
then
	if [ `cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "pam_tally.so" | grep -v '^ *#' | wc -l` -ge 1 ]
	then
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "pam_tally.so" >> $BingoDIR/03.log
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-01" >> $BingoDIR/03.msg
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "pam_tally.so" >> $BingoDIR/03.log
    fi

    if [ `cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "deny" | grep "5" | grep -v '^ *#' | wc -l` -ge 1 ]
    then 
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "deny" | grep "5" >> $BingoDIR/03.log
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-02" >> $BingoDIR/03.msg
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "deny" | grep "5" >> $BingoDIR/03.log
    fi 

    if [ `cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "unlock_time" | grep "120" | grep -v '^ *#' | wc -l` -ge 1 ]
    then 
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "unlock_time" | grep "120" >> $BingoDIR/03.log
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-03" >> $BingoDIR/03.msg
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "unlock_time" | grep "120" >> $BingoDIR/03.log
    fi 

    if [ `cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "no_magic_root" | grep -v '^ *#' | wc -l` -ge 1 ]
    then 
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "no_magic_root" >> $BingoDIR/03.log
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-04" >> $BingoDIR/03.msg
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "no_magic_root" >> $BingoDIR/03.log
    fi 

    if [ `cat /etc/pam.d/system-auth | grep -i "account" | grep -i "required" | grep -i "/lib/security/pam_tally.so" | grep -v '^ *#' | wc -l` -ge 1 ]
    then 
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/system-auth | grep -i "account" | grep -i "required" | grep -i "/lib/security/pam_tally.so" >> $BingoDIR/03.log
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-05" >> $BingoDIR/03.msg
        cat /etc/pam.d/system-auth | grep -i "account" | grep -i "required" | grep -i "/lib/security/pam_tally.so" >> $BingoDIR/03.log
    fi 

    if [ `cat /etc/pam.d/system-auth | grep -i "account" | grep -i "required" | grep -i "no_magic_root" | grep -v '^ *#' | wc -l` -ge 1 ]
    then 
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/system-auth | grep -i "account" | grep -i "required" | grep -i "no_magic_root" >> $BingoDIR/03.log
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-06" >> $BingoDIR/03.msg
        cat /etc/pam.d/system-auth | grep -i "account" | grep -i "required" | grep -i "no_magic_root" >> $BingoDIR/03.log
    fi 

    if [ `cat /etc/pam.d/system-auth | grep -i "account" | grep -i "required" | grep -i "reset" | grep -v '^ *#' | wc -l` -ge 1 ]
    then 
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/system-auth | grep -i "account" | grep -i "required" | grep -i "reset" >> $BingoDIR/03.log
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-07" >> $BingoDIR/03.msg
        cat /etc/pam.d/system-auth | grep -i "account" | grep -i "required" | grep -i "reset" >> $BingoDIR/03.log
    fi 

    # RHEL 5 이하 전체 출력
    echo "$LOG_ALL" >> $BingoDIR/03.log
    echo "------------------------------" >> $BingoDIR/03.log
    echo "File: /etc/pam.d/system-auth" >> $BingoDIR/03.log
    echo "------------------------------" >> $BingoDIR/03.log
    cat /etc/pam.d/system-auth >> $BingoDIR/03.log
elif [ "$((LV))" -ge 6 ] && [ "$((LV))" -le 7 ]
then
	if [ `cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "pam_faillock.so" | grep -v '^ *#' | wc -l` -ge 1 ] || [ `cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "pam_tally2.so" | grep -v '^ *#' | wc -l` -ge 1 ]
	then
        echo "YES" >> $BingoDIR/03.result
        echo "------------------------------" >> $BingoDIR/03.log
        echo "File: /etc/pam.d/system-auth" >> $BingoDIR/03.log
        echo "------------------------------" >> $BingoDIR/03.log
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "pam_faillock.so" >> $BingoDIR/03.system-auth
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "pam_tally2.so" >> $BingoDIR/03.system-auth
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-08" >> $BingoDIR/03.msg
        echo "------------------------------" >> $BingoDIR/03.log
        echo "File: /etc/pam.d/system-auth" >> $BingoDIR/03.log
        echo "------------------------------" >> $BingoDIR/03.log
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "pam_faillock.so" >> $BingoDIR/03.system-auth
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "pam_tally2.so" >> $BingoDIR/03.system-auth
    fi 

    if [ `cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "deny" | grep "5" | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "deny" | grep "5" >> $BingoDIR/03.system-auth
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-09" >> $BingoDIR/03.msg
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "deny" | grep "5" >> $BingoDIR/03.system-auth
    fi 

    if [ `cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "unlock_time" | grep "120" | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "unlock_time" | grep "120" >> $BingoDIR/03.system-auth
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-10" >> $BingoDIR/03.msg
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "unlock_time" | grep "120" >> $BingoDIR/03.system-auth
    fi

    if [ `cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "even_deny_root" | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "even_deny_root" >> $BingoDIR/03.system-auth
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-11" >> $BingoDIR/03.msg
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "even_deny_root" >> $BingoDIR/03.system-auth
    fi

    if [ `cat /etc/pam.d/system-auth | grep -i "account" | grep -i "required" | grep -i "faillock.so" | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/system-auth | grep -i "account" | grep -i "required" | grep -i "faillock.so" >> $BingoDIR/03.system-auth
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-12" >> $BingoDIR/03.msg
        cat /etc/pam.d/system-auth | grep -i "account" | grep -i "required" | grep -i "faillock.so" >> $BingoDIR/03.system-auth
    fi

    if [ `cat /etc/pam.d/system-auth | grep -i "account" | grep -i "required" | grep -i "even_deny_root" | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/system-auth | grep -i "account" | grep -i "required" | grep -i "even_deny_root" >> $BingoDIR/03.system-auth
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-13" >> $BingoDIR/03.msg
        cat /etc/pam.d/system-auth | grep -i "account" | grep -i "required" | grep -i "even_deny_root" >> $BingoDIR/03.system-auth
    fi

    # 중복값 제거 후 log 파일에 저장
    sort -u $BingoDIR/03.system-auth >> $BingoDIR/03.log

    if [ `cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "pam_faillock.so" | grep -v '^ *#' | wc -l` -ge 1 ] || [ `cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "pam_tally2.so" | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/03.result
        echo "------------------------------" >> $BingoDIR/03.log
        echo "File: /etc/pam.d/password-auth" >> $BingoDIR/03.log
        echo "------------------------------" >> $BingoDIR/03.log
        cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "pam_faillock.so" >> $BingoDIR/03.password-auth
        cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "pam_tally2.so" >> $BingoDIR/03.password-auth
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-15" >> $BingoDIR/03.msg
        echo "------------------------------" >> $BingoDIR/03.log
        echo "File: /etc/pam.d/password-auth" >> $BingoDIR/03.log
        echo "------------------------------" >> $BingoDIR/03.log  
        cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "pam_faillock.so" >> $BingoDIR/03.password-auth
        cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "pam_tally2.so" >> $BingoDIR/03.password-auth
    fi

    if [ `cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "deny" | grep "5" | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "deny" | grep "5" >> $BingoDIR/03.password-auth
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-16" >> $BingoDIR/03.msg
        cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "deny" | grep "5" >> $BingoDIR/03.password-auth
    fi

    if [ `cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "unlock_time" | grep "120" | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "unlock_time" | grep "120" >> $BingoDIR/03.password-auth
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-17" >> $BingoDIR/03.msg
        cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "unlock_time" | grep "120" >> $BingoDIR/03.password-auth
    fi

    if [ `cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "even_deny_root" | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "even_deny_root" >> $BingoDIR/03.password-auth
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-18" >> $BingoDIR/03.msg
        cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "even_deny_root" >> $BingoDIR/03.password-auth
    fi

    if [ `cat /etc/pam.d/password-auth | grep -i "account" | grep -i "required" | grep -i "faillock.so" | grep -v '^ *#' | wc -l` -ge 1 ] || [ `cat /etc/pam.d/password-auth | grep -i "account" | grep -i "required" | grep -i "tally2.so" | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/password-auth | grep -i "account" | grep -i "required" | grep -i "faillock.so" >> $BingoDIR/03.password-auth
        cat /etc/pam.d/password-auth | grep -i "account" | grep -i "required" | grep -i "tally2.so" >> $BingoDIR/03.password-auth
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-19" >> $BingoDIR/03.msg
        cat /etc/pam.d/password-auth | grep -i "account" | grep -i "required" | grep -i "faillock.so" >> $BingoDIR/03.password-auth
        cat /etc/pam.d/password-auth | grep -i "account" | grep -i "required" | grep -i "tally2.so" >> $BingoDIR/03.password-auth
    fi

    if [ `cat /etc/pam.d/password-auth | grep -i "account" | grep -i "required" | grep -i "even_deny_root" | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/password-auth | grep -i "account" | grep -i "required" | grep -i "even_deny_root" >> $BingoDIR/03.password-auth
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-20" >> $BingoDIR/03.msg
        cat /etc/pam.d/password-auth | grep -i "account" | grep -i "required" | grep -i "even_deny_root" >> $BingoDIR/03.password-auth
    fi

    # 중복값 제거 후 log 파일에 저장
    sort -u $BingoDIR/03.password-auth >> $BingoDIR/03.log

    # RHEL 6 이상 전체 출력
    echo "$LOG_ALL" >> $BingoDIR/03.log
    echo "------------------------------" >> $BingoDIR/03.log
    echo "File: /etc/pam.d/system-auth" >> $BingoDIR/03.log
    echo "------------------------------" >> $BingoDIR/03.log
    cat /etc/pam.d/system-auth >> $BingoDIR/03.log
    echo "------------------------------" >> $BingoDIR/03.log
    echo "File: /etc/pam.d/password-auth" >> $BingoDIR/03.log
    echo "------------------------------" >> $BingoDIR/03.log
    cat /etc/pam.d/password-auth >> $BingoDIR/03.log 
elif [ "$((LV))" -ge 8 ]
then
	if [ `cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "pam_faillock.so" | grep -v '^ *#' | wc -l` -ge 1 ]
	then
        echo "YES" >> $BingoDIR/03.result
        echo "------------------------------" >> $BingoDIR/03.log
        echo "File: /etc/pam.d/system-auth" >> $BingoDIR/03.log
        echo "------------------------------" >> $BingoDIR/03.log
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "pam_faillock.so" >> $BingoDIR/03.system-auth
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-08" >> $BingoDIR/03.msg
        echo "------------------------------" >> $BingoDIR/03.log
        echo "File: /etc/pam.d/system-auth" >> $BingoDIR/03.log
        echo "------------------------------" >> $BingoDIR/03.log
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "pam_faillock.so" >> $BingoDIR/03.system-auth
    fi 

    if [ `cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "deny" | grep "5" | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "deny" | grep "5" >> $BingoDIR/03.system-auth
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-09" >> $BingoDIR/03.msg
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "deny" | grep "5" >> $BingoDIR/03.system-auth
    fi 

    if [ `cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "unlock_time" | grep "120" | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "unlock_time" | grep "120" >> $BingoDIR/03.system-auth
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-10" >> $BingoDIR/03.msg
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "unlock_time" | grep "120" >> $BingoDIR/03.system-auth
    fi

    if [ `cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "even_deny_root" | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "even_deny_root" >> $BingoDIR/03.system-auth
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-11" >> $BingoDIR/03.msg
        cat /etc/pam.d/system-auth | grep -i "auth" | grep -i "required" | grep -i "even_deny_root" >> $BingoDIR/03.system-auth
    fi

    if [ `cat /etc/pam.d/system-auth | grep -i "account" | grep -i "required" | grep -i "faillock.so" | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/system-auth | grep -i "account" | grep -i "required" | grep -i "faillock.so" >> $BingoDIR/03.system-auth
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-12" >> $BingoDIR/03.msg
        cat /etc/pam.d/system-auth | grep -i "account" | grep -i "required" | grep -i "faillock.so" >> $BingoDIR/03.system-auth
    fi

    if [ `cat /etc/pam.d/system-auth | grep -i "account" | grep -i "required" | grep -i "even_deny_root" | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/system-auth | grep -i "account" | grep -i "required" | grep -i "even_deny_root" >> $BingoDIR/03.system-auth
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-13" >> $BingoDIR/03.msg
        cat /etc/pam.d/system-auth | grep -i "account" | grep -i "required" | grep -i "even_deny_root" >> $BingoDIR/03.system-auth
    fi
    
    # 중복값 제거 후 log 파일에 저장
    sort -u $BingoDIR/03.system-auth >> $BingoDIR/03.log

    if [ `cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "pam_faillock.so" | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/03.result
        echo "------------------------------" >> $BingoDIR/03.log
        echo "File: /etc/pam.d/password-auth" >> $BingoDIR/03.log
        echo "------------------------------" >> $BingoDIR/03.log
        cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "pam_faillock.so" >> $BingoDIR/03.password-auth
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-15" >> $BingoDIR/03.msg
        echo "------------------------------" >> $BingoDIR/03.log
        echo "File: /etc/pam.d/password-auth" >> $BingoDIR/03.log
        echo "------------------------------" >> $BingoDIR/03.log  
        cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "pam_faillock.so" >> $BingoDIR/03.password-auth
    fi

    if [ `cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "deny" | grep "5" | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "deny" | grep "5" >> $BingoDIR/03.password-auth
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-16" >> $BingoDIR/03.msg
        cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "deny" | grep "5" >> $BingoDIR/03.password-auth
    fi

    if [ `cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "unlock_time" | grep "120" | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "unlock_time" | grep "120" >> $BingoDIR/03.password-auth
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-17" >> $BingoDIR/03.msg
        cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "unlock_time" | grep "120" >> $BingoDIR/03.password-auth
    fi

    if [ `cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "even_deny_root" | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "even_deny_root" >> $BingoDIR/03.password-auth
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-18" >> $BingoDIR/03.msg
        cat /etc/pam.d/password-auth | grep -i "auth" | grep -i "required" | grep -i "even_deny_root" >> $BingoDIR/03.password-auth
    fi

    if [ `cat /etc/pam.d/password-auth | grep -i "account" | grep -i "required" | grep -i "faillock.so" | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/password-auth | grep -i "account" | grep -i "required" | grep -i "faillock.so" >> $BingoDIR/03.password-auth
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-19" >> $BingoDIR/03.msg
        cat /etc/pam.d/password-auth | grep -i "account" | grep -i "required" | grep -i "faillock.so" >> $BingoDIR/03.password-auth
    fi

    if [ `cat /etc/pam.d/password-auth | grep -i "account" | grep -i "required" | grep -i "even_deny_root" | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/03.result
        cat /etc/pam.d/password-auth | grep -i "account" | grep -i "required" | grep -i "even_deny_root" >> $BingoDIR/03.password-auth
    else 
        echo "NO" >> $BingoDIR/03.result
        echo "KB-AU-03-N-20" >> $BingoDIR/03.msg
        cat /etc/pam.d/password-auth | grep -i "account" | grep -i "required" | grep -i "even_deny_root" >> $BingoDIR/03.password-auth
    fi

    # 중복값 제거 후 log 파일에 저장
    sort -u $BingoDIR/03.password-auth >> $BingoDIR/03.log

    # RHEL 6 이상 전체 출력
    echo "$LOG_ALL" >> $BingoDIR/03.log
    echo "------------------------------" >> $BingoDIR/03.log
    echo "File: /etc/pam.d/system-auth" >> $BingoDIR/03.log
    echo "------------------------------" >> $BingoDIR/03.log
    cat /etc/pam.d/system-auth >> $BingoDIR/03.log
    echo "------------------------------" >> $BingoDIR/03.log
    echo "File: /etc/pam.d/password-auth" >> $BingoDIR/03.log
    echo "------------------------------" >> $BingoDIR/03.log
    cat /etc/pam.d/password-auth >> $BingoDIR/03.log 
else
	echo "MANUAL" >> $BingoDIR/03.result
	echo "KB-AU-03-M-01" > $BingoDIR/03.msg
    cat /etc/*release* > $BingoDIR/03.log
fi

if [ `cat $BingoDIR/03.result | grep -i "MANUAL" | wc -l` -ge 1 ]
then 
    echo ""MANUAL > $BingoDIR/03.result
elif [ `cat $BingoDIR/03.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/03.result
else 
    echo "YES" > $BingoDIR/03.result
    echo "KB-AU-03-Y-01" > $BingoDIR/03.msg
fi    
													
# 03 end

# 04 start
#================================================================================
# U-04 비밀번호 암호화
# 시스템의  사용자  계정(root,  일반계정)  정보가  저장된  파일(예  /etc/passwd,  /etc/shadow)에 사용자 계정 패스워드가 암호화되어 저장되어 있는지 점검
echo "KB-AU-04" > $BingoDIR/04.title

RESULT='YES'

if [ `cat /etc/passwd | awk -F ":" '{ print $2 }' | grep -vwc "x"` -ge 1 ]
then
	RESULT='NO'
    RESULT_MSG="KB-AU-04-N-01"
    RESULT_LOG=$(cat /etc/passwd | grep -i 'root:' 2>&1)
	RESULT_LOG2=$(cat /etc/passwd 2>&1)
else
	RESULT='YES'
	RESULT_MSG="KB-AU-04-Y-01"
	RESULT_LOG=$(cat /etc/passwd | grep -i 'root:x' 2>&1)
	RESULT_LOG2=$(cat /etc/passwd 2>&1)
fi

echo "$RESULT" > $BingoDIR/04.result
echo "$RESULT_MSG" > $BingoDIR/04.msg
echo "$LOG_SECTION" > $BingoDIR/04.log
echo "$RESULT_LOG" >> $BingoDIR/04.log
echo "$LOG_ALL" >> $BingoDIR/04.log
echo "$RESULT_LOG2" >> $BingoDIR/04.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
# 04 end

# 05 start
#================================================================================
# U-05 root이외의 UID가 '0' 금지
# 사용자  계정  정보가  저장된  파일(예  /etc/passwd)에  root(UID=0)  계정과 동일한 UID(User Identification)를 가진 계정이 존재하는지 점검
echo "KB-AU-05" > $BingoDIR/05.title

RESULT='YES'

if [ `awk -F: '$3==0  { print $1 " -> UID=" $3 }' /etc/passwd | wc -l` -eq 1 ]
then
	RESULT='YES'
	RESULT_MSG="KB-AU-05-Y-01"
	RESULT_LOG=$(cat /etc/passwd | awk -F: '$3==0' 2>&1)
	RESULT_LOG2=$(cat /etc/passwd 2>&1)
else
	RESULT='NO'
	RESULT_MSG="KB-AU-05-N-01"
	RESULT_LOG=$(cat /etc/passwd | awk -F: '$3==0' 2>&1)
	RESULT_LOG2=$(cat /etc/passwd 2>&1)
fi 

echo "$RESULT" > $BingoDIR/05.result
echo "$RESULT_MSG" > $BingoDIR/05.msg
echo "$LOG_SECTION" > $BingoDIR/05.log
echo "$RESULT_LOG" >> $BingoDIR/05.log
echo "$LOG_ALL" >> $BingoDIR/05.log
echo "$RESULT_LOG2" >> $BingoDIR/05.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
# 05 end

# 06 start
#================================================================================
# U-06 root 계정 su 제한
# su 명령어 사용을 허용하는 사용자를 지정한 그룹이 설정되어 있는지 점검
echo "KB-AU-06" > $BingoDIR/06.title

echo "YES" > $BingoDIR/06.result

echo "" > $BingoDIR/06.msg

echo "$LOG_SECTION" > $BingoDIR/06.log

if [ -f /usr/bin/su ]
then
    if [ `stat -c "%a" /usr/bin/su | cut -c 1-4` -eq 4750 ]
    then
        echo "YES" >> $BingoDIR/06.result
        echo "------------------------------" >> $BingoDIR/06.log
        echo "File: /usr/bin/su" >> $BingoDIR/06.log
        echo "------------------------------" >> $BingoDIR/06.log 
        ls -al /usr/bin/su | stat -c "%a" /usr/bin/su | cut -c 1-4 >> $BingoDIR/06.log
    else 
        echo "NO" >> $BingoDIR/06.result
        echo "KB-AU-06-N-01" >> $BingoDIR/06.msg
        echo "------------------------------" >> $BingoDIR/06.log
        echo "File: /usr/bin/su" >> $BingoDIR/06.log
        echo "------------------------------" >> $BingoDIR/06.log 
        ls -al /usr/bin/su | stat -c "%a" /usr/bin/su | cut -c 1-4 >> $BingoDIR/06.log
    fi

    if [ `ls -al /usr/bin/su | awk '{ print $3 }'` == 'root' ]
    then
        echo "YES" >> $BingoDIR/06.result
        ls -al /usr/bin/su  >> $BingoDIR/06.log
    else 
        echo "NO" >> $BingoDIR/06.result
        echo "KB-AU-06-N-02" >> $BingoDIR/06.msg
        ls -al /usr/bin/su >> $BingoDIR/06.log
    fi

    if [ `ls -al /usr/bin/su | awk '{ print $4 }'` == wheel ]
    then
        echo "YES" >> $BingoDIR/06.result
    else
        echo "NO" >> $BingoDIR/06.result
        echo "KB-AU-06-N-03" >> $BingoDIR/06.msg
    fi
else
    echo "MANUAL" >> $BingoDIR/06.result
    echo "KB-AU-06-M-01" >> $BingoDIR/06.msg
    echo "------------------------------" >> $BingoDIR/06.log
    echo "File: /usr/bin/su" >> $BingoDIR/06.log
    echo "------------------------------" >> $BingoDIR/06.log 
    echo "NO FILE" >> $BingoDIR/06.log
fi    

if [ `cat /etc/pam.d/su | grep -i 'auth' | grep -i 'sufficient' | grep -i 'pam_rootok.so' | grep -v '^ *#' | wc -l` -ge 1 ]
then
    echo "YES" >> $BingoDIR/06.result
    echo "------------------------------" >> $BingoDIR/06.log
    echo "File: /usr/pam.d/su" >> $BingoDIR/06.log
    echo "------------------------------" >> $BingoDIR/06.log 
    cat /etc/pam.d/su | grep -i 'auth' | grep -i 'sufficient' | grep -i 'pam_rootok.so' | grep -v '^ *#' >> $BingoDIR/06.log
else 
    echo "NO" >> $BingoDIR/06.result
    echo "KB-AU-06-N-04" >> $BingoDIR/06.msg
    echo "------------------------------" >> $BingoDIR/06.log
    echo "File: /usr/pam.d/su" >> $BingoDIR/06.log
    echo "------------------------------" >> $BingoDIR/06.log 
    cat /etc/pam.d/su | grep -i 'auth' | grep -i 'sufficient' | grep -i 'pam_rootok.so' | grep -v '^ *#' >> $BingoDIR/06.log
fi

if [ `cat /etc/pam.d/su | grep -i 'auth' | grep -i 'required' | grep -i 'pam_wheel.so' | grep -v '^ *#' | wc -l` -ge 1 ]
then 
    echo "YES" >> $BingoDIR/06.result
    cat /etc/pam.d/su | grep -i 'auth' | grep -i 'required' | grep -i 'pam_wheel.so' | grep -v '^ *#' >> $BingoDIR/06.log
else 
    echo "NO" >> $BingoDIR/06.result
    echo "KB-AU-06-N-05" >> $BingoDIR/06.msg
    cat /etc/pam.d/su | grep -i 'auth' | grep -i 'required' | grep -i 'pam_wheel.so' | grep -v '^ *#' >> $BingoDIR/06.log
fi

if [ `cat /etc/pam.d/su | grep -i 'auth' | grep -i 'required' | grep -i 'debug' | grep -v '^ *#' | wc -l` -ge 1 ]
then
    echo "YES" >> $BingoDIR/06.result
    cat /etc/pam.d/su | grep -i 'auth' | grep -i 'required' | grep -i 'debug' | grep -v '^ *#' >> $BingoDIR/06.log
    if [ `cat /etc/pam.d/su | grep -i 'auth' | grep -i 'required' | grep -i 'group' | grep -i 'wheel' | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/06.result
        cat /etc/pam.d/su | grep -i 'auth' | grep -i 'required' | grep -i 'group' | grep -i 'wheel' | grep -v '^ *#' >> $BingoDIR/06.log
    else
        echo "NO" >> $BingoDIR/06.result
        echo "KB-AU-06-N-06" >> $BingoDIR/06.msg
        cat /etc/pam.d/su | grep -i 'auth' | grep -i 'required' | grep -i 'group' | grep -i 'wheel' | grep -v '^ *#' >> $BingoDIR/06.log
    fi
elif [ `cat /etc/pam.d/su | grep -i 'auth' | grep -i 'required' | grep -i 'use_uid' | grep -v '^ *#' | wc -l` -ge 1 ]
then
    echo "YES" >> $BingoDIR/06.result
    cat /etc/pam.d/su | grep -i 'auth' | grep -i 'required' | grep -i 'use_uid' | grep -v '^ *#' >> $BingoDIR/06.log
else 
    echo "NO" >> $BingoDIR/06.result
    echo "KB-AU-06-N-07" >> $BingoDIR/06.msg
    cat /etc/pam.d/su | grep -i 'auth' | grep -i 'required' | grep -i 'debug' | grep -v '^ *#' >> $BingoDIR/06.log
    cat /etc/pam.d/su | grep -i 'auth' | grep -i 'required' | grep -i 'use_uid' | grep -v '^ *#' >> $BingoDIR/06.log
fi

if [ `cat /etc/group | grep -e ^wheel | wc -l` -ge 1 ]
then
    echo "YES" >> $BingoDIR/06.result
    echo "------------------------------" >> $BingoDIR/06.log
    echo "File: /etc/group" >> $BingoDIR/06.log
    echo "------------------------------" >> $BingoDIR/06.log
    cat /etc/group | grep -e ^wheel >> $BingoDIR/06.log
else 
    echo "NO" >> $BingoDIR/06.result
    echo "KB-AU-06-N-08" >> $BingoDIR/06.msg
    echo "------------------------------" >> $BingoDIR/06.log
    echo "File: /etc/group" >> $BingoDIR/06.log
    echo "------------------------------" >> $BingoDIR/06.log
    cat /etc/group | grep -e ^wheel >> $BingoDIR/06.log
fi

if [ `cat $BingoDIR/06.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/06.result
else 
    echo "YES" > $BingoDIR/06.result
    echo "KB-AU-06-Y-01" > $BingoDIR/06.msg
fi   

# 전체 파일 출력 
echo "$LOG_ALL" >> $BingoDIR/06.log
if [ -f /usr/bin/su ]
then
    echo "------------------------------" >> $BingoDIR/06.log
    echo "File: /usr/bin/su" >> $BingoDIR/06.log
    echo "------------------------------" >> $BingoDIR/06.log 
    ls -al /usr/bin/su >> $BingoDIR/06.log
else
    echo "------------------------------" >> $BingoDIR/06.log
    echo "File: /usr/bin/su" >> $BingoDIR/06.log
    echo "------------------------------" >> $BingoDIR/06.log 
    echo "NO FILE" >> $BingoDIR/06.log 
fi 
echo "------------------------------" >> $BingoDIR/06.log
echo "File: /usr/pam.d/su" >> $BingoDIR/06.log
echo "------------------------------" >> $BingoDIR/06.log 
cat /etc/pam.d/su >> $BingoDIR/06.log
echo "------------------------------" >> $BingoDIR/06.log
echo "File: /etc/group" >> $BingoDIR/06.log
echo "------------------------------" >> $BingoDIR/06.log
cat /etc/group >> $BingoDIR/06.log

# 06 end

# 07 start
#================================================================================
# U-07 비밀번호 최소 길이 설정
# 시스템 정책에 패스워드 최소(8자 이상) 길이 설정이 적용되어 있는 점검
echo "KB-AU-07" > $BingoDIR/07.title

RESULT='YES'

var07=$(cat /etc/login.defs | grep -i "pass_min_len" | grep -v '^ *#' | awk '{ print $2 }')
# $var07 값이 null이거나 숫자가 아닌 경우 에러가 날 수 있다. 이 때 멈추는 것이 아닌 에러 출력을 /dev/null로 보내고 else값으로 넘긴다.
if [ "$var07" -ge 9 ] 2>/dev/null;
then
	RESULT='YES'
	RESULT_MSG="KB-AU-07-Y-01"
	RESULT_LOG=$(cat /etc/login.defs | grep -i "pass_min_len" 2>&1)
	RESULT_LOG2=$(cat /etc/login.defs 2>&1)
else
	RESULT='NO'
    RESULT_MSG="KB-AU-07-N-01"
	RESULT_LOG=$(cat /etc/login.defs | grep -i "pass_min_len" 2>&1)
	RESULT_LOG2=$(cat /etc/login.defs 2>&1)
fi 

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='NO VALUE'
fi

echo "$RESULT" > $BingoDIR/07.result
echo "$RESULT_MSG" > $BingoDIR/07.msg
echo "$LOG_SECTION" > $BingoDIR/07.log
echo "$RESULT_LOG" >> $BingoDIR/07.log
echo "$LOG_ALL" >> $BingoDIR/07.log
echo "$RESULT_LOG2" >> $BingoDIR/07.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
# 07 end

# 08 start
#================================================================================
# U-08 비밀번호 최대 사용기간 설정
# 시스템 정책에 패스워드 최대(90일 이하) 사용기간 설정이 적용되어 있는지 점검
echo "KB-AU-08" > $BingoDIR/08.title

RESULT='YES'

if [ `cat /etc/login.defs | grep "PASS_MAX_DAYS" | grep -iv "^ *#" | awk '{if ( $2 > 0 && $2 < 32 ) print $1 }' | wc -l` -ge 1 ]
then
	RESULT='YES'
	RESULT_MSG="KB-AU-08-Y-01"
	RESULT_LOG=$(cat /etc/login.defs | grep -i "PASS_MAX_DAYS" 2>&1)
	RESULT_LOG2=$(cat /etc/login.defs 2>&1)
else
	RESULT='NO'
    RESULT_MSG="KB-AU-08-N-01"
	RESULT_LOG=$(cat /etc/login.defs | grep -i "PASS_MAX_DAYS" 2>&1)
	RESULT_LOG2=$(cat /etc/login.defs 2>&1)
fi

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='NO VALUE'
fi

echo "$RESULT" > $BingoDIR/08.result
echo "$RESULT_MSG" > $BingoDIR/08.msg
echo "$LOG_SECTION" > $BingoDIR/08.log
echo "$RESULT_LOG" >> $BingoDIR/08.log
echo "$LOG_ALL" >> $BingoDIR/08.log
echo "$RESULT_LOG2" >> $BingoDIR/08.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
# 08 end

# 09 start
#================================================================================
# U-09 비밀번호 최소 사용기간 설정
# 시스템 정책에 패스워드 최소 사용기간 설정이 적용되어 있는지 점검
echo "KB-AU-09" > $BingoDIR/09.title

RESULT='YES'

if [ `cat /etc/login.defs | grep -i "PASS_MIN_DAYS" | grep -v '^ *#' | awk '{ print $2 }'` -ge 1 ]
then
	RESULT='YES'
	RESULT_MSG="KB-AU-09-Y-01"
	RESULT_LOG=$(cat /etc/login.defs | grep -i "PASS_MIN_DAYS" 2>&1)
	RESULT_LOG2=$(cat /etc/login.defs 2>&1)
else
	RESULT='NO'
	RESULT_MSG="KB-AU-09-N-01"
	RESULT_LOG=$(cat /etc/login.defs | grep -i "PASS_MIN_DAYS" 2>&1)
	RESULT_LOG2=$(cat /etc/login.defs 2>&1)
fi 

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='NO VALUE'
fi

echo "$RESULT" > $BingoDIR/09.result
echo "$RESULT_MSG" > $BingoDIR/09.msg
echo "$LOG_SECTION" > $BingoDIR/09.log
echo "$RESULT_LOG" >> $BingoDIR/09.log
echo "$LOG_ALL" >> $BingoDIR/09.log
echo "$RESULT_LOG2" >> $BingoDIR/09.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
# 09 end

# 10 start
#================================================================================
# U-10 불필요한 계정 제거
# 시스템 계정 중 불필요한 계정(퇴직, 전직, 휴직 등의 이유로 사용하지 않는 계정 및 장기적으로 사용하지 않는 계정 등)이 존재하는지 점검
echo "KB-AU-10" > $BingoDIR/10.title

RESULT='YES'

if [ `cat /etc/passwd | grep "lp:\|uucp:\|nuucp:" | wc -l` -eq 0 ]
then
	RESULT='MANUAL'
	RESULT_MSG="KB-AU-10-M-01"
	RESULT_LOG="CONFIRM"
	RESULT_LOG2=$(cat /etc/passwd 2>&1)
else
	RESULT='NO'
	RESULT_MSG="KB-AU-10-N-01"
	RESULT_LOG=$(cat /etc/passwd | grep "lp:\|uucp:\|nuucp:" 2>&1)
	RESULT_LOG2=$(cat /etc/passwd 2>&1)
fi 

echo "$RESULT" > $BingoDIR/10.result
echo "$RESULT_MSG" > $BingoDIR/10.msg
echo "$LOG_SECTION" > $BingoDIR/10.log
echo "$RESULT_LOG" >> $BingoDIR/10.log
echo "$LOG_ALL" >> $BingoDIR/10.log
echo "$RESULT_LOG2" >> $BingoDIR/10.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
# 10 end

# 11 start
#================================================================================
# U-11 관리자 그룹에 최소한의 계정 포함
# 시스템 관리자 그룹에 최소한(root 계정과 시스템 관리에 허용된 계정)의 계정만 존재하는지 점검
echo "KB-AU-11" > $BingoDIR/11.title

RESULT='YES'

if [ `cat /etc/group | grep -w "^root:x:0:$" | wc -l` -eq 1 ]
then
    RESULT='YES'
	RESULT_MSG="KB-AU-11-Y-01"
	RESULT_LOG=$(cat /etc/group | grep -i "^root:x:0:" 2>&1)
	RESULT_LOG2=$(cat /etc/group 2>&1)
elif [ `cat /etc/group | grep -w "^root:x:0:root$" | wc -l` -eq 1 ]
then
    RESULT='YES'
	RESULT_MSG="KB-AU-11-Y-01"
	RESULT_LOG=$(cat /etc/group | grep -i "^root:x:0:" 2>&1)
	RESULT_LOG2=$(cat /etc/group 2>&1)
else
	RESULT='NO'
	RESULT_MSG="KB-AU-11-N-01"
	RESULT_LOG=$(cat /etc/group | grep -i "^root:x:0:" 2>&1)
	RESULT_LOG2=$(cat /etc/group 2>&1)
fi 

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='NO VALUE'
fi

echo "$RESULT" > $BingoDIR/11.result
echo "$RESULT_MSG" > $BingoDIR/11.msg
echo "$LOG_SECTION" > $BingoDIR/11.log
echo "$RESULT_LOG" >> $BingoDIR/11.log
echo "$LOG_ALL" >> $BingoDIR/11.log
echo "$RESULT_LOG2" >> $BingoDIR/11.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
# 11 end

# 12 start
#================================================================================
# U-12 계정이 존재하지 않는 GID 금지
# 그룹 설정 파일에 불필요한 그룹(계정이 존재하지 않고 시스템 관리나 운용에 사용되지 않는 그룹, 계정이 존재하고 시스템 관리나 운용에 사용되지 않는 그룹 등)이 존재하는지 점검
echo "KB-AU-12" > $BingoDIR/12.title

RESULT='YES'

if [ `cat /etc/group | awk -F ":"  '{if ($3 > 499 )  print $3 }' | wc -l` -ge 1 ]
then
	RESULT='MANUAL'
	RESULT_MSG="KB-AU-12-M-01"
	RESULT_LOG=$(echo "== File: /etc/group ==" && cat /etc/group && echo -e ""  && echo "== File: /etc/passwd ==" && cat /etc/passwd && echo -e ""  && echo "== File: /etc/gshadow ==" && cat /etc/gshadow 2>&1)
else
    RESULT='YES'
	RESULT_MSG="KB-AU-12-Y-01"
	RESULT_LOG=$(echo "== File: /etc/group ==" && cat /etc/group && echo -e ""  && echo "== File: /etc/passwd ==" && cat /etc/passwd && echo -e ""  && echo "== File: /etc/gshadow ==" && cat /etc/gshadow 2>&1)
fi

echo "$RESULT" > $BingoDIR/12.result
echo "$RESULT_MSG" > $BingoDIR/12.msg
echo "$LOG_ALL" > $BingoDIR/12.log
echo "$RESULT_LOG" >> $BingoDIR/12.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
# 12 end

# 13 start
#================================================================================
# U-13 동일한 UID 금지
# /etc/passwd 파일 내 UID가 동일한 사용자 계정 존재 여부 점검
echo "KB-AU-13" > $BingoDIR/13.title

RESULT='YES'

if [ `awk -F ':' 'a[$3]++{print $3}' /etc/passwd | wc -l` -eq 0 ]
then
	RESULT='YES'
	RESULT_MSG="KB-AU-13-Y-01"
	RESULT_LOG=$(awk -F ':' 'a[$3]++{print $3}' /etc/passwd 2>&1)
	RESULT_LOG2=$(cat /etc/passwd 2>&1)
else
	RESULT='NO'
	RESULT_MSG="KB-AU-13-N-01"
	RESULT_LOG=$(awk -F ':' 'a[$3]++{print $3}' /etc/passwd 2>&1)
	RESULT_LOG2=$(cat /etc/passwd 2>&1)
fi

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='NO UID'
fi

echo "$RESULT" > $BingoDIR/13.result
echo "$RESULT_MSG" > $BingoDIR/13.msg
echo "$LOG_SECTION" > $BingoDIR/13.log
echo "$RESULT_LOG" >> $BingoDIR/13.log
echo "$LOG_ALL" >> $BingoDIR/13.log
echo "$RESULT_LOG2" >> $BingoDIR/13.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
# 13 end

# 14 start
#================================================================================
# U-14 사용자 shell 점검
# 로그인이 불필요한 계정(adm, sys, daemon 등)에 쉘 부여 여부 점검
echo "KB-AU-14" > $BingoDIR/14.title

echo "YES" > $BingoDIR/14.result

echo "" > $BingoDIR/14.msg

echo "$LOG_SECTION" > $BingoDIR/14.log

if [ `cat /etc/passwd | grep -v "nologin\|false"  | awk -F ":" '{ print $3 }' | awk '{if ($1 > 0 && $1 < 101) print $1}' | wc -l` -eq 0 ]
then
	echo "YES" >> $BingoDIR/14.result
    cat /etc/passwd |grep -v "/bin/false" | grep -v "/sbin/nologin" | grep -v "root">> $BingoDIR/14.log
else 
    echo "NO" >> $BingoDIR/14.result
    echo "KB-AU-14-N-01" >> $BingoDIR/14.msg
    cat /etc/passwd |grep -v "/bin/false" | grep -v "/sbin/nologin" | grep -v "root" >> $BingoDIR/14.log
fi

if [ `cat /etc/passwd | grep -v "nologin\|false"  | awk -F ":" '{ print $3 }' | awk '{if ($1 > 59999) print $1}' | wc -l` -eq 0 ]
then
	echo "YES" >> $BingoDIR/14.result
else 
    echo "NO" >> $BingoDIR/14.result
    echo "KB-AU-14-N-02" >> $BingoDIR/14.msg
fi

users="daemon bin sys adm listen nobody nobody4 noaccess diag operator games gopher"

for user in $users
do
    if [ $(cat /etc/passwd | grep -v "nologin\|false" | awk -F ':' -v usr="$user" '$1 == usr { print $1 }' | wc -l) -ge 1 ]
    then
        echo "NO" >> $BingoDIR/14.result
        echo "KB-AU-14-N-01" >> $BingoDIR/14.msg
        cat /etc/passwd | grep -v "nologin\|false" | awk -F ':' -v usr="$user" '$1 == usr { print }' >> $BingoDIR/14.log
    fi
done

if [ `cat $BingoDIR/14.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/14.result
else 
    echo "YES" > $BingoDIR/14.result
    echo "KB-AU-14-Y-01" > $BingoDIR/14.msg
fi

# 전체 파일 출력
echo "$LOG_ALL" >> $BingoDIR/14.log
echo "------------------------------" >> $BingoDIR/14.log
echo "File: /etc/passwd" >> $BingoDIR/14.log
echo "------------------------------" >> $BingoDIR/14.log
cat /etc/passwd >> $BingoDIR/14.log

# 14 end

# 15 start
#================================================================================
# U-15 Session Timeout 설정
# 사용자 쉘에 대한 환경설정 파일에서 session timeout 설정 여부 점검
echo "KB-AU-15" > $BingoDIR/15.title

RESULT='YES'

if [ `cat /etc/profile | grep "TMOUT" | grep -v '^ *#' | awk -F "=" '{print $2}' | awk '{if ($1 > 0 && $1 < 301) print $1}' | wc -l` -ge 1 ]
then
	RESULT='YES'
	RESULT_MSG="KB-AU-15-Y-01"
	RESULT_LOG=$(cat /etc/profile | grep "TMOUT" | grep -v '^ *#' 2>&1)
	RESULT_LOG2=$(cat /etc/profile 2>&1)
else
	RESULT='NO'
	RESULT_MSG="KB-AU-15-N-01"
	RESULT_LOG=$(cat /etc/profile | grep "TMOUT" | grep -v '^ *#' 2>&1)
	RESULT_LOG2=$(cat /etc/profile 2>&1)
fi 

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='NO VALUE'
fi

echo "$RESULT" > $BingoDIR/15.result
echo "$RESULT_MSG" > $BingoDIR/15.msg
echo "$LOG_SECTION" > $BingoDIR/15.log
echo "$RESULT_LOG" >> $BingoDIR/15.log
echo "$LOG_ALL" >> $BingoDIR/15.log
echo "$RESULT_LOG2" >> $BingoDIR/15.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
# 15 end

# 16 start
#================================================================================
# U-16 root홈, 패스 디렉터리 권한 및 패스 설정
# root 계정의 PATH 환경변수에 “.”이(마침표) 포함되어 있는지 점검
echo "KB-AU-16" > $BingoDIR/16.title

echo "YES" > $BingoDIR/16.result

echo "" > $BingoDIR/16.msg

echo "$LOG_SECTION" > $BingoDIR/16.log

if [ -f /etc/profile ] 
then
	if [ `cat /etc/profile | grep "PATH=" | grep -iv "^ *#" | awk -F '=' '{print $2}' | grep  "\.:" | wc -l` -ge 1 ]
    then
	    echo "NO" >> $BingoDIR/16.result
        echo "KB-AU-16-N-01" > $BingoDIR/16.msg
        echo "------------------------------" >> $BingoDIR/16.log
        echo "File: /etc/profile" >> $BingoDIR/16.log
        echo "------------------------------" >> $BingoDIR/16.log
        cat /etc/profile | grep "PATH=" | grep -iv "^ *#" | awk -F '=' '{print $2}' | grep  "\.:" >> $BingoDIR/16.log
    else
        echo "YES" >> $BingoDIR/16.result
        echo "------------------------------" >> $BingoDIR/16.log
        echo "File: /etc/profile" >> $BingoDIR/16.log
        echo "------------------------------" >> $BingoDIR/16.log
        cat /etc/profile | grep "PATH=" | grep -iv "^ *#" >> $BingoDIR/16.log
    fi
else 
    echo "YES" >> $BingoDIR/16.result
    echo "------------------------------" >> $BingoDIR/16.log
    echo "File: /etc/profile" >> $BingoDIR/16.log
    echo "------------------------------" >> $BingoDIR/16.log
    echo "NO FILE" >> $BingoDIR/16.log
fi

if [ -f /root/.bashrc ] 
then
	if [ `cat /root/.bashrc | grep "PATH=" | grep -iv "^ *#" | awk -F '=' '{print $2}' | grep  "\.:" | wc -l` -ge 1 ]
    then
	    echo "NO" >> $BingoDIR/16.result
        echo "KB-AU-16-N-02" >> $BingoDIR/16.msg
        echo "------------------------------" >> $BingoDIR/16.log
        echo "File: /root/.bashrc" >> $BingoDIR/16.log
        echo "------------------------------" >> $BingoDIR/16.log
        cat /root/.bashrc | grep "PATH=" | grep -iv "^ *#" | awk -F '=' '{print $2}' | grep  "\.:" >> $BingoDIR/16.log
    else
        echo "YES" >> $BingoDIR/16.result
        echo "------------------------------" >> $BingoDIR/16.log
        echo "File: /root/.bashrc" >> $BingoDIR/16.log
        echo "------------------------------" >> $BingoDIR/16.log
        cat /root/.bashrc | grep "PATH=" >> $BingoDIR/16.log
    fi
else 
    echo "YES" >> $BingoDIR/16.result
    echo "------------------------------" >> $BingoDIR/16.log
    echo "File: /root/.bashrc" >> $BingoDIR/16.log
    echo "------------------------------" >> $BingoDIR/16.log
    echo "NO FILE" >> $BingoDIR/16.log
fi

if [ -f /root/.profile ] 
then
	if [ `cat /root/.profile | grep "PATH=" | grep -iv "^ *#" | awk -F '=' '{print $2}' | grep  "\.:" | wc -l` -ge 1 ]
    then
	    echo "NO" >> $BingoDIR/16.result
        echo "KB-AU-16-N-03" >> $BingoDIR/16.msg
        echo "------------------------------" >> $BingoDIR/16.log
        echo "File: /root/.profile" >> $BingoDIR/16.log
        echo "------------------------------" >> $BingoDIR/16.log
        cat /root/.profile | grep "PATH=" | grep -iv "^ *#" | awk -F '=' '{print $2}' | grep  "\.:" >> $BingoDIR/16.log
    else
        echo "YES" >> $BingoDIR/16.result
        echo "------------------------------" >> $BingoDIR/16.log
        echo "File: /root/.profile" >> $BingoDIR/16.log
        echo "------------------------------" >> $BingoDIR/16.log
        cat /root/.profile | grep "PATH=" >> $BingoDIR/16.log
    fi
else 
    echo "YES" >> $BingoDIR/16.result
    echo "------------------------------" >> $BingoDIR/16.log
    echo "File: /root/.profile" >> $BingoDIR/16.log
    echo "------------------------------" >> $BingoDIR/16.log
    echo "NO FILE" >> $BingoDIR/16.log
fi

if [ `cat $BingoDIR/16.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/16.result
else 
    echo "YES" > $BingoDIR/16.result
    echo "KB-AU-16-Y-01" > $BingoDIR/16.msg
fi

# 전체 파일 출력
echo "$LOG_ALL" >> $BingoDIR/16.log
if [ -f /etc/profile ] 
then
    echo "------------------------------" >> $BingoDIR/16.log
    echo "File: /etc/profile" >> $BingoDIR/16.log
    echo "------------------------------" >> $BingoDIR/16.log
    cat /etc/profile >> $BingoDIR/16.log
else 
    echo "------------------------------" >> $BingoDIR/16.log
    echo "File: /etc/profile" >> $BingoDIR/16.log
    echo "------------------------------" >> $BingoDIR/16.log
    echo "NO FILE" >> $BingoDIR/16.log
fi

if [ -f /root/.bashrc ] 
then
    echo "------------------------------" >> $BingoDIR/16.log
    echo "File: /root/.bashrc" >> $BingoDIR/16.log
    echo "------------------------------" >> $BingoDIR/16.log
    cat /root/.bashrc >> $BingoDIR/16.log
else 
    echo "------------------------------" >> $BingoDIR/16.log
    echo "File: /root/.bashrc" >> $BingoDIR/16.log
    echo "------------------------------" >> $BingoDIR/16.log
    echo "NO FILE" >> $BingoDIR/16.log
fi

if [ -f /root/.profile ] 
then
    echo "------------------------------" >> $BingoDIR/16.log
    echo "File: /root/.profile" >> $BingoDIR/16.log
    echo "------------------------------" >> $BingoDIR/16.log
    cat /root/.profile >> $BingoDIR/16.log
else 
    echo "------------------------------" >> $BingoDIR/16.log
    echo "File: /root/.profile" >> $BingoDIR/16.log
    echo "------------------------------" >> $BingoDIR/16.log
    echo "NO FILE" >> $BingoDIR/16.log
fi 
# 16 end

# 17 start
#============================================================================================================================================
# U-17 파일 및 디렉터리 소유자 설정
# 소유자 불분명한 파일이나 디렉터리가 존재하는지 여부를 점검
echo "KB-AU-17" > $BingoDIR/17.title

RESULT='MANUAL'
RESULT_MSG="KB-AU-17-M-01"
RESULT_LOG="MANUAL"
RESULT_LOG2="Nouser: #find / nouser -print"
RESULT_LOG3="Nogroup: #find / nogroup -print"

echo "$RESULT" > $BingoDIR/17.result
echo "$RESULT_MSG" > $BingoDIR/17.msg
echo "$RESULT_LOG" > $BingoDIR/17.log
echo "$RESULT_LOG2" >> $BingoDIR/17.log
echo "$RESULT_LOG3" >> $BingoDIR/17.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
unset RESULT_LOG3
# 17 end

# 18 start
#================================================================================
# U-18 /etc/passwd 파일 소유자 및 권한 설정
# /etc/passwd 파일 권한 적절성 점검
echo "KB-AU-18" > $BingoDIR/18.title

echo "YES" > $BingoDIR/18.result

echo "" > $BingoDIR/18.msg

echo "$LOG_PERMISSION" > $BingoDIR/18.log

if [ `ls -alL /etc/passwd | awk '{ print $3 }'` == 'root' ]
then
    echo "YES" >> $BingoDIR/18.result
    ls -alL /etc/passwd >> $BingoDIR/18.log
else 
    echo "NO" >> $BingoDIR/18.result
    echo "KB-AU-18-N-01" >> $BingoDIR/18.msg
    ls -alL /etc/passwd >> $BingoDIR/18.log
fi

if [ `ls -al /etc/passwd | cut -c 2-4` == 'rw-' ] || [ `ls -al /etc/passwd | cut -c 2-4` == 'r--' ] || [ `ls -al /etc/passwd | cut -c 2-4` == '---' ] || [ `ls -al /etc/passwd | cut -c 2-4` == '-w-' ]
then
    if [ `ls -al /etc/passwd | cut -c 5-7` == 'r--' ] || [ `ls -al /etc/passwd | cut -c 5-7` == '---' ]
    then
        if [ `ls -al /etc/passwd | cut -c 8-10` == 'r--' ] || [ `ls -al /etc/passwd | cut -c 8-10` == '---' ]
        then
            echo "YES" >> $BingoDIR/18.result
        else
            echo "NO" >> $BingoDIR/18.result
            echo "KB-AU-18-N-02" >> $BingoDIR/18.msg
        fi
    else
        echo "NO" >> $BingoDIR/18.result
        echo "KB-AU-18-N-02" >> $BingoDIR/18.msg
    fi
else
    echo "NO" >> $BingoDIR/18.result
    echo "KB-AU-18-N-02" >> $BingoDIR/18.msg
fi

if [ `cat $BingoDIR/18.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/18.result
else 
    echo "YES" > $BingoDIR/18.result
    echo "KB-AU-18-Y-01" > $BingoDIR/18.msg
fi

# 18 end

# 19 start
#================================================================================
# U-19 /etc/shadow 파일 소유자 및 권한 설정
# /etc/shadow 파일 권한 적절성 점검
echo "KB-AU-19" > $BingoDIR/19.title

echo "YES" > $BingoDIR/19.result

echo "" > $BingoDIR/19.msg

echo "$LOG_PERMISSION" > $BingoDIR/19.log

if [ `ls -alL /etc/shadow | awk '{ print $3 }'` == 'root' ]
then
    echo "YES" >> $BingoDIR/19.result
    ls -alL /etc/shadow >> $BingoDIR/19.log
else 
    echo "NO" >> $BingoDIR/19.result
    echo "KB-AU-19-N-01" >> $BingoDIR/19.msg
    ls -alL /etc/shadow >> $BingoDIR/19.log
fi

if [ `ls -al /etc/shadow | cut -c 2-10` == 'r--------' ] || [ `ls -al /etc/shadow | cut -c 2-10` == '---------' ]
then
    echo "YES" >> $BingoDIR/19.result
else
    echo "NO" >> $BingoDIR/19.result
    echo "KB-AU-19-N-02" >> $BingoDIR/19.msg
fi

if [ `cat $BingoDIR/19.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/19.result
else 
    echo "YES" > $BingoDIR/19.result
    echo "KB-AU-19-Y-01" > $BingoDIR/19.msg
fi

# 19 end

# 20 start
#================================================================================
# U-20 /etc/hosts 파일 소유자 및 권한 설정
# /etc/hosts 파일의 권한 적절성 점검
echo "KB-AU-20" > $BingoDIR/20.title

echo "YES" > $BingoDIR/20.result

echo "" > $BingoDIR/20.msg

echo "$LOG_PERMISSION" > $BingoDIR/20.log

if [ `ls -l /etc/hosts | awk '{ print $3 }'` == 'root' ]
then
    echo "YES" >> $BingoDIR/20.result
    ls -al /etc/hosts >> $BingoDIR/20.log
else
    echo "NO" >> $BingoDIR/20.result
    echo "KB-AU-20-N-01" >> $BingoDIR/20.msg
	ls -al /etc/hosts >> $BingoDIR/20.log
fi

if [ `ls -al /etc/hosts | cut -c 2-4` == 'rw-' ] || [ `ls -al /etc/hosts | cut -c 2-4` == 'r--' ] || [ `ls -al /etc/hosts | cut -c 2-4` == '---' ] || [ `ls -al /etc/hosts | cut -c 2-4` == '-w-' ]
then
    if [ `ls -al /etc/hosts | cut -c 5-7` == 'r--' ] || [ `ls -al /etc/hosts | cut -c 5-7` == '---' ]
    then
        if [ `ls -al /etc/hosts | cut -c 8-10` == 'r--' ] || [ `ls -al /etc/hosts | cut -c 8-10` == '---' ]
        then
            echo "YES" >> $BingoDIR/20.result
        else
            echo "NO" >> $BingoDIR/20.result
            echo "KB-AU-20-N-02" >> $BingoDIR/20.msg
        fi
    else
        echo "NO" >> $BingoDIR/20.result
        echo "KB-AU-20-N-02" >> $BingoDIR/20.msg
    fi
else
    echo "NO" >> $BingoDIR/20.result
    echo "KB-AU-20-N-02" >> $BingoDIR/20.msg
fi

if [ `cat $BingoDIR/20.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/20.result
else 
    echo "YES" > $BingoDIR/20.result
    echo "KB-AU-20-Y-01" > $BingoDIR/20.msg
fi

# 20 end

# 21 start
#================================================================================
# U-21 /etc/(x)inetd.conf 파일 소유자 및 권한 설정
# /etc/(x)inetd.conf 파일 권한 적절성 점검
echo "KB-AU-21" > $BingoDIR/21.title

echo "YES" > $BingoDIR/21.result

echo "" > $BingoDIR/21.msg

echo "$LOG_PERMISSION" > $BingoDIR/21.log

if [ -f /etc/inetd.conf ]
then
	if [ `ls -l /etc/inetd.conf | awk '{ print $3}'` == 'root' ]
    then
        echo "YES" >> $BingoDIR/21.result
        ls -l /etc/inetd.conf >> $BingoDIR/21.log
    else
        echo "NO" >> $BingoDIR/21.result
        echo "KB-AU-21-N-01" >> $BingoDIR/21.msg
    fi

    if [ `ls -al /etc/inetd.conf | cut -c 2-10` == 'rw-------' ] || [ `ls -al /etc/inetd.conf | cut -c 2-10` == 'r--------' ] || [ `ls -al /etc/inetd.conf | cut -c 2-10` == '-w-------' ] || [ `ls -al /etc/inetd.conf | cut -c 2-10` == '---------' ]
    then
		echo "YES" >> $BingoDIR/21.result
	else
		echo "NO" >> $BingoDIR/21.result
        echo "KB-AU-21-N-02" >> $BingoDIR/21.msg
	fi
elif [ -f /etc/xinetd.conf ]
then
	if [ `ls -l /etc/xinetd.conf | awk '{ print $3}'` == 'root' ]
    then
        echo "YES" >> $BingoDIR/21.result
        ls -l /etc/xinetd.conf >> $BingoDIR/21.log
    else 
        echo "NO" >> $BingoDIR/21.result
        echo "KB-AU-21-N-03" >> $BingoDIR/21.msg
    fi

    if [ `ls -al /etc/xinetd.conf | cut -c 2-10` == 'rw-------' ] || [ `ls -al /etc/xinetd.conf | cut -c 2-10` == 'r--------' ] || [ `ls -al /etc/xinetd.conf | cut -c 2-10` == '-w-------' ] || [ `ls -al /etc/xinetd.conf | cut -c 2-10` == '---------' ]
    then
        echo "YES" >> $BingoDIR/21.result
    else
        echo "NO" >> $BingoDIR/21.result
        echo "KB-AU-21-N-04" >> $BingoDIR/21.msg
    fi
else
	echo "MANUAL" > $BingoDIR/21.result
	echo "KB-AU-21-M-01" > $BingoDIR/21.msg
	echo "NO FILE" >> $BingoDIR/21.log
fi

if [ `cat $BingoDIR/21.result | grep -i "MANUAL" | wc -l` -ge 1 ]
then 
    echo "MANUAL" > $BingoDIR/21.result
elif [ `cat $BingoDIR/21.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/21.result
else 
    echo "YES" > $BingoDIR/21.result
    echo "KB-AU-21-Y-01" >> $BingoDIR/21.msg
fi

# 21 end

# 22 start
#================================================================================
# U-22 /etc/syslog.conf 파일 소유자 및 권한 설정
# /etc/syslog.conf 파일 권한 적절성 점검
echo "KB-AU-22" > $BingoDIR/22.title

echo "YES" > $BingoDIR/22.result

echo "" > $BingoDIR/22.msg

echo "$LOG_PERMISSION" > $BingoDIR/22.log

if [ -f /etc/syslog.conf ]
then
	if [ `ls -al /etc/syslog.conf | awk '{ print $3 }'` == 'root' ] || [ `ls -al /etc/syslog.conf | awk '{ print $3 }'` == 'bin' ] || [ `ls -al /etc/syslog.conf | awk '{ print $3 }'` == 'sys' ]
    then
        echo "YES" >> $BingoDIR/22.result
        ls -al /etc/syslog.conf >> $BingoDIR/22.log
    else 
        echo "NO" >> $BingoDIR/22.result
        echo "KB-AU-22-N-01" >> $BingoDIR/22.msg
        ls -al /etc/syslog.conf >> $BingoDIR/22.log
    fi
        
    if [ `ls -al /etc/syslog.conf | cut -c 2-4` == 'rw-' ] || [ `ls -al /etc/syslog.conf | cut -c 2-4` == 'r--' ] || [ `ls -al /etc/syslog.conf | cut -c 2-4` == '---' ] || [ `ls -al /etc/syslog.conf | cut -c 2-4` == '-w-' ]
    then
        if [ `ls -al /etc/syslog.conf | cut -c 5-10` == 'r-----' ] || [ `ls -al /etc/syslog.conf | cut -c 5-10` == '------' ]
        then
            echo "YES" >> $BingoDIR/22.result
        else
            echo "NO" >> $BingoDIR/22.result
            echo "KB-AU-22-N-02" >> $BingoDIR/22.msg
        fi
    else
        echo "NO" >> $BingoDIR/22.result
        echo "KB-AU-22-N-02" >> $BingoDIR/22.msg
    fi       
elif [ -f /etc/rsyslog.conf ]
then
	if [ `ls -al /etc/rsyslog.conf | awk '{ print $3 }'` == 'root' ] || [ `ls -al /etc/rsyslog.conf | awk '{ print $3 }'` == 'bin' ] || [ `ls -al /etc/rsyslog.conf | awk '{ print $3 }'` == 'sys' ]
    then
        echo "YES" >> $BingoDIR/22.result
        ls -al /etc/rsyslog.conf >> $BingoDIR/22.log
    else 
        echo "NO" >> $BingoDIR/22.result
        echo "KB-AU-22-N-03" >> $BingoDIR/22.msg
        ls -al /etc/rsyslog.conf >> $BingoDIR/22.log
    fi

    if [ `ls -al /etc/rsyslog.conf | cut -c 2-4` == 'rw-' ] || [ `ls -al /etc/rsyslog.conf | cut -c 2-4` == 'r--' ] || [ `ls -al /etc/rsyslog.conf | cut -c 2-4` == '---' ] || [ `ls -al /etc/rsyslog.conf | cut -c 2-4` == '-w-' ]
    then
        if [ `ls -al /etc/rsyslog.conf | cut -c 5-10` == 'r-----' ] || [ `ls -al /etc/rsyslog.conf | cut -c 5-10` == '------' ]
        then
            echo "YES" >> $BingoDIR/22.result
        else
            echo "NO" >> $BingoDIR/22.result
            echo "KB-AU-22-N-04" >> $BingoDIR/22.msg
        fi
    else
        echo "NO" >> $BingoDIR/22.result
        echo "KB-AU-22-N-04" >> $BingoDIR/22.msg
    fi
else
    echo "MANUAL" > $BingoDIR/22.result
	echo "KB-AU-22-M-01" > $BingoDIR/22.msg
	echo "NO FILE" >> $BingoDIR/22.log
fi

if [ `cat $BingoDIR/22.result | grep -i "MANUAL" | wc -l` -ge 1 ]
then 
    echo "MANUAL" > $BingoDIR/22.result
elif [ `cat $BingoDIR/22.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/22.result
else 
    echo "YES" > $BingoDIR/22.result
    echo "KB-AU-22-Y-01" >> $BingoDIR/22.msg
fi

# 22 end

# 23 start
#================================================================================
# U-23 /etc/services 파일 소유자 및 권한 설정
# /etc/services 파일 권한 적절성 점검
echo "KB-AU-23" > $BingoDIR/23.title

echo "YES" > $BingoDIR/23.result

echo "" > $BingoDIR/23.msg

echo "$LOG_PERMISSION" > $BingoDIR/23.log

if [ `ls -l /etc/services | awk '{ print $3}' |grep -w 'root\|bin\|sys' | wc -l` -eq 1 ]
then
    echo "YES" >> $BingoDIR/23.result
    ls -al /etc/services >> $BingoDIR/23.log
else 
    echo "NO" >> $BingoDIR/23.result
    echo "KB-AU-23-N-01" >> $BingoDIR/23.msg
    ls -al /etc/services >> $BingoDIR/23.log
fi

if [ `ls -al /etc/services | cut -c 2-4` == 'rw-' ] || [ `ls -al /etc/services | cut -c 2-4` == 'r--' ] || [ `ls -al /etc/services | cut -c 2-4` == '---' ] || [ `ls -al /etc/services | cut -c 2-4` == '-w-' ]
then
    if [ `ls -al /etc/services | cut -c 5-7 ` == 'r--' ] || [ `ls -al /etc/services | cut -c 5-7` == '---' ]
    then
        if [ `ls -al /etc/services | cut -c 8-10` == 'r--' ] || [ `ls -al /etc/services | cut -c 8-10` == '---' ]
        then
            echo "YES" >> $BingoDIR/23.result
        else
            echo "NO" >> $BingoDIR/23.result
            echo "KB-AU-23-N-02" >> $BingoDIR/23.msg
        fi
    else
        echo "NO" >> $BingoDIR/23.result
        echo "KB-AU-23-N-02" >> $BingoDIR/23.msg
    fi
else
    echo "NO" >> $BingoDIR/23.result
    echo "KB-AU-23-N-02" >> $BingoDIR/23.msg
fi

if [ `cat $BingoDIR/23.result | grep -i "MANUAL" | wc -l` -ge 1 ]
then 
    echo "MANUAL" > $BingoDIR/23.result
elif [ `cat $BingoDIR/23.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/23.result
else 
    echo "YES" > $BingoDIR/23.result
    echo "KB-AU-23-Y-01" >> $BingoDIR/23.msg
fi

# 23 end

# 24 start
#================================================================================*****
# U-24 SUID, SGID, 설정 및 권한 설정
# 불필요하거나 악의적인 파일에 SUID, SGID 설정 여부 점검
echo "KB-AU-24" > $BingoDIR/24.title

echo "YES" > $BingoDIR/24.result

echo "" > $BingoDIR/24.msg

echo "$LOG_PERMISSION" > $BingoDIR/24.log

for VALUE in 'dump' 'restore' 'unix_chkpwd'
do
	if [ -f /sbin/$VALUE ]
	then
		if [ `find /sbin/ -user root -type f \( -perm -04000 -o -perm -02000 \) -exec ls -al {} \; 2>/dev/null | grep -w 'root' | grep -w $VALUE | wc -l` -eq 0 ]
		then
			echo "YES" >> $BingoDIR/24.result
            find /sbin/ -user root -type f \( -perm -04000 -o -perm -02000 \) -exec ls -al {} \; 2>/dev/null | grep -w $VALUE >> $BingoDIR/24.log
		else
			echo "NO" >> $BingoDIR/24.result
			echo "KB-AU-24-N-$VALUE" >> $BingoDIR/24.msg
			find /sbin/ -user root -type f \( -perm -04000 -o -perm -02000 \) -exec ls -al {} \; 2>/dev/null | grep -w $VALUE >> $BingoDIR/24.log
		fi
	else
		continue
	fi
done
unset VALUE

for VALUE in 'at' 'lpq' 'lpq-lpd' 'lpr' 'lpr-lpd' 'lprm' 'lprm-lpd' 'newgrp'
do
    if [ -f /usr/bin/$VALUE ]
    then
        if [ `find /usr/bin/ -user root -type f \( -perm -04000 -o -perm -02000 \) -exec ls -al {} \; 2>/dev/null | grep -w 'root' | grep -w $VALUE | wc -l` -eq 0 ]
        then
            echo "YES" >> $BingoDIR/24.result
            find /usr/bin/ -user root -type f \( -perm -04000 -o -perm -02000 \) -exec ls -al {} \; 2>/dev/null | grep -w $VALUE >> $BingoDIR/24.log
        else
            echo "NO" >> $BingoDIR/24.result
			echo "KB-AU-24-N-$VALUE" >> $BingoDIR/24.msg
			find /usr/bin/ -user root -type f \( -perm -04000 -o -perm -02000 \) -exec ls -al {} \; 2>/dev/null | grep -w $VALUE >> $BingoDIR/24.log
        fi
    else
        continue
    fi
done
unset VALUE

for VALUE in 'lpc' 'lpc-lpd' 'traceroute'
do
    if [ -f /usr/sbin/$VALUE ]
    then
        if [ `find /usr/sbin/ -user root -type f \( -perm -04000 -o -perm -02000 \) -exec ls -al {} \; 2>/dev/null | grep -w 'root' | grep -w $VALUE | wc -l` -eq 0 ]
        then
            echo "YES" >> $BingoDIR/24.result
            find /usr/sbin/ -user root -type f \( -perm -04000 -o -perm -02000 \) -exec ls -al {} \; 2>/dev/null | grep -w $VALUE >> $BingoDIR/24.log
        else
            echo "NO" >> $BingoDIR/24.result
			echo "KB-AU-24-N-$VALUE" >> $BingoDIR/24.msg
			find /usr/sbin/ -user root -type f \( -perm -04000 -o -perm -02000 \) -exec ls -al {} \; 2>/dev/null | grep -w $VALUE >> $BingoDIR/24.log
        fi
    fi
done
unset VALUE

if [ `cat $BingoDIR/24.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/24.result
else 
    echo "YES" > $BingoDIR/24.result
    echo "KB-AU-24-Y-01" > $BingoDIR/24.msg
fi

# 24 end

# 25 start
#================================================================================
# U-25 사용자, 시스템 시작파일 및 환경파일 소유자 및 권한 설정
# 홈 디렉터리 내의 환경변수 파일에 대한 소유자 및 접근권한이 관리자 또는 해당 계정으로 설정되어 있는지 점검
echo "KB-AU-25" > $BingoDIR/25.title

echo "YES" > $BingoDIR/25.result

echo "" > $BingoDIR/25.msg

echo "$LOG_PERMISSION" > $BingoDIR/25.log

LIST=($(cat /etc/passwd | grep -v nologin | grep -v /bin/false | awk -F ":" '{ print $1 }'))
DIR=($(cat /etc/passwd | grep -v nologin | grep -v /bin/false | awk -F ":" '{ print $6 }'))

for((i=0; i<${#LIST[@]}; i++))
do
    echo "------------------------------" >> $BingoDIR/25.log
    echo "Directory: " ${DIR[i]} >> $BingoDIR/25.log
    echo "------------------------------" >> $BingoDIR/25.log

    for VALUE in '.profile' '.kshrc' '.bashrc' '.cshrc' '.login' '.bash_profile'
    do
        if [ -f ${DIR[i]}/$VALUE ]
        then
            if [ `ls -al ${DIR[i]}/$VALUE | cut -c 2-10` == 'rw-------' ] || [ `ls -al ${DIR[i]}/$VALUE | cut -c 2-10` = 'r--------' ] || [ `ls -al ${DIR[i]}/$VALUE | cut -c 2-10` = '-w-------' ] || [ `ls -al ${DIR[i]}/$VALUE | cut -c 2-10` = '---------' ]
            then
                echo "YES" >> $BingoDIR/25.result
                ls -al ${DIR[i]}/$VALUE >> $BingoDIR/25.log
            else
                echo "NO" >> $BingoDIR/25.result
                echo "KB-AU-25-N-1$VALUE" >> $BingoDIR/25.dedup
                ls -al ${DIR[i]}/$VALUE >> $BingoDIR/25.log
            fi

            if [ `ls -al ${DIR[i]}/$VALUE | awk '{ print $3 }'` == 'root' ] || [ `ls -al ${DIR[i]}/$VALUE | awk '{ print $3 }'` == "${LIST[i]}" ]
            then
                echo "YES" >> $BingoDIR/25.result
            else
                echo "NO" >> $BingoDIR/25.result
                echo "KB-AU-25-N-2$VALUE" >> $BingoDIR/25.dedup
            fi
        else
            echo "YES" >> $BingoDIR/25.result
            echo "$VALUE NO FILE" >> $BingoDIR/25.log
        fi
    done
done

unset LIST
unset DIR
unset VALUE

echo "------------------------------" >> $BingoDIR/25.log
if [ -f /root/.sh_history ]
then
    if [ `ls -al /root/.sh_history | cut -c 2-10` = 'rw-------' ] || [ `ls -al /root/.sh_history | cut -c 2-10` = 'r--------' ] || [ `ls -al /root/.sh_history | cut -c 2-10` = '-w-------' ] || [ `ls -al /root/.sh_history | cut -c 2-10` = '---------' ]
    then
        echo "YES" >> $BingoDIR/25.result
        ls -al /root/.sh_history >> $BingoDIR/25.log
    else 
        echo "NO" >> $BingoDIR/25.result
        echo "KB-AU-25-N-01" >> $BingoDIR/25.msg
        ls -al /root/.sh_history >> $BingoDIR/25.log
    fi
    
    if [ `ls -al /root/.sh_history | awk '{ print $3 }'` == 'root' ]
    then
        echo "YES" >> $BingoDIR/25.result
    else 
        echo "NO" >> $BingoDIR/25.result
        echo "KB-AU-25-N-02" >> $BingoDIR/25.msg
    fi
else
    echo "YES" >> $BingoDIR/25.result
    echo "/root/.sh_history NO FILE" >> $BingoDIR/25.log
fi

if [ -f /root/.bash_history ]
then
    if [ `ls -al /root/.bash_history | cut -c 2-10` = 'rw-------' ] || [ `ls -al /root/.bash_history | cut -c 2-10` = 'r--------' ] || [ `ls -al /root/.bash_history | cut -c 2-10` = '-w-------' ] || [ `ls -al /root/.bash_history | cut -c 2-10` = '---------' ]
    then
        echo "YES" >> $BingoDIR/25.result
        ls -al /root/.bash_history >> $BingoDIR/25.log
    else 
        echo "NO" >> $BingoDIR/25.result
        echo "KB-AU-25-N-03" >> $BingoDIR/25.msg
        ls -al /root/.bash_history >> $BingoDIR/25.log
    fi

    if [ `ls -al /root/.bash_history | awk '{ print $3 }'` == 'root' ]
    then
        echo "YES" >> $BingoDIR/25.result
    else 
        echo "NO" >> $BingoDIR/25.result
        echo "KB-AU-25-N-04" >> $BingoDIR/25.msg
    fi
else
    echo "YES" >> $BingoDIR/25.result
    echo "/root/.bash_history NO FILE" >> $BingoDIR/25.log
fi

if [ -f /tcb/file/auth ]
then
    if [ `ls -al /tcb/file/auth | cut -c 2-10` == 'r--------' ] || [ `ls -al /tcb/file/auth | cut -c 2-10` = '---------' ]
    then
        echo "YES" >> $BingoDIR/25.result
        ls -al /tcb/file/auth >> $BingoDIR/25.log
    else 
        echo "NO" >> $BingoDIR/25.result
        echo "KB-AU-25-N-05" >> $BingoDIR/25.msg
        ls -al /tcb/file/auth >> $BingoDIR/25.log
    fi

    if [ `ls -al /tcb/file/auth | awk '{ print $3 }'` == 'root' ]
    then
        echo "YES" >> $BingoDIR/25.result
    else 
        echo "NO" >> $BingoDIR/25.result
        echo "KB-AU-25-N-06" >> $BingoDIR/25.msg
    fi
else
    echo "YES" >> $BingoDIR/25.result
    echo "/tcb/file/auth NO FILE" >> $BingoDIR/25.log
fi

if [ -f /etc/profile ]
then
    if [ `ls -al /etc/profile | cut -c 2-4` == 'rwx' ] || [ `ls -al /etc/profile | cut -c 2-4` == 'rw-' ] || [ `ls -al /etc/profile | cut -c 2-4` == 'r-x' ] || [ `ls -al /etc/profile | cut -c 2-4` == 'r--' ] || [ `ls -al /etc/profile | cut -c 2-4` == '-wx' ] || [ `ls -al /etc/profile | cut -c 2-4` == '-w-' ] || [ `ls -al /etc/profile | cut -c 2-4` == '--x' ] || [ `ls -al /etc/profile | cut -c 2-4` == '---' ]
    then
        if [ `ls -al /etc/profile | cut -c 5-7` == 'r-x' ] || [ `ls -al /etc/profile | cut -c 5-7` == 'r--' ] || [ `ls -al /etc/profile | cut -c 5-7` == '--x' ] || [ `ls -al /etc/profile | cut -c 5-7` == '---' ]
        then
            if [ `ls -al /etc/profile | cut -c 8-10` == 'r-x' ] || [ `ls -al /etc/profile | cut -c 8-10` == 'r--' ] || [ `ls -al /etc/profile | cut -c 8-10` == '--x' ] || [ `ls -al /etc/profile | cut -c 8-10` == '---' ]
            then
                echo "YES" >> $BingoDIR/25.result
                ls -al /etc/profile >> $BingoDIR/25.log
            else
                echo "NO" >> $BingoDIR/25.result
                echo "KB-AU-25-N-07" >> $BingoDIR/25.msg
                ls -al /etc/profile >> $BingoDIR/25.log
            fi
        else
            echo "NO" >> $BingoDIR/25.result
            echo "KB-AU-25-N-07" >> $BingoDIR/25.msg
            ls -al /etc/profile >> $BingoDIR/25.log
        fi
    else
        echo "NO" >> $BingoDIR/25.result
        echo "KB-AU-25-N-07" >> $BingoDIR/25.msg
        ls -al /etc/profile >> $BingoDIR/25.log
    fi

    if [ `ls -al /etc/profile | awk '{ print $3 }'` = "root" ]
    then
        echo "YES" >> $BingoDIR/25.result
    else 
        echo "NO" >> $BingoDIR/25.result
        echo "KB-AU-25-N-08" >> $BingoDIR/25.msg
    fi
else
    echo "YES" >> $BingoDIR/25.result
    echo "/etc/profile NO FILE" >> $BingoDIR/25.log
fi

if [ -f /etc/inittab ]
then
    if [ `ls -al /etc/inittab | cut -c 2-4` == 'rw-' ] || [ `ls -al /etc/inittab | cut -c 2-4` == 'r--' ] || [ `ls -al /etc/inittab | cut -c 2-4` == '-w-' ] || [ `ls -al /etc/inittab | cut -c 2-4` == '---' ]
    then
        if [ `ls -al /etc/inittab | cut -c 5-7` == '---' ] || [ `ls -al /etc/inittab | cut -c 5-7` == 'r--' ]
        then
            if [ `ls -al /etc/inittab | cut -c 8-10` == '---' ] || [ `ls -al /etc/inittab | cut -c 8-10` == 'r--' ]
            then
                echo "YES" >> $BingoDIR/25.result
                ls -al /etc/inittab >> $BingoDIR/25.log
            else
                echo "NO" >> $BingoDIR/25.result
                echo "KB-AU-25-N-09" >> $BingoDIR/25.msg
                ls -al /etc/inittab >> $BingoDIR/25.log
            fi
        else
            echo "NO" >> $BingoDIR/25.result
            echo "KB-AU-25-N-09" >> $BingoDIR/25.msg
            ls -al /etc/inittab >> $BingoDIR/25.log
        fi
    else 
        echo "NO" >> $BingoDIR/25.result
        echo "KB-AU-25-N-09" >> $BingoDIR/25.msg
        ls -al /etc/inittab >> $BingoDIR/25.log
    fi
    
    if [ `ls -al /etc/inittab | awk '{ print $3 }'` = "root" ]
    then
        echo "YES" >> $BingoDIR/25.result
    else 
        echo "NO" >> $BingoDIR/25.result
        echo "KB-AU-25-N-10" >> $BingoDIR/25.msg
    fi
else
    echo "YES" >> $BingoDIR/25.result
    echo "/etc/inittab NO FILE" >> $BingoDIR/25.log
fi

if [ -f /etc/snmp/snmpd.conf ]
then
    if [ `ls -al /etc/snmp/snmpd.conf | cut -c 2-4` == 'rw-' ] || [ `ls -al /etc/snmp/snmpd.conf | cut -c 2-4` == 'r--' ] || [ `ls -al /etc/snmp/snmpd.conf | cut -c 2-4` == '-w-' ] || [ `ls -al /etc/snmp/snmpd.conf | cut -c 2-4` == '---' ]
    then
        if [ `ls -al /etc/snmp/snmpd.conf | cut -c 5-7` == '---' ] || [ `ls -al /etc/snmp/snmpd.conf | cut -c 5-7` == 'r--' ]
        then
            if [ `ls -al /etc/snmp/snmpd.conf | cut -c 8-10` == '---' ] || [ `ls -al /etc/snmp/snmpd.conf | cut -c 8-10` == 'r--' ]
            then
                echo "YES" >> $BingoDIR/25.result
                ls -al /etc/snmp/snmpd.conf >> $BingoDIR/25.log
            else
                echo "NO" >> $BingoDIR/25.result
                echo "KB-AU-25-N-11" >> $BingoDIR/25.msg
                ls -al /etc/snmp/snmpd.conf >> $BingoDIR/25.log
            fi
        else
            echo "NO" >> $BingoDIR/25.result
            echo "KB-AU-25-N-11" >> $BingoDIR/25.msg
            ls -al /etc/snmp/snmpd.conf >> $BingoDIR/25.log
        fi
    else 
        echo "NO" >> $BingoDIR/25.result
        echo "KB-AU-25-N-11" >> $BingoDIR/25.msg
        ls -al /etc/snmp/snmpd.conf >> $BingoDIR/25.log
    fi

    if [ `ls -al /etc/snmp/snmpd.conf | awk '{ print $3 }'` = "root" ]
    then
        echo "YES" >> $BingoDIR/25.result
    else 
        echo "NO" >> $BingoDIR/25.result
        echo "KB-AU-25-N-12" >> $BingoDIR/25.msg
    fi
else
    echo "YES" >> $BingoDIR/25.result
    echo "/etc/snmp/snmpd.conf NO FILE" >> $BingoDIR/25.log
fi

# 중복값 제거
if [ -f $BingoDIR/25.dedup ]
then
    sort $BingoDIR/25.dedup > $BingoDIR/252.dedup
    sort $BingoDIR/252.dedup | uniq >> $BingoDIR/25.msg

    rm -rf $BingoDIR/25.dedup
    rm -rf $BingoDIR/252.dedup
fi

if [ `cat $BingoDIR/25.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/25.result
else 
    echo "YES" > $BingoDIR/25.result
    echo "KB-AU-25-Y-01" > $BingoDIR/25.msg
fi

# 25 end

# 26 start
#================================================================================
# U-26 world writable 파일 점검
# 불필요한 world writable 파일 존재 여부 점검
echo "KB-AU-26" > $BingoDIR/26.title

RESULT='MANUAL'
RESULT_MSG='KB-AU-26-M-01'
RESULT_LOG="MANUAL"
RESULT_LOG2="#find / -perm -2 -type f -exec ls -l {} \;"

echo "$RESULT" > $BingoDIR/26.result
echo "$RESULT_MSG" > $BingoDIR/26.msg
echo "$RESULT_LOG" > $BingoDIR/26.log
echo "$RESULT_LOG2" >> $BingoDIR/26.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
# 26 end

# 27 start
#================================================================================
# U-27 /dev에 존재하지 않는 device파일 점검
# 존재하지 않는 device 파일 존재 여부 점검
echo "KB-AU-27" > $BingoDIR/27.title

RESULT='YES'

if [ `find /dev -type f -exec ls -l {} \; | wc -l` -eq 0 ]
then
	RESULT='YES'
	RESULT_MSG="KB-AU-27-Y-01"
	RESULT_LOG=$(find /dev -type f -exec ls -l {} \; 2>&1)
else
    RESULT='NO'
	RESULT_MSG="KB-AU-27-N-01"
	RESULT_LOG=$(find /dev -type f -exec ls -l {} \; 2>&1)
fi

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='NO VALUE'
fi

echo "$RESULT" > $BingoDIR/27.result
echo "$RESULT_MSG" > $BingoDIR/27.msg
echo "$LOG_ALL" > $BingoDIR/27.log
echo "$RESULT_LOG" >> $BingoDIR/27.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
# 27 end

# 28 start
#================================================================================
# U-28 $HOME/.rhosts, hosts.equiv 사용 금지
# /etc/hosts.equiv  파일  및  .rhosts  파일  사용자를  root  또는,  해당  계정으로  설정한 뒤 권한을 600으로 설정하고 해당파일 설정에 ‘+’ 설정(모든 호스트 허용)이 포함되지 않도록 설정되어 있는지 점검
echo "KB-AU-28" > $BingoDIR/28.title

echo "YES" > $BingoDIR/28.result

echo "" > $BingoDIR/28.msg

echo "$LOG_SECTION" > $BingoDIR/28.log

LS_HOME=`ls -d /home/*`

if [ -f /etc/hosts.equiv ]
then
	if [ `ls -al /etc/hosts.equiv | awk '{ print $3 }'` == 'root' ]
	then
	    echo "YES" >> $BingoDIR/28.result
        echo "------------------------------" >> $BingoDIR/28.log
        echo "File: /etc/hosts.equiv" >> $BingoDIR/28.log
        echo "------------------------------" >> $BingoDIR/28.log
        ls -al /etc/hosts.equiv >> $BingoDIR/28.log
    else 
        echo "NO" >> $BingoDIR/28.result
        echo "KB-AU-28-N-01" >> $BingoDIR/28.dedup
        echo "------------------------------" >> $BingoDIR/28.log
        echo "File: /etc/hosts.equiv" >> $BingoDIR/28.log
        echo "------------------------------" >> $BingoDIR/28.log
        ls -al /etc/hosts.equiv >> $BingoDIR/28.log
    fi

    if [ `ls -al /etc/hosts.equiv | cut -c 2-10` == 'rw-------' ] || [ `ls -al /etc/hosts.equiv | cut -c 2-10` == 'r--------' ] || [ `ls -al /etc/hosts.equiv | cut -c 2-10` == '-w-------' ] || [ `ls -al /etc/hosts.equiv | cut -c 2-10` == '---------' ]
	then
        echo "YES" >> $BingoDIR/28.result
    else 
        echo "NO" >> $BingoDIR/28.result
        echo "KB-AU-28-N-02" >> $BingoDIR/28.dedup
    fi
   
    if [ `cat /etc/hosts.equiv | grep '+' | grep -v '^ *#' | wc -l` -eq 0 ]
    then
        echo "YES" >> $BingoDIR/28.result
        cat /etc/hosts.equiv | grep '+' | grep -v '^ *#' >> $BingoDIR/28.log
    else
        echo "NO" >> $BingoDIR/28.result
        echo "KB-AU-28-N-03" >> $BingoDIR/28.dedup
        cat /etc/hosts.equiv | grep '+' | grep -v '^ *#' >> $BingoDIR/28.log
    fi
else
    echo "YES" >> $BingoDIR/28.result
    echo "KB-AU-28-Y-01" >> $BingoDIR/28.dedup
    echo "/etc/hosts.equiv NO FILE" >> $BingoDIR/28.log
fi

for USER_HOME in ${LS_HOME[@]}
do
    if [ -f $USER_HOME/.rhosts ]
    then
        if [ `ls -al $USER_HOME/.rhosts | awk '{ print $3 }'` == 'root' ] || [ `ls -al $USER_HOME/.rhosts | awk '{ print $3 }'` == `echo $USER_HOME | cut -c  7-` ]
        then
            echo "YES" >> $BingoDIR/28.result
            echo "------------------------------" >> $BingoDIR/28.log
            echo "File: $USER_HOME/.rhosts" >> $BingoDIR/28.log
            echo "------------------------------" >> $BingoDIR/28.log
            ls -al $USER_HOME/.rhosts >> $BingoDIR/28.log
        else 
            echo "NO" >> $BingoDIR/28.result
            echo "KB-AU-28-N-04" >> $BingoDIR/28.dedup
            echo "------------------------------" >> $BingoDIR/28.log
            echo "File: $USER_HOME/.rhosts" >> $BingoDIR/28.log
            echo "------------------------------" >> $BingoDIR/28.log
            ls -al $USER_HOME/.rhosts >> $BingoDIR/28.log
        fi
            
        if [ `ls -al $USER_HOME/.rhosts | cut -c 2-10` == 'rw-------' ] || [ `ls -al $USER_HOME/.rhosts | cut -c 2-10` == 'r--------' ] || [ `ls -al $USER_HOME/.rhosts | cut -c 2-10` == '-w-------' ] || [ `ls -al $USER_HOME/.rhosts | cut -c 2-10` == '---------' ]
        then
            echo "YES" >> $BingoDIR/28.result
        else
            echo "NO" >> $BingoDIR/28.result
            echo "KB-AU-28-N-05" >> $BingoDIR/28.dedup
        fi      
            
        if [ `cat $USER_HOME/.rhosts | grep '+' | grep -v '^ *#' | wc -l` -eq 0 ]
        then
            echo "YES" >> $BingoDIR/28.result
            cat $USER_HOME/.rhosts | grep '+' | grep -v '^ *#' >> $BingoDIR/28.log
        else
            echo "NO" >> $BingoDIR/28.result
            echo "KB-AU-28-N-06" >> $BingoDIR/28.dedup
            cat $USER_HOME/.rhosts | grep '+' | grep -v '^ *#' >> $BingoDIR/28.log
        fi
    else
        echo "YES" >> $BingoDIR/28.result
        echo "$USER_HOME/.rhosts NO FILE" >> $BingoDIR/28.log
    fi
done

# 중복값 제거
if [ -f $BingoDIR/28.dedup ]
then
    sort $BingoDIR/28.dedup > $BingoDIR/282.dedup
    sort $BingoDIR/282.dedup | uniq >> $BingoDIR/28.msg

    rm -rf $BingoDIR/28.dedup
    rm -rf $BingoDIR/282.dedup
fi

if [ `cat $BingoDIR/28.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/28.result
else 
    echo "YES" > $BingoDIR/28.result
    echo "KB-AU-28-Y-02" > $BingoDIR/28.msg
fi

# 전체 파일 출력
echo "$LOG_ALL" >> $BingoDIR/28.log
if [ -f /etc/hosts.equiv ]
then
    echo "------------------------------" >> $BingoDIR/28.log
    echo "File: /etc/hosts.equiv" >> $BingoDIR/28.log
    echo "------------------------------" >> $BingoDIR/28.log
    cat /etc/hosts.equiv >> $BingoDIR/28.log
else 
    echo "------------------------------" >> $BingoDIR/28.log
    echo "File: /etc/hosts.equiv" >> $BingoDIR/28.log
    echo "------------------------------" >> $BingoDIR/28.log
    echo "NO FILE" >> $BingoDIR/28.log
fi

for USER_HOME in ${LS_HOME[@]}
do
    if [ -f $USER_HOME/.rhosts ]
    then
        echo "------------------------------" >> $BingoDIR/28.log
        echo "File: $USER_HOME/.rhosts" >> $BingoDIR/28.log
        echo "------------------------------" >> $BingoDIR/28.log
        cat $USER_HOME/.rhosts >> $BingoDIR/28.log
    else
        echo "------------------------------" >> $BingoDIR/28.log
        echo "File: $USER_HOME/.rhosts" >> $BingoDIR/28.log
        echo "------------------------------" >> $BingoDIR/28.log
        echo "NO FILE" >> $BingoDIR/28.log
    fi
done

unset USER_HOME
unset LS_HOME
# 28 end

# 29 start
#================================================================================
# U-29 접속 IP 및 포트 제한
# 허용할 호스트에 대한 접속 IP 주소 제한 및 포트 제한 설정 여부 점검
echo "KB-AU-29" > $BingoDIR/29.title

echo "YES" > $BingoDIR/29.result

echo "" > $BingoDIR/29.msg

echo "$LOG_SECTION" > $BingoDIR/29.log

# IPtables인 경우
if [ `iptables -L INPUT | grep -i DROP | grep -i tcp | grep -i 'ssh' | grep 'anywhere' | wc -l` -ge 1 ]
then
    echo "YES" >> $BingoDIR/29.table
    echo "------------------------------" >> $BingoDIR/29.tablelog
    echo "iptables" >> $BingoDIR/29.tablelog
    echo "------------------------------" >> $BingoDIR/29.tablelog
    iptables -L INPUT | grep -i DROP | grep -i tcp | grep -i 'ssh' | grep 'anywhere' >> $BingoDIR/29.tablelog
else 
    echo "NO" >> $BingoDIR/29.table
    echo "KB-AU-29-N-01" >> $BingoDIR/29.dedup
    echo "------------------------------" >> $BingoDIR/29.tablelog
    echo "iptables" >> $BingoDIR/29.tablelog
    echo "------------------------------" >> $BingoDIR/29.tablelog
    iptables -L INPUT | grep -i DROP | grep -i tcp | grep -i 'ssh' | grep 'anywhere' >> $BingoDIR/29.tablelog
fi

if [ "`iptables -L INPUT | grep -i DROP | grep -i tcp | grep -i 'telnet' | awk '{ print $4 }'`" == 'anywhere' ]
then
    echo "YES" >> $BingoDIR/29.result
    iptables -L INPUT | grep -i DROP | grep -i tcp | grep -i 'telnet' | awk '{ print $4 }' >> $BingoDIR/29.tablelog
else 
    echo "NO" >> $BingoDIR/29.table
    echo "KB-AU-29-N-02" >> $BingoDIR/29.dedup
    iptables -L INPUT | grep -i DROP | grep -i tcp | grep -i 'telnet' | awk '{ print $4 }' >> $BingoDIR/29.tablelog
fi

if [ "`iptables -L INPUT | grep -i DROP | grep -i tcp | grep -i 'telnet' | awk '{ print $5 }'`" == 'anywhere' ]
then
    echo "YES" >> $BingoDIR/29.table
    iptables -L INPUT | grep -i DROP | grep -i tcp | grep -i 'telnet' | awk '{ print $5 }' >> $BingoDIR/29.tablelog
else 
    echo "NO" >> $BingoDIR/29.result
    echo "KB-AU-29-N-02" >> $BingoDIR/29.dedup
    iptables -L INPUT | grep -i DROP | grep -i tcp | grep -i 'telnet' | awk '{ print $5 }' >> $BingoDIR/29.tablelog
fi

if [ "`iptables -L INPUT | grep -i DROP | grep -i tcp | grep -i 'ftp' | awk '{ print $4 }'`" == 'anywhere' ]
then 
    echo "YES" >> $BingoDIR/29.table
    iptables -L INPUT | grep -i DROP | grep -i tcp | grep -i 'ftp' | awk '{ print $4 }' >> $BingoDIR/29.tablelog
else 
    echo "NO" >> $BingoDIR/29.table
    echo "KB-AU-29-N-03" >> $BingoDIR/29.dedup
    iptables -L INPUT | grep -i DROP | grep -i tcp | grep -i 'ftp' | awk '{ print $4 }' >> $BingoDIR/29.tablelog
fi

if [ "`iptables -L INPUT | grep -i DROP | grep -i tcp | grep -i 'ftp' | awk '{ print $5 }'`" == 'anywhere' ]
then 
    echo "YES" >> $BingoDIR/29.table
    iptables -L INPUT | grep -i DROP | grep -i tcp | grep -i 'ftp' | awk '{ print $5 }' >> $BingoDIR/29.tablelog
else 
    echo "NO" >> $BingoDIR/29.table
    echo "KB-AU-29-N-03" >> $BingoDIR/29.dedup
    iptables -L INPUT | grep -i DROP | grep -i tcp | grep -i 'ftp' | awk '{ print $5 }' >> $BingoDIR/29.tablelog
fi

# TCPWrapper인 경우
if [ -f /etc/hosts.deny ]
then
    if [ `cat /etc/hosts.deny | grep -v '^ *#' | grep -P 'ALL\s*:\s*ALL' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/29.wrapper
        echo "------------------------------" >> $BingoDIR/29.wrapperlog
        echo "File: /etc/hosts.deny" >> $BingoDIR/29.wrapperlog
        echo "------------------------------" >> $BingoDIR/29.wrapperlog
        cat /etc/hosts.deny | grep -v '^ *#' | grep -P 'ALL\s*:\s*ALL' >> $BingoDIR/29.wrapperlog
    else 
        echo "NO" >> $BingoDIR/29.wrapper
        echo "KB-AU-29-N-04" >> $BingoDIR/29.msg
        echo "------------------------------" >> $BingoDIR/29.wrapperlog
        echo "File: /etc/hosts.deny" >> $BingoDIR/29.wrapperlog
        echo "------------------------------" >> $BingoDIR/29.wrapperlog
        cat /etc/hosts.deny | grep -v '^ *#' | grep -P 'ALL\s*:\s*ALL' >> $BingoDIR/29.wrapperlog
    fi
else
    echo "NO" >> $BingoDIR/29.wrapper
    echo "KB-AU-29-N-05" >> $BingoDIR/29.msg
    echo "------------------------------" >> $BingoDIR/29.wrapperlog
    echo "File: /etc/hosts.deny" >> $BingoDIR/29.wrapperlog
    echo "------------------------------" >> $BingoDIR/29.wrapperlog
    echo "NO FILE" >> $BingoDIR/29.wrapperlog
fi

# IPtables msg 중복값 제거
# IPtables가 양호인 경우 29.dedup 파일 없음
if [ -f $BingoDIR/29.dedup ]
then
    # TCPWrapper가 양호인 경우 iptables가 취약한 msg가 필요 없으므로 파일만 삭제
    if [ `cat $BingoDIR/29.wrapper | grep -i "NO" | wc -l` -ge 1 ]
    then 
        sort $BingoDIR/29.dedup > $BingoDIR/292.dedup
        sort $BingoDIR/292.dedup | uniq >> $BingoDIR/29.msg

        rm -rf $BingoDIR/29.dedup
        rm -rf $BingoDIR/292.dedup
    else
        rm -rf $BingoDIR/29.dedup
    fi
fi

# RESULT 정리
# IPtables
if [ `cat $BingoDIR/29.table | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/29.result
else 
    echo "YES1" > $BingoDIR/29.result
    echo "KB-AU-29-Y-01" > $BingoDIR/29.msg
fi

# TCPWrapper
if [ `cat $BingoDIR/29.wrapper | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" >> $BingoDIR/29.result
else 
    echo "YES2" >> $BingoDIR/29.result
    echo "KB-AU-29-Y-01" > $BingoDIR/29.msg
fi

# 최종 result
# 29.result 파일에 YES1 값이 1개 이상인 경우 IPtables가 양호이기 때문에 양호 및 IPtables만 출력

if [ `cat $BingoDIR/29.result | grep -i "YES1" | wc -l` -ge 1 ] && [ `cat $BingoDIR/29.result | grep -i "YES2" | wc -l` -ge 1 ]
then
    echo "YES" > $BingoDIR/29.result
    echo "KB-AU-29-Y-01" > $BingoDIR/29.msg
    cat $BingoDIR/29.tablelog >> $BingoDIR/29.log
    cat $BingoDIR/29.wrapperlog >> $BingoDIR/29.log
    echo "$LOG_ALL" >> $BingoDIR/29.log
    echo "------------------------------" >> $BingoDIR/29.log
    echo "IPtables" >> $BingoDIR/29.log
    echo "------------------------------" >> $BingoDIR/29.log
    iptables -L >> $BingoDIR/29.log
    if [ -f /etc/hosts.deny ]
        then
            echo "------------------------------" >> $BingoDIR/29.log
            echo "File: /etc/hosts.deny" >> $BingoDIR/29.log
            echo "------------------------------" >> $BingoDIR/29.log
            cat /etc/hosts.deny >> $BingoDIR/29.log
        else 
            echo "------------------------------" >> $BingoDIR/29.log
            echo "File: /etc/hosts.deny" >> $BingoDIR/29.log
            echo "------------------------------" >> $BingoDIR/29.log
            echo "NO FILE" >> $BingoDIR/29.log
        fi

        if [ -f /etc/hosts.allow ]
        then
            echo "------------------------------" >> $BingoDIR/29.log
            echo "File: /etc/hosts.allow" >> $BingoDIR/29.log
            echo "------------------------------" >> $BingoDIR/29.log
            cat /etc/hosts.allow >> $BingoDIR/29.log
        else 
            echo "------------------------------" >> $BingoDIR/29.log
            echo "File: /etc/hosts.allow" >> $BingoDIR/29.log
            echo "------------------------------" >> $BingoDIR/29.log
            echo "NO FILE" >> $BingoDIR/29.log
        fi
else
    if [ `cat $BingoDIR/29.result | grep -i "YES1" | wc -l` -ge 1 ]
    then 
        echo "YES" > $BingoDIR/29.result
        echo "KB-AU-29-Y-01" > $BingoDIR/29.msg
        cat $BingoDIR/29.tablelog >> $BingoDIR/29.log
        echo "$LOG_ALL" >> $BingoDIR/29.log
        echo "------------------------------" >> $BingoDIR/29.log
        echo "IPtables" >> $BingoDIR/29.log
        echo "------------------------------" >> $BingoDIR/29.log
        iptables -L >> $BingoDIR/29.log
    else 
        # 29.result 파일에 YES2 값이 1개 이상인 경우 TCPWrapper가 양호이기 때문에 양호 및 TCPWrapper 로그만 출력
        if [ `cat $BingoDIR/29.result | grep -i "YES2" | wc -l` -ge 1 ]
        then
            echo "YES" > $BingoDIR/29.result
            echo "KB-AU-29-Y-01" > $BingoDIR/29.msg
            cat $BingoDIR/29.wrapperlog >> $BingoDIR/29.log
            echo "$LOG_ALL" >> $BingoDIR/29.log
            if [ -f /etc/hosts.deny ]
            then
                echo "------------------------------" >> $BingoDIR/29.log
                echo "File: /etc/hosts.deny" >> $BingoDIR/29.log
                echo "------------------------------" >> $BingoDIR/29.log
                cat /etc/hosts.deny >> $BingoDIR/29.log
            else 
                echo "------------------------------" >> $BingoDIR/29.log
                echo "File: /etc/hosts.deny" >> $BingoDIR/29.log
                echo "------------------------------" >> $BingoDIR/29.log
                echo "NO FILE" >> $BingoDIR/29.log
            fi

            if [ -f /etc/hosts.allow ]
            then
                echo "------------------------------" >> $BingoDIR/29.log
                echo "File: /etc/hosts.allow" >> $BingoDIR/29.log
                echo "------------------------------" >> $BingoDIR/29.log
                cat /etc/hosts.allow >> $BingoDIR/29.log
            else 
                echo "------------------------------" >> $BingoDIR/29.log
                echo "File: /etc/hosts.allow" >> $BingoDIR/29.log
                echo "------------------------------" >> $BingoDIR/29.log
                echo "NO FILE" >> $BingoDIR/29.log
            fi
        else 
            # 29.result 값이 YES1과 YES2가 없는 경우 둘 다 취약이므로 모든 log 출력
            echo "NO" > $BingoDIR/29.result
            cat $BingoDIR/29.tablelog >> $BingoDIR/29.log
            cat $BingoDIR/29.wrapperlog >> $BingoDIR/29.log
            echo "$LOG_ALL" >> $BingoDIR/29.log
            echo "------------------------------" >> $BingoDIR/29.log
            echo "IPtables" >> $BingoDIR/29.log
            echo "------------------------------" >> $BingoDIR/29.log
            iptables -L >> $BingoDIR/29.log
            if [ -f /etc/hosts.deny ]
            then
                echo "------------------------------" >> $BingoDIR/29.log
                echo "File: /etc/hosts.deny" >> $BingoDIR/29.log
                echo "------------------------------" >> $BingoDIR/29.log
                cat /etc/hosts.deny >> $BingoDIR/29.log
            else 
                echo "------------------------------" >> $BingoDIR/29.log
                echo "File: /etc/hosts.deny" >> $BingoDIR/29.log
                echo "------------------------------" >> $BingoDIR/29.log
                echo "NO FILE" >> $BingoDIR/29.log
            fi

            if [ -f /etc/hosts.allow ]
            then
                echo "------------------------------" >> $BingoDIR/29.log
                echo "File: /etc/hosts.allow" >> $BingoDIR/29.log
                echo "------------------------------" >> $BingoDIR/29.log
                cat /etc/hosts.allow >> $BingoDIR/29.log
            else 
                echo "------------------------------" >> $BingoDIR/29.log
                echo "File: /etc/hosts.allow" >> $BingoDIR/29.log
                echo "------------------------------" >> $BingoDIR/29.log
                echo "NO FILE" >> $BingoDIR/29.log
            fi
        fi
    fi
fi

rm -rf $BingoDIR/29.table
rm -rf $BingoDIR/29.tablelog
rm -rf $BingoDIR/29.wrapper
rm -rf $BingoDIR/29.wrapperlog

# 29.table은 IPtables의 result 값
# 29.tablelog는 IPtables의 부분 출력
# 29.wrapper는 TCPwrapper의 result 값
# 29.wrapperlog는 TCPWrapper의 부분 출력

# 29 end

# 30 start
#================================================================================
# U-30 hosts.lpd 파일 소유자 및 권한 설정
# /etc/hosts.lpd 파일의 삭제 및 권한 적절성 점검
echo "KB-AU-30" > $BingoDIR/30.title

echo "YES" > $BingoDIR/30.result

echo "" > $BingoDIR/30.msg

echo "$LOG_PERMISSION" > $BingoDIR/30.log

if [ -f /etc/hosts.lpd ]
then
    if [ `ls -al /etc/hosts.lpd | awk '{ print $3 }'` == 'root' ]
    then
        echo "YES" >> $BingoDIR/30.result
        ls -al /etc/hosts.lpd >> $BingoDIR/30.log
    else
        echo "NO" >> $BingoDIR/30.result
        echo "KB-AU-30-N-01" >> $BingoDIR/30.msg
        ls -al /etc/hosts.lpd >> $BingoDIR/30.log
    fi

	if [ `ls -al /etc/hosts.lpd | cut -c 2-4` == 'rw-' ]
	then
		if [ `ls -al /etc/hosts.lpd | cut -c 4-10` == '-------' ]
        then
			echo "YES" >> $BingoDIR/30.result
        else
            echo "NO" >> $BingoDIR/30.result
            echo "KB-AU-30-N-02" >> $BingoDIR/30.msg
       	fi
	else
		echo "NO" >> $BingoDIR/30.result
        echo "KB-AU-30-N-02" >> $BingoDIR/30.msg
	fi
else
	echo "YES2" >> $BingoDIR/30.result
	echo "KB-AU-30-Y-01" >> $BingoDIR/30.msg
    echo "/etc/hosts.lpd NO FILE" >> $BingoDIR/30.log
fi

if [ `cat $BingoDIR/30.result | grep -i "YES2" | wc -l` -eq 1 ]
then 
    echo "YES" > $BingoDIR/30.result
elif [ `cat $BingoDIR/30.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/30.result
else 
    echo "YES" > $BingoDIR/30.result
    echo "KB-AU-30-Y-02" > $BingoDIR/30.msg
fi

# 30 end

# 31 start
#================================================================================
# U-31 UMASK 설정 관리
# 시스템 UMASK 값이 022 이상인지 점검
echo "KB-AU-31" > $BingoDIR/31.title

echo "YES" > $BingoDIR/31.result

echo "" > $BingoDIR/31.msg

echo "$LOG_SECTION" > $BingoDIR/31.log

if [ `cat /etc/profile | grep -i "umask" | grep -w "002" | grep -v '^ *#' | wc -l` -ge 1 ]
then
    echo "NO" >> $BingoDIR/31.result
    echo "KB-AU-31-N-01" >> $BingoDIR/31.msg
    cat /etc/profile | grep -i "umask" | grep -w "002" | grep -v '^ *#' >> $BingoDIR/31.log
else 
    if [ `cat /etc/profile | grep -i "umask" | grep -w "022" | grep -v '^ *#' | wc -l` -ge 1 ]
	then
        echo "YES" >> $BingoDIR/31.result
        cat /etc/profile | grep -i "umask" | grep -w "022" | grep -v '^ *#' >> $BingoDIR/31.log
    else
        echo "NO" >> $BingoDIR/31.result
        echo "KB-AU-31-N-02" >> $BingoDIR/31.msg
        cat /etc/profile | grep -i "umask" >> $BingoDIR/31.log
    fi
fi

if [ `cat $BingoDIR/31.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/31.result
else 
    echo "YES" > $BingoDIR/31.result
    echo "KB-AU-31-Y-01" > $BingoDIR/31.msg
fi

# 전체 파일 출력
echo "$LOG_ALL" >> $BingoDIR/31.log
cat /etc/profile >> $BingoDIR/31.log

# 31 end

# 32 start
#================================================================================
# U-32 홈 디렉토리 소유자 및 권한 설정
# 홈 디렉터리의 소유자 외 타사용자가 해당 홈 디렉터리를 수정할 수 없도록 제한하는지 점검
echo "KB-AU-32" > $BingoDIR/32.title

LIST=($(cat /etc/passwd | awk -F ":" '{if ($3 > 999 && $3 < 60000 )  print $1 }'))
DIR=($(cat /etc/passwd | awk -F ":" '{if ($3 > 999 && $3 < 60000 )  print $6 }'))

echo "YES" > $BingoDIR/32.result

echo "" > $BingoDIR/32.msg

for((i=0; i<${#LIST[@]}; i++))
do
    if [ ${LIST[i]} == `ls -ald ${DIR[i]} | awk '{ print $3 }'` ]
    then
       echo "YES" >> $BingoDIR/32.result
       ls -ald ${DIR[i]} >> $BingoDIR/32.log2
    else
        echo "NO" >> $BingoDIR/32.result
        echo "KB-AU-32-N-01" >> $BingoDIR/32.msg
        ls -ald ${DIR[i]} >> $BingoDIR/32.log2
    fi

    if [ `ls -ald ${DIR[i]} | awk '{ print $1 }' | cut -c 9`  == '-' ]
    then
        echo "YES" >> $BingoDIR/32.result
    else 
        echo "NO" >> $BingoDIR/32.result
        echo "KB-AU-32-N-02" >> $BingoDIR/32.msg
    fi
done

if [ `cat $BingoDIR/32.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/32.result
    echo "$LOG_PERMISSION" > $BingoDIR/32.log
    cat $BingoDIR/32.log2 >> $BingoDIR/32.log
    echo "$LOG_ALL" >> $BingoDIR/32.log
    cat /etc/passwd >> $BingoDIR/32.log
else 
    echo "YES" > $BingoDIR/32.result
    echo "KB-AU-32-Y-01" > $BingoDIR/32.msg
    if [ -f $BingoDIR/32.log2 ]
    then
        echo "$LOG_PERMISSION" > $BingoDIR/32.log
        cat $BingoDIR/32.log2 >> $BingoDIR/32.log
        echo "$LOG_ALL" >> $BingoDIR/32.log
        cat /etc/passwd >> $BingoDIR/32.log
    else
        echo "$LOG_ALL" > $BingoDIR/32.log
        cat /etc/passwd >> $BingoDIR/32.log
    fi
fi

unset LIST
unset DIR
rm -rf $BingoDIR/32.log2

# 32 end

# 33 start
#================================================================================
# U-33 홈 디렉토리로 지정한 디렉토리의 존재 관리
# 사용자 계정과 홈 디렉터리의 일치 여부를 점검
echo "KB-AU-33" > $BingoDIR/33.title

RESULT='YES'

if [ `cat /etc/passwd | grep ':/:' | awk -F ':' '{if ($4 > 999 && $4 < 60000) print $1 }' | wc -l` -eq 0 ]
then
    RESULT='YES'
	RESULT_MSG='KB-AU-33-Y-01'
	RESULT_LOG=$(cat /etc/passwd | grep ':/:' | awk -F ':' '{if ($4 > 999 && $4 < 60000) print $1 }' 2>&1)
	RESULT_LOG2=$(cat /etc/passwd 2>&1)
else
    RESULT='NO'
	RESULT_MSG='KB-AU-33-N-01'
	RESULT_LOG=$(cat /etc/passwd | grep ':/:' | awk -F ':' '{if ($4 > 999 && $4 < 60000) print $1 }' 2>&1)
	RESULT_LOG2=$(cat /etc/passwd 2>&1)
fi

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='NO HOME'
fi

echo "$RESULT" > $BingoDIR/33.result
echo "$RESULT_MSG" > $BingoDIR/33.msg
echo "$LOG_SECTION" > $BingoDIR/33.log
echo "$RESULT_LOG" >> $BingoDIR/33.log
echo "$LOG_ALL" >> $BingoDIR/33.log
echo "$RESULT_LOG2" >> $BingoDIR/33.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
# 33 end

# 34 start
#================================================================================Permission denied
# U-34 숨겨진 파일 및 디렉토리 검색 및 제거
# 숨김 파일 및 디렉터리 내 의심스러운 파일 존재 여부 점검
echo "KB-AU-34" > $BingoDIR/34.title

RESULT='MANUAL'
RESULT_MSG='KB-AU-34-M-01'
RESULT_LOG="MANUAL"
RESULT_LOG2="File: #find / -type f -name \".*\""
RESULT_LOG3="Directory: #find / -type d -name \".*\""

echo "$RESULT" > $BingoDIR/34.result
echo "$RESULT_MSG" > $BingoDIR/34.msg
echo "$RESULT_LOG" > $BingoDIR/34.log
echo "$RESULT_LOG2" >> $BingoDIR/34.log
echo "$RESULT_LOG3" >> $BingoDIR/34.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
unset RESULT_LOG3
# 34 end

# 35 start
#================================================================================
# U-35 Finger 서비스 비활성화
# finger 서비스 비활성화 여부 점검
echo "KB-AU-35" > $BingoDIR/35.title

echo "YES" > $BingoDIR/35.result

echo "" > $BingoDIR/35.msg

echo "$LOG_SECTION" > $BingoDIR/35.log

if [ -f /etc/xinetd.d/finger ]
then
    if [ `cat /etc/xinetd.d/finger | grep "disable" | grep "yes" | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/35.result
        echo "------------------------------" >> $BingoDIR/35.log
        echo "File: /etc/xinetd.d/finger" >> $BingoDIR/35.log
        echo "------------------------------" >> $BingoDIR/35.log
		cat /etc/xinetd.d/finger | grep "disable" >> $BingoDIR/35.log
    else
        echo "NO" >> $BingoDIR/35.result
        echo "KB-AU-35-N-01" >> $BingoDIR/35.msg
        echo "------------------------------" >> $BingoDIR/35.log
        echo "File: /etc/xinetd.d/finger" >> $BingoDIR/35.log
        echo "------------------------------" >> $BingoDIR/35.log
        cat /etc/xinetd.d/finger | grep "disable" >> $BingoDIR/35.log
    fi
else
    echo "YES" >> $BingoDIR/35.result
    echo "------------------------------" >> $BingoDIR/35.log
    echo "File: /etc/xinetd.d/finger" >> $BingoDIR/35.log
    echo "------------------------------" >> $BingoDIR/35.log
    echo "NO FILE" >> $BingoDIR/35.log
fi

if [ -f /etc/inetd.conf ]
then
    if [ `cat /etc/inetd.conf | grep -w "finger" | grep -v "^ *#" |  wc -l` -ge 1 ]
    then
        echo "NO" >> $BingoDIR/35.result
        echo "KB-AU-35-N-02" >> $BingoDIR/35.msg
        echo "------------------------------" >> $BingoDIR/35.log
        echo "File: /etc/inetd.conf" >> $BingoDIR/35.log
        echo "------------------------------" >> $BingoDIR/35.log
        cat /etc/inetd.conf | grep "finger" >> $BingoDIR/35.log    
    else
        echo "YES" >> $BingoDIR/35.result
        echo "------------------------------" >> $BingoDIR/35.log
        echo "File: /etc/inetd.conf" >> $BingoDIR/35.log
        echo "------------------------------" >> $BingoDIR/35.log
        cat /etc/inetd.conf | grep "finger" >> $BingoDIR/35.log
    fi
else
    echo "YES" >> $BingoDIR/35.result
    echo "------------------------------" >> $BingoDIR/35.log
    echo "File: /etc/inetd.conf" >> $BingoDIR/35.log
    echo "------------------------------" >> $BingoDIR/35.log
    echo "NO FILE" >> $BingoDIR/35.log
fi

if [ `cat $BingoDIR/35.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/35.result
else 
    echo "YES" > $BingoDIR/35.result
    echo "KB-AU-35-Y-01" > $BingoDIR/35.msg
fi


# 전체 파일 출력
echo "$LOG_ALL" >> $BingoDIR/35.log
if [ -f /etc/xinetd.d/finger ]
then
    echo "------------------------------" >> $BingoDIR/35.log
    echo "File: /etc/xinetd.d/finger" >> $BingoDIR/35.log
    echo "------------------------------" >> $BingoDIR/35.log
    cat /etc/xinetd.d/finger >> $BingoDIR/35.log
else
    echo "------------------------------" >> $BingoDIR/35.log
    echo "File: /etc/xinetd.d/finger" >> $BingoDIR/35.log
    echo "------------------------------" >> $BingoDIR/35.log
    echo "NO FILE" >> $BingoDIR/35.log
fi

if [ -f /etc/inetd.conf ]
then
    echo "------------------------------" >> $BingoDIR/35.log
    echo "File: /etc/inetd.conf" >> $BingoDIR/35.log
    echo "------------------------------" >> $BingoDIR/35.log
    cat /etc/inetd.conf >> $BingoDIR/35.log
else
    echo "------------------------------" >> $BingoDIR/35.log
    echo "File: /etc/inetd.conf" >> $BingoDIR/35.log
    echo "------------------------------" >> $BingoDIR/35.log
    echo "NO FILE" >> $BingoDIR/35.log
fi

# 35 end

# 36 start
#================================================================================
# U-36 Anonymous FTP 비활성화
# 익명 FTP 접속 허용 여부 점검
echo "KB-AU-36" > $BingoDIR/36.title

echo "YES" > $BingoDIR/36.result

echo "" > $BingoDIR/36.msg

echo "$LOG_SECTION" > $BingoDIR/36.log

# 일반 ftp
if [ `cat /etc/passwd | grep -w "ftp" | wc -l` -eq 0 ]
then
    echo "YES" >> $BingoDIR/36.result
    echo "NO FTP" >> $BingoDIR/36.log
else
    echo "NO" >> $BingoDIR/36.result
    echo "KB-AU-36-N-01" > $BingoDIR/36.msg
    echo "------------------------------" >> $BingoDIR/36.log
    echo "File: /etc/passwd" >> $BingoDIR/36.log
    echo "------------------------------" >> $BingoDIR/36.log
    cat /etc/passwd | grep -w "ftp" >> $BingoDIR/36.log
fi

if [ `cat /etc/passwd | grep -w "anonymous" | wc -l` -eq 0 ]
then
    echo "YES" >> $BingoDIR/36.result
    echo "NO anonymous" >> $BingoDIR/36.log
else 
    echo "NO" >> $BingoDIR/36.result
    echo "KB-AU-36-N-02" >> $BingoDIR/36.msg
    echo "------------------------------" >> $BingoDIR/36.log
    echo "File: /etc/passwd" >> $BingoDIR/36.log
    echo "------------------------------" >> $BingoDIR/36.log
    cat /etc/passwd | grep -w "anonymous" >> $BingoDIR/36.log
fi

#ProFTP
# proftpd.conf 파일 위치는 OS 종류별로 상이함

if [ `ps -ef | grep 'proftpd' | grep -v grep | wc -l` -ge 1 ]
then
    files=("/etc/proftpd/anonftp.conf" "/etc/proftpd.conf" "/etc/proftpd/proftpd.conf")
    for file in "${files[@]}"
    do
        if [ -f "$file" ]
        then
            if [ `sed -n '/<Anonymous ~ftp>/,/<\/Anonymous>/p' "$file" | grep -i '^ *User' | wc -l` -ge 1 ]
            then
                echo "NO" >> $BingoDIR/36.result
                echo "KB-AU-36-N-03" >> $BingoDIR/36.msg
                echo "------------------------------" >> $BingoDIR/36.log
                echo "File: $file " >> $BingoDIR/36.log
                echo "------------------------------" >> $BingoDIR/36.log
                sed -n '/<Anonymous ~ftp>/,/<\/Anonymous>/p' $file | grep -i '^ *User' >> $BingoDIR/36.log
            else
                echo "YES" >> $BingoDIR/36.result
            fi
        else
            echo "MANUAL" >> $BingoDIR/36.result
            echo "KB-AU-36-M-01" >> $BingoDIR/36.msg
            echo "$file NO FILE" >> $BingoDIR/36.log
        fi
    done
else 
	echo "YES" >> $BingoDIR/36.result
    echo "proftpd Service is not running" >> $BingoDIR/36.log
fi

unset files
unset file

#vsFTP
if [ `ps -ef | grep 'vsftpd' | grep -v grep | wc -l` -ge 1 ]
then
    if [ -f /etc/vsftpd.conf ]
    then
        if [ `cat /etc/vsftpd.conf | grep -w "anoymous_enable" | grep -i "no" | grep -v '^ *#' | wc -l` -eq 1 ]
        then
            echo "YES" >> $BingoDIR/36.result
            echo "------------------------------" >> $BingoDIR/36.log
            echo "File: /etc/vsftpd.conf" >> $BingoDIR/36.log
            echo "------------------------------" >> $BingoDIR/36.log
            cat /etc/vsftpd.conf | grep -w "anoymous_enable" | grep -i "no" | grep -v '^ *#' >> $BingoDIR/36.log
        else 
            echo "NO" >> $BingoDIR/36.result
            echo "KB-AU-36-N-04" >> $BingoDIR/36.msg
            echo "------------------------------" >> $BingoDIR/36.log
            echo "File: /etc/vsftpd.conf" >> $BingoDIR/36.log
            echo "------------------------------" >> $BingoDIR/36.log
            cat /etc/vsftpd.conf | grep -w "anoymous_enable" >> $BingoDIR/36.log
        fi
    elif [ -f /etc/vsftd/vsftpd.conf ]
    then
        if [ `cat /etc/vsftd/vsftpd.conf | grep -w "anoymous_enable" | grep -i "no" | grep -v '^ *#' | wc -l` -eq 1 ]
        then
            echo "YES" >> $BingoDIR/36.result
            echo "------------------------------" >> $BingoDIR/36.log
            echo "File: /etc/vsftd/vsftpd.conf" >> $BingoDIR/36.log
            echo "------------------------------" >> $BingoDIR/36.log
            cat /etc/vsftd/vsftpd.conf | grep -w "anoymous_enable" | grep -i "no" | grep -v '^ *#' >> $BingoDIR/36.log
        else
            echo "NO" >> $BingoDIR/36.result
            echo "KB-AU-36-N-05" >> $BingoDIR/36.msg
            echo "------------------------------" >> $BingoDIR/36.log
            echo "File: /etc/vsftd/vsftpd.conf" >> $BingoDIR/36.log
            echo "------------------------------" >> $BingoDIR/36.log
            cat /etc/vsftd/vsftpd.conf | grep -w "anoymous_enable" >> $BingoDIR/36.log
        fi
    else
        echo "MANUAL" >> $BingoDIR/36.result
        echo "KB-AU-36-M-02" >> $BingoDIR/36.msg
        echo "vsftpd.conf NO FILE" >> $BingoDIR/36.log
    fi	
else
	echo "YES" >> $BingoDIR/36.result
    echo "vsftpd Service is not running" >> $BingoDIR/36.log
fi

if [ `cat $BingoDIR/36.result | grep -i "MANUAL" | wc -l` -ge 1 ]
then 
    echo "MANUAL" > $BingoDIR/36.result
else 
    if [ `cat $BingoDIR/36.result | grep -i "NO" | wc -l` -ge 1 ]
    then 
        echo "NO" > $BingoDIR/36.result
    else 
        echo "YES" > $BingoDIR/36.result
        echo "KB-AU-36-Y-01" > $BingoDIR/36.msg
    fi
fi

# 전체 파일 출력
# FTP
echo "$LOG_ALL" >> $BingoDIR/36.log
echo "------------------------------" >> $BingoDIR/36.log
echo "File: /etc/passwd" >> $BingoDIR/36.log
echo "------------------------------" >> $BingoDIR/36.log
cat /etc/passwd >> $BingoDIR/36.log

#ProFTP
if [ `ps -ef | grep 'proftpd' | grep -v grep | wc -l` -ge 1 ]
then
    files=("/etc/proftpd/anonftp.conf" "/etc/proftpd.conf" "/etc/proftpd/proftpd.conf")
    for file in "${files[@]}"
    do
        if [ -f "$file" ]
        then
            echo "------------------------------" >> $BingoDIR/36.log
            echo "File: $file " >> $BingoDIR/36.log
            echo "------------------------------" >> $BingoDIR/36.log
            cat $file >> $BingoDIR/36.log
        else
            echo "------------------------------" >> $BingoDIR/36.log
            echo "File: $file " >> $BingoDIR/36.log
            echo "------------------------------" >> $BingoDIR/36.log
            echo "NO FILE" >> $BingoDIR/36.log
        fi
    done
else 
    echo "proftpd Service is not running" >> $BingoDIR/36.log
fi

unset files
unset file

#vsFTP
if [ `ps -ef | grep 'vsftpd' | grep -v grep | wc -l` -ge 1 ]
then
    if [ -f /etc/vsftpd.conf ]
    then
        echo "------------------------------" >> $BingoDIR/36.log
        echo "File: /etc/vsftpd.conf" >> $BingoDIR/36.log
        echo "------------------------------" >> $BingoDIR/36.log
        cat /etc/vsftpd.conf >> $BingoDIR/36.log
    elif [ -f /etc/vsftd/vsftpd.conf ]
    then
        echo "------------------------------" >> $BingoDIR/36.log
        echo "File: /etc/vsftd/vsftpd.conf" >> $BingoDIR/36.log
        echo "------------------------------" >> $BingoDIR/36.log
        cat /etc/vsftd/vsftpd.conf >> $BingoDIR/36.log
    else
        echo "------------------------------" >> $BingoDIR/36.log
        echo "File: vsftpd.conf" >> $BingoDIR/36.log
        echo "------------------------------" >> $BingoDIR/36.log
        echo "NO FILE" >> $BingoDIR/36.log
    fi
else 
    echo "vsftpd Service is not running" >> $BingoDIR/36.log
fi
    
# 36 end

# 37 start
#================================================================================
# U-37 r 계열 서비스 비활성화
# r-command 서비스 비활성화 여부 점검
echo "KB-AU-37" > $BingoDIR/37.title

echo "YES" > $BingoDIR/37.result

echo "" > $BingoDIR/37.msg

echo "$LOG_SECTION" > $BingoDIR/37.log

DUD=("rlogin" "rsh" "rexec")

for VALUE in "${DUD[@]}"
do
    if [ -f /etc/xinetd.d/$VALUE ]
    then
        if [ `cat /etc/xinetd.d/$VALUE | grep -i "disable" | grep -iv "yes" | wc -l` -ge 1 ]
        then
            echo "NO" >> $BingoDIR/37.result
            echo "KB-AU-37-N-1$VALUE" >> $BingoDIR/37.msg
            echo "------------------------------" >> $BingoDIR/37.log
            echo "File: /etc/xinetd.d/$VALUE" >> $BingoDIR/37.log
            echo "------------------------------" >> $BingoDIR/37.log
            cat /etc/xinetd.d/$VALUE | grep -i "disable" >> $BingoDIR/37.log
        else 
            echo "YES" >> $BingoDIR/37.result
            echo "------------------------------" >> $BingoDIR/37.log
            echo "File: /etc/xinetd.d/$VALUE" >> $BingoDIR/37.log
            echo "------------------------------" >> $BingoDIR/37.log
            cat /etc/xinetd.d/$VALUE | grep -i "disable" >> $BingoDIR/37.log
        fi
    else
        echo "YES" >> $BingoDIR/37.result
        echo "------------------------------" >> $BingoDIR/37.log
        echo "File: /etc/xinetd.d/$VALUE" >> $BingoDIR/37.log
        echo "------------------------------" >> $BingoDIR/37.log
        echo "NO FILE" >> $BingoDIR/37.log
    fi
done

unset VALUE

if [ -f /etc/inetd.conf ]
then
    echo "------------------------------" >> $BingoDIR/37.log
    echo "File: /etc/inetd.conf" >> $BingoDIR/37.log
    echo "------------------------------" >> $BingoDIR/37.log
    for VALUE in "${DUD[@]}"
    do
        if [ `cat /etc/inetd.conf | grep $VALUE | grep "^ *#" |  wc -l` -ge 1 ]
        then
            echo "NO" >> $BingoDIR/37.result
            echo "KB-AU-37-N-2$VALUE" >> $BingoDIR/37.msg
            cat /etc/inetd.conf | grep $VALUE >> $BingoDIR/37.log
        else 
            echo "YES" >> $BingoDIR/37.result
            cat /etc/inetd.conf | grep $VALUE >> $BingoDIR/37.log  
        fi
    done
else
    echo "YES" >> $BingoDIR/37.result
    echo "------------------------------" >> $BingoDIR/37.log
    echo "File: /etc/inetd.conf" >> $BingoDIR/37.log
    echo "------------------------------" >> $BingoDIR/37.log
    echo "NO FILE" >> $BingoDIR/37.log
fi

if [ `cat $BingoDIR/37.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/37.result
else 
    echo "YES" > $BingoDIR/37.result
    echo "KB-AU-37-Y-01" > $BingoDIR/37.msg
fi

# 전체 파일 출력
echo "$LOG_ALL" >> $BingoDIR/37.log
for VALUE in "${DUD[@]}"
do
    if [ -f /etc/xinetd.d/$VALUE ]
    then
        echo "------------------------------" >> $BingoDIR/37.log
        echo "File: /etc/xinetd.d/$VALUE" >> $BingoDIR/37.log
        echo "------------------------------" >> $BingoDIR/37.log
        cat /etc/xinetd.d/$VALUE >> $BingoDIR/37.log
    else
        echo "------------------------------" >> $BingoDIR/37.log
        echo "File: /etc/xinetd.d/$VALUE" >> $BingoDIR/37.log
        echo "------------------------------" >> $BingoDIR/37.log
        echo "NO FILE" >> $BingoDIR/37.log
    fi
done

if [ -f /etc/inetd.conf ]
then
    echo "------------------------------" >> $BingoDIR/37.log
    echo "File: /etc/inetd.conf" >> $BingoDIR/37.log
    echo "------------------------------" >> $BingoDIR/37.log
    cat /etc/inetd.conf >> $BingoDIR/37.log
else 
    echo "------------------------------" >> $BingoDIR/37.log
    echo "File: /etc/inetd.conf" >> $BingoDIR/37.log
    echo "------------------------------" >> $BingoDIR/37.log   
    echo "NO FILE" >> $BingoDIR/37.log
fi

unset DUD
unset VALUE

# 37 end

# 38 start
#================================================================================
# U-38 crond 서비스 권한 설정
# Cron 관련 파일의 권한 적절성 점검
echo "KB-AU-38" > $BingoDIR/38.title

echo "YES" > $BingoDIR/38.result

echo "" > $BingoDIR/38.msg

if [ `ls -al /usr/bin/crontab | awk '{ print $3 }'` != 'root' ]
then
    echo "NO" >> $BingoDIR/38.result
    echo "KB-AU-38-N-01" >> $BingoDIR/38.msg
    ls -al /usr/bin/crontab >> $BingoDIR/38.nlog
else
    echo "YES" >> $BingoDIR/38.result
    ls -al /usr/bin/crontab >> $BingoDIR/38.ylog
fi

if [ `ls -al /usr/bin/crontab | cut -c 5-7` == 'r-x' ] || [ `ls -al /usr/bin/crontab | cut -c 5-7` == 'r--' ] || [ `ls -al /usr/bin/crontab | cut -c 5-7` == '--x' ] || [ `ls -al /usr/bin/crontab | cut -c 5-7` == '---' ]
then
    if [ `ls -al /usr/bin/crontab | cut -c 8-10` != '---' ]
    then
        echo "NO" >> $BingoDIR/38.result
        echo "KB-AU-38-N-02" >> $BingoDIR/38.msg
        ls -al /usr/bin/crontab >> $BingoDIR/38.nlog
    else
        echo "YES" >> $BingoDIR/38.result
    fi
else
    echo "NO" >> $BingoDIR/38.result
    echo "KB-AU-38-N-02" >> $BingoDIR/38.msg
    ls -al /usr/bin/crontab >> $BingoDIR/38.nlog
fi

for VALUE in 'cron' 'cron/crontabs'
do
    if [ -d "/var/spool/$VALUE" ]
    then
        CRON_FILE=`ls /var/spool/$VALUE`
        if [ `ls -A "/var/spool/$VALUE" | wc -l` -le 0 ]
        then
            for USER in ${CRON_FILE[@]}
            do
                if [ `ls -l /var/spool/$VALUE | grep $USER | awk '{ print $3 }'` == 'root' ]
                then
                    echo "YES" >> $BingoDIR/38.result
                    ls -l /var/spool/$VALUE >> $BingoDIR/38.ylog
                else 
                    echo "NO" >> $BingoDIR/38.result
                    echo "KB-AU-38-N-2$VALUE" >> $BingoDIR/38.msg
                    ls -l /var/spool/$VALUE >> $BingoDIR/38.nlog
                fi

                if [ `ls -al /var/spool/$VALUE/$USER | cut -c 2-4` == 'rw-' ] || [ `ls -al /var/spool/$VALUE/$USER | cut -c 2-4` == 'r--' ] || [ `ls -al /var/spool/$VALUE/$USER | cut -c 2-4` == '---' ] || [ `ls -al /var/spool/$VALUE/$USER | cut -c 2-4` == '-w-' ]
                then
                    if [ `ls -al /var/spool/$VALUE/$USER | cut -c 5-10` == 'r-----' ] || [ `ls -al /var/spool/$VALUE/$USER | cut -c 5-10` == '------' ]
                    then
                        echo "YES" >> $BingoDIR/38.result
                    else
                        echo "NO" >> $BingoDIR/38.result
                        echo "KB-AU-38-N-1$VALUE" >> $BingoDIR/38.msg
                        ls -l /var/spool/$VALUE >> $BingoDIR/38.nlog
                    fi
                else
                    echo "NO" >> $BingoDIR/38.result
                    echo "KB-AU-38-N-1$VALUE" >> $BingoDIR/38.msg
                    ls -l /var/spool/$VALUE >> $BingoDIR/38.nlog
                fi
            done
        fi
    else 
        echo "YES" >> $BingoDIR/38.result
        echo "/var/spool/$VALUE NO FILE" >> $BingoDIR/38.ylog
    fi
done

unset CRON_FILE

## File ##
for VALUE in 'crontab' 'cron.allow' 'cron.deny'
do
    if [ -f /etc/$VALUE ]
    then
        if [ `ls -al /etc/$VALUE | cut -c 2-4` == 'rw-' ] || [ `ls -al /etc/$VALUE | cut -c 2-4` == 'r--' ] || [ `ls -al /etc/$VALUE | cut -c 2-4` == '---' ] || [ `ls -al /etc/$VALUE | cut -c 2-4` == '-w-' ]
        then
            if [ `ls -al /etc/$VALUE | cut -c 5-10` == 'r-----' ] || [ `ls -al /etc/$VALUE | cut -c 5-10` == '------' ]
            then
                echo "YES" >> $BingoDIR/38.result
                ls -al /etc/$VALUE >> $BingoDIR/38.ylog
            else
                echo "NO" >> $BingoDIR/38.result
                echo "KB-AU-38-N-1$VALUE" >> $BingoDIR/38.msg
                ls -al /etc/$VALUE >> $BingoDIR/38.nlog
            fi
        else
            echo "NO" >> $BingoDIR/38.result
            echo "KB-AU-38-N-1$VALUE" >> $BingoDIR/38.msg
            ls -al /etc/$VALUE >> $BingoDIR/38.nlog
        fi

        if [ `ls -al /etc/$VALUE | awk '{ print $3 }'` != 'root' ]
        then
            echo "NO" >> $BingoDIR/38.result
            echo "KB-AU-38-N-2$VALUE" >> $BingoDIR/38.msg
            ls -al /etc/$VALUE >> $BingoDIR/38.nlog
        else
            echo "YES" >> $BingoDIR/38.result
        fi 
    else
        echo "YES" >> $BingoDIR/38.result
        echo "/etc/$VALUE NO FILE" >> $BingoDIR/38.ylog
    fi
done

unset VALUE

## Directory ##

# 디렉터리 배열 설정
dirs=("/etc/cron.hourly" "/etc/cron.daily" "/etc/cron.weekly" "/etc/cron.monthly")

# 각 디렉터리에 대해 반복
for dir in "${dirs[@]}"
do
    dirName=$(basename "$dir")
    # 디렉터리가 존재하고 파일이 하나 이상 있는지 확인
    if [ -d "${dir}" ] && [ "$(ls -A ${dir})" ]
    then
        # 파일 리스트를 배열에 저장
        fileArray=($(find ${dir} -type f))
        
        for file in "${fileArray[@]}"
        do
            fileName=$(basename "${file}")

            if [ `ls -al "${file}" | cut -c 2-4` == 'rw-' ] || [ `ls -al "${file}" | cut -c 2-4` == 'r--' ] || [ `ls -al "${file}" | cut -c 2-4` == '---' ] || [ `ls -al "${file}" | cut -c 2-4` == '-w-' ]
            then
                if [ `ls -al "${file}" | cut -c 5-10` == 'r-----' ] || [ `ls -al "${file}" | cut -c 5-10` == '------' ]
                then
                    echo "YES" >> $BingoDIR/38.result
                    ls -al "${file}" >> $BingoDIR/38.ylog
                else
                    echo "NO" >> $BingoDIR/38.result
                    echo "KB-AU-38-N-1${dirName}" >> $BingoDIR/38.msg
                    ls -al "${file}" >> $BingoDIR/38.nlog
                fi
            else
                echo "NO" >> $BingoDIR/38.result
                echo "KB-AU-38-N-1${dirName}" >> $BingoDIR/38.msg
                ls -al "${file}" >> $BingoDIR/38.nlog
            fi

            if [ `ls -al "${file}" | awk '{ print $3 }'` != 'root' ]
            then
                echo "NO" >> $BingoDIR/38.result
                echo "KB-AU-38-N-2${dirName}" >> $BingoDIR/38.msg
                ls -al ${file} >> $BingoDIR/38.nlog
            else
                echo "YES" >> $BingoDIR/38.result 
            fi 
        done
    fi
done

if [ `cat $BingoDIR/38.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/38.result
else 
    echo "YES" > $BingoDIR/38.result
    echo "KB-AU-38-Y-01" > $BingoDIR/38.msg
fi

# 중복값 제거
if [ -f $BingoDIR/38.nlog ]
then
    sort $BingoDIR/38.nlog > $BingoDIR/382.nlog
    sort $BingoDIR/382.nlog | uniq >> $BingoDIR/383.nlog

    rm -rf $BingoDIR/38.nlog
    rm -rf $BingoDIR/382.nlog
fi

# log 출력
if [ -f $BingoDIR/383.nlog ]
then
    echo "$LOG_SECTION" > $BingoDIR/38.log
    cat $BingoDIR/383.nlog >> $BingoDIR/38.log
    echo "$LOG_ALL" >> $BingoDIR/38.log
    cat $BingoDIR/383.nlog >> $BingoDIR/38.log
    cat $BingoDIR/38.ylog >> $BingoDIR/38.log
    rm -rf $BingoDIR/383.nlog
else
    echo "$LOG_ALL" > $BingoDIR/38.log
    cat $BingoDIR/38.ylog >> $BingoDIR/38.log
fi

unset DUD
unset VALUE
# 38 end

# 39 start
#================================================================================
# U-39 스케줄링 점검
# 스케줄링 서비스 공격에 작업의 실행 여부 점검
echo "KB-AU-39" > $BingoDIR/39.title

RESULT='YES'

if [ `crontab -l | grep -v "^ *#" | wc -l` -eq 0 ]
then
	RESULT='YES'
	RESULT_MSG="KB-AU-39-Y-01"
	RESULT_LOG=$(crontab -l 2>&1)
else
	RESULT='NO'
	RESULT_MSG="KB-AU-39-N-01"
	RESULT_LOG=$(crontab -l 2>&1)
fi

echo "$RESULT" > $BingoDIR/39.result
echo "$RESULT_MSG" > $BingoDIR/39.msg
echo "$LOG_ALL" > $BingoDIR/39.log
echo "$RESULT_LOG" >> $BingoDIR/39.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
# 39 end

# 40 start
#================================================================================
# U-40 DoS 공격에 취약한 서비스 비활성화
# 사용하지 않는 Dos 공격에 취약한 서비스의 실행 여부 점검
echo "KB-AU-40" > $BingoDIR/40.title

echo "YES" > $BingoDIR/40.result

echo "" > $BingoDIR/40.msg

echo "$LOG_SECTION" > $BingoDIR/40.log

DUD1=("echo" "discard" "daytime" "chargen" "echo-dgram" "discard-dgram" "daytime-dgram" "chargen-dgram" "echo-stream" "discard-stream" "daytime-stream" "chargen-stream" "ntp" "dns" "snmp" "smtp")
DUD2=("echo" "discard" "daytime" "chargen" "ntp" "dns" "snmp" "smtp")

# xinetd.d 밑에 DUD1 파일이 있는지 확인 후 있으면 disable 값 확인
for VALUE1 in "${DUD1[@]}"
do
	if [ -f /etc/xinetd.d/$VALUE1 ]
	then
		if [ `cat /etc/xinetd.d/$VALUE1 | grep "disable" | grep "yes" | grep -v '^ *#' | wc -l` -eq 0 ]
		then
            echo "NO" >> $BingoDIR/40.result
            echo "KB-AU-40-N-1$VALUE1" >> $BingoDIR/40.msg
            echo "------------------------------" >> $BingoDIR/40.log
            echo "File: /etc/xinetd.d/$VALUE1" >> $BingoDIR/40.log
            echo "------------------------------" >> $BingoDIR/40.log
            cat /etc/xinetd.d/$VALUE1 | grep "disable" >> $BingoDIR/40.log
		else
            echo "YES" >> $BingoDIR/40.result
            echo "------------------------------" >> $BingoDIR/40.log
            echo "File: /etc/xinetd.d/$VALUE1" >> $BingoDIR/40.log
            echo "------------------------------" >> $BingoDIR/40.log
            cat /etc/xinetd.d/$VALUE1 | grep "disable" >> $BingoDIR/40.log
		fi
    else 
        echo "YES" >> $BingoDIR/40.result
        echo "/etc/xinetd.d/$VALUE1 NO FILE" >> $BingoDIR/40.log   
	fi
done

# inetd.conf 파일이 있는지 확인 후 있으면 DUD2 값들이 있는지 확인
if [ -f /etc/inetd.conf ]
then
    echo "------------------------------" >> $BingoDIR/40.log
    echo "File: /etc/inetd.conf" >> $BingoDIR/40.log
    echo "------------------------------" >> $BingoDIR/40.log
    for VALUE2 in "${DUD2[@]}"
    do
        if [ `cat /etc/inetd.conf | grep -w $VALUE2 | grep -v "^ *#" |  wc -l` -ge 1 ]
        then
            echo "NO" >> $BingoDIR/40.result
            echo "KB-AU-40-N-2$VALUE2" >> $BingoDIR/40.msg
            cat /etc/inetd.conf | grep -w $VALUE2 >> $BingoDIR/40.log
        else
            echo "YES" >> $BingoDIR/40.result
            cat /etc/inetd.conf | grep -w $VALUE2 >> $BingoDIR/40.log
        fi
    done
else
    echo "YES" >> $BingoDIR/40.result
    echo "------------------------------" >> $BingoDIR/40.log
    echo "File: /etc/inetd.conf" >> $BingoDIR/40.log
    echo "------------------------------" >> $BingoDIR/40.log
    echo "NO FILE" >> $BingoDIR/40.log
fi

if [ `cat $BingoDIR/40.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/40.result
else 
    echo "YES" > $BingoDIR/40.result
    echo "KB-AU-40-Y-01" > $BingoDIR/40.msg
fi

# 전체 파일 출력
echo "$LOG_ALL" >> $BingoDIR/40.log
for VALUE1 in "${DUD1[@]}"
do
	if [ -f /etc/xinetd.d/$VALUE1 ]
	then
        echo "------------------------------" >> $BingoDIR/40.log
        echo "File: /etc/xinetd.d/$VALUE1" >> $BingoDIR/40.log
        echo "------------------------------" >> $BingoDIR/40.log
        cat /etc/xinetd.d/$VALUE1 >> $BingoDIR/40.log
    else
        echo "------------------------------" >> $BingoDIR/40.log
        echo "File: /etc/xinetd.d/$VALUE1" >> $BingoDIR/40.log
        echo "------------------------------" >> $BingoDIR/40.log
        echo "NO FILE" >> $BingoDIR/40.log
    fi
done

if [ -f /etc/inetd.conf ]
then
    echo "------------------------------" >> $BingoDIR/40.log
    echo "File: /etc/inetd.conf" >> $BingoDIR/40.log
    echo "------------------------------" >> $BingoDIR/40.log
    cat /etc/inetd.conf >> $BingoDIR/40.log
else 
    echo "------------------------------" >> $BingoDIR/40.log
    echo "File: /etc/inetd.conf" >> $BingoDIR/40.log
    echo "------------------------------" >> $BingoDIR/40.log
    echo "NO FILE" >> $BingoDIR/40.log
fi

unset DUD1
unset DUD2
unset VALUE1
unset VALUE2
# 40 end

# 41 start
#================================================================================
# U-41 NFS 서비스 비활성화
# 불필요한 NFS 서비스 사용여부 점검
echo "KB-AU-41" > $BingoDIR/41.title

RESULT='YES'

if [ `ps -ef | grep 'nfs|statd|lockd|mountd' | grep -v grep | wc -l` -eq 0 ]
then
	RESULT='YES'
	RESULT_MSG="KB-AU-41-Y-01"
	RESULT_LOG=$(ps -ef | grep 'nfs|statd|lockd|mountd' | grep -v grep 2>&1)
else
	RESULT='NO'
	RESULT_MSG="KB-AU-41-N-01"
	RESULT_LOG=$(ps -ef | grep 'nfs|statd|lockd|mountd' | grep -v grep 2>&1)
fi

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='NFS Service is not running'
fi

echo "$RESULT" > $BingoDIR/41.result
echo "$RESULT_MSG" > $BingoDIR/41.msg
echo "$LOG_USE" > $BingoDIR/41.log
echo "$RESULT_LOG" >> $BingoDIR/41.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
# 41 end

# 42 start
#================================================================================
# U-42 NFS 접근 통제
# NFS(Network File System) 사용 시 허가된 사용자만 접속할 수 있도록 접근제한 설정 적용 여부 점검
echo "KB-AU-42" > $BingoDIR/42.title

RESULT='YES'
if [ `ps -ef | grep -i 'nfs' | grep -v grep | wc -l` -ge 1 ]
then
    if [ -f /etc/exports ]
    then
        if [ `cat /etc/exports | grep -i "insecure" | grep -v '^ *#' | wc -l` -eq 0 ]
        then
            RESULT='YES'
            RESULT_MSG="KB-AU-42-Y-01"
            RESULT_LOG=$(cat /etc/exports | grep -i "insecure" 2>&1)
            RESULT_LOG2=$(cat /etc/exports 2>&1)
        else
            RESULT='NO'
            RESULT_MSG="KB-AU-42-N-01"
            RESULT_LOG=$(cat /etc/exports | grep -i "insecure" 2>&1)
            RESULT_LOG2=$(cat /etc/exports 2>&1)
        fi
    elif [ -f /etc/export ]
    then
        if [ `cat /etc/export | grep -i "insecure" | grep -v '^ *#' | wc -l` -eq 0 ]
        then
            RESULT='YES'
            RESULT_MSG="KB-AU-42-Y-01"
            RESULT_LOG=$(cat /etc/export | grep -i "insecure" 2>&1)
            RESULT_LOG2=$(cat /etc/export 2>&1)
        else
            RESULT='NO'
            RESULT_MSG="KB-AU-42-N-02"
            RESULT_LOG=$(cat /etc/export | grep -i "insecure" 2>&1)
            RESULT_LOG2=$(cat /etc/export 2>&1)
        fi
    else
        RESULT='MANUAL'
        RESULT_MSG="KB-AU-42-M-01"
        RESULT_LOG="/etc/export(s) NO FILE"
        RESULT_LOG2=$(cat /etc/exports 2>&1 || cat /etc/export 2>&1)
    fi
else
    RESULT='YES'
	RESULT_MSG="KB-AU-42-Y-02"
	RESULT_LOG="NFS Service is not running"
	RESULT_LOG2=$(cat /etc/exports 2>&1)
fi

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='NO VALUE'
fi

echo "$RESULT" > $BingoDIR/42.result
echo "$RESULT_MSG" > $BingoDIR/42.msg
echo "$LOG_SECTION" > $BingoDIR/42.log
echo "$RESULT_LOG" >> $BingoDIR/42.log
echo "$LOG_ALL" >> $BingoDIR/42.log
echo "$RESULT_LOG2" >> $BingoDIR/42.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
# 42 end

# 43 start
#================================================================================
# U-43 automountd 제거
# automountd 서비스 데몬의 실행 여부 점검
echo "KB-AU-43" > $BingoDIR/43.title

RESULT='YES'

if [ `ps -ef | grep "automount\|autofs" | grep -v grep | wc -l` -ge 1 ]
then
    RESULT='NO'
	RESULT_MSG="KB-AU-43-N-01"
	RESULT_LOG=$(ps -ef | grep "automount\|autofs" | grep -v grep 2>&1)
else
    RESULT='YES'
	RESULT_MSG="KB-AU-43-Y-01"
	RESULT_LOG=$(ps -ef | grep "automount\|autofs" | grep -v grep 2>&1)
fi

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='automount Service is not running'
fi

echo "$RESULT" > $BingoDIR/43.result
echo "$RESULT_MSG" > $BingoDIR/43.msg
echo "$LOG_USE" > $BingoDIR/43.log
echo "$RESULT_LOG" >> $BingoDIR/43.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
# 43 end

# 44 start
#================================================================================
# U-44 RPC 서비스 확인
# 불필요한 RPC 서비스의 실행 여부 점검
echo "KB-AU-44" > $BingoDIR/44.title

echo "YES" > $BingoDIR/44.result

echo "" > $BingoDIR/44.msg

echo "$LOG_SECTION" > $BingoDIR/44.log

DUD=("rpc.cmsd" "rpc.ttdbserverd" "sadmind" "ruserd" "walld" "sprayd" "rstatd" "rpc.nisd" "rexd" "rpc.pcnfsd" "rpc.statd" "rpc.ypupdated" "rpc.rquotad" "kcms_server" "cachefsd")

for VALUE in "${DUD[@]}"
do
    if [ -f /etc/xinetd.d/$VALUE ]
    then
    	if [ `cat /etc/xinetd.d/$VALUE | grep -i "disable" | grep -i "yes" | grep -v '^ *#' | wc -l` -eq 0 ]
        then
            echo "NO" >> $BingoDIR/44.result
            echo "KB-AU-44-N-1$VALUE" >> $BingoDIR/44.msg
            echo "------------------------------" >> $BingoDIR/44.log
            echo "File: /etc/xinetd.d/$VALUE" >> $BingoDIR/44.log
            echo "------------------------------" >> $BingoDIR/44.log
            cat /etc/xinetd.d/$VALUE | grep -i "disable" >> $BingoDIR/44.log
		else
            echo "YES" >> $BingoDIR/44.result
            echo "------------------------------" >> $BingoDIR/44.log
            echo "File: /etc/xinetd.d/$VALUE" >> $BingoDIR/44.log
            echo "------------------------------" >> $BingoDIR/44.log
            cat /etc/xinetd.d/$VALUE | grep -i "disable" >> $BingoDIR/44.log
        fi
    else
        echo "YES" >> $BingoDIR/44.result
        echo "/etc/xinetd.d/$VALUE NO FILE" >> $BingoDIR/44.log 
    fi
done

unset VALUE

if [ -f /etc/inetd.conf ]
then
    echo "------------------------------" >> $BingoDIR/44.log
    echo "File: /etc/inetd.conf" >> $BingoDIR/44.log
    echo "------------------------------" >> $BingoDIR/44.log
    for VALUE in "${DUD[@]}"
    do
        if [ `cat /etc/inetd.conf | grep $VALUE | grep -v "^ *#" |  wc -l` -ge 1 ]
        then
            echo "NO" >> $BingoDIR/44.result
            echo "KB-AU-44-N-2$VALUE" >> $BingoDIR/44.msg
            cat /etc/inetd.conf | grep $VALUE >> $BingoDIR/44.log
        else
            echo "YES" >> $BingoDIR/44.result
            cat /etc/inetd.conf | grep $VALUE >> $BingoDIR/44.log
        fi
    done
else
    echo "YES" >> $BingoDIR/44.result
    echo "------------------------------" >> $BingoDIR/44.log
    echo "File: /etc/inetd.conf" >> $BingoDIR/44.log
    echo "------------------------------" >> $BingoDIR/44.log
    echo "NO FILE" >> $BingoDIR/44.log 
fi

if [ `cat $BingoDIR/44.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/44.result
else 
    echo "YES" > $BingoDIR/44.result
    echo "KB-AU-44-Y-01" > $BingoDIR/44.msg
fi

# 전체 파일 출력
echo "$LOG_ALL" >> $BingoDIR/44.log
for VALUE in "${DUD[@]}"
do
    if [ -f /etc/xinetd.d/$VALUE ]
    then
        echo "------------------------------" >> $BingoDIR/44.log
        echo "File: /etc/xinetd.d/$VALUE" >> $BingoDIR/44.log
        echo "------------------------------" >> $BingoDIR/44.log
        cat /etc/xinetd.d/$VALUE >> $BingoDIR/44.log
    else
        echo "------------------------------" >> $BingoDIR/44.log
        echo "File: /etc/xinetd.d/$VALUE" >> $BingoDIR/44.log
        echo "------------------------------" >> $BingoDIR/44.log
        echo "NO FILE" >> $BingoDIR/44.log
    fi
done

if [ -f /etc/inetd.conf ]
then
    echo "------------------------------" >> $BingoDIR/44.log
    echo "File: /etc/inetd.conf" >> $BingoDIR/44.log
    echo "------------------------------" >> $BingoDIR/44.log
    cat /etc/inetd.conf >> $BingoDIR/44.log   
else
    echo "------------------------------" >> $BingoDIR/44.log
    echo "File: /etc/inetd.conf" >> $BingoDIR/44.log
    echo "------------------------------" >> $BingoDIR/44.log
    echo "NO FILE" >> $BingoDIR/44.log
fi

unset DUD
unset VALUE

# 44 end

# 45 start
#================================================================================
# U-45 NIS, NIS+점검
# 안전하지  않은  NIS  서비스의  비활성화,  안전한  NIS+  서비스의  활성화  여부  점검
echo "KB-AU-45" > $BingoDIR/45.title

RESULT='YES'

if [ `ps -ef | grep -w "ypserv\|ypbind\|ypxfrd\|rpc.yppasswdd\|rpc.ypupdated" | grep -v grep | wc -l` -ge 1 ]
then
	RESULT='NO'
	RESULT_MSG="KB-AU-45-N-01"
	RESULT_LOG=$(ps -ef | grep -w "ypserv\|ypbind\|ypxfrd\|rpc.yppasswdd\|rpc.ypupdated" | grep -v grep 2>&1)
else
    RESULT='YES'
	RESULT_MSG="KB-AU-45-Y-01"
	RESULT_LOG=$(ps -ef | grep -w "ypserv\|ypbind\|ypxfrd\|rpc.yppasswdd\|rpc.ypupdated" | grep -v grep 2>&1)
fi

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='NIS Service is not running'
fi

echo "$RESULT" > $BingoDIR/45.result
echo "$RESULT_MSG" > $BingoDIR/45.msg
echo "$LOG_USE" > $BingoDIR/45.log
echo "$RESULT_LOG" >> $BingoDIR/45.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
# 45 end

# 46 start
#================================================================================
# U-46 tftp,talk 서비스 비활성화
# tftp, talk 등의 서비스를 사용하지 않거나 취약점이 발표된 서비스의 활성화 여부 점검
echo "KB-AU-46" > $BingoDIR/46.title

echo "YES" > $BingoDIR/46.result

echo "" > $BingoDIR/46.msg

echo "$LOG_SECTION" > $BingoDIR/46.log

DUD=("tftp" "talk" "ntalk")

for VALUE in "${DUD[@]}"
do
    if [ -f /etc/xinetd.d/$VALUE ]
    then
    	if [ `cat /etc/xinetd.d/$VALUE | grep -i "disable" | grep -i "yes" | grep -v '^ *#' | wc -l` -eq 0 ]
        then
            echo "NO" >> $BingoDIR/46.result
            echo "KB-AU-46-N-1$VALUE" >> $BingoDIR/46.msg
            echo "------------------------------" >> $BingoDIR/46.log
            echo "File: /etc/xinetd.d/$VALUE" >> $BingoDIR/46.log
            echo "------------------------------" >> $BingoDIR/46.log
            cat /etc/xinetd.d/$VALUE | grep -i "disable" >> $BingoDIR/46.log
		else
            echo "YES" >> $BingoDIR/46.result
            echo "------------------------------" >> $BingoDIR/46.log
            echo "File: /etc/xinetd.d/$VALUE" >> $BingoDIR/46.log
            echo "------------------------------" >> $BingoDIR/46.log
            cat /etc/xinetd.d/$VALUE | grep -i "disable" >> $BingoDIR/46.log
        fi
    else
        echo "YES" >> $BingoDIR/46.result
        echo "------------------------------" >> $BingoDIR/46.log
        echo "File: /etc/xinetd.d/$VALUE" >> $BingoDIR/46.log
        echo "------------------------------" >> $BingoDIR/46.log
        echo "NO FILE" >> $BingoDIR/46.log
    fi
done

unset VALUE   
    
if [ -f /etc/inetd.conf ]
then
    echo "------------------------------" >> $BingoDIR/46.log
    echo "File: /etc/inetd.conf" >> $BingoDIR/46.log
    echo "------------------------------" >> $BingoDIR/46.log
    for VALUE in "${DUD[@]}"
    do
        if [ `cat /etc/inetd.conf | grep -w $VALUE | grep -v "^ *#" |  wc -l` -ge 1 ]
        then
            echo "NO" >> $BingoDIR/46.result            
            echo "KB-AU-46-N-2$VALUE" >> $BingoDIR/46.msg
            cat /etc/inetd.conf | grep -w $VALUE >> $BingoDIR/46.log
        else 
            echo "YES" >> $BingoDIR/46.result
            cat /etc/inetd.conf | grep -w $VALUE >> $BingoDIR/46.log
        fi
    done
else
    echo "YES" >> $BingoDIR/46.result
    echo "------------------------------" >> $BingoDIR/46.log
    echo "File: /etc/inetd.conf" >> $BingoDIR/46.log
    echo "------------------------------" >> $BingoDIR/46.log
    echo "NO FILE" >> $BingoDIR/46.log
fi

if [ `cat $BingoDIR/46.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/46.result
else 
    echo "YES" > $BingoDIR/46.result
    echo "KB-AU-46-Y-01" > $BingoDIR/46.msg
fi

# 전체 파일 출력
echo "$LOG_ALL" >> $BingoDIR/46.log
for VALUE in "${DUD[@]}"
do
    if [ -f /etc/xinetd.d/$VALUE ]
    then
        echo "------------------------------" >> $BingoDIR/46.log
        echo "File: /etc/xinetd.d/$VALUE" >> $BingoDIR/46.log
        echo "------------------------------" >> $BingoDIR/46.log
        cat /etc/xinetd.d/$VALUE >> $BingoDIR/46.log
    else 
        echo "------------------------------" >> $BingoDIR/46.log
        echo "File: /etc/xinetd.d/$VALUE" >> $BingoDIR/46.log
        echo "------------------------------" >> $BingoDIR/46.log
        echo "NO FILE" >> $BingoDIR/46.log
    fi
done

if [ -f /etc/inetd.conf ]
then
    echo "------------------------------" >> $BingoDIR/46.log
    echo "File: /etc/inetd.conf" >> $BingoDIR/46.log
    echo "------------------------------" >> $BingoDIR/46.log
    cat /etc/inetd.conf >> $BingoDIR/46.log
else
    echo "------------------------------" >> $BingoDIR/46.log
    echo "File: /etc/inetd.conf" >> $BingoDIR/46.log
    echo "------------------------------" >> $BingoDIR/46.log
    echo "NO FILE" >> $BingoDIR/46.log
fi

unset DUD
unset VALUE
# 46 end

# 47 start
#================================================================================
# U-47 Sendmail 버전 점검
# 취약한 버전의 Sendmail 서비스 이용 여부 점검
echo "KB-AU-47" > $BingoDIR/47.title

RESULT='YES'

# Sendmail 8.17.1  = 2022-08-17 기준
if [ `ps -ef | grep -i sendmail | grep -v grep | wc -l` -ge 1 ] || [ `ps -ef | grep -i postfix | grep -v grep | wc -l` -ge 1 ]
then
	if [ `sendmail -d0.4 -bv root | grep -i Version | awk -F "." '{ print $2 }'` -lt 17 ]
	then
		RESULT="NO"
		RESULT_MSG="KB-AU-47-N-01"
		RESULT_LOG=$(sendmail -d0.4 -bv root | grep -i Version 2>&1)
	else
	    RESULT='YES'
		RESULT_MSG="KB-AU-47-Y-01"
		RESULT_LOG=$(sendmail -d0.4 -bv root | grep -i Version 2>&1)
	fi
elif [ `ss -tuln | grep -c 25` -ge 1 ]
then
	if [ `sendmail -d0.4 -bv root | grep -i Version | awk -F "." '{ print $2 }'` -lt 17 ]
	then
		RESULT="NO"
		RESULT_MSG="KB-AU-47-N-01"
		RESULT_LOG=$(sendmail -d0.4 -bv root | grep -i Version 2>&1)
	else
	    RESULT='YES'
		RESULT_MSG="KB-AU-47-Y-01"
		RESULT_LOG=$(sendmail -d0.4 -bv root | grep -i Version 2>&1)
	fi
else
    RESULT='YES'
	RESULT_MSG="KB-AU-47-Y-02"
	RESULT_LOG="Sendmail Service is not running"
fi

echo "$RESULT" > $BingoDIR/47.result
echo "$RESULT_MSG" > $BingoDIR/47.msg
echo "$LOG_USE" > $BingoDIR/47.log
echo "$RESULT_LOG" >> $BingoDIR/47.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
# 47 end

# 48 start
#================================================================================
# U-48 스팸 메일 릴레이 제한
# SMTP 서버의 릴레이 기능 제한 여부 점검
echo "KB-AU-48" > $BingoDIR/48.title

RESULT='YES'

if [ `ps -ef | grep sendmail | grep -v "grep" | wc -l` -ge 1 ]
then
    if [ -f /etc/mail/sendmail.cf ]
    then
        if [ `cat /etc/mail/sendmail.cf | grep "R$\*" | grep -i "Relaying denied" | grep "^ *#" | wc -l` -ge 1 ]
        then
			RESULT='NO'
			RESULT_MSG="KB-AU-48-N-01"
			RESULT_LOG=$(cat /etc/mail/sendmail.cf | grep "R$\*" | grep -i "Relaying denied" 2>&1)
			RESULT_LOG2=$(cat /etc/mail/sendmail.cf 2>&1)
        else
            RESULT='YES'
			RESULT_MSG="KB-AU-48-Y-01"
			RESULT_LOG=$(cat /etc/mail/sendmail.cf | grep "R$\*" | grep -i "Relaying denied" 2>&1)
			RESULT_LOG2=$(cat /etc/mail/sendmail.cf 2>&1)
        fi
    else
		RESULT='MANUAL'
		RESULT_MSG="KB-AU-48-M-01"
		RESULT_LOG="/etc/mail/sendmail.cf NO FILE"
		RESULT_LOG2=$(cat /etc/mail/sendmail.cf 2>&1)
	fi
elif [ `ps -ef | grep postfix | grep -v "grep" | wc -l` -ge 1 ]
then
    if [ -f /etc/postfix/main.cf ]
	then
		if [ `cat /etc/postfix/main.cf | grep check_sender_access | grep -v "^ *#" | wc -l` -ge 1 ]
		then
	        RESULT='YES'
			RESULT_MSG="KB-AU-48-Y-01"
			RESULT_LOG=$(cat /etc/postfix/main.cf | grep check_sender_access 2>&1)
			RESULT_LOG2=$(cat /etc/postfix/main.cf 2>&1)
		else
			RESULT='NO'
			RESULT_MSG="KB-AU-48-N-02"
			RESULT_LOG=$(cat /etc/postfix/main.cf | grep check_sender_access 2>&1)
			RESULT_LOG2=$(cat /etc/postfix/main.cf 2>&1)
		fi
	else
        RESULT='MANUAL'
		RESULT_MSG="KB-AU-48-M-02"
		RESULT_LOG="/etc/postfix/main.cf NO FILE"
		RESULT_LOG2=$(cat /etc/postfix/main.cf 2>&1)
	fi
else
	RESULT='YES'
	RESULT_MSG="KB-AU-48-Y-01"
	RESULT_LOG="Sendmail/Postfix Service is not running"
	RESULT_LOG2="Sendmail/Postfix Service is not running"
fi

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='NO VALUE'
fi

echo "$RESULT" > $BingoDIR/48.result
echo "$RESULT_MSG" > $BingoDIR/48.msg
echo "$LOG_SECTION" > $BingoDIR/48.log
echo "$RESULT_LOG" >> $BingoDIR/48.log
echo "$LOG_ALL" >> $BingoDIR/48.log
echo "$RESULT_LOG2" >> $BingoDIR/48.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
# 48 end

# 49 start
#================================================================================
# U-49 일반 사용자의 Sendmail 실행 방지
# SMTP 서비스 사용 시 일반사용자의 q 옵션 제한 여부 점검
echo "KB-AU-49" > $BingoDIR/49.title

RESULT='YES'

if [ `ps -ef | grep 'sendmail' | grep -v grep | wc -l` -ge 1 ]
then
    if [ -f /etc/mail/sendmail.cf ]
    then
        if [ `cat /etc/mail/sendmail.cf | grep -i 'PrivacyOptions=' | grep -i restrictqrun | grep -v "^ *#" | wc -l` -eq 0 ]
        then
			RESULT='NO'
			RESULT_MSG="KB-AU-49-N-01"
			RESULT_LOG=$(cat /etc/mail/sendmail.cf | grep -i 'PrivacyOptions=' 2>&1)
			RESULT_LOG2=$(cat /etc/mail/sendmail.cf 2>&1)
        else
        	RESULT='YES'
			RESULT_MSG="KB-AU-49-Y-01"
			RESULT_LOG=$(cat /etc/mail/sendmail.cf | grep -i 'PrivacyOptions=' 2>&1)
			RESULT_LOG2=$(cat /etc/mail/sendmail.cf 2>&1)
        fi
    else
       	RESULT='MANUAL'
		RESULT_MSG="KB-AU-49-M-01"
		RESULT_LOG="/etc/mail/sendmail.cf NO FILE"
		RESULT_LOG2=$(cat /etc/mail/sendmail.cf 2>&1)
    fi
else
	RESULT='YES'
	RESULT_MSG="KB-AU-49-Y-01"
	RESULT_LOG="Sendmail Service is not running"
	RESULT_LOG2="Sendmail Service is not running"
fi

echo "$RESULT" > $BingoDIR/49.result
echo "$RESULT_MSG" > $BingoDIR/49.msg
echo "$LOG_SECTION" > $BingoDIR/49.log
echo "$RESULT_LOG" >> $BingoDIR/49.log
echo "$LOG_ALL" >> $BingoDIR/49.log
echo "$RESULT_LOG2" >> $BingoDIR/49.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
# 49 end

# 50 start
#================================================================================
# U-50 DNS보안 버전 패치
# BIND  사용 유무 및 주기적 보안 패치 여부 점검
echo "KB-AU-50" > $BingoDIR/50.title

RESULT='YES'

if [ `ps -ef | grep named | grep -v "grep" | wc -l` -ge 1 ]
then
    if [ `named -v | cut -c 6-11 | cut -c 1` -ge 9 ]
    then
        if [ `named -v | cut -c 6-11 | awk -F "." '{ print $2 }'` -ge 10 ]
        then
            RESULT='YES'
			RESULT_MSG="KB-AU-50-Y-01"
			RESULT_LOG=$(named -v 2>&1)
        else
            RESULT='NO'
			RESULT_MSG="KB-AU-50-N-01"
			RESULT_LOG=$(named -v 2>&1)
        fi
    else
        RESULT='NO'
		RESULT_MSG="KB-AU-50-N-01"
		RESULT_LOG=$(named -v 2>&1)
    fi
else
    RESULT='YES'
	RESULT_MSG="KB-AU-50-Y-01"
	RESULT_LOG="DNS Service is not running"
fi 

echo "$RESULT" > $BingoDIR/50.result
echo "$RESULT_MSG" > $BingoDIR/50.msg
echo "$LOG_USE" > $BingoDIR/50.log
echo "$RESULT_LOG" >> $BingoDIR/50.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
# 50 end

# 51 start
#================================================================================
# U-51 DNS ZoneTransfer 설정
# Secondary Name Server로만 Zone 정보 전송 제한 여부 점검
echo "KB-AU-51" > $BingoDIR/51.title

RESULT='YES'

if [ `ps -ef | grep named | grep -v "grep" | wc -l` -ge 1 ]
then
	if [ -f /etc/named.conf ]
	then
		if [ `cat /etc/named.conf | grep -i 'allow-transfer' | wc -l` -eq 0 ]
        then
			RESULT='NO'
			RESULT_MSG="KB-AU-51-N-01"
			RESULT_LOG=$(cat /etc/named.conf | grep -i 'allow-transfer' 2>&1)
			RESULT_LOG2=$(cat /etc/named.conf 2>&1)
		else
			RESULT='YES'
			RESULT_MSG="KB-AU-51-Y-01"
			RESULT_LOG=$(cat /etc/named.conf | grep -i 'allow-transfer' 2>&1)
			RESULT_LOG2=$(cat /etc/named.conf 2>&1)
		fi
    # BIND 4.9
	elif [ -f /etc/named.boot ]
	then
		if [ `cat /etc/named.boot | grep -i "xfrnets" | wc -l` -eq 0 ]
		then
			RESULT='NO'
			RESULT_MSG="KB-AU-51-N-02"
			RESULT_LOG=$(cat /etc/named.boot | grep -i "xfrnets" 2>&1)
			RESULT_LOG2=$(cat /etc/named.boot 2>&1)
		else
			RESULT='YES'
			RESULT_MSG="KB-AU-51-Y-01" 
			RESULT_LOG=$(cat /etc/named.boot | grep -i "xfrnets" 2>&1)
			RESULT_LOG2=$(cat /etc/named.boot 2>&1)
		fi
	else
		RESULT='MANUAL'
		RESULT_MSG="KB-AU-51-M-01"
		RESULT_LOG="/etc/named.conf & /etc/named.boot NO FILE"
		RESULT_LOG2=$(cat /etc/named.conf 2>&1 || cat /etc/named.boot 2>&1)
	fi
else
	RESULT='YES'
	RESULT_MSG="KB-AU-51-Y-01"
	RESULT_LOG="DNS Service is not running"
	RESULT_LOG2="DNS Service is not running"
fi

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='NO VALUE'
fi

echo "$RESULT" > $BingoDIR/51.result
echo "$RESULT_MSG" > $BingoDIR/51.msg
echo "$LOG_SECTION" > $BingoDIR/51.log
echo "$RESULT_LOG" >> $BingoDIR/51.log
echo "$LOG_ALL" >> $BingoDIR/51.log
echo "$RESULT_LOG2" >> $BingoDIR/51.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
# 51 end

# 52 start
#================================================================================
# U-52 Apache 디렉터리 리스팅 제거
# 디렉터리 검색 기능의 활성화 여부 점검
echo "KB-AU-52" > $BingoDIR/52.title

RESULT='YES'

if [ `ps -ef | grep -w httpd | grep -v grep | wc -l` -ge 1 ] || [ `ps -ef | grep -i apache | grep -v grep | wc -l` -ge 1 ]
then
	if [ -f /etc/httpd/conf/httpd.conf ]
	then
		if [ `cat /etc/httpd/conf/httpd.conf | grep -i 'indexes' | grep -v "^ *#" | wc -l` -ge 1 ]
		then
			RESULT='NO'
			RESULT_MSG="KB-AU-52-N-01"
			RESULT_LOG=$(cat /etc/httpd/conf/httpd.conf | grep -i 'indexes' | grep -v "^ *#" 2>&1)
			RESULT_LOG2=$(cat /etc/httpd/conf/httpd.conf 2>&1)
		else
			RESULT='YES'
			RESULT_MSG="KB-AU-52-Y-01"
			RESULT_LOG=$(cat /etc/httpd/conf/httpd.conf | grep -i 'indexes' | grep -v "^ *#" 2>&1)
			RESULT_LOG2=$(cat /etc/httpd/conf/httpd.conf 2>&1)
		fi
	else
		RESULT='MANUAL'
		RESULT_MSG="KB-AU-AP-M-01"
		RESULT_LOG="/etc/httpd/conf/httpd.conf NO FILE"
		RESULT_LOG2=$(cat /etc/httpd/conf/httpd.conf 2>&1)
	fi   
else
	RESULT='YES'
	RESULT_MSG="KB-AU-AP-Y-01"
	RESULT_LOG="Apache Service is not running"
	RESULT_LOG2="Apache Service is not running"
fi

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='NO VALUE'
fi

echo "$RESULT" > $BingoDIR/52.result
echo "$RESULT_MSG" > $BingoDIR/52.msg
echo "$LOG_SECTION" > $BingoDIR/52.log
echo "$RESULT_LOG" >> $BingoDIR/52.log
echo "$LOG_ALL" >> $BingoDIR/52.log
echo "$RESULT_LOG2" >> $BingoDIR/52.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
# 52 end

# 53 start
#================================================================================
# U-53 Apache 웹 프로세스 권한 제한
# Apache 데몬이 root 권한으로 구동되는지 여부 점검
echo "KB-AU-53" > $BingoDIR/53.title

RESULT='YES'

if [ `ps -ef | grep -w httpd | grep -v grep | wc -l` -ge 1 ] || [ `ps -ef | grep -i apache | grep -v grep | wc -l` -ge 1 ]
then
	if [ -f /etc/httpd/conf/httpd.conf ]
	then
		if [ `cat /etc/httpd/conf/httpd.conf | grep -i 'user\|group' | grep -iw root | wc -l` -ge 1 ]
		then
			RESULT='NO'
			RESULT_MSG="KB-AU-53-N-01"
			RESULT_LOG=$(cat /etc/httpd/conf/httpd.conf | grep -i 'user\|group' | grep -iw root 2>&1)
			RESULT_LOG2=$(cat /etc/httpd/conf/httpd.conf 2>&1)
		else
			RESULT='YES'
			RESULT_MSG="KB-AU-53-Y-01"
			RESULT_LOG=$(cat /etc/httpd/conf/httpd.conf | grep -i 'user\|group' 2>&1)
			RESULT_LOG2=$(cat /etc/httpd/conf/httpd.conf 2>&1)
		fi
	else
		RESULT='MANUAL'
		RESULT_MSG="KB-AU-AP-M-01"
		RESULT_LOG="/etc/httpd/conf/httpd.conf NO FILE"
		RESULT_LOG2=$(cat /etc/httpd/conf/httpd.conf 2>&1)
	fi
else
	RESULT='YES'
	RESULT_MSG="KB-AU-AP-Y-01"
	RESULT_LOG="Apache Service is not running"
	RESULT_LOG2="Apache Service is not running"
fi

echo "$RESULT" > $BingoDIR/53.result
echo "$RESULT_MSG" > $BingoDIR/53.msg
echo "$LOG_SECTION" > $BingoDIR/53.log
echo "$RESULT_LOG" >> $BingoDIR/53.log
echo "$LOG_ALL" >> $BingoDIR/53.log
echo "$RESULT_LOG2" >> $BingoDIR/53.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
# 53 end

# 54 start
#================================================================================***func54***
# U-54 Apache 상위 디렉토리 접근 금지
# “..” 와 같은 문자 사용 등으로 상위 경로로 이동이 가능한지 여부 점검
echo "KB-AU-54" > $BingoDIR/54.title

RESULT='YES'

if [ `ps -ef | grep -w httpd | grep -v grep | wc -l` -ge 1 ] || [ `ps -ef | grep -i apache | grep -v grep | wc -l` -ge 1 ]
then
	if [ -f /etc/httpd/conf/httpd.conf ]
	then
		if [ `cat /etc/httpd/conf/httpd.conf | grep -i "AllowOverride" | grep -i "none" | grep -v '^ *#' | wc -l` -ge 1 ]
		then
			RESULT='NO'
			RESULT_MSG="KB-AU-54-N-01"
			RESULT_LOG=$(cat /etc/httpd/conf/httpd.conf | grep -i "AllowOverride" | grep -i "none" 2>&1)
			RESULT_LOG2=$(cat /etc/httpd/conf/httpd.conf 2>&1)
		else
			RESULT='YES'
			RESULT_MSG="KB-AU-54-Y-01"
			RESULT_LOG=$(cat /etc/httpd/conf/httpd.conf | grep -i "AllowOverride" 2>&1)
			RESULT_LOG2=$(cat /etc/httpd/conf/httpd.conf 2>&1)
		fi
	else
		RESULT='MANUAL'
		RESULT_MSG="KB-AU-AP-M-01"
		RESULT_LOG="/etc/httpd/conf/httpd.conf NO FILE"
		RESULT_LOG2=$(cat /etc/httpd/conf/httpd.conf 2>&1)
	fi
else
    RESULT='YES'
	RESULT_MSG="KB-AU-AP-Y-01"
	RESULT_LOG="Apache Service is not running"
	RESULT_LOG2="Apache Service is not running"
fi

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='NO VALUE'
fi

echo "$RESULT" > $BingoDIR/54.result
echo "$RESULT_MSG" > $BingoDIR/54.msg
echo "$LOG_SECTION" > $BingoDIR/54.log
echo "$RESULT_LOG" >> $BingoDIR/54.log
echo "$LOG_ALL" >> $BingoDIR/54.log
echo "$RESULT_LOG2" >> $BingoDIR/54.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
# 54 end

# 55 start
#================================================================================***func55***
# U-55 Apache 불필요한 파일 제거
# Apache 설치 시 기본으로 생성되는 불필요한 파일의 삭제 여부 점검
echo "KB-AU-55" > $BingoDIR/55.title

if [ `ps -ef | grep -w httpd | grep -v grep | wc -l` -ge 1 ] || [ `ps -ef | grep -i apache | grep -v grep | wc -l` -ge 1 ]
then
    RESULT_LOG=$(ps -ef | grep -w httpd | grep -v grep 2>&1)
else
    RESULT_LOG="Apache Service is not running"
fi

RESULT='MANUAL'
RESULT_MSG='KB-AU-55-M-01'
RESULT_LOG2="MANUAL"
RESULT_LOG3="#ls -ld /[Apache_home]/htdocs/manual"
RESULT_LOG4="#ls -ld /[Apache_home]/manual"

echo "$RESULT" > $BingoDIR/55.result
echo "$RESULT_MSG" > $BingoDIR/55.msg
echo "$LOG_USE" > $BingoDIR/55.log
echo "$RESULT_LOG" >> $BingoDIR/55.log
echo "$RESULT_LOG2" >> $BingoDIR/55.log
echo "$RESULT_LOG3" >> $BingoDIR/55.log
echo "$RESULT_LOG4" >> $BingoDIR/55.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
unset RESULT_LOG3
unset RESULT_LOG4
# 55 end

# 56 start
#================================================================================***func56***
# U-56 Apache 링크 사용금지
# 심볼릭 링크, aliases 사용 제한 여부 점검
echo "KB-AU-56" > $BingoDIR/56.title

RESULT='YES'

if [ `ps -ef | grep -w httpd | grep -v grep | wc -l` -ge 1 ] || [ `ps -ef | grep -i apache | grep -v grep | wc -l` -ge 1 ]
then
	if [ -f /etc/httpd/conf/httpd.conf ]
	then
		if [ `cat /etc/httpd/conf/httpd.conf | grep -iw 'options' | grep -iw "FollowSymLinks" | grep -v "^ *#" | wc -l` -ge 1 ]
		then
			RESULT='NO'
			RESULT_MSG="KB-AU-56-N-01"
			RESULT_LOG=$(cat /etc/httpd/conf/httpd.conf | grep -iw 'options' | grep -iw "FollowSymLinks" 2>&1)
			RESULT_LOG2=$(cat /etc/httpd/conf/httpd.conf 2>&1)
		else
			RESULT='YES'
			RESULT_MSG="KB-AU-56-Y-01"
			RESULT_LOG=$(cat /etc/httpd/conf/httpd.conf | grep -iw 'options' 2>&1)
			RESULT_LOG2=$(cat /etc/httpd/conf/httpd.conf 2>&1)
		fi
	else
		RESULT='MANUAL'
		RESULT_MSG="KB-AU-AP-M-01"
		RESULT_LOG="/etc/httpd/conf/httpd.conf NO FILE"
		RESULT_LOG2=$(cat /etc/httpd/conf/httpd.conf 2>&1)
	fi
else
	RESULT='YES'
	RESULT_MSG="KB-AU-AP-Y-01"
	RESULT_LOG="Apache Service is not running"
	RESULT_LOG2="Apache Service is not running"
fi

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='NO VALUE'
fi

echo "$RESULT" > $BingoDIR/56.result
echo "$RESULT_MSG" > $BingoDIR/56.msg
echo "$LOG_SECTION" > $BingoDIR/56.log
echo "$RESULT_LOG" >> $BingoDIR/56.log
echo "$LOG_ALL" >> $BingoDIR/56.log
echo "$RESULT_LOG2" >> $BingoDIR/56.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
# 56 end

# 57 start
#================================================================================***func57***
# U-57 Apache 파일 업로드 및 다운로드 제한
# 파일 업로드 및 다운로드의 사이즈 제한 여부 점검
echo "KB-AU-57" > $BingoDIR/57.title

RESULT='YES'

if [ `ps -ef | grep -w httpd | grep -v grep | wc -l` -ge 1 ] || [ `ps -ef | grep -i apache | grep -v grep | wc -l` -ge 1 ]
then
	if [ -f /etc/httpd/conf/httpd.conf ]
	then
        if [ `cat /etc/httpd/conf/httpd.conf | grep -iw "/Directory" | grep -v "^ *#" | wc -l` == `cat /etc/httpd/conf/httpd.conf | grep -v "^ *#" | grep -iw "LimitRequestBody" | wc -l` ]
        then
            if [ `cat /etc/httpd/conf/httpd.conf | grep -v "^ *#" | grep -iw "LimitRequestBody" | awk '{ print $2 }' | awk '{if ($1 > 5000000) print $1}' | wc -l` -ge 1 ]
            then
                RESULT='NO'
                RESULT_MSG="KB-AU-57-N-01"
                RESULT_LOG=$(cat /etc/httpd/conf/httpd.conf | grep -iw "LimitRequestBody" 2>&1)
                RESULT_LOG2=$(cat /etc/httpd/conf/httpd.conf 2>&1)
            else
                RESULT='YES'
                RESULT_MSG="KB-AU-57-Y-01"
                RESULT_LOG=$(cat /etc/httpd/conf/httpd.conf | grep -iw "LimitRequestBody" 2>&1)
                RESULT_LOG2=$(cat /etc/httpd/conf/httpd.conf 2>&1)
            fi
        else
            RESULT='NO'
            RESULT_MSG="KB-AU-57-N-02"
            RESULT_LOG=$(cat /etc/httpd/conf/httpd.conf | grep -iw "LimitRequestBody" 2>&1)
            RESULT_LOG2=$(cat /etc/httpd/conf/httpd.conf 2>&1)
        fi
	else
		RESULT='MANUAL'
		RESULT_MSG="KB-AU-AP-M-01"
		RESULT_LOG="/etc/httpd/conf/httpd.conf NO FILE"
		RESULT_LOG2=$(cat /etc/httpd/conf/httpd.conf 2>&1)
	fi
else
    RESULT='YES'
	RESULT_MSG="KB-AU-AP-Y-01"
	RESULT_LOG="Apache Service is not running"
	RESULT_LOG2="Apache Service is not running"
fi

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='NO VALUE'
fi

echo "$RESULT" > $BingoDIR/57.result
echo "$RESULT_MSG" > $BingoDIR/57.msg
echo "$LOG_SECTION" > $BingoDIR/57.log
echo "$RESULT_LOG" >> $BingoDIR/57.log
echo "$LOG_ALL" >> $BingoDIR/57.log
echo "$RESULT_LOG2" >> $BingoDIR/57.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
# 57 end

# 58 start
#================================================================================***func58***
# U-58 Apache 웹 서비스 영역의 분리
# 웹 서버의 루트 디렉터리와 OS의 루트 디렉터리를 다르게 지정하였는지 점검
echo "KB-AU-58" > $BingoDIR/58.title

RESULT='YES'

if [ `ps -ef | grep -w httpd | grep -v grep | wc -l` -ge 1 ] || [ `ps -ef | grep -i apache | grep -v grep | wc -l` -ge 1 ]
then
	if [ -f /etc/httpd/conf/httpd.conf ]
	then
		if [ `cat /etc/httpd/conf/httpd.conf | grep -v "^ *#" | grep -i "DocumentRoot" | grep -iw "apache2/htdocs\|apache/htdocs\|www/html" | wc -l` -ge 1 ]
		then
			RESULT='NO'
			RESULT_MSG="KB-AU-58-N-01"
			RESULT_LOG=$(cat /etc/httpd/conf/httpd.conf | grep -i "DocumentRoot" | grep -v "^ *#" 2>&1)
			RESULT_LOG2=$(cat /etc/httpd/conf/httpd.conf 2>&1)
		else
			RESULT='YES'
			RESULT_MSG="KB-AU-58-Y-01"
			RESULT_LOG=$(cat /etc/httpd/conf/httpd.conf | grep -i "DocumentRoot" | grep -v "^ *#" 2>&1)
			RESULT_LOG2=$(cat /etc/httpd/conf/httpd.conf 2>&1)
		fi
	else
		RESULT='MANUAL'
		RESULT_MSG="KB-AU-AP-M-01"
		RESULT_LOG="/etc/httpd/conf/httpd.conf NO FILE"
		RESULT_LOG2=$(cat /etc/httpd/conf/httpd.conf 2>&1)
	fi
else
    RESULT='YES'
	RESULT_MSG="KB-AU-AP-Y-01"
	RESULT_LOG="Apache Service is not running"
	RESULT_LOG2="Apache Service is not running"
fi

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='NO VALUE'
fi

echo "$RESULT" > $BingoDIR/58.result
echo "$RESULT_MSG" > $BingoDIR/58.msg
echo "$LOG_SECTION" > $BingoDIR/58.log
echo "$RESULT_LOG" >> $BingoDIR/58.log
echo "$LOG_ALL" >> $BingoDIR/58.log
echo "$RESULT_LOG2" >> $BingoDIR/58.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
# 58 end

# 59 start
#================================================================================
# U-59 ssh 원격접속 허용
# 원격 접속 시 SSH 프로토콜을 사용하는지 점검
echo "KB-AU-59" > $BingoDIR/59.title

RESULT='YES'

if [ `ps -ef | grep -iw "sshd" | grep -v "grep" | wc -l` -ge 1  ]  
then
	RESULT='YES'
	RESULT_MSG="KB-AU-59-Y-01"
	RESULT_LOG=$(ps -ef | grep -iw "sshd" | grep -v "grep" 2>&1)
else
    RESULT='NO'
	RESULT_MSG="KB-AU-59-N-01"
	RESULT_LOG=$(ps -ef | grep -iw "sshd" | grep -v "grep" 2>&1)
fi

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='SSH Service is not running'
fi

echo "$RESULT" > $BingoDIR/59.result
echo "$RESULT_MSG" > $BingoDIR/59.msg
echo "$LOG_USE" > $BingoDIR/59.log
echo "$RESULT_LOG" >> $BingoDIR/59.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
# 59 end

# 60 start
#================================================================================
# U-60 FTP 서비스 확인
# FTP 서비스가 활성화 되어있는지 점검
echo "KB-AU-60" > $BingoDIR/60.title

RESULT='YES'

if [ `ps -ef | grep -iw "ftp" | grep -v "grep" | wc -l` -eq 0 ]
then
    if [ `ps -ef | grep -i "vsftpd\|proftpd" | grep -v "grep" | wc -l` -ge 1 ]
    then
    	RESULT='NO'
		RESULT_MSG="KB-AU-60-N-01"
		RESULT_LOG=$(ps -ef | grep -i "vsftpd\|proftpd" | grep -v "grep" 2>&1)
    else
        RESULT='YES'
		RESULT_MSG="KB-AU-60-Y-01"
		RESULT_LOG=$(ps -ef | grep -i "vsftpd\|proftpd" | grep -v "grep" 2>&1)
    fi
else
	RESULT='NO'
	RESULT_MSG="KB-AU-60-N-01"
	RESULT_LOG=$(ps -ef | grep -iw "ftp" | grep -v "grep" 2>&1)
fi

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='FTP Service is not running'
fi

echo "$RESULT" > $BingoDIR/60.result
echo "$RESULT_MSG" > $BingoDIR/60.msg
echo "$LOG_USE" > $BingoDIR/60.log
echo "$RESULT_LOG" >> $BingoDIR/60.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
# 60 end

# 61 start
#================================================================================
# U-61 ftp 계정 shell 제한
# FTP 기본 계정에 쉘 설정 여부 점검
echo "KB-AU-61" > $BingoDIR/61.title

RESULT='YES'

if [ `cat /etc/passwd | grep -iw "^ftp" | wc -l` -ge 1 ]
then
	if [ `cat /etc/passwd | grep -iw "ftp" | grep -v '^ *#' | awk -F: '{ print $7 }'` == '/bin/false' ]
	then
		RESULT='YES'
		RESULT_MSG="KB-AU-61-Y-01"
		RESULT_LOG=$(cat /etc/passwd | grep -iw "ftp" 2>&1)
		RESULT_LOG2=$(cat /etc/passwd 2>&1)
	else
		RESULT='NO'
		RESULT_MSG="KB-AU-61-N-01"
		RESULT_LOG=$(cat /etc/passwd | grep -iw "ftp" 2>&1)
		RESULT_LOG2=$(cat /etc/passwd 2>&1)
	fi
else
	RESULT='YES'
	RESULT_MSG="KB-AU-61-Y-02"
	RESULT_LOG="FTP NO VALUE"
	RESULT_LOG2=$(cat /etc/passwd 2>&1)
fi

echo "$RESULT" > $BingoDIR/61.result
echo "$RESULT_MSG" > $BingoDIR/61.msg
echo "$LOG_SECTION" > $BingoDIR/61.log
echo "$RESULT_LOG" >> $BingoDIR/61.log
echo "$LOG_ALL" >> $BingoDIR/61.log
echo "$RESULT_LOG2" >> $BingoDIR/61.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
# 61 end

# 62 start
#================================================================================***func62***
# U-62 ftpusers파일 소유자 및 권한 설정
# FTP 접근제어 설정파일에 관리자 외 비인가자들이 수정 제한 여부 점검
echo "KB-AU-62" > $BingoDIR/62.title

echo "YES" > $BingoDIR/62.result

echo "" > $BingoDIR/62.msg

echo "$LOG_PERMISSION" > $BingoDIR/62.log

if [ `ps -ef | grep -iw "ftp" | grep -v "grep" | wc -l` -ge 1 ]
then
	if [ -f /etc/ftpusers ]
	then
		if [ `ls -al /etc/ftpusers | cut -c 5-10` == 'r-----' ] || [ `ls -al /etc/ftpusers | cut -c 5-10` == '------' ]
		then
			if [ `ls -al /etc/ftpusers | cut -c 2-4` == 'rw-' ] || [ `ls -al /etc/ftpusers | cut -c 2-4` == 'r--' ] || [ `ls -al /etc/ftpusers | cut -c 2-4` == '---' ] || [ `ls -al /etc/ftpusers | cut -c 2-4` == '-w-' ]
			then
				echo "YES" >> $BingoDIR/62.result
                ls -al /etc/ftpusers >> $BingoDIR/62.log
			else
                echo "NO" >> $BingoDIR/62.result
                echo "KB-AU-62-N-01" >> $BingoDIR/62.msg
                ls -al /etc/ftpusers >> $BingoDIR/62.log
			fi
		else
			echo "NO" >> $BingoDIR/62.result
            echo "KB-AU-62-N-01" >> $BingoDIR/62.msg
            ls -al /etc/ftpusers >> $BingoDIR/62.log
		fi

        if [ `ls -al /etc/ftpusers | awk '{ print $3 }'` == 'root' ]
        then
            echo "YES" >> $BingoDIR/62.result
        else
            echo "NO" >> $BingoDIR/62.result
            echo "KB-AU-62-N-02" >> $BingoDIR/62.msg
        fi
	elif [ -f /etc/ftpd/ftpusers ]
    then
        if [ `ls -al /etc/ftpd/ftpusers | cut -c 5-10` == 'r-----' ] || [ `ls -al /etc/ftpd/ftpusers | cut -c 5-10` == '------' ]
        then
            if [ `ls -al /etc/ftpd/ftpusers | cut -c 2-4` == 'rw-' ] || [ `ls -al /etc/ftpd/ftpusers | cut -c 2-4` == 'r--' ] || [ `ls -al /etc/ftpd/ftpusers | cut -c 2-4` == '---' ] || [ `ls -al /etc/ftpd/ftpusers | cut -c 2-4` == '-w-' ]
            then 
                echo "YES" >> $BingoDIR/62.result
            else
                echo "NO" >> $BingoDIR/62.result
                echo "KB-AU-62-N-03" >> $BingoDIR/62.msg
                ls -al /etc/ftpd/ftpusers >> $BingoDIR/62.log
            fi
        else
            echo "NO" >> $BingoDIR/62.result
            echo "KB-AU-62-N-03" >> $BingoDIR/62.msg
            ls -al /etc/ftpd/ftpusers >> $BingoDIR/62.log
        fi

        if [ `ls -al /etc/ftpd/ftpusers | awk '{ print $3 }'` == 'root' ]
        then
            echo "YES" >> $BingoDIR/62.result
        else
            echo "NO" >> $BingoDIR/62.result
            echo "KB-AU-62-N-04" >> $BingoDIR/62.msg
        fi
	else 
        echo "MANUAL" >> $BingoDIR/62.result
        echo "KB-AU-62-M-01" >> $BingoDIR/62.msg
        echo "ftpusers NO FILE" >> $BingoDIR/62.log
    fi
else 
    echo "YES" >> $BingoDIR/62.result
    echo "FTP Service is not running" >> $BingoDIR/62.log
fi

#vsFTP
if [ `ps -ef | grep 'vsftp' | grep -v grep | wc -l` -ge 1 ]
then
    if [ -f /etc/vsftpd/ftpusers ]
    then
        if [ `ls -al /etc/vsftpd/ftpusers | cut -c 5-10` == 'r-----' ] || [ `ls -al /etc/vsftpd/ftpusers | cut -c 5-10` == '------' ]
        then
            if [ `ls -al /etc/vsftpd/ftpusers | cut -c 2-4` == 'rw-' ] || [ `ls -al /etc/vsftpd/ftpusers | cut -c 2-4` == 'r--' ] || [ `ls -al /etc/vsftpd/ftpusers | cut -c 2-4` == '---' ] || [ `ls -al /etc/vsftpd/ftpusers | cut -c 2-4` == '-w-' ]
            then
                echo "YES" >> $BingoDIR/62.result
                ls -al /etc/vsftpd/ftpusers >> $BingoDIR/62.log
            else 
                echo "NO" >> $BingoDIR/62.result
                echo "KB-AU-62-N-05" >> $BingoDIR/62.msg
                ls -al /etc/vsftpd/ftpusers >> $BingoDIR/62.log
            fi
        else
            echo "NO" >> $BingoDIR/62.result
            echo "KB-AU-62-N-05" >> $BingoDIR/62.msg
            ls -al /etc/vsftpd/ftpusers >> $BingoDIR/62.log
        fi
                
        if [ `ls -al /etc/vsftpd/ftpusers | awk '{ print $3 }'` == 'root' ]
        then
            echo "YES" >> $BingoDIR/62.result
        else
            echo "NO" >> $BingoDIR/62.result
            echo "KB-AU-62-N-06" >> $BingoDIR/62.msg
        fi

        if [ -f /etc/vsftpd/user_list ]
        then
            if [ `ls -al /etc/vsftpd/user_list | cut -c 5-10` == 'r-----' ] || [ `ls -al /etc/vsftpd/user_list | cut -c 5-10` == '------' ]
            then
                if [ `ls -al /etc/vsftpd/user_list | cut -c 2-4` == 'rw-' ] || [ `ls -al /etc/vsftpd/user_list | cut -c 2-4` == 'r--' ] || [ `ls -al /etc/vsftpd/user_list | cut -c 2-4` == '---' ] || [ `ls -al /etc/vsftpd/user_list | cut -c 2-4` == '-w-' ]
                then
                    echo "YES" >> $BingoDIR/62.result
                    ls -al /etc/vsftpd/user_list >> $BingoDIR/62.log
                else 
                    echo "NO" >> $BingoDIR/62.result
                    echo "KB-AU-62-N-07" >> $BingoDIR/62.msg
                    ls -al /etc/vsftpd/user_list >> $BingoDIR/62.log
                fi
            else 
                echo "NO" >> $BingoDIR/62.result
                echo "KB-AU-62-N-07" >> $BingoDIR/62.msg
                ls -al /etc/vsftpd/user_list >> $BingoDIR/62.log
            fi
            
            if [ `ls -al /etc/vsftpd/user_list | awk '{ print $3 }'` == 'root' ]
            then
                echo "YES" >> $BingoDIR/62.result
            else
                echo "NO" >> $BingoDIR/62.result
                echo "KB-AU-62-N-08" >> $BingoDIR/62.msg
            fi
        else
            echo "MANUAL" >> $BingoDIR/62.result
            echo "KB-AU-62-M-02" >> $BingoDIR/62.msg
            echo "/etc/vsftpd/user_list NO FILE" >> $BingoDIR/62.log        
        fi
    elif [ -f /etc/vsftpd.ftpusers ]
    then
        if [ `ls -al /etc/vsftpd.ftpusers | cut -c 5-10` == 'r-----' ] || [ `ls -al /etc/vsftpd.ftpusers | cut -c 5-10` == '------' ]
        then
            if [ `ls -al /etc/vsftpd.ftpusers | cut -c 2-4` == 'rw-' ] || [ `ls -al /etc/vsftpd.ftpusers | cut -c 2-4` == 'r--' ] || [ `ls -al /etc/vsftpd.ftpusers | cut -c 2-4` == '---' ] || [ `ls -al /etc/vsftpd.ftpusers | cut -c 2-4` == '-w-' ]
            then
                echo "YES" >> $BingoDIR/62.result
                ls -al /etc/vsftpd.ftpusers >> $BingoDIR/62.log
            else
                echo "NO" >> $BingoDIR/62.result
                echo "KB-AU-62-N-09" >> $BingoDIR/62.msg
                ls -al /etc/vsftpd.ftpusers >> $BingoDIR/62.log
            fi 
        else 
            echo "NO" >> $BingoDIR/62.result
            echo "KB-AU-62-N-09" >> $BingoDIR/62.msg
            ls -al /etc/vsftpd.ftpusers >> $BingoDIR/62.log
        fi

        if [ `ls -al /etc/vsftpd.ftpusers | awk '{ print $3 }'` == 'root' ]
        then
            echo "YES" >> $BingoDIR/62.result
        else
            echo "NO" >> $BingoDIR/62.result
            echo "KB-AU-62-N-10" >> $BingoDIR/62.msg
        fi

        if [ -f /etc/vsftpd.user_list ]
        then
            if [ `ls -al /etc/vsftpd.user_list | cut -c 5-10` == 'r-----' ] || [ `ls -al /etc/vsftpd.user_list | cut -c 5-10` == '------' ]
            then
                if [ `ls -al /etc/vsftpd.user_list | cut -c 2-4` == 'rw-' ] || [ `ls -al /etc/vsftpd.user_list | cut -c 2-4` == 'r--' ] || [ `ls -al /etc/vsftpd.user_list | cut -c 2-4` == '---' ] || [ `ls -al /etc/vsftpd.user_list | cut -c 2-4` == '-w-' ]
                then
                    echo "YES" >> $BingoDIR/62.result
                    ls -al /etc/vsftpd.user_list >> $BingoDIR/62.log
                else
                    echo "NO" >> $BingoDIR/62.result
                    echo "KB-AU-62-N-11" >> $BingoDIR/62.msg
                    ls -al /etc/vsftpd.user_list >> $BingoDIR/62.log
                fi
            else 
                echo "NO" >> $BingoDIR/62.result
                echo "KB-AU-62-N-11" >> $BingoDIR/62.msg
                ls -al /etc/vsftpd.user_list >> $BingoDIR/62.log
            fi

            if [ `ls -al /etc/vsftpd.user_list | awk '{ print $3 }'` == 'root' ]
            then
                echo "YES" >> $BingoDIR/62.result
            else
                echo "NO" >> $BingoDIR/62.result
                echo "KB-AU-62-N-12" >> $BingoDIR/62.msg
            fi
        else
            echo "MANUAL" >> $BingoDIR/62.result
            echo "KB-AU-62-M-03" >> $BingoDIR/62.msg
            echo "/etc/vsftpd.user_list NO FILE" >> $BingoDIR/62.log
        fi
    else
        echo "MANUAL" >> $BingoDIR/62.result
        echo "KB-AU-62-M-04" >> $BingoDIR/62.msg
        echo "vsftpd ftpusers NO FILE" >> $BingoDIR/62.log
    fi
else
    echo "YES" >> $BingoDIR/62.result
    echo "vsFTP Service is not running" >> $BingoDIR/62.log
fi

if [ `cat $BingoDIR/62.result | grep -i "MANUAL" | wc -l` -ge 1 ]
then 
    echo "MANUAL" > $BingoDIR/62.result
elif [ `cat $BingoDIR/62.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/62.result
else 
    echo "YES" > $BingoDIR/62.result
    echo "KB-AU-62-Y-01" > $BingoDIR/62.msg
fi

# 62 end

# 63 start
#================================================================================***func63***
# U-63 FTP 서비스 root 계정 접근제한
# FTP 서비스를 사용할 경우 ftpusers 파일 root 계정이 포함 여부 점검
echo "KB-AU-63" > $BingoDIR/63.title

echo "YES" > $BingoDIR/63.result

echo "" > $BingoDIR/63.msg

echo "$LOG_SECTION" > $BingoDIR/63.log

if [ `ps -ef | grep -iw "ftp" | grep -v "grep" | wc -l` -ge 1 ]
then
    if [ -f /etc/ftpusers ]
    then
        if [ `cat /etc/ftpusers | grep -iw 'root' | grep -v '^ *#' | wc -l` -ge 1 ]
        then
            echo "YES" >> $BingoDIR/63.result
            echo "------------------------------" >> $BingoDIR/63.log
            echo "File: /etc/ftpusers" >> $BingoDIR/63.log
            echo "------------------------------" >> $BingoDIR/63.log
            cat /etc/ftpusers | grep -iw 'root' >> $BingoDIR/63.log
        else
            echo "NO" >> $BingoDIR/63.result
            echo "KB-AU-63-N-01" >> $BingoDIR/63.msg
            echo "------------------------------" >> $BingoDIR/63.log
            echo "File: /etc/ftpusers" >> $BingoDIR/63.log
            echo "------------------------------" >> $BingoDIR/63.log
            cat /etc/ftpusers | grep -iw 'root' | grep -v '^ *#' >> $BingoDIR/63.log
        fi
    elif [ -f /etc/ftpd/ftpusers ]
    then
        if [ `cat /etc/ftpd/ftpusers | grep -iw 'root' | grep -v '^ *#' | wc -l` -ge 1 ]
        then
            echo "YES" >> $BingoDIR/63.result
            echo "------------------------------" >> $BingoDIR/63.log
            echo "File: /etc/ftpd/ftpuserss" >> $BingoDIR/63.log
            echo "------------------------------" >> $BingoDIR/63.log
            cat /etc/ftpd/ftpusers | grep -iw 'root' >> $BingoDIR/63.log
        else
            echo "NO" >> $BingoDIR/63.result
            echo "KB-AU-63-N-02" >> $BingoDIR/63.msg
            echo "------------------------------" >> $BingoDIR/63.log
            echo "File: /etc/ftpd/ftpusers" >> $BingoDIR/63.log
            echo "------------------------------" >> $BingoDIR/63.log
            cat /etc/ftpd/ftpusers | grep -iw 'root' | grep -v '^ *#' >> $BingoDIR/63.log
        fi
    else 
        echo "MANUAL" >> $BingoDIR/63.result
        echo "KB-AU-63-M-01" >> $BingoDIR/63.msg
        echo "ftpusers NO FILE" >> $BingoDIR/63.log
    fi
else
    echo "YES" >> $BingoDIR/63.result
    echo "FTP Service is not running" >> $BingoDIR/63.log
fi

#ProFTP
if [ `ps -ef | grep 'proftpd' | grep -v grep | wc -l` -ge 1 ]
then
    if [ -f /etc/proftpd.conf ]
    then
        if [ `cat /etc/proftpd.conf | grep -i rootlogin | grep -i off | grep -v '^ *#' | wc -l` -ge 1 ]
        then
            echo "YES" >> $BingoDIR/63.result
            echo "------------------------------" >> $BingoDIR/63.log
            echo "File: /etc/proftpd.conf" >> $BingoDIR/63.log
            echo "------------------------------" >> $BingoDIR/63.log
            cat /etc/proftpd.conf | grep -i rootlogin | grep -v '^ *#' >> $BingoDIR/63.log
        else
            echo "NO" >> $BingoDIR/63.result
            echo "KB-AU-63-N-03" >> $BingoDIR/63.msg
            echo "------------------------------" >> $BingoDIR/63.log
            echo "File: /etc/proftpd.conf" >> $BingoDIR/63.log
            echo "------------------------------" >> $BingoDIR/63.log
            cat /etc/proftpd.conf | grep -i rootlogin >> $BingoDIR/63.log
        fi
    else
        echo "MANUAL" >> $BingoDIR/63.result
        echo "KB-AU-63-M-02" >> $BingoDIR/63.msg
        echo "/etc/proftpd.conf NO FILE" >> $BingoDIR/63.log
    fi
else
    echo "YES" >> $BingoDIR/63.result
    echo "ProFTP Service is not running" >> $BingoDIR/63.log
fi

#vsFTP
if [ `ps -ef | grep 'vsftp' | grep -v grep | wc -l` -ge 1 ]
then
    if [ -f /etc/vsftpd/ftpusers ]
    then
        if [ `cat /etc/vsftpd/ftpusers | grep -iw 'root' | grep -v '^ *#' | wc -l` -ge 1 ]
        then
            echo "YES" >> $BingoDIR/63.result
            echo "------------------------------" >> $BingoDIR/63.log
            echo "File: /etc/vsftpd/ftpusers" >> $BingoDIR/63.log
            echo "------------------------------" >> $BingoDIR/63.log
            cat /etc/vsftpd/ftpusers | grep -iw 'root' >> $BingoDIR/63.log
        else
            echo "NO" >> $BingoDIR/63.result
            echo "KB-AU-63-N-04" >> $BingoDIR/63.msg
            echo "------------------------------" >> $BingoDIR/63.log
            echo "File: /etc/vsftpd/ftpusers" >> $BingoDIR/63.log
            echo "------------------------------" >> $BingoDIR/63.log
            cat /etc/vsftpd/ftpusers | grep -iw 'root' | grep -v '^ *#' >> $BingoDIR/63.log
        fi
    else
        echo "MANUAL" >> $BingoDIR/63.result
        echo "KB-AU-63-M-03" >> $BingoDIR/63.msg
        echo "/etc/vsftpd/ftpusers NO FILE" >> $BingoDIR/63.log
    fi

    if [ -f /etc/vsftpd/user_list ]
    then
        if [ `cat /etc/vsftpd/user_list | grep -iw 'root' | grep -v '^ *#' | wc -l` -ge 1 ]
        then
            echo "YES" >> $BingoDIR/63.result
            echo "------------------------------" >> $BingoDIR/63.log
            echo "File: /etc/vsftpd/user_list" >> $BingoDIR/63.log
            echo "------------------------------" >> $BingoDIR/63.log
            cat /etc/vsftpd/user_list | grep -iw 'root' >> $BingoDIR/63.log
        else
            echo "NO" >> $BingoDIR/63.result
            echo "KB-AU-63-N-05" >> $BingoDIR/63.msg
            echo "------------------------------" >> $BingoDIR/63.log
            echo "File: /etc/vsftpd/user_list" >> $BingoDIR/63.log
            echo "------------------------------" >> $BingoDIR/63.log
            cat /etc/vsftpd/user_list | grep -iw 'root' | grep -v '^ *#' >> $BingoDIR/63.log
        fi
    else
        echo "MANUAL" >> $BingoDIR/63.result
        echo "KB-AU-63-M-04" >> $BingoDIR/63.msg
        echo "/etc/vsftpd/user_list NO FILE" >> $BingoDIR/63.log
    fi
else
    echo "YES" >> $BingoDIR/63.result
    echo "vsFTP Service is not running" >> $BingoDIR/63.log
fi

if [ `cat $BingoDIR/63.result | grep -i "MANUAL" | wc -l` -ge 1 ]
then 
    echo "MANUAL" > $BingoDIR/63.result
elif [ `cat $BingoDIR/63.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/63.result
else 
    echo "YES" > $BingoDIR/63.result
    echo "KB-AU-63-Y-01" > $BingoDIR/63.msg
fi

# 전체 파일 출력
echo "$LOG_ALL" >> $BingoDIR/63.log
if [ -f /etc/ftpusers ]
then
    echo "------------------------------" >> $BingoDIR/63.log
    echo "File: /etc/ftpusers" >> $BingoDIR/63.log
    echo "------------------------------" >> $BingoDIR/63.log
    cat /etc/ftpusers >> $BingoDIR/63.log
elif [ -f /etc/ftpd/ftpusers ]
then 
    echo "------------------------------" >> $BingoDIR/63.log
    echo "File: /etc/ftpd/ftpusers" >> $BingoDIR/63.log
    echo "------------------------------" >> $BingoDIR/63.log
    cat /etc/ftpd/ftpusers >> $BingoDIR/63.log
else 
    echo "------------------------------" >> $BingoDIR/63.log
    echo "File: ftpusers" >> $BingoDIR/63.log
    echo "------------------------------" >> $BingoDIR/63.log
    echo "NO FILE" >> $BingoDIR/63.log
fi

if [ -f /etc/proftpd.conf ]
then
    echo "------------------------------" >> $BingoDIR/63.log
    echo "File: /etc/proftpd.conf" >> $BingoDIR/63.log
    echo "------------------------------" >> $BingoDIR/63.log
    cat /etc/proftpd.conf >> $BingoDIR/63.log
else 
    echo "------------------------------" >> $BingoDIR/63.log
    echo "File: /etc/proftpd.conf" >> $BingoDIR/63.log
    echo "------------------------------" >> $BingoDIR/63.log
    echo "NO FILE" >> $BingoDIR/63.log
fi

if [ -f /etc/vsftpd/ftpusers ]
then
    echo "------------------------------" >> $BingoDIR/63.log
    echo "File: /etc/vsftpd/ftpusers" >> $BingoDIR/63.log
    echo "------------------------------" >> $BingoDIR/63.log
    cat /etc/vsftpd/ftpusers >> $BingoDIR/63.log
else 
    echo "------------------------------" >> $BingoDIR/63.log
    echo "File: /etc/vsftpd/ftpusers" >> $BingoDIR/63.log
    echo "------------------------------" >> $BingoDIR/63.log
    echo "NO FILE" >> $BingoDIR/63.log
fi

if [ -f /etc/vsftpd/user_list ]
then
    echo "------------------------------" >> $BingoDIR/63.log
    echo "File: /etc/vsftpd/user_list" >> $BingoDIR/63.log
    echo "------------------------------" >> $BingoDIR/63.log
    cat /etc/vsftpd/user_list >> $BingoDIR/63.log
else 
    echo "------------------------------" >> $BingoDIR/63.log
    echo "File: /etc/vsftpd/user_list" >> $BingoDIR/63.log
    echo "------------------------------" >> $BingoDIR/63.log
    echo "NO FILE" >> $BingoDIR/63.log
fi

# 63 end

# 64 start
#================================================================================
# U-64 at 서비스 권한 설정
# 관리자(root)만 at.allomw파일과 at.deny 파일을 제어할 수 있는지 점검
echo "KB-AU-64" > $BingoDIR/64.title

echo "YES" > $BingoDIR/64.result

echo "" > $BingoDIR/64.msg

echo "$LOG_PERMISSION" > $BingoDIR/64.log

if [ -f /etc/at.allow ] && [ -f /etc/at.deny ] && [ -f /usr/bin/at ]
then
    if [ `ls -al /usr/bin/at | cut -c 5-7` == 'r-x' ] || [ `ls -al /usr/bin/at | cut -c 5-7` == 'r--' ] || [ `ls -al /usr/bin/at | cut -c 5-7` == '--x' ] || [ `ls -al /usr/bin/at | cut -c 5-7` == '---' ]
    then
        if [ `ls -al /usr/bin/at | cut -c 8-10` != '---' ]
        then
            echo "NO" >> $BingoDIR/64.result
            echo "KB-AU-64-N-01" >> $BingoDIR/64.msg
            ls -al /usr/bin/at >> $BingoDIR/64.log
        else
            echo "YES" >> $BingoDIR/64.result
            echo "KB-AU-64-Y-01" >> $BingoDIR/64.msg
            ls -al /usr/bin/at >> $BingoDIR/64.log
        fi
    else 
        echo "NO" >> $BingoDIR/64.result
        echo "KB-AU-64-N-01" >> $BingoDIR/64.msg
        ls -al /usr/bin/at >> $BingoDIR/64.log
    fi

    if [ `ls -al /usr/bin/at | awk '{ print $3 }'` == 'root' ]
    then
        echo "YES" >> $BingoDIR/64.result
        echo "KB-AU-64-Y-01" >> $BingoDIR/64.msg
    else
        echo "NO" >> $BingoDIR/64.result
        echo "KB-AU-64-N-02" >> $BingoDIR/64.msg
    fi

    if [ `ls -al /etc/at.deny | cut -c 2-4` == 'rw-' ] || [ `ls -al /etc/at.deny | cut -c 2-4` == 'r--' ] || [ `ls -al /etc/at.deny | cut -c 2-4` == '---' ] || [ `ls -al /etc/at.deny | cut -c 2-4` == '-w-' ]
    then
        if [ `ls -al /etc/at.deny | cut -c 5-10` == 'r-----' ] || [ `ls -al /etc/at.deny | cut -c 5-10` == '------' ]
        then
            echo "YES" >> $BingoDIR/64.result
            echo "KB-AU-64-Y-01" >> $BingoDIR/64.msg
            ls -al /etc/at.deny >> $BingoDIR/64.msg
        else
            echo "NO" >> $BingoDIR/64.result
            echo "KB-AU-64-N-03" >> $BingoDIR/64.msg
            ls -al /etc/at.deny >> $BingoDIR/64.log
        fi
    else 
        echo "NO" >> $BingoDIR/64.result
        echo "KB-AU-64-N-03" >> $BingoDIR/64.msg
        ls -al /etc/at.deny >> $BingoDIR/64.log
    fi

    if [ `ls -al /etc/at.deny | awk '{ print $3 }'` == 'root' ]
    then
        echo "YES" >> $BingoDIR/64.result
        echo "KB-AU-64-Y-01" >> $BingoDIR/64.msg
    else
        echo "NO" >> $BingoDIR/64.result
        echo "KB-AU-64-N-04" >> $BingoDIR/64.msg
    fi

    if [ `ls -al /etc/at.allow | cut -c 5-10` == 'r-----' ] || [ `ls -al /etc/at.allow | cut -c 5-10` == '------' ]
    then
        if [ `ls -al /etc/at.allow | cut -c 2-4` == 'rw-' ] || [ `ls -al /etc/at.allow | cut -c 2-4` == 'r--' ] || [ `ls -al /etc/at.allow | cut -c 2-4` == '---' ] || [ `ls -al /etc/at.allow | cut -c 2-4` == '-w-' ]
        then
            echo "YES" >> $BingoDIR/64.result
            echo "KB-AU-64-Y-01" >> $BingoDIR/64.msg
            ls -al /etc/at.allow >> $BingoDIR/64.log
        else
            echo "NO" >> $BingoDIR/64.result
            echo "KB-AU-64-N-05" >> $BingoDIR/64.msg
            ls -al /etc/at.allow >> $BingoDIR/64.log
        fi
    else
        echo "NO" >> $BingoDIR/64.result
        echo "KB-AU-64-N-05" >> $BingoDIR/64.msg
        ls -al /etc/at.allow >> $BingoDIR/64.log
    fi

    if [ `ls -al /etc/at.allow | awk '{ print $3 }'` == 'root' ]
    then
        echo "YES" >> $BingoDIR/64.result
        echo "KB-AU-64-Y-01" >> $BingoDIR/64.msg
    else
        echo "NO" >> $BingoDIR/64.result
        echo "KB-AU-64-N-06" >> $BingoDIR/64.msg
    fi
else

    echo "YES" >> $BingoDIR/64.result
    echo "KB-AU-64-Y-02" >> $BingoDIR/64.msg

    if [ ! -f /etc/at.allow ]
    then
        echo "at.allow NO FILE" >> $BingoDIR/64.log
    fi

    if [ ! -f /etc/at.deny ]
    then
        echo "at.deny NO FILE" >> $BingoDIR/64.log
    fi

    if [ ! -f /usr/bin/at ]
    then
        echo "/usr/bin/at NO FILE" >> $BingoDIR/64.log
    fi
fi

at -l > /dev/null 2>&1
if [ $? = 0 ]
then
    echo "[at schedule list]" >> $BingoDIR/64.log
    at -l >> $BingoDIR/64.log 2>&1
fi

if [ `cat $BingoDIR/64.result | grep -i "MANUAL" | wc -l` -ge 1 ]
then 
    echo "MANUAL" > $BingoDIR/64.result
elif [ `cat $BingoDIR/64.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/64.result
    sed -i '/Y-/d' $BingoDIR/64.msg
else 
    echo "YES" > $BingoDIR/64.result
fi

# 64 end

# 65 start
#================================================================================
# U-65 SNMP 서비스 구동 점검
# SNMP 서비스 활성화 여부 점검 (SNMP 서비스 구동 점검)
echo "KB-AU-65" > $BingoDIR/65.title

RESULT='YES'

if [ `ps -ef | grep snmp | grep -v "grep" | wc -l` -eq 0 ]
then
    RESULT='YES'
	RESULT_MSG="KB-AU-65-Y-01"
	RESULT_LOG=$(ps -ef | grep 'snmp' | grep -v "grep" 2>&1)
else
    RESULT='NO'
	RESULT_MSG="KB-AU-65-N-01"
	RESULT_LOG=$(ps -ef | grep 'snmp' | grep -v "grep" 2>&1)
fi

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='SNMP Service is not running'
fi

echo "$RESULT" > $BingoDIR/65.result
echo "$RESULT_MSG" > $BingoDIR/65.msg
echo "$LOG_USE" > $BingoDIR/65.log
echo "$RESULT_LOG" >> $BingoDIR/65.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
# 65 end

# 66 start
#================================================================================
# U-66 SNMP 서비스 CommunityString의 복잡성 설정
# SNMP Community String 복잡성 설정 여부 점검
echo "KB-AU-66" > $BingoDIR/66.title

RESULT='YES'

if [ `ps -ef | grep snmp | grep -v "grep" | wc -l` -ge 1 ]
then
    if [ -f /etc/snmp/snmpd.conf ]
    then
        if [ `cat /etc/snmp/snmpd.conf | grep -i 'default' | grep -i "public\|private" | grep -v "^ *#" | wc -l ` -eq 0 ]
        then
            RESULT='YES'
            RESULT_MSG="KB-AU-66-Y-01"
            RESULT_LOG=$(cat /etc/snmp/snmpd.conf | grep -i 'default' | grep -i "public\|private" | grep -v "^ *#" 2>&1)
            RESULT_LOG2=$(cat /etc/snmp/snmpd.conf 2>&1)
        else
            RESULT='NO'
            RESULT_MSG="KB-AU-66-N-01"
            RESULT_LOG=$(cat /etc/snmp/snmpd.conf | grep -i 'default' | grep -i "public\|private" | grep -v "^ *#" 2>&1)
            RESULT_LOG2=$(cat /etc/snmp/snmpd.conf 2>&1)
        fi
    else
        RESULT='MANUAL'
        RESULT_MSG="KB-AU-66-M-01"
        RESULT_LOG="/etc/snmp/snmpd.conf NO FILE"
        RESULT_LOG2=$(cat /etc/snmp/snmpd.conf 2>&1)
    fi
else 
    RESULT='YES'
    RESULT_MSG="KB-AU-66-Y-02"
    RESULT_LOG="SNMP Service is not running"
	RESULT_LOG2="SNMP Service is not running"
fi

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='NO VALUE'
fi

echo "$RESULT" > $BingoDIR/66.result
echo "$RESULT_MSG" > $BingoDIR/66.msg
echo "$LOG_SECTION" > $BingoDIR/66.log
echo "$RESULT_LOG" >> $BingoDIR/66.log
echo "$LOG_ALL" >> $BingoDIR/66.log
echo "$RESULT_LOG2" >> $BingoDIR/66.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
# 66 end

# 67 start
#================================================================================
# U-67 로그온시 경고 메시지 제공
# 서버 및 서비스에 로그온 시 불필요한 정보 차단 설정 및 불법적인 사용에 대한 경고 메시지 출력 여부 점검
echo "KB-AU-67" > $BingoDIR/67.title

echo "YES" > $BingoDIR/67.result

echo "" > $BingoDIR/67.msg

echo "$LOG_SECTION" > $BingoDIR/67.log

if [ -f /etc/issue.net ]
then
    if [ `cat /etc/issue.net | grep -v -e ^$ | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/67.result
        echo "------------------------------" >> $BingoDIR/67.log
        echo "File: /etc/issue.net" >> $BingoDIR/67.log
        echo "------------------------------" >> $BingoDIR/67.log
        cat /etc/issue.net >> $BingoDIR/67.log
    else
        echo "NO" >> $BingoDIR/67.result
        echo "KB-AU-67-N-01" >> $BingoDIR/67.msg
        echo "------------------------------" >> $BingoDIR/67.log
        echo "File: /etc/issue.net" >> $BingoDIR/67.log
        echo "------------------------------" >> $BingoDIR/67.log
        cat /etc/issue.net >> $BingoDIR/67.log
    fi
else
	echo "MANUAL" >> $BingoDIR/67.result
    echo "KB-AU-67-M-01" >> $BingoDIR/67.msg
    echo "------------------------------" >> $BingoDIR/67.log
    echo "File: /etc/issue.net" >> $BingoDIR/67.log
    echo "------------------------------" >> $BingoDIR/67.log
    echo "/etc/issue.net NO FILE" >> $BingoDIR/67.log
fi

if [ -f /etc/motd ]
then
    if [ `cat /etc/motd | grep -v -e ^$ | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/67.result
        echo "------------------------------" >> $BingoDIR/67.log
        echo "File: /etc/motd" >> $BingoDIR/67.log
        echo "------------------------------" >> $BingoDIR/67.log
        cat /etc/motd >> $BingoDIR/67.log
    else
        echo "NO" >> $BingoDIR/67.result
        echo "KB-AU-67-N-02" >> $BingoDIR/67.msg
        echo "------------------------------" >> $BingoDIR/67.log
        echo "File: /etc/motd" >> $BingoDIR/67.log
        echo "------------------------------" >> $BingoDIR/67.log
        cat /etc/motd >> $BingoDIR/67.log
    fi
else
    echo "MANUAL" >> $BingoDIR/67.result
    echo "KB-AU-67-M-02" >> $BingoDIR/67.msg
    echo "------------------------------" >> $BingoDIR/67.log
    echo "File: /etc/motd" >> $BingoDIR/67.log
    echo "------------------------------" >> $BingoDIR/67.log
    echo "/etc/motd NO FILE" >> $BingoDIR/67.log
fi

if [ `ps -ef | grep -i vsftpd | grep -v grep | wc -l` -ge 1 ]
then
    if [ -f /etc/vsftpd/vsftpd.conf ]
    then
        if [ `cat /etc/vsftpd/vsftpd.conf | grep -i "ftpd_banner" | grep -v "^ *#" | wc -l` -ge 1 ]
        then
            echo "YES" >> $BingoDIR/67.result
            echo "------------------------------" >> $BingoDIR/67.log
            echo "File: /etc/vsftpd/vsftpd.conf" >> $BingoDIR/67.log
            echo "------------------------------" >> $BingoDIR/67.log
            cat /etc/vsftpd/vsftpd.conf | grep -i "ftpd_banner" | grep -v "^ *#" >> $BingoDIR/67.log
        else
            echo "NO" >> $BingoDIR/67.result
            echo "KB-AU-67-N-03" >> $BingoDIR/67.msg
            echo "------------------------------" >> $BingoDIR/67.log
            echo "File: /etc/vsftpd/vsftpd.conf" >> $BingoDIR/67.log
            echo "------------------------------" >> $BingoDIR/67.log
            cat /etc/vsftpd/vsftpd.conf | grep -i "ftpd_banner" >> $BingoDIR/67.log
        fi
    else
        echo "MANUAL" >> $BingoDIR/67.result
        echo "KB-AU-67-M-03" >> $BingoDIR/67.msg
        echo "------------------------------" >> $BingoDIR/67.log
        echo "File: /etc/vsftpd/vsftpd.conf" >> $BingoDIR/67.log
        echo "------------------------------" >> $BingoDIR/67.log
        echo "/etc/vsftpd/vsftpd.conf NO FILE" >> $BingoDIR/67.log
    fi
else
    echo "YES" >> $BingoDIR/67.result
    echo "KB-AU-67-Y-01" >> $BingoDIR/67.msg
    echo "------------------------------" >> $BingoDIR/67.log
    echo "File: /etc/vsftpd/vsftpd.conf" >> $BingoDIR/67.log
    echo "------------------------------" >> $BingoDIR/67.log
    echo "vsftpd Service is not running" >> $BingoDIR/67.log
fi

if [ `ps -ef | grep sendmail | grep -v grep | wc -l` -ge 1 ]
then
    if [ -f /etc/mail/sendmail.cf ]
    then
        if [ `cat /etc/mail/sendmail.cf | grep -i "GreetingMessage" | grep -v "^ *#" | wc -l` -ge 1 ]
        then
            echo "YES" >> $BingoDIR/67.result
            echo "------------------------------" >> $BingoDIR/67.log
            echo "File: /etc/mail/sendmail.cf" >> $BingoDIR/67.log
            echo "------------------------------" >> $BingoDIR/67.log
            cat /etc/mail/sendmail.cf | grep -i "GreetingMessage" | grep -v "^ *#" >> $BingoDIR/67.log
        else
            echo "NO" >> $BingoDIR/67.result
            echo "KB-AU-67-N-04" >> $BingoDIR/67.msg
            echo "------------------------------" >> $BingoDIR/67.log
            echo "File: /etc/mail/sendmail.cf" >> $BingoDIR/67.log
            echo "------------------------------" >> $BingoDIR/67.log
            cat /etc/mail/sendmail.cf | grep -i "GreetingMessage" >> $BingoDIR/67.log
        fi
   else
        echo "MANUAL" >> $BingoDIR/67.result
        echo "KB-AU-67-M-04" >> $BingoDIR/67.msg
        echo "------------------------------" >> $BingoDIR/67.log
        echo "File: /etc/mail/sendmail.cf" >> $BingoDIR/67.log
        echo "------------------------------" >> $BingoDIR/67.log
        echo "/etc/mail/sendmail.cf NO FILE" >> $BingoDIR/67.log
    fi
else
    echo "YES" >> $BingoDIR/67.result
    echo "KB-AU-67-Y-02" >> $BingoDIR/67.msg
    echo "------------------------------" >> $BingoDIR/67.log
    echo "File: /etc/mail/sendmail.cf" >> $BingoDIR/67.log
    echo "------------------------------" >> $BingoDIR/67.log
    echo "sendmail Service is not running" >> $BingoDIR/67.log
fi

if [ `cat $BingoDIR/67.result | grep -i "MANUAL" | wc -l` -ge 1 ]
then 
    echo "MANUAL" > $BingoDIR/67.result
elif [ `cat $BingoDIR/67.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/67.result
else 
    echo "YES" > $BingoDIR/67.result
    echo "KB-AU-67-Y-03" >> $BingoDIR/67.msg
fi

# 전체 파일 출력
echo "$LOG_ALL" >> $BingoDIR/67.log
if [ -f /etc/issue.net ]
then
    echo "------------------------------" >> $BingoDIR/67.log
    echo "File: /etc/issue.net" >> $BingoDIR/67.log
    echo "------------------------------" >> $BingoDIR/67.log
    cat /etc/issue.net >> $BingoDIR/67.log
else
    echo "------------------------------" >> $BingoDIR/67.log
    echo "File: /etc/issue.net" >> $BingoDIR/67.log
    echo "------------------------------" >> $BingoDIR/67.log
    echo "NO FILE" >> $BingoDIR/67.log
fi

if [ -f /etc/motd ]
then
    echo "------------------------------" >> $BingoDIR/67.log
    echo "File: /etc/motd" >> $BingoDIR/67.log
    echo "------------------------------" >> $BingoDIR/67.log
    cat /etc/motd >> $BingoDIR/67.log
else
    echo "------------------------------" >> $BingoDIR/67.log
    echo "File: /etc/motd" >> $BingoDIR/67.log
    echo "------------------------------" >> $BingoDIR/67.log
    echo "NO FILE" >> $BingoDIR/67.log
fi

if [ -f /etc/vsftpd/vsftpd.conf ]
then
    echo "------------------------------" >> $BingoDIR/67.log
    echo "File: /etc/vsftpd/vsftpd.conf" >> $BingoDIR/67.log
    echo "------------------------------" >> $BingoDIR/67.log
    cat /etc/vsftpd/vsftpd.conf >> $BingoDIR/67.log
else 
    echo "------------------------------" >> $BingoDIR/67.log
    echo "File: /etc/vsftpd/vsftpd.conf" >> $BingoDIR/67.log
    echo "------------------------------" >> $BingoDIR/67.log
    echo "NO FILE" >> $BingoDIR/67.log
fi

if [ -f /etc/mail/sendmail.cf ]
then
    echo "------------------------------" >> $BingoDIR/67.log
    echo "File: /etc/mail/sendmail.cf" >> $BingoDIR/67.log
    echo "------------------------------" >> $BingoDIR/67.log
    cat /etc/mail/sendmail.cf >> $BingoDIR/67.log
else 
    echo "------------------------------" >> $BingoDIR/67.log
    echo "File: /etc/mail/sendmail.cf" >> $BingoDIR/67.log
    echo "------------------------------" >> $BingoDIR/67.log
    echo "NO FILE" >> $BingoDIR/67.log
fi

if [ -f /etc/named.conf ]
then
    echo "------------------------------" >> $BingoDIR/67.log
    echo "File: /etc/named.conf" >> $BingoDIR/67.log
    echo "------------------------------" >> $BingoDIR/67.log
    cat /etc/named.conf >> $BingoDIR/67.log
else 
    echo "------------------------------" >> $BingoDIR/67.log
    echo "File: /etc/named.conf" >> $BingoDIR/67.log
    echo "------------------------------" >> $BingoDIR/67.log
    echo "NO FILE" >> $BingoDIR/67.log
fi

# 67 end

# 68 start
#================================================================================
# U-68 NFS설정파일 접근권한
# NFS 접근제어 설정파일에 대한 비인가자들의 수정 제한 여부 점검
echo "KB-AU-68" > $BingoDIR/68.title

echo "YES" > $BingoDIR/68.result

echo "" > $BingoDIR/68.msg

echo "$LOG_PERMISSION" > $BingoDIR/68.log

if [ `ps -ef | grep -i nfs | grep -v grep | wc -l` -ge 1 ]
then
	if [ -f /etc/exports ]
	then
		if [ `ls -al /etc/exports | cut -c 2-4` == 'rw-' ] || [ `ls -al /etc/exports | cut -c 2-4` == 'r--' ] || [ `ls -al /etc/exports | cut -c 2-4` == '---' ] || [ `ls -al /etc/exports | cut -c 2-4` == '-w-' ]
        then
            if [ `ls -al /etc/exports | cut -c 5-7` == 'r--' ] || [ `ls -al /etc/exports | cut -c 5-7` == '---' ]
            then
                if [ `ls -al /etc/exports | cut -c 8-10` == 'r--' ] || [ `ls -al /etc/exports | cut -c 8-10` == '---' ]
                then
                    echo "YES" >> $BingoDIR/68.result
                    ls -al /etc/exports >> $BingoDIR/68.log
                else
                    echo "NO" >> $BingoDIR/68.result
                    echo "KB-AU-68-N-01" >> $BingoDIR/68.msg
                    ls -al /etc/exports >> $BingoDIR/68.log
                fi
			else
                echo "NO" >> $BingoDIR/68.result
                echo "KB-AU-68-N-01" >> $BingoDIR/68.msg
                ls -al /etc/exports >> $BingoDIR/68.log
			fi
		else
            echo "NO" >> $BingoDIR/68.result
            echo "KB-AU-68-N-01" >> $BingoDIR/68.msg
            ls -al /etc/exports >> $BingoDIR/68.log
		fi
        
        if [ `ls -al /etc/exports | awk '{ print $3 }'` == 'root' ] 
        then
            echo "YES" >> $BingoDIR/68.result
        else
            echo "NO" >> $BingoDIR/68.result
            echo "KB-AU-68-N-02" >> $BingoDIR/68.msg
        fi
    else 
        echo "MANUAL" >> $BingoDIR/68.result
        echo "KB-AU-68-M-01" >> $BingoDIR/68.msg
        echo "/etc/exports NO FILE" >> $BingoDIR/68.log
    fi
else
    echo "YES2" >> $BingoDIR/68.result
    echo "KB-AU-68-Y-01" >> $BingoDIR/68.msg
    echo "NFS Service is not running" >> $BingoDIR/68.log
fi

if [ `cat $BingoDIR/68.result | grep -i "MANUAL" | wc -l` -ge 1 ]
then 
    echo "MANUAL" > $BingoDIR/68.result
elif [ `cat $BingoDIR/68.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/68.result
elif [ `cat $BingoDIR/68.result | grep -i "YES2" | wc -l` -ge 1 ]
then 
    echo "YES" > $BingoDIR/68.result
else 
    echo "YES" > $BingoDIR/68.result
    echo "KB-AU-68-Y-02" >> $BingoDIR/68.msg
fi

# 68 end

# 69 start
#================================================================================
# U-69 expn,vrfy 명령어 제한
# SMTP 서비스 사용 시 vrfy, expn 명령어 사용 금지 설정 여부 점검
echo "KB-AU-69" > $BingoDIR/69.title

RESULT='YES'

if [ `ps -ef | grep 'sendmail' | grep -v "grep" | wc -l` -ge 1 ]
then
	if [ -f /etc/mail/sendmail.cf ]
    then
        if [ `cat /etc/mail/sendmail.cf | grep -i PrivacyOptions  | grep -i "novrfy" | grep -i "noexpn" | grep -v "^ *#" | wc -l` -ge 1 ]
        then
	        RESULT='YES'
			RESULT_MSG="KB-AU-69-Y-01"
			RESULT_LOG=$(cat /etc/mail/sendmail.cf | grep -i PrivacyOptions  | grep -i "novrfy" | grep -i "noexpn" 2>&1)
			RESULT_LOG2=$(cat /etc/mail/sendmail.cf 2>&1)
        elif [ `cat /etc/mail/sendmail.cf | grep -i PrivacyOptions  | grep -i "goaway" | grep -v "^ *#" | wc -l` -ge 1 ]
		then
        	RESULT='YES'
			RESULT_MSG="KB-AU-69-Y-01"
			RESULT_LOG=$(cat /etc/mail/sendmail.cf | grep -i PrivacyOptions  | grep -i "goaway" 2>&1)
			RESULT_LOG2=$(cat /etc/mail/sendmail.cf 2>&1)
	    else
			RESULT='NO'
			RESULT_MSG="KB-AU-69-N-01"
			RESULT_LOG=$(cat /etc/mail/sendmail.cf | grep -i PrivacyOptions 2>&1)
			RESULT_LOG2=$(cat /etc/mail/sendmail.cf 2>&1)
	    fi
    else
        RESULT='MANUAL'
		RESULT_MSG="KB-AU-69-M-01"
		RESULT_LOG="/etc/mail/sendmail.cf NO FILE"
		RESULT_LOG2=$(cat /etc/mail/sendmail.cf 2>&1)
    fi
else
	RESULT='YES'
	RESULT_MSG="KB-AU-69-Y-01"
	RESULT_LOG="Sendmail Service is not running"
	RESULT_LOG2="Sendmail Service is not running"
fi

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='NO VALUE'
fi

echo "$RESULT" > $BingoDIR/69.result
echo "$RESULT_MSG" > $BingoDIR/69.msg
echo "$LOG_SECTION" > $BingoDIR/69.log
echo "$RESULT_LOG" >> $BingoDIR/69.log
echo "$LOG_ALL" >> $BingoDIR/69.log
echo "$RESULT_LOG2" >> $BingoDIR/69.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
# 69 end

# 70 start
#================================================================================
# U-70 Apache 웹 서비스 정보 숨김
# 웹페이지에서 오류발생 시 출력되는 메시지 내용 점검
echo "KB-AU-70" > $BingoDIR/70.title

RESULT='YES'

if [ `ps -ef | grep -w httpd | grep -v grep | wc -l` -ge 1 ] || [ `ps -ef | grep -i apache | grep -v grep | wc -l` -ge 1 ]
then
	if [ -f /etc/httpd/conf/httpd.conf ]
	then
		if [ `cat /etc/httpd/conf/httpd.conf | grep -iw servertokens | grep -iw Prod | wc -l` -eq 0 ]
		then
			RESULT='NO'
			RESULT_MSG="KB-AU-70-N-01"
			RESULT_LOG=$(cat /etc/httpd/conf/httpd.conf | grep -iw servertokens 2>&1)
			RESULT_LOG2=$(cat /etc/httpd/conf/httpd.conf 2>&1)
		else
			if [ `cat /etc/httpd/conf/httpd.conf | grep -i Serversignature | grep -i off | wc -l` -eq 0 ]
			then
				RESULT='NO'
				RESULT_MSG="KB-AU-70-N-02"
				RESULT_LOG=$(cat /etc/httpd/conf/httpd.conf | grep -i Serversignature 2>&1)
				RESULT_LOG2=$(cat /etc/httpd/conf/httpd.conf 2>&1)
			else
				RESULT='YES'
				RESULT_MSG="KB-AU-70-Y-01"
				RESULT_LOG=$(cat /etc/httpd/conf/httpd.conf | grep -i Serversignature 2>&1)
				RESULT_LOG2=$(cat /etc/httpd/conf/httpd.conf 2>&1)
			fi
		fi
	else
		RESULT='MANUAL'
		RESULT_MSG="KB-AU-AP-M-01"
		RESULT_LOG="/etc/httpd/conf/httpd.conf NO FILE"
		RESULT_LOG2=$(cat /etc/httpd/conf/httpd.conf 2>&1)
	fi   
else
    RESULT='YES'
	RESULT_MSG="KB-AU-AP-Y-01"
	RESULT_LOG="Apache Service is not running"
	RESULT_LOG2="Apache Service is not running"
fi

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='NO VALUE'
fi

echo "$RESULT" > $BingoDIR/70.result
echo "$RESULT_MSG" > $BingoDIR/70.msg
echo "$LOG_SECTION" > $BingoDIR/70.log
echo "$RESULT_LOG" >> $BingoDIR/70.log
echo "$LOG_ALL" >> $BingoDIR/70.log
echo "$RESULT_LOG2" >> $BingoDIR/70.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
unset RESULT_LOG2
# 70 end

# 71 start
#================================================================================
# U-71 최신 보안패치 및 권고사항 적용
# 시스템에서 최신 패치가 적용되어 있는지 점검
echo "KB-AU-71" > $BingoDIR/71.title

RESULT='MANUAL'
RESULT_MSG="KB-AU-71-M-01"

echo "$RESULT" > $BingoDIR/71.result
echo "$RESULT_MSG" > $BingoDIR/71.msg
echo "======================================================" > $BingoDIR/71.log
echo "Service Version" >> $BingoDIR/71.log
echo "======================================================" >> $BingoDIR/71.log

echo "" >> $BingoDIR/71.log

DEBCHK=$(cat /etc/os-release | grep -ic debian | awk '{ if ($1==0) print "other"; else print "debian" }')
if [ "$DEBCHK" = 'other' ]
then
        SUSECHK=$(cat /etc/os-release | grep -ic suse | awk '{ if ($1==0) print "other"; else print "opensuse" }')
        if [ "$SUSECHK" = 'other' ]
        then
                if [ -f /etc/system-release ]
                then
                        if [ "$(cat /etc/system-release | awk '{ print $1 }')" = 'Oracle' ]
                        then
                                MAIN_LINUX=Oracle
                        else
                                MAIN_LINUX=CentOS
                        fi
                else
                        MAIN_LINUX=CentOS
                fi
        else
                MAIN_LINUX=openSuSE
        fi
elif [ "$DEBCHK" = 'debian' ]
then
        MAIN_LINUX=Debian
fi

case $MAIN_LINUX in
    Debian)
    # DEBIAN VERSION CHECK
    if [ -f /etc/os-release ]
    then
        debOs=$(cat /etc/os-release | grep -i ^name | grep -ic debian | awk '{ if ($1==0) print "ubuntu"; else print "debian" }')
        case $debOs in
            debian)
                L="Debian"
                LV=$(cat /etc/debian_version)
            ;;

            ubuntu)
                L="Ubuntu"
                LV=$(lsb_release -a 2>&1 | grep -i ^Description | awk '{ print $3 }')
            ;;

            *)
            echo "Nothing"
            ;;
        esac
    fi
    ;;

    openSuSE)
    # OPENSUSE VERSION CHECK
    L=$(cat /etc/os-release  | grep -i ^name | awk -F"=" '{ print $2 }')
    LV=$(cat /etc/os-release | grep -i ^version_id | awk -F"=" '{ print $2 }' | sed 's/\"//g')
    ;;

	Oracle)
	L=`cat /etc/system-release | awk '{ print $1$2 }'`
	LV=`cat /etc/system-release | awk '{ print $5 }'`
    ;;
	
    CentOS)
	for var in `seq 1 15`
	do
		uname -r | cut -f$var -d '.' >> /tmp/MAINVER
	done

	if [ `cat /tmp/MAINVER | grep el | cut -c3` -ge 7 ]
	then
		L=`cat /etc/redhat-release | awk '{ print $1 }'`
		LV=`cat /etc/redhat-release | awk '{ print $4 }' | cut -c 1-3`
	else
		L=`cat /etc/redhat-release | awk '{ print $1 }'`
		LV=`cat /etc/redhat-release | awk '{ print $3 }'`
	fi
    ;;
    *)
    echo "Nothing"
    ;;
esac

echo "OS Version: `echo $L $LV`" >> $BingoDIR/71.log

echo "" >> $BingoDIR/71.log

if [ `ps -ef | grep -iw "sshd" | grep -v "grep" | wc -l` -ge 1  ]
then
    echo "SSH is ON" >> $BingoDIR/71.log
    SSH_V=$(ssh -V 2>&1)
    SSH_V2=$(echo $SSH_V | awk '{print $1}' | awk -F "," '{ print $1}' 2>&1)
    echo "SSH Version is: $SSH_V2" >> $BingoDIR/71.log
    unset SSH_V
    unset SSH_V2
else
    echo "SSH is OFF" >> $BingoDIR/71.log
fi

echo "" >> $BingoDIR/71.log

if [ `ps -ef | grep snmp | grep -v "grep" | wc -l` -eq 0 ]
then
    echo "SNMP is OFF" >> $BingoDIR/71.log
else
    echo "SNMP is ON" >> $BingoDIR/71.log
    SNMP_V=$(snmpwalk -v 2c -c community_string localhost system | grep SNMPv 2>&1)
    echo "SNMP Version is: $SNMP_V" >> $BingoDIR/71.log
    unset SNMP_V
fi

echo "" >> $BingoDIR/71.log

if [ `ps -ef | grep -iw "ftp" | grep -v "grep" | wc -l` -eq 0 ]
then
    echo "FTP is OFF" >> $BingoDIR/71.log
else
    echo "FTP is ON" >> $BingoDIR/71.log
fi

echo "" >> $BingoDIR/71.log

if [ `ps -ef | grep -i "proftpd" | grep -v "grep" | wc -l` -ge 1 ]
then
    echo "ProFTP is ON" >> $BingoDIR/71.log
    FTP_V=$(proftpd -v 2>&1)
    echo "ProFTP Version is: $FTP_V" >> $BingoDIR/71.log
    unset FTP_V
else
    echo "ProFTP is OFF" >> $BingoDIR/71.log
fi

echo "" >> $BingoDIR/71.log

SSL_V=$(openssl version 2>&1)
echo "openssl Version is: $SSL_V" >> $BingoDIR/71.log

echo "" >> $BingoDIR/71.log

if [ `ps -ef | grep sendmail | grep -v grep | wc -l` -ge 1 ]
then
    echo "sendmail is ON" >> $BingoDIR/71.log
    MAIL_V=$(sendmail -d0.4 -bv root | grep -i Version 2>&1)
    echo "sendmail Version is: $MAIL_V" >> $BingoDIR/71.log
    unset MAIL_V
else
    echo "sendmail is OFF" >> $BingoDIR/71.log
fi

unset MAIN_LINUX
unset L
unset LV
unset var

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
# 71 end

# 72 start
#================================================================================
# U-72 로그의 정기적 검토 및 보고
# 로그의 정기적 검토 및 보고 여부 점검
echo "KB-AU-72" > $BingoDIR/72.title

RESULT='MANUAL'
RESULT_MSG="KB-AU-72-M-01"
RESULT_LOG=$(echo "CONFIRM" 2>&1)

echo "$RESULT" > $BingoDIR/72.result
echo "$RESULT_MSG" > $BingoDIR/72.msg
echo "$RESULT_LOG" > $BingoDIR/72.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
# 72 end

# 73 start
#================================================================================
# U-73 정책에 따른 시스템 로깅 설정
# 내부 정책에 따른 시스템 로깅 설정 적용 여부 점검
echo "KB-AU-73" > $BingoDIR/73.title

echo "YES" > $BingoDIR/73.result

echo "" > $BingoDIR/73.msg

echo "$LOG_SECTION" > $BingoDIR/73.log

if [ -f /etc/syslog.conf ]
then
	if [ `cat /etc/syslog.conf | grep -w "*.info;mail.none;authpriv.none;cron.none" | grep -w '/var/log/messages' | grep -v '^ *#' | wc -l` -ge 1 ]
	then
        echo "YES" >> $BingoDIR/73.result
        cat /etc/syslog.conf | grep -w "*.info;mail.none;authpriv.none;cron.none" | grep -w '/var/log/messages' | grep -v '^ *#' >> $BingoDIR/73.log
    else
        echo "NO" >> $BingoDIR/73.result
        echo "KB-AU-73-N-01" >> $BingoDIR/73.msg
        cat /etc/syslog.conf | grep -w "*.info;mail.none;authpriv.none;cron.none" >> $BingoDIR/73.log
    fi

    if [ `cat /etc/syslog.conf | grep -w "authpriv.*" | grep -w '/var/log/secure' | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/73.result
        cat /etc/syslog.conf | grep -w "authpriv.*" | grep -w '/var/log/secure' | grep -v '^ *#' >> $BingoDIR/73.log
    else
        echo "NO" >> $BingoDIR/73.result
        echo "KB-AU-73-N-02" >> $BingoDIR/73.msg
        cat /etc/syslog.conf | grep -w "authpriv.*" >> $BingoDIR/73.log
    fi

	if [ `cat /etc/syslog.conf | grep -w "mail.*" | grep -w '/var/log/maillog' | grep -v '^ *#' | wc -l` -ge 1 ]
	then
        echo "YES" >> $BingoDIR/73.result
        cat /etc/syslog.conf | grep -w "mail.*" | grep -w '/var/log/maillog' | grep -v '^ *#' >> $BingoDIR/73.log
    else
        echo "NO" >> $BingoDIR/73.result
        echo "KB-AU-73-N-03" >> $BingoDIR/73.msg
        cat /etc/syslog.conf | grep -w "mail.*" >> $BingoDIR/73.log
    fi

    if [ `cat /etc/syslog.conf | grep -w "cron.*" | grep -w '/var/log/cron' | grep -v '^ *#' | wc -l` -ge 1 ]
	then
        echo "YES" >> $BingoDIR/73.result
        cat /etc/syslog.conf | grep -w "cron.*" | grep -w '/var/log/cron' | grep -v '^ *#' >> $BingoDIR/73.log
    else
        echo "NO" >> $BingoDIR/73.result
        echo "KB-AU-73-N-04" >> $BingoDIR/73.msg
        cat /etc/syslog.conf | grep -w "cron.*" >> $BingoDIR/73.log
    fi	

    if [ `cat /etc/syslog.conf | grep -w "*.alert" | grep -w '/dev/console' | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/73.result
        cat /etc/syslog.conf | grep -w "*.alert" | grep -w '/dev/console' | grep -v '^ *#' >> $BingoDIR/73.log
    else
        echo "NO" >> $BingoDIR/73.result
        echo "KB-AU-73-N-05" >> $BingoDIR/73.msg
        cat /etc/syslog.conf | grep -w "*.alert" >> $BingoDIR/73.log
    fi	
		
    if [ `cat /etc/syslog.conf | grep -w "*.emerg" | grep -w '\*' | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/73.result
        cat /etc/syslog.conf | grep -w "*.emerg" | grep -w '\*' | grep -v '^ *#' >> $BingoDIR/73.log
    else
        echo "NO" >> $BingoDIR/73.result
        echo "KB-AU-73-N-06" >> $BingoDIR/73.msg
        cat /etc/syslog.conf | grep -w "*.emerg" >> $BingoDIR/73.log
    fi 
elif [ -f /etc/rsyslog.conf ]
then
	if [ `cat /etc/rsyslog.conf | grep -w "*.info;mail.none;authpriv.none;cron.none" | grep -w '/var/log/messages' | grep -v '^ *#' | wc -l` -ge 1 ]
	then
        echo "YES" >> $BingoDIR/73.result
        cat /etc/rsyslog.conf | grep -w "*.info;mail.none;authpriv.none;cron.none" | grep -w '/var/log/messages' | grep -v '^ *#' >> $BingoDIR/73.log
    else
        echo "NO" >> $BingoDIR/73.result
        echo "KB-AU-73-N-07" >> $BingoDIR/73.msg
        cat /etc/rsyslog.conf | grep -w "*.info;mail.none;authpriv.none;cron.none" >> $BingoDIR/73.log
    fi

    if [ `cat /etc/rsyslog.conf | grep -w "authpriv.*" | grep -w '/var/log/secure' | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/73.result
        cat /etc/rsyslog.conf | grep -w "authpriv.*" | grep -w '/var/log/secure' | grep -v '^ *#' >> $BingoDIR/73.log
    else
        echo "NO" >> $BingoDIR/73.result
        echo "KB-AU-73-N-08" >> $BingoDIR/73.msg
        cat /etc/rsyslog.conf | grep -w "authpriv.*" >> $BingoDIR/73.log
    fi

	if [ `cat /etc/rsyslog.conf | grep -w "mail.*" | grep -w '/var/log/maillog' | grep -v '^ *#' | wc -l` -ge 1 ]
	then
        echo "YES" >> $BingoDIR/73.result
        cat /etc/rsyslog.conf | grep -w "mail.*" | grep -w '/var/log/maillog' | grep -v '^ *#' >> $BingoDIR/73.log
    else
        echo "NO" >> $BingoDIR/73.result
        echo "KB-AU-73-N-09" >> $BingoDIR/73.msg
        cat /etc/rsyslog.conf | grep -w "mail.*" >> $BingoDIR/73.log
    fi

    if [ `cat /etc/rsyslog.conf | grep -w "cron.*" | grep -w '/var/log/cron' | grep -v '^ *#' | wc -l` -ge 1 ]
	then
        echo "YES" >> $BingoDIR/73.result
        cat /etc/rsyslog.conf | grep -w "cron.*" | grep -w '/var/log/cron' | grep -v '^ *#' >> $BingoDIR/73.log
    else
        echo "NO" >> $BingoDIR/73.result
        echo "KB-AU-73-N-10" >> $BingoDIR/73.msg
        cat /etc/rsyslog.conf | grep -w "cron.*" >> $BingoDIR/73.log
    fi	

    if [ `cat /etc/rsyslog.conf | grep -w "*.alert" | grep -w '/dev/console' | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/73.result
        cat /etc/rsyslog.conf | grep -w "*.alert" | grep -w '/dev/console' | grep -v '^ *#' >> $BingoDIR/73.log
    else
        echo "NO" >> $BingoDIR/73.result
        echo "KB-AU-73-N-11" >> $BingoDIR/73.msg
        cat /etc/rsyslog.conf | grep -w "*.alert" >> $BingoDIR/73.log
    fi	
		
    if [ `cat /etc/rsyslog.conf | grep -w "*.emerg" | grep -w '\*' | grep -v '^ *#' | wc -l` -ge 1 ]
    then
        echo "YES" >> $BingoDIR/73.result
        cat /etc/rsyslog.conf | grep -w "*.emerg" | grep -w '\*' | grep -v '^ *#' >> $BingoDIR/73.log
    else
        echo "NO" >> $BingoDIR/73.result
        echo "KB-AU-73-N-12" >> $BingoDIR/73.msg
        cat /etc/rsyslog.conf | grep -w "*.emerg" >> $BingoDIR/73.log
    fi 
else
    echo "MANUAL" >> $BingoDIR/73.result
    echo "KB-AU-73-M-01" >> $BingoDIR/73.msg
    echo "/etc/(r)syslog.conf NO FILE" >> $BingoDIR/73.log
fi

if [ `cat $BingoDIR/73.result | grep -i "MANUAL" | wc -l` -ge 1 ]
then 
    echo "MANUAL" > $BingoDIR/73.result
elif [ `cat $BingoDIR/73.result | grep -i "NO" | wc -l` -ge 1 ]
then 
    echo "NO" > $BingoDIR/73.result
else 
    echo "YES" > $BingoDIR/73.result
    echo "KB-AU-73-Y-01" >> $BingoDIR/73.msg
fi

echo "$LOG_ALL" >> $BingoDIR/73.log
if [ -f /etc/syslog.conf ]
then
    echo "------------------------------" >> $BingoDIR/73.log
    echo "File: /etc/syslog.conf" >> $BingoDIR/73.log
    echo "------------------------------" >> $BingoDIR/73.log
    cat /etc/syslog.conf >> $BingoDIR/73.log
elif [ -f /etc/rsyslog.conf ]
then
    echo "------------------------------" >> $BingoDIR/73.log
    echo "File: /etc/rsyslog.conf" >> $BingoDIR/73.log
    echo "------------------------------" >> $BingoDIR/73.log
    cat /etc/rsyslog.conf >> $BingoDIR/73.log
else 
    echo "------------------------------" >> $BingoDIR/73.log
    echo "File: /etc/(r)syslog.conf" >> $BingoDIR/73.log
    echo "------------------------------" >> $BingoDIR/73.log
    echo "NO FILE" >> $BingoDIR/73.log
fi

# 73 end

# 74 start
#================================================================================
# U-74 서버용 백신 프로그램 운용
# 내부 정책에 따른 시스템 로깅 설정 적용 여부 점검
echo "KB-AU-74" > $BingoDIR/74.title

RESULT='YES'

if [ -d /usr/local/ViRobot/VRManager ]
then
	if  [ `/usr/local/ViRobot/VRManager/hAgent INFO | grep -i "status"  | grep -i "running" | wc -l` -ge -1 ]
	then
    	RESULT='YES'
		RESULT_MSG="KB-AU-74-Y-01"
		RESULT_LOG=$(/usr/local/ViRobot/VRManager/hAgent INFO 2>&1)
 	else
		RESULT='NO'
		RESULT_MSG="KB-AU-74-N-01"
		RESULT_LOG=$(/usr/local/ViRobot/VRManager/hAgent INFO 2>&1)
	fi
elif [ -d /usr/local/v3net ]
then 
	if [ `/usr/local/v3net/v3net.sh status | grep -iw "v3net" | grep -i "running" | wc -l` -ge 1 ]		
	then
    	RESULT='YES'
		RESULT_MSG="KB-AU-74-Y-02"
		RESULT_LOG=$(/usr/local/v3net/v3net.sh status | grep -iw "v3net" 2>&1)
    else
		RESULT='NO'
		RESULT_MSG="KB-AU-74-N-02"
		RESULT_LOG=$(/usr/local/v3net/v3net.sh status | grep -iw "v3net" 2>&1)
	fi
else
	RESULT='MANUAL'
	RESULT_MSG="KB-AU-74-M-01"
	RESULT_LOG=$(echo "NO FILE" 2>&1)
fi

if [ "$RESULT_LOG" == "" ]
then 
    RESULT_LOG='NO VALUE'
fi

echo "$RESULT" > $BingoDIR/74.result
echo "$RESULT_MSG" > $BingoDIR/74.msg
echo "$LOG_USE" > $BingoDIR/74.log
echo "$RESULT_LOG" >> $BingoDIR/74.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
# 74 end

# 75 start
#================================================================================
# U-75 시간 동기화 설정
# NTP 설치 및 동기화 상태 확인
echo "KB-AU-75" > $BingoDIR/75.title

RESULT='YES'
chronyc sources -v > /dev/null 2>&1
if [ $? = 0 ]
then
    # 출력값 파일에 담고 진단
    chronyc sources -v > $BingoDIR/75.chronyc
    if [ "$(cat $BingoDIR/75.chronyc | grep '^^' | sed 's/^.\(.*\)/\1/' | grep '^\*' | wc -l)" -ge 1 ]
    then
        RESULT='YES'
        RESULT_MSG="KB-AU-75-Y-01"
        RESULT_LOG=$(chronyc sources -v 2>&1)
    else
        RESULT='MANUAL'
        RESULT_MSG="KB-AU-75-M-01"
        RESULT_LOG="CONFIRM"
    fi
else
    ntpq -p > /dev/null 2>&1
    if [ $? = 0 ]
    then
        ntpq -p > $BingoDIR/75.ntpq
        if [ "$(cat $BingoDIR/75.ntpq | grep '^\*' | wc -l)" -ge 1 ]
        then
            RESULT='YES'
            RESULT_MSG="KB-AU-75-Y-01"
            RESULT_LOG=$(ntpq -p 2>&1)
        else
            RESULT='MANUAL'
            RESULT_MSG="KB-AU-75-M-01"
            RESULT_LOG="CONFIRM"
        fi
    else
        RESULT='MANUAL'
        RESULT_MSG="KB-AU-75-MM-01"
        RESULT_LOG="CONFIRM"
    fi
fi

echo "$RESULT" > $BingoDIR/75.result
echo "$RESULT_MSG" > $BingoDIR/75.msg
echo "$LOG_ALL" > $BingoDIR/75.log
echo "$RESULT_LOG" >> $BingoDIR/75.log

unset RESULT
unset RESULT_MSG
unset RESULT_LOG
# 75 end