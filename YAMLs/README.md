1. ```k apply -f stg-opsmx-gate-x509svc.yml``` # Create servive
2. Configure the loadbalancer to route to the service created

### Create the gate secret gate config from x509-secret.yml file
- Update redis URL (and password as required)
- Update JKS password (from "changeit") for production use
- Update any Datadog config, if required
- Disable fiat if RBAC is disabled by editing the file (approx line no. 140)
- ```k apply -f x509-secret.yml```

### Create the gate deployment
- ```k apply -f stg-opsmx-gate-x509deploy.yml```
- ```k rollout restart deploy opsmx-gate-x509``` # Restart gate if required in multiple iterations
