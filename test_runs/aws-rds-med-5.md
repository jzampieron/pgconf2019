# Test Runs on AWS-RDS-Med-5 #

See `terraform/aws-rds-med-5/` for setup details.

## Cost ##

- Per the RDS Cost Estimator:

| Estimated **monthly** costs | -------------- |
| ----------------------- | ------------------ |
| DB Instance             | 259.88 USD         |
| Storage                 | 125.00 USD         |
| Provisioned IOPS        | 1600.00 USD        |
| **Total**               | **1984.88 USD**    |

## Run 1 ##

### PG Info ###

Docker image per included tooling.

### Results - PGBench ###

Dashboards indicates CPU bound at 100% use.
Putting 16k iops on a m5.xlarge is a waste of money.

```
transaction type: <builtin: TPC-B (sort of)>
scaling factor: 70
query mode: simple
number of clients: 100
number of threads: 4
duration: 300 s
number of transactions actually processed: 1400465
latency average = 21.392 ms
latency stddev = 21.357 ms
tps = 4667.600630 (including connections establishing)
tps = 4667.865967 (excluding connections establishing)
```

### Results - fio - Sync Heavy ###

N/A for hosted PG.

### Results - fio - Sync Heavy - Large Block ###

N/A for hosted PG.

### Results - fio - Async ###

N/A for hosted PG.

### Results - fio - Async - Large Block ###

N/A for hosted PG.
