# Test Runs on AWS-RDS-Med-4 #

See `terraform/aws-rds-med-4/` for setup details.

## Cost ##

- Per the RDS Cost Estimator:

| Estimated **monthly** costs | -------------- |
| ----------------------- | ------------------ |
| DB Instance             | 259.88 USD         |
| Storage                 | 125.00 USD         |
| Provisioned IOPS        | 800.00 USD         |
| **Total**               | **1184.88 USD**    |

## Run 1 ##

### PG Info ###

Docker image per included tooling.

- 100 clients

### Results - PGBench ###

Dashboards indicates CPU bound at 100% use.
Putting 8k iops on a m5.xlarge is a waste of money.

```
transaction type: <builtin: TPC-B (sort of)>
scaling factor: 70
query mode: simple
number of clients: 100
number of threads: 4
duration: 300 s
number of transactions actually processed: 1448850
latency average = 20.681 ms
latency stddev = 8.874 ms
tps = 4828.856604 (including connections establishing)
tps = 4829.101413 (excluding connections establishing)
```

## Run 2 ##

### PG Info ###

Docker image per included tooling.

- 200 clients

### Results - PGBench ###

- Double the latency for double the number of clients means
    we still aren't limited by the client's ability to load
- Dashboard indicated 100% CPU.

```
transaction type: <builtin: TPC-B (sort of)>
scaling factor: 70
query mode: simple
number of clients: 200
number of threads: 4
duration: 300 s
number of transactions actually processed: 1327137
latency average = 45.100 ms
latency stddev = 18.719 ms
tps = 4422.441146 (including connections establishing)
tps = 4422.668128 (excluding connections establishing)
```

### Results - fio - Sync Heavy ###

N/A for hosted PG.

### Results - fio - Sync Heavy - Large Block ###

N/A for hosted PG.

### Results - fio - Async ###

N/A for hosted PG.

### Results - fio - Async - Large Block ###

N/A for hosted PG.
