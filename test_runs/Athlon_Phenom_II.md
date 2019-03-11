# Test Runs on Pre-2012 AMD Athlon Phenom II #

Kubutu 18.04.1

| Item                  | Details        |
| --------------------- | -------------- |
| Model Name            | Custom		       |
| Model Identifier      | AMD Athlon		       |
| Processor Name        | AMD Athlon Phenom II X4 965  |
| Processor Speed       | 800 MHz        |
| Number of Processors  | 1              |
| Total Number of Cores | 4              |
| Memory                | 8 GB           |
| --------------------- | -------------- |

| Physical Drive        | ----------------- |
| --------------------- | ----------------- |
| Device Name           | Seagate ST1000DX001-1CM162  |
| Medium Type           | HDD               |
| Protocol              | SATA              |
| Internal              | Yes               |
| File System           | xfs		    |
| --------------------- | ----------------- |

| Physical Drive        | ----------------- |
| --------------------- | ----------------- |
| Device Name           | INTEL SSDSC2BW120A4  |
| Medium Type           | SSD               |
| Protocol              | SATA              |
| Internal              | Yes               |
| File System           | btrfs		    |
| --------------------- | ----------------- |


2 Test Runs, 1 on each drive.

## Run 1 ##

### PG Info ###

Docker image per included tooling.

Using the Seagate HDD mounted on `/xfs`:

### Results - PGBench ###

```
Run 1: 
transaction type: <builtin: TPC-B (sort of)>
scaling factor: 70
query mode: simple
number of clients: 100
number of threads: 4
duration: 600 s
number of transactions actually processed: 203020
latency average = 295.743 ms
latency stddev = 408.931 ms
tps = 337.466603 (including connections establishing)
tps = 337.468786 (excluding connections establishing)
```

## Run 2 ##

### PG Info ###

Docker image per included tooling.

Using the Intel SSD mounted on `/pgdata`:

### Results - PGBench ###

```
Run 2:
transaction type: <builtin: TPC-B (sort of)>
scaling factor: 70
query mode: simple
number of clients: 100
number of threads: 4
duration: 600 s
number of transactions actually processed: 517005
latency average = 116.047 ms
latency stddev = 97.119 ms
tps = 861.317140 (including connections establishing)
tps = 861.323816 (excluding connections establishing)
```