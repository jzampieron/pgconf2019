# Test Runs on AWS-RDS-Large-1 #

See `terraform/aws-rds-large-1/` for setup details.

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
number of transactions actually processed: 2504392
latency average = 11.963 ms
latency stddev = 7.169 ms
tps = 8347.286313 (including connections establishing)
tps = 8347.752564 (excluding connections establishing)
```

## Run 2 ##

- 200 clients.

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
number of transactions actually processed: 3172049
latency average = 18.869 ms
latency stddev = 10.786 ms
tps = 10571.821105 (including connections establishing)
tps = 10572.344976 (excluding connections establishing)
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
number of transactions actually processed: 3066434
latency average = 38.969 ms
latency stddev = 36.175 ms
tps = 10218.187106 (including connections establishing)
tps = 10218.627040 (excluding connections establishing)
```

### Results - fio - Sync Heavy ###

N/A for hosted PG.

### Results - fio - Sync Heavy - Large Block ###

N/A for hosted PG.

### Results - fio - Async ###

N/A for hosted PG.

### Results - fio - Async - Large Block ###

N/A for hosted PG.
