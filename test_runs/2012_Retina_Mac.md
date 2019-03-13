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

### Results - PGBench ###

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

### Results - fio - Sync Heavy ###

```
Jeffreys-MacBook-Pro:tooling jzampieron$ ./run_fio_sync_heavy.sh
test-randwrite: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=posixaio, iodepth=8
...
fio-3.12
Starting 32 processes
test-randwrite: Laying out IO file (1 file / 5120MiB)
Jobs: 19 (f=19): [E(2),w(1),E(4),w(2),E(2),w(1),E(2),w(2),E(1),w(1),E(1),w(2),E(1),w(10)][1.1%][w=62.8MiB/s][w=16.1k IOPS][eta 47m:15s]
test-randwrite: (groupid=0, jobs=32): err= 0: pid=99860: Wed Mar 13 06:44:01 2019
  write: IOPS=15.8k, BW=61.7MiB/s (64.7MB/s)(1851MiB/30009msec)
    slat (nsec): min=1491, max=16204k, avg=3907.81, stdev=57031.34
    clat (usec): min=28, max=299243, avg=3101.30, stdev=2857.36
     lat (usec): min=43, max=299247, avg=3105.21, stdev=2857.71
    clat percentiles (usec):
     |  1.00th=[ 2245],  5.00th=[ 2474], 10.00th=[ 2606], 20.00th=[ 2737],
     | 30.00th=[ 2868], 40.00th=[ 2966], 50.00th=[ 3032], 60.00th=[ 3130],
     | 70.00th=[ 3228], 80.00th=[ 3326], 90.00th=[ 3490], 95.00th=[ 3621],
     | 99.00th=[ 4015], 99.50th=[ 5276], 99.90th=[11731], 99.95th=[23200],
     | 99.99th=[51643]
   bw (  KiB/s): min=  894, max= 2912, per=3.12%, avg=1968.50, stdev=259.64, samples=1906
   iops        : min=  223, max=  728, avg=491.91, stdev=64.83, samples=1906
  lat (usec)   : 50=0.01%, 100=0.01%, 250=0.01%, 500=0.01%, 750=0.01%
  lat (usec)   : 1000=0.01%
  lat (msec)   : 2=0.11%, 4=98.85%, 10=0.88%, 20=0.10%, 50=0.03%
  lat (msec)   : 100=0.01%, 500=0.01%
  fsync/fdatasync/sync_file_range:
    sync (usec): min=172, max=318970, avg=6442.63, stdev=5924.07
    sync percentiles (msec):
     |  1.00th=[    3],  5.00th=[    3], 10.00th=[    4], 20.00th=[    4],
     | 30.00th=[    4], 40.00th=[    5], 50.00th=[    6], 60.00th=[    7],
     | 70.00th=[    8], 80.00th=[    9], 90.00th=[   12], 95.00th=[   13],
     | 99.00th=[   18], 99.50th=[   19], 99.90th=[   27], 99.95th=[   36],
     | 99.99th=[  305]
  cpu          : usr=1.00%, sys=0.78%, ctx=908649, majf=0, minf=892
  IO depths    : 1=24.9%, 2=53.0%, 4=58.6%, 8=3.7%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.1%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,473862,0,190635 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=8

Run status group 0 (all jobs):
  WRITE: bw=61.7MiB/s (64.7MB/s), 61.7MiB/s-61.7MiB/s (64.7MB/s-64.7MB/s), io=1851MiB (1941MB), run=30009-30009msec
Jeffreys-MacBook-Pro:tooling jzampieron$
```

### Results - fio - Sync Heavy - Large Block ###

```
Jeffreys-MacBook-Pro:tooling jzampieron$ ./run_fio_sync_heavy_lb.sh
test-randwrite: (g=0): rw=randwrite, bs=(R) 64.0KiB-64.0KiB, (W) 64.0KiB-64.0KiB, (T) 64.0KiB-64.0KiB, ioengine=posixaio, iodepth=8
...
fio-3.12
Starting 32 processes
Jobs: 32 (f=32): [w(32)][100.0%][w=274MiB/s][w=4382 IOPS][eta 00m:00s]
test-randwrite: (groupid=0, jobs=32): err= 0: pid=99916: Wed Mar 13 06:45:23 2019
  write: IOPS=3440, BW=215MiB/s (225MB/s)(6454MiB/30013msec)
    slat (nsec): min=1574, max=660249, avg=3469.13, stdev=2956.16
    clat (msec): min=2, max=369, avg=13.50, stdev=20.88
     lat (msec): min=2, max=369, avg=13.51, stdev=20.88
    clat percentiles (msec):
     |  1.00th=[    8],  5.00th=[    9], 10.00th=[    9], 20.00th=[   10],
     | 30.00th=[   10], 40.00th=[   11], 50.00th=[   11], 60.00th=[   11],
     | 70.00th=[   12], 80.00th=[   13], 90.00th=[   15], 95.00th=[   20],
     | 99.00th=[  120], 99.50th=[  207], 99.90th=[  288], 99.95th=[  342],
     | 99.99th=[  368]
   bw (  KiB/s): min=  896, max=18778, per=3.12%, avg=6869.90, stdev=2697.41, samples=1918
   iops        : min=   14, max=  293, avg=107.09, stdev=42.19, samples=1918
  lat (msec)   : 4=0.01%, 10=36.81%, 20=58.62%, 50=3.15%, 100=0.24%
  lat (msec)   : 250=1.01%, 500=0.16%
  fsync/fdatasync/sync_file_range:
    sync (msec): min=4, max=422, avg=26.50, stdev=31.83
    sync percentiles (msec):
     |  1.00th=[    8],  5.00th=[    9], 10.00th=[   10], 20.00th=[   11],
     | 30.00th=[   13], 40.00th=[   18], 50.00th=[   20], 60.00th=[   23],
     | 70.00th=[   28], 80.00th=[   33], 90.00th=[   44], 95.00th=[   56],
     | 99.00th=[  207], 99.50th=[  257], 99.90th=[  355], 99.95th=[  376],
     | 99.99th=[  405]
  cpu          : usr=0.31%, sys=0.20%, ctx=191268, majf=0, minf=868
  IO depths    : 1=21.7%, 2=58.9%, 4=63.2%, 8=3.8%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.1%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,103256,0,49260 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=8

Run status group 0 (all jobs):
  WRITE: bw=215MiB/s (225MB/s), 215MiB/s-215MiB/s (225MB/s-225MB/s), io=6454MiB (6767MB), run=30013-30013msec
Jeffreys-MacBook-Pro:tooling jzampieron$
```

### Results - fio - Async ###

```
Jeffreys-MacBook-Pro:tooling jzampieron$ ./run_fio_async.sh
test-randwrite: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=posixaio, iodepth=128
fio-3.12
Starting 1 process
test-randwrite: Laying out IO file (1 file / 5120MiB)
Jobs: 1 (f=1): [F(1)][100.0%][w=87.8MiB/s][w=22.5k IOPS][eta 00m:00s]
test-randwrite: (groupid=0, jobs=1): err= 0: pid=99981: Wed Mar 13 06:47:36 2019
  write: IOPS=20.3k, BW=79.2MiB/s (83.1MB/s)(2378MiB/30025msec)
    slat (nsec): min=1481, max=96710, avg=2360.34, stdev=1879.08
    clat (usec): min=92, max=256858, avg=782.15, stdev=3595.78
     lat (usec): min=98, max=256860, avg=784.51, stdev=3595.78
    clat percentiles (usec):
     |  1.00th=[   469],  5.00th=[   553], 10.00th=[   586], 20.00th=[   627],
     | 30.00th=[   652], 40.00th=[   676], 50.00th=[   693], 60.00th=[   709],
     | 70.00th=[   734], 80.00th=[   758], 90.00th=[   807], 95.00th=[   873],
     | 99.00th=[  1106], 99.50th=[  1221], 99.90th=[  8094], 99.95th=[ 18220],
     | 99.99th=[229639]
   bw (  KiB/s): min=46808, max=94080, per=99.62%, avg=80802.75, stdev=14591.17, samples=59
   iops        : min=11702, max=23520, avg=20200.42, stdev=3647.88, samples=59
  lat (usec)   : 100=0.01%, 250=0.01%, 500=1.84%, 750=75.82%, 1000=20.56%
  lat (msec)   : 2=1.48%, 4=0.08%, 10=0.14%, 20=0.02%, 50=0.01%
  lat (msec)   : 100=0.01%, 250=0.03%, 500=0.01%
  cpu          : usr=30.05%, sys=24.51%, ctx=527436, majf=0, minf=27
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=32.9%, 16=67.1%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.3%, 8=0.7%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,608831,0,1 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=128

Run status group 0 (all jobs):
  WRITE: bw=79.2MiB/s (83.1MB/s), 79.2MiB/s-79.2MiB/s (83.1MB/s-83.1MB/s), io=2378MiB (2494MB), run=30025-30025msec
Jeffreys-MacBook-Pro:tooling jzampieron$
```

### Results - fio - Async - Large Block ###

```
Jeffreys-MacBook-Pro:tooling jzampieron$ ./run_fio_async_lb.sh
test-randwrite: (g=0): rw=randwrite, bs=(R) 64.0KiB-64.0KiB, (W) 64.0KiB-64.0KiB, (T) 64.0KiB-64.0KiB, ioengine=posixaio, iodepth=128
fio-3.12
Starting 1 process
test-randwrite: Laying out IO file (1 file / 5120MiB)
Jobs: 1 (f=1): [w(1)][96.6%][w=313MiB/s][w=5007 IOPS][eta 00m:01s]
test-randwrite: (groupid=0, jobs=1): err= 0: pid=139: Wed Mar 13 06:49:38 2019
  write: IOPS=2956, BW=185MiB/s (194MB/s)(5120MiB/27713msec)
    slat (nsec): min=1667, max=111024, avg=3020.11, stdev=2097.30
    clat (usec): min=898, max=414035, avg=5403.62, stdev=16903.56
     lat (usec): min=902, max=414037, avg=5406.64, stdev=16903.60
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    3], 10.00th=[    3], 20.00th=[    3],
     | 30.00th=[    4], 40.00th=[    4], 50.00th=[    4], 60.00th=[    4],
     | 70.00th=[    5], 80.00th=[    5], 90.00th=[    6], 95.00th=[    9],
     | 99.00th=[   34], 99.50th=[  120], 99.90th=[  300], 99.95th=[  334],
     | 99.99th=[  405]
   bw (  KiB/s): min=33213, max=337664, per=99.19%, avg=187658.95, stdev=77106.07, samples=55
   iops        : min=  518, max= 5276, avg=2931.80, stdev=1204.74, samples=55
  lat (usec)   : 1000=0.01%
  lat (msec)   : 2=0.84%, 4=67.68%, 10=27.68%, 20=2.04%, 50=1.01%
  lat (msec)   : 100=0.20%, 250=0.42%, 500=0.13%
  cpu          : usr=4.89%, sys=4.44%, ctx=85129, majf=0, minf=28
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=47.8%, 16=52.2%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.0%, 8=1.0%, 16=0.1%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,81920,0,1 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=128

Run status group 0 (all jobs):
  WRITE: bw=185MiB/s (194MB/s), 185MiB/s-185MiB/s (194MB/s-194MB/s), io=5120MiB (5369MB), run=27713-27713msec
Jeffreys-MacBook-Pro:tooling jzampieron$ 
```
