for file in `ls abc`
 do
cat ./abc/$file | while read LINE
do
#        echo $LINE
email=`echo $LINE|awk -F"----" '{print $1}'`
password=`echo $LINE|awk -F"----" '{print $2}'`
#echo $email
#echo $password
mysql  --user=root --password="" test << EOF
INSERT INTO spdb1 (id,email,password,site) VALUES (NULL, '$email', '$password','mail.163.com');
EOF
done
done


注入mysql 163邮箱库
