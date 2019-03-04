# Test Runs on 2012 Retina Mac #

Mac OS 10.13.6

| Item                  | Details        |
| --------------------- | -------------- |
| Model Name            | MacBook Pro    |
| Model Identifier      | MacBookPro10,1 |
| Processor Name        | Intel Core i7  |
| Processor Speed       | 2.3 GHz        |
| Number of Processors  | 1              |
| Total Number of Cores | 4              |
| L2 Cache (per Core)   | 256 KB         |
| L3 Cache              | 6 MB           |
| Memory                | 16 GB          |
| --------------------- | -------------- |

| Physical Drive        | ----------------- |
| --------------------- | ----------------- |
| Device Name           | APPLE SSD SM256E  |
| Media Name            | AppleAPFSMedia    |
| Medium Type           | SSD               |
| Protocol              | SATA              |
| Internal              | Yes               |
| Partition Map Type    | Unknown           |
| S.M.A.R.T. Status:    | Verified          |
| --------------------- | ----------------- |

File System is *APFS*.

## Run 1 ##

### PG Info ###

Postgres-2.2.2-11.dmg from https://postgresapp.com/

- init: `pgbench -U jzampieron -i -s 70 jzampieron`
- cmd: `pgbench -U jzampieron -P 10 -r -c 100 -j 4 -T 600 jzampieron`

### Results ###

```
transaction type: <builtin: TPC-B (sort of)>
scaling factor: 70
query mode: simple
number of clients: 100
number of threads: 4
duration: 600 s
number of transactions actually processed: 1964169
latency average = 30.553 ms
latency stddev = 76.399 ms
tps = 3270.779946 (including connections establishing)
tps = 3270.815483 (excluding connections establishing)
```