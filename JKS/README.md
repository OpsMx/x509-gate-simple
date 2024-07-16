# Instructions for creating gate.jks for mounting in the x509-gate pod
## "keytool" command comes with Java JDK (not JRE), install it if required
## "changeit" is the password used. For prod, please do actually "change" the password

#Create gate.p12 with server.crt and key in it
- ```openssl pkcs12 -export -clcerts -in server.crt -inkey server.key -out gate.p12 -name gate -passin pass:```  #Enter password twice "changeit"
  
#Convert P12 to JKS
- ```keytool -importkeystore -srckeystore gate.p12 -srcstoretype pkcs12 -srcalias gate -destkeystore gate.jks -destalias gate -deststoretype jks -deststorepass changeit  -srcstorepass changeit```

#Import the CA also into the same JKS (enter 'yes")
- ```keytool -importcert -keystore gate.jks -alias ca -file ca.crt -storepass changeit```
  
#Check, it should show 2 entries, one for gate and one for ca
- ```keytool -list -keystore gate.jks```

## Create secret (k aliased to "kubectl -n NameSpace --kubeconfig <..> --context..."
- ```k delete secret x509gatejks```
- ```k create secret generic x509gatejks --from-file gate.jks```
- ```k rollout restart deploy opsmx-gate-x509``` # Restart gate if required in multiple iterations

## Gate.yml config
```
server:
  ssl:
    enabled: true
    keyAlias: gate
    keyStore: /opt/cert/gate.jks
    keyStoreType: jks
    keyStorePassword: changeit
    trustStore: /opt/cert/**gate.jks**
    trustStoreType: jks
    trustStorePassword: changeit
    clientAuth: WANT
    crlFile: blocklist:/opsmx/blocklist
    blocklist: true
  port: '8084'
  address: 0.0.0.0
```

## Test/Debug ONLY: Script to extract cert and key from JKS
https://stackoverflow.com/questions/23087537/how-to-export-key-and-crt-from-keystore
```
#!/usr/bin/env bash

# Extracts the private key and certificate from a Java keystore and saves them
#
# Ouputs:
#   <keystore>.p12: private key and certificate in PKCS12 format
#   <keystore>.pem: private key and certificate in PEM format
#   <keystore>.crt: certificate only
#   <keystore>.key: private key only

# Usage:
#   jks2pem.sh <keystore>

# Example:
#   jks2pem.sh keystore.jks

if [ -z "$1" ]; then
    echo "Usage: jks2pem.sh <keystore>.jks"
    exit 1
fi

base_name=$(basename "$1" .jks)
temp_password="changeit"

keytool -importkeystore -srckeystore "$1" -srcstoretype jks \
    -destkeystore "$base_name.p12" -deststoretype PKCS12 \
    -deststorepass "$temp_password"

# Export the private key and certificate as a PEM file without a password
openssl pkcs12 -nodes -in "$base_name.p12" -out "$base_name.pem" -passin pass:"$temp_password"

# Export the certificate as a PEM file
openssl pkcs12 -nokeys -in "$base_name.p12" -out "$base_name.crt" -passin pass:"$temp_password"

# Export the private key as a PEM file
openssl pkcs12 -nocerts -nodes -in "$base_name.p12" -out "$base_name.key" -passin pass:"$temp_password"![image](https://github.com/user-attachments/assets/c9776401-7a0e-4945-8ed7-fc116f2e82af)

```
