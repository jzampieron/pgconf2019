# Test Runs on AWS-EC2-Large-2 #

See `terraform/aws-ec2-large-2/` for setup details.

## Cost ##

Using: https://calculator.s3.amazonaws.com/index.html

1x 1TB x 16k IOPS

| Service     | Cost        |
| ----------- | ----------- |
| Compute     | 2213.57 USD |
| EBS Vol     | 125     USD |
| EBS IOPS    | 1040    USD |
| Snaps       | 50      USD |
| ** Total ** | 3428.57 USD |

## Run 1 ##

- 4x 1TB x 16k IOPS (io1) x Single disks.
- 800 connections

### PG Info ###

Docker image per included tooling.

### Results - PGBench ###

```
transaction type: <builtin: TPC-B (sort of)>
scaling factor: 70
query mode: simple
number of clients: 800
number of threads: 4
duration: 300 s
number of transactions actually processed: 3997699
latency average = 59.964 ms
latency stddev = 75.567 ms
tps = 13317.953277 (including connections establishing)
tps = 13318.048370 (excluding connections establishing)
```
