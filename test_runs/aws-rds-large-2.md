# Test Runs on AWS-RDS-Large-2 #

See `terraform/aws-rds-large-2/` for setup details.

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

```
transaction type: <builtin: TPC-B (sort of)>
scaling factor: 70
query mode: simple
number of clients: 100
number of threads: 4
duration: 300 s
number of transactions actually processed: 2454870
latency average = 12.205 ms
latency stddev = 6.261 ms
tps = 8178.308971 (including connections establishing)
tps = 8178.746973 (excluding connections establishing)
```

## Run 2 ##

- 200 clients

### PG Info ###

Docker image per included tooling.

### Results - PGBench ###

```
transaction type: <builtin: TPC-B (sort of)>
scaling factor: 70
query mode: simple
number of clients: 200
number of threads: 4
duration: 300 s
number of transactions actually processed: 3167918
latency average = 18.899 ms
latency stddev = 11.025 ms
tps = 10558.245311 (including connections establishing)
tps = 10558.714462 (excluding connections establishing)
```

## Run 3 ##

- 400 clients.

### PG Info ###

Docker image per included tooling.

### Results - PGBench ###

```
transaction type: <builtin: TPC-B (sort of)>
scaling factor: 70
query mode: simple
number of clients: 400
number of threads: 4
duration: 300 s
number of transactions actually processed: 3064085
latency average = 38.945 ms
latency stddev = 35.800 ms
tps = 10210.229080 (including connections establishing)
tps = 10210.809611 (excluding connections establishing)
```

### Results - fio - Sync Heavy ###

N/A for hosted PG.

### Results - fio - Sync Heavy - Large Block ###

N/A for hosted PG.

### Results - fio - Async ###

N/A for hosted PG.

### Results - fio - Async - Large Block ###

N/A for hosted PG.
