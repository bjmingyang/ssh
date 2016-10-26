#!/bin/sh
    echo "Content-type: text/html"
    echo ""
    echo ""

    # read in our parameters
    CMD=`echo "$QUERY_STRING" | sed -n 's/^.*cmd=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"`
    FOLDER=`echo "$QUERY_STRING" | sed -n 's/^.*folder=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"| sed "s/%2F/\//g"`
     FOLDER1=`echo "$QUERY_STRING" | sed -n 's/^.*folder1=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"| sed "s/%2F/\//g"`
FOLDER2=`echo "$QUERY_STRING" | sed -n 's/^.*folder2=\([^&]*\).*$/\1/p' | sed "s/%20/ /g"| sed "s/%2F/\//g"`

    # our html header
    echo "<html>"
    echo "<head><title>Bash CGI</title></head>"
    echo "<body>"

    # test if any parameters were passed
    if [ $CMD ]
    then
      case "$CMD" in
        ifconfig)
          echo "Output of ifconfig :<pre>"
          /sbin/ifconfig
          echo "</pre>"
          ;;

        uname)
          echo "Output of uname -a :<pre>"
          /bin/uname -a
          echo "</pre>"
          ;;

        dmesg)
          echo "Output of dmesg :<pre>"
          /bin/dmesg
          echo "</pre>"
          ;;

    df)
          echo "Output of df -h :<pre>"
          /bin/df -h
          echo "</pre>"
          ;;

    free)
          echo "Output of free :<pre>"
          /usr/bin/free
          echo "</pre>"
          ;;

     hw)
              echo "Hardware listing :<pre>"
              /usr/bin/lshw
              echo "</pre>"
              ;;


     lsusb)
              echo "lsusb :<pre>"
              /usr/bin/lsusb
              echo "</pre>"
              ;;

    lsuser)
              echo "List of users :<pre>"
              /usr/bin/lsuser
              echo "</pre>"
              ;;

        ls)
          echo "Output of ls $FOLDER :<pre>"
          /bin/ls "$FOLDER"
          echo "</pre>"
          ;;

            lsal)
              echo "Output of ls $FOLDER1 :<pre>"
              /bin/ls -al "$FOLDER1"
              echo "</pre>"
              ;;

          wol)
              echo "System to wake: $FOLDER2 :<pre>"
              /usr/bin/wakeonlan "$FOLDER2"
              echo "</pre>"
              ;;


        lsb_release)
          echo "Ubuntu version :<pre>"
          /usr/bin/lsb_release -a
          echo "</pre>"
          ;;

           cpuinfo)
              echo "Cpu information :<pre>"
              cat /proc/cpuinfo
              echo "</pre>"
              ;;

         *)
          echo "Unknown command $CMD<br>"
          ;;
      esac
    fi

    # print out the form

    # page header
    echo "<p>"
    echo "<center>"
    echo "<h2>Bash commands</h2>"
    echo "</center>"
    echo "<p>"
    echo "<p>"

    echo "Choose which command you want to run"
    echo "<form method=get>"
    echo "<input type=radio name=cmd value=ifconfig checked> ifconfig (Network configuration) <br>"
    echo "<input type=radio name=cmd value=uname> uname -a (Kernel version)<br>"
    echo "<input type=radio name=cmd value=dmesg> dmesg (System messages) <br>"
    echo "<input type=radio name=cmd value=lsb_release> lsb_release (Ubuntu version) <br>"
    echo "<input type=radio name=cmd value=df> df -h (Free disk space) <br>"
    echo "<input type=radio name=cmd value=free> free (Memory info)<br>"
        echo "<input type=radio name=cmd value=cpuinfo> Cpu information <br>"
        echo "<input type=radio name=cmd value=hw> Hardware listing <br>"
    echo "<input type=radio name=cmd value=lsuser> User listing <br>"
    echo "<input type=radio name=cmd value=lsusb> lsusb (Usb ports info)<br>"
    echo "<input type=radio name=cmd value=ls> ls  -- folder <input type=text name=folder value=/mnt/flash><br>"
    echo "<input type=radio name=cmd value=lsal> ls -al -- folder <input type=text name=folder1 value=/mnt/flash><br>"
echo "<input type=radio name=cmd value=wol> wakeonlan (enter mac address) <input type=text name=folder2 value=00:00:00:00:00:00><br>"
    echo "<input type=submit>"
    echo "</form>"
    echo "</body>"
    echo "</html>"
