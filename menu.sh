#!/system/bin/sh
#
# 
# Kludgy hack to help with kernels
boot=$(grep -i "boot" /proc/emmc | sed 's/.*boot\(.*\)<\/recovery.*/\1/' | sed 's/:[^:]*$//')
recovery=$(grep -i "recovery" /proc/emmc | sed 's/.*boot\(.*\)<\/recovery.*/\1/' | sed 's/:[^:]*$//')
cd /sdcard/lunar
echo
echo "1) Flash a previously saved boot.img"
echo "2) Flash a recovery.img"
echo
echo "Choose number selection[99 = abort]:"
read menu
        case "$menu" in
                "1")
			grep_cmd=`find ./boot* | grep -i \\.img$`
			echo "Previous configurations:" 
			echo
			for filename in $grep_cmd 
			    do
 			     count=$(($count+1))

 			     filename=`echo $filename | sed 's/temp_space/ /g'`

   			   # Store file names in an array
     			 file_array[$count]=$filename

			      echo "  ($count) $filename" >> temp.list
  			  done

  			  more temp.list
 			  rm temp.list

			    echo
			    echo -n "Enter selection number to flash (exit = 0): "

    			read enterNumber
    			echo
			if [ "$enterNumber" == "0" ]
    			then
      			exit 0
			fi
			if [ "`echo $enterNumber | sed 's/[0-9]*//'`" == "" ] || [ "enterNumber"=="1" ]
    			then
      			file_chosen=${file_array[$enterNumber]}
			fi
			echo "Last chance before we flash" 
			echo "You chose $file_chosen"
			echo 
			echo "1) Yes; I am ready flash it right away"
			echo "2) No; let's just save it for later"
			echo "Confirm flash?"
			read confirm
			case "$confirm" in
				"1")
					echo "Flashing selection in ..."
					echo "5"
					sleep 1
					echo "4"
					sleep 1
					echo "3"
					sleep 1
					echo "2"
					sleep 1
					echo "1"
					sleep 1
					dd if=$file_chosen of=/dev/block/$boot
					echo "Please Reboot to recovery....."
					echo ".... and Wipe Dalvik Cache & Cache"
					echo "GoodBye!"
					;;
				"2")
					echo "Fine, I will be here when you get back :)"
					echo "This message will self-destruct in ..."
					echo "5"
					sleep 1
					echo "4"
					sleep 1
					echo "3"
					sleep 1
					echo "2"
					sleep 1
					echo "1"
					sleep 1
					echo "P O O F!"
					exit
					;;
			esac
		$confirm
		;;
                "2")
			grep_cmd=`find ./recovery* | grep -i \\.img$`
			echo "Recoveries found:" 
			echo
			for filename in $grep_cmd 
			    do
 			     count=$(($count+1))

 			     filename=`echo $filename | sed 's/temp_space/ /g'`

   			   # Store file names in an array
     			 file_array[$count]=$filename

			      echo "  ($count) $filename" >> temp.list
  			  done

  			  more temp.list
 			  rm temp.list

			    echo
			    echo -n "Enter selection number to flash (exit = 0): "

    			read enterNumber
    			echo
			if [ "$enterNumber" == "0" ]
    			then
      			exit 0
			fi
			if [ "`echo $enterNumber | sed 's/[0-9]*//'`" == "" ] || [ "enterNumber"=="1" ]
    			then
      			file_chosen=${file_array[$enterNumber]}
			fi
			echo "Last chance before we flash" 
			echo "You chose $file_chosen"
			echo 
			echo "1) Yes; I am ready flash it right away"
			echo "2) No; let's just save it for later"
			echo "Confirm flash?"
			read confirm
			case "$confirm" in
				"1")
					echo "Flashing selection in ..."
					echo "5"
					sleep 1
					echo "4"
					sleep 1
					echo "3"
					sleep 1
					echo "2"
					sleep 1
					echo "1"
					sleep 1
					dd if=/dev/block/$recovery of=/sdcard/lunar/recovery_backup.img
					echo "Your current recovery was saved to SDCard/Lunar dir as recovery_backup.img"
					dd if=$file_chosen of=/dev/block/$recovery
					echo "Please Reboot to recovery....."
					echo ".... and Wipe Dalvik Cache & Cache"
					echo "GoodBye!"
					;;
				"2")
					echo "Fine, I will be here when you get back :)"
					echo "This message will self-destruct in ..."
					echo "5"
					sleep 1
					echo "4"
					sleep 1
					echo "3"
					sleep 1
					echo "2"
					sleep 1
					echo "1"
					sleep 1
					echo "P O O F!"
					exit
					;;
			esac
			$confirm
                        ;;
		"99")
			exit
                        ;;
        esac
$menu
