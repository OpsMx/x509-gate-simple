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
- ```spin -k pi exec -a APPNAME -n PIPE-NAME``` to execute a pipeline
- ```spin -k pi exec -h``` to get help, type as much as you can and put -h to get specific help
- Note: 


# Executing a pipeline with parameters
- POST a json as shown below to the /pipelines/{application name}/{pipeline-name} end point. E.g.
- ```curl --key client.key --cert client.crt --cacert ca.crt -vvv https://opsmx-gate-x509/pipelines/opsmx-gitops/curl-trig -H "accept: */*" -H "Content-Type: application/json" -d '{"parameters":{"name":"MYVALUE","animal":"dog"}}'```
- In the pipeline, add an "Evaluate Variables" stage, and check ```$trigger.parameters.name}``` to see if "MYVALUE" shows up.

# Debugging  
- Debug using: ```curl --key client.key --cert client.crt --cacert ca.crt -vvv https://spinnaker-opsmx-x509-api.opsmx.com/applications```
- or ```curl --key client.key --cert client.crt --cacert ca.crt -vvv https://opsmx-gate-x509/applications``` from inside the halyard pod
- Try adding "--insecure" to see if that gets a response. If so, check your client certs.

# Using "-k" in spin-cli
- using "-k" option is mandatory unless you are using public certs known to the OS OR you import the CA into the OS trust certificates store
- For ubuntu, follow instructions here: https://ubuntu.com/server/docs/install-a-root-ca-certificate-in-the-trust-store
- For Mac, {TODO: fill the link here}
- Once the ca.crt used by the server.crt is trusted, "-k" option in spin-cli commands is not required
