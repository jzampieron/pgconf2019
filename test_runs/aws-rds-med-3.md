# Test Runs on AWS-RDS-Med-3 #

See `terraform/aws-rds-med-3/` for setup details.


## Cost ##

- Per the RDS Cost Estimator:

| Estimated **monthly** costs | -------------- |
| ----------------------- | ------------------ |
| DB Instance             | 259.88 USD         |
| Storage                 | 125.00 USD         |
| Provisioned IOPS        | 400.00 USD         |
| **Total**               | **784.88 USD**     |

## Run 1 ##

### PG Info ###

Docker image per included tooling.

### Results - PGBench ###

This is about the reasonable iops limit for a m5.xlarge.

```
transaction type: <builtin: TPC-B (sort of)>
scaling factor: 70
query mode: simple
number of clients: 100
number of threads: 4
duration: 300 s
number of transactions actually processed: 1412843
latency average = 21.214 ms
latency stddev = 9.059 ms
tps = 4708.856788 (including connections establishing)
tps = 4709.044373 (excluding connections establishing)
```

### Results - fio - Sync Heavy ###

N/A for hosted PG.

### Results - fio - Sync Heavy - Large Block ###

N/A for hosted PG.

### Results - fio - Async ###

N/A for hosted PG.

### Results - fio - Async - Large Block ###

N/A for hosted PG.
