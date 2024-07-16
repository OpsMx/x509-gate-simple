# x509-gate
This repo contains all the files and instructions for setting up x509 Spinnaker gate

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


## Setup Instructions
- Create server-certs, JKS and create k8s secret for gate.jks
- Deploy opsmx-gate-x509, ensure that the JKS is mounted correct
- Create the k8s service
- Create a LoadBalancer that routes traffic to the k8s service WITHOUT TLS termination or modification
[ use of Ingress is discouraged. If we need to tls-passthrough must be enabled and tls-termination should be configured in the ingress]

## Testing Instructions
- Follow the instructions in the "CLIENT-CERTS" folder
- Once client.crt and client.key are generated, test it using curl
- if it does not work, test it from inside the halyard pod (copy the ca.crt, client.crt+key into the pod)
- Once that works, test it from the external/LB URL.

