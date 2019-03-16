# Test Runs on AWS-RDS-Med-2 #

See `terraform/aws-rds-med-2/` for setup details.

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
number of transactions actually processed: 1259726
latency average = 23.783 ms
latency stddev = 21.363 ms
tps = 4198.416474 (including connections establishing)
tps = 4198.647009 (excluding connections establishing)
```

### Results - fio - Sync Heavy ###

N/A for hosted PG.

### Results - fio - Sync Heavy - Large Block ###

N/A for hosted PG.

### Results - fio - Async ###

N/A for hosted PG.

### Results - fio - Async - Large Block ###

N/A for hosted PG.
