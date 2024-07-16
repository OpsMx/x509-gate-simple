# SAMPLE ".spin/config" file for using spin-cli
# Update gate.endpoint and file paths for client.crt and key
# use "spin -k" for self-signed certs

gate:
  endpoint: https://192.168.1.40:31907
  retryTimeout: 300
auth:
  enabled: true
  x509:
    certPath: "/home/srini/WU/x509-setup/x509-gate/CLIENT-CERTS/client.crt"
    keyPath: "/home/srini/WU/x509-setup/x509-gate/CLIENT-CERTS/client.key"
