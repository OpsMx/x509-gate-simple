# Instructions for creating server certs
## Need openssl command, openssl-server.cnf, openssl-ca.cnf. In addition ca.crt add ca.key are referenced in openssl-ca.cnf

## IF NO CA.cert and ca.key is available generate your own for testing purposes only, 
- ```openssl req -x509 -newkey rsa:4096 -keyout ca.key -out ca.crt -sha256 -days 3650 -subj "/C=US/ST=CA/L=SFO/O=OpsMx/OU=CustomerSuccess/CN=OpsmxSelfSignedCA" ```
- Enter a strong key password, twice, and SAVE THE PASSWORD. This will be used for signing a cert+key everytime we need to generate a new one
- Check your CA: ```openssl x509 -text -in ca.crt```
- For Production use, please use ensure that the server and client certs are signed by your organization's CA.

## Generate server.crt and server.key
#Create Key , give password
- ```openssl genrsa  -out server.key 2048``` 

#UPDATE **commonName_default** and **subjectAltName** in openssl-server.cnf and Create CSR,
- ```openssl req -new -key server.key -out CSR.csr -nodes -config openssl-server.cnf```

#Create Signed cert, give password for the key
- ```touch index.txt; echo "01" > serial.txt```
- ```openssl ca -config openssl-ca.cnf -policy signing_policy -extensions signing_req -out server.crt -infiles CSR.csr```
  
#You should have server.crt and server.key
- ```openssl x509 -text -in server.crt``` # Check Issuer, CN and subjectAltName (SAN)

# Verify certs
- ```openssl verify -verbose -CAfile ca.crt server.crt``` # CA and Cert Is this cert signed by this CA?
- ```openssl x509 -noout -modulus -in server.crt```
- ```openssl rsa -noout -modulus -in server.key``` # Match  of server.crt and key, Is this cert and key match?
