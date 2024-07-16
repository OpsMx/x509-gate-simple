
export TEST_EXPIRY_DAYS=30
export GATE_URL="spinnaker-staging-x509-api.opsmx.org"
export USER_NAME="USERNAME-GOES-HERE"
export TEST_USER_EMAIL="USER-EMAIL-GOES-HERE"
export CA_PASSWORD="CA-KEY-PASSWORD"

# Update this to give a role to the user
export TEST_USER_ROLE="admin"

rm client.crt
rm client.pem
rm client.key
rm client.csr
rm temp_client.conf

echo $TEST_USER_EMAIL
echo $TEST_USER_ROLE

sed "s#ROLE#$TEST_USER_ROLE#" client.conf > temp_client.conf

cat temp_client.conf | grep "1.2.840.10070.8.1"

# Replace "OpsMx" with the customer name
openssl req -nodes -newkey rsa:4096 -keyout client.key -out client.csr -subj "/C=US/ST=CA/L=SF/O=OpsMx/CN=$USER_NAME/emailAddress=$TEST_USER_EMAIL" -config temp_client.conf

openssl x509 -req -days "$TEST_EXPIRY_DAYS" -in client.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out client.crt -passin "pass:$CA_PASSWORD" -extensions client_crt -extfile temp_client.conf
