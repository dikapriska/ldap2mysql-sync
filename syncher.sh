#!/bin/bash

usercount=$(ldapsearch -x -D $LDAP_USER -h $LDAP_HOST -p $LDAP_PORT -w $LDAP_PASS -b $LDAP_BASE -LLL "objectClass=person" | grep dn | grep uid | wc -l)

i=1
while [[ $i -le $usercount ]]
do
    username[$i]=$(ldapsearch -x -D $LDAP_USER -h $LDAP_HOST -p $LDAP_PORT -w $LDAP_PASS -b $LDAP_BASE -LLL "objectClass=person" |  tr "," "\n"  | grep dn | sed -n $((i))p | awk '{print $2}' | cut -d "=" -f 2)
    ((i++))
done

usercounter=1
while [[ $usercounter -le $usercount ]]
do

    #Create the User if not exists
    user=${username[$usercounter]}
    mysql -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASS -P $MYSQL_PORT -e "CREATE USER IF NOT EXISTS '$user'@'%' IDENTIFIED VIA pam USING 'mariadb'"

    db=${user}_%
    mysql -h$MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASS -P $MYSQL_PORT -e "GRANT ALL PRIVILEGES ON \`$db\` . * TO '$user'@'%'; FLUSH PRIVILEGES;"
    ((usercounter++))

done
