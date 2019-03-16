# Test Runs on AWS-RDS-Micro-3 #

See `terraform/aws-rds-micro-3/` for setup details.

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
number of transactions actually processed: 308794
latency average = 48.500 ms
latency stddev = 22.242 ms
tps = 1029.084114 (including connections establishing)
tps = 1029.118900 (excluding connections establishing)
```

### Results - fio - Sync Heavy ###

N/A for hosted PG.

### Results - fio - Sync Heavy - Large Block ###

N/A for hosted PG.

### Results - fio - Async ###

N/A for hosted PG.

### Results - fio - Async - Large Block ###

N/A for hosted PG.
