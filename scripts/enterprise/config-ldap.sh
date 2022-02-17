vault auth enable ldap

vault write auth/ldap/config \
	binddn="uid=topldap,ou=Users,o=5d16e8db46208d35882b2740,dc=jumpcloud,dc=com" \
	bindpass="TopLDAP123!" \
        url="ldap://ldap.jumpcloud.com:389" \
        userdn="ou=Users,o=5d16e8db46208d35882b2740,dc=jumpcloud,dc=com" \
        groupdn="ou=Users,o=5d16e8db46208d35882b2740,dc=jumpcloud,dc=com" \
	userattr="uid" \
        groupattr="cn" \
        insecure_tls=true 

vault auth list -format=json | jq -r '.["ldap/"].accessor' > accessor.txt
vault write -format=json identity/group name="training_admin_root"         type="external"         | jq -r ".data.id" > group_id.txt
vault write -format=json identity/group-alias name="support"         mount_accessor=$(cat accessor.txt)         canonical_id=$(cat group_id.txt)

