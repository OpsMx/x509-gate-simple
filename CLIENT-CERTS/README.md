# Instructions for creating client certs

## Check client.conf once if want to change anything

- Clone this folder
- Copy ca.crt and ca.key into this folder (look at server-certs folder)
- Ensure that ca.crt, ca.key and client.conf are present
- Edit gen_client_crt.sh as appropriate, updating the ca.key password
- Execute it to create client.crt and client.key

# Instructions for running spin-cli

- Download spin-cli from here: https://spinnaker.io/docs/setup/other_config/spin/
- Edit sample config.spin as appropriate and place it in ~/.spin/config
- ```spin -k app list``` to check
- Debug using: ```curl --key client.key --cert client.crt --cacert ca.crt -vvv https://spinnaker-opsmx-x509-api.opsmx.sk/applications```
- or ```curl --key client.key --cert client.crt --cacert ca.crt -vvv https://opsmx-gate-x509:443/applications``` from inside the halyard pod
- Try adding "--insecure" to see if that gets a response. If so, check your client certs.

