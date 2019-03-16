# Test Runs on AWS-EC2-Med-1 #

See `terraform/aws-ec2-med-1/` for setup details.

## Run 1 ##

- 4x 1TB x 1k IOPS (io1) SW RAID 0

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
number of transactions actually processed: 1093358
latency average = 27.436 ms
latency stddev = 19.614 ms
tps = 3642.813195 (including connections establishing)
tps = 3642.860173 (excluding connections establishing)
```

### Results - fio - Sync Heavy ###

```
```

### Results - fio - Sync Heavy - Large Block ###

```
```

### Results - fio - Async ###

```
```

### Results - fio - Async - Large Block ###

```
```