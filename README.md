# x509-gate
This repo contains all the files and instructions for setting up x509 Spinnaker gate

## Setup Instructions
- YAMLs folder: create ONLY the k8s service and LoadBalancer (1st 2 steps)
- SERVER-CERTS folder: Create server-certs, ensuring that LB address (created above) is in the subjectAltName
- JKS folder: JKS and create k8s secret for gate.jks
- YAMLS folder: Create the x509-secret and Deploy opsmx-gate-x509 deployment, ensure that the pod comes to running status and remains there for a min or two

## Testing Instructions (details in CLIENT_CERTS folder)
- Follow the instructions in the "CLIENT-CERTS" folder, ensure to use the SAME ca.crt and ca.key as was used for creating server.crt/key
- Once client.crt and client.key are generated, test it using curl
- if it does not work, test it from inside the halyard pod (copy the ca.crt, client.crt+key into the pod)
- Once that works, test it from the external/LB URL.

## SERVER-CERTS folder contains 
- Instructions for creating server.crt and server.key
- OPTIONAL: If required, instructions are there for generating self-signed ca and key

## JKS folder contains
- Creating a JKS from server.crt, server.key and ca.crt
- Verifying the jks
- Sample config for gate.yml

## YAMLs folder contains
- x509 secret that refers to the JKS created above
- Deployment YAML that creates opsmx-gate-x509 pod
- SVC YAML for k8s service connecting to the opsmx-gate-x509 pods
  
## CLIENT-CERTS contains
- Instructions creating client.crt and client.key
- Configuring .spin/config for using spin-cli
- Sample spin-cli command


