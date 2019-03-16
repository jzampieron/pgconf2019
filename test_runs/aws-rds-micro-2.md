# Test Runs on AWS-RDS-Micro-2 #

See `terraform/aws-rds-micro-2/` for setup details.

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
number of transactions actually processed: 575012
latency average = 78.190 ms
latency stddev = 26.616 ms
tps = 958.220024 (including connections establishing)
tps = 958.247129 (excluding connections establishing)
```

### Results - fio - Sync Heavy ###

N/A for hosted PG.

### Results - fio - Sync Heavy - Large Block ###

N/A for hosted PG.

### Results - fio - Async ###

N/A for hosted PG.

### Results - fio - Async - Large Block ###

N/A for hosted PG.
