# SAMPLE ".spin/config" file for using spin-cli
# Update gate.endpoint and file paths for client.crt and key
# use "spin -k" for self-signed certs

gate:
  endpoint: https://k8s-spin-opsmxgat-1aa7fa4a19-c49d24079799b22a.elb.us-east-1.amazonaws.com  
  retryTimeout: 300
auth:
  enabled: true
  x509:
    certPath: "/Users/srinivas.kambhampati/old-spin-staging/x509/client-certs/client.crt"
    keyPath: "/Users/srinivas.kambhampati/old-spin-staging/x509/client-certs/client.key"
