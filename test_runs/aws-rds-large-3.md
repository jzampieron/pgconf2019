# Test Runs on AWS-RDS-Large-3 #

See `terraform/aws-rds-large-3/` for setup details.

## Cost ##

- Per the RDS Cost Estimator:

| Estimated **monthly** costs | -------------- |
| ------------------------| ------------------ |
| DB Instance             | 4380.00 USD        |
| Storage                 | 125.00  USD        |
| Provisioned IOPS        | 800.00  USD        |
| **Total**               | **5305.00 USD**    |

## Run 1 ##

### PG Info ###

Docker image per included tooling.

### Results - PGBench ###

Dual Client - 400 connections each.

Approx. 14k TPS and 800 concurrent connections.

Client 1
```
transaction type: <builtin: TPC-B (sort of)>
scaling factor: 70
query mode: simple
number of clients: 400
number of threads: 4
duration: 300 s
number of transactions actually processed: 2124623
latency average = 56.261 ms
latency stddev = 74.796 ms
tps = 7079.446444 (including connections establishing)
tps = 7079.730737 (excluding connections establishing)
```

Client 2
```
transaction type: <builtin: TPC-B (sort of)>
scaling factor: 70
query mode: simple
number of clients: 400
number of threads: 4
duration: 300 s
number of transactions actually processed: 2087554
latency average = 57.216 ms
latency stddev = 75.575 ms
tps = 6946.013124 (including connections establishing)
tps = 6946.352249 (excluding connections establishing)
```

### Results - fio - Sync Heavy ###

N/A for hosted PG.

### Results - fio - Sync Heavy - Large Block ###

N/A for hosted PG.

### Results - fio - Async ###

N/A for hosted PG.

### Results - fio - Async - Large Block ###

N/A for hosted PG.
