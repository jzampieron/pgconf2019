# Test Runs on AWS-RDS-Micro-1 #

See `terraform/aws-rds-micro-1/` for setup details.

## Cost ##

- Per the RDS Cost Estimator:

| Estimated **monthly** costs | -------------- |
| ----------------------- | ------------------ |
| DB Instance             | 13.14 USD          |
| Storage                 | 12.50 USD          |
| Provisioned IOPS        | 100.00 USD         |
| **Total**               | **125.64 USD**     |

## Run 1 ##

### PG Info ###

Docker image per included tooling.

### Results - PGBench ###

```
transaction type: <builtin: TPC-B (sort of)>
scaling factor: 70
query mode: simple
number of clients: 100
number of threads: 4
duration: 600 s
number of transactions actually processed: 267718
latency average = 167.986 ms
latency stddev = 125.950 ms
tps = 446.018821 (including connections establishing)
tps = 446.030802 (excluding connections establishing)
```

### Results - fio - Sync Heavy ###

N/A for hosted PG.

### Results - fio - Sync Heavy - Large Block ###

N/A for hosted PG.

### Results - fio - Async ###

N/A for hosted PG.

### Results - fio - Async - Large Block ###

N/A for hosted PG.
