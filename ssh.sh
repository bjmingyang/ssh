for host in `cat /home/mingyang/hosts/drac`

do
cmd="ssh $host racadm config -g cfgUserAdmin -o cfgUserAdminPassword -i 2 daodao.com"
  /home/mingyang/c.sh "ssh $host racadm config -g cfgUserAdmin -o cfgUserAdminPassword -i 2 daodao.com" calvin;echo done

  #ssh $host sed -i 's/^PasswordAuthentication\ yes/PasswordAuthentication\ no/g' /etc/ssh/sshd_config
  #ssh $host service sshd restart
done
