# Test Runs on AWS-RDS-Med-1 #

See `terraform/aws-rds-med-1/` for setup details.

## Cost ##

- Per the RDS Cost Estimator:

| Estimated **monthly** costs | -------------- |
| ------------------------| ------------------ |
| DB Instance             | 259.88 USD         |
| Storage                 | 125.00 USD         |
| Provisioned IOPS        | 100.00 USD         |
| **Total**               | **484.88 USD**     |

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
duration: 300 s
number of transactions actually processed: 1152871
latency average = 25.992 ms
latency stddev = 15.930 ms
tps = 3842.402272 (including connections establishing)
tps = 3842.585781 (excluding connections establishing)
```

### Results - fio - Sync Heavy ###

N/A for hosted PG.

### Results - fio - Sync Heavy - Large Block ###

N/A for hosted PG.

### Results - fio - Async ###

N/A for hosted PG.

### Results - fio - Async - Large Block ###

N/A for hosted PG.
