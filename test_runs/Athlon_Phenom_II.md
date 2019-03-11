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

## Run 1 - HDD ##

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

## Run 2 - SSD ##

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

### Results - fio - Sync Heavy ###

```
jzampieron@atlas:~/Documents/Speaking/pgconf2019/tooling$ ./run_fio_sync_heavy.sh
test-randwrite: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=8
...
fio-3.1
Starting 64 processes
test-randwrite: Laying out IO file (1 file / 5120MiB)
Jobs: 64 (f=64): [w(64)][100.0%][r=0KiB/s,w=11.0MiB/s][r=0,w=2820 IOPS][eta 00m:00s]
test-randwrite: (groupid=0, jobs=64): err= 0: pid=19787: Sun Mar 10 20:13:38 2019
  write: IOPS=3551, BW=13.9MiB/s (14.5MB/s)(417MiB/30079msec)
    slat (usec): min=13, max=242313, avg=7680.00, stdev=22518.79
    clat (nsec): min=1403, max=429971k, avg=125782135.94, stdev=75027735.34
     lat (usec): min=277, max=438950, avg=133463.60, stdev=71547.55
    clat percentiles (usec):
     |  1.00th=[   766],  5.00th=[  8586], 10.00th=[ 23987], 20.00th=[ 62653],
     | 30.00th=[ 84411], 40.00th=[101188], 50.00th=[120062], 60.00th=[135267],
     | 70.00th=[158335], 80.00th=[183501], 90.00th=[225444], 95.00th=[263193],
     | 99.00th=[333448], 99.50th=[362808], 99.90th=[408945], 99.95th=[417334],
     | 99.99th=[429917]
   bw (  KiB/s): min=   63, max=  449, per=1.57%, avg=222.71, stdev=60.81, samples=3840
   iops        : min=   15, max=  112, avg=55.45, stdev=15.19, samples=3840
  lat (usec)   : 2=0.01%, 4=0.01%, 10=0.02%, 20=0.01%, 50=0.01%
  lat (usec)   : 100=0.01%, 250=0.05%, 500=0.61%, 750=0.27%, 1000=0.19%
  lat (msec)   : 2=0.45%, 4=1.11%, 10=3.10%, 20=3.42%, 50=4.90%
  lat (msec)   : 100=24.96%, 250=54.30%, 500=6.58%
  cpu          : usr=0.05%, sys=1.00%, ctx=183013, majf=0, minf=554
  IO depths    : 1=0.1%, 2=0.1%, 4=0.2%, 8=99.6%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.9%, 8=0.1%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwt: total=0,106822,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=8

Run status group 0 (all jobs):
  WRITE: bw=13.9MiB/s (14.5MB/s), 13.9MiB/s-13.9MiB/s (14.5MB/s-14.5MB/s), io=417MiB (438MB), run=30079-30079msec
```

### Results - fio - Sync Heavy - Large Block ###

```
jzampieron@atlas:~/Documents/Speaking/pgconf2019/tooling$ ./run_fio_sync_heavy_lb.sh
test-randwrite: (g=0): rw=randwrite, bs=(R) 64.0KiB-64.0KiB, (W) 64.0KiB-64.0KiB, (T) 64.0KiB-64.0KiB, ioengine=libaio, iodepth=8
...
fio-3.1
Starting 64 processes
Jobs: 64 (f=64): [w(64)][100.0%][r=0KiB/s,w=92.8MiB/s][r=0,w=1485 IOPS][eta 00m:00s]
test-randwrite: (groupid=0, jobs=64): err= 0: pid=19887: Sun Mar 10 20:16:32 2019
  write: IOPS=1658, BW=104MiB/s (109MB/s)(3115MiB/30058msec)
    slat (usec): min=58, max=451399, avg=22248.64, stdev=52906.69
    clat (usec): min=2, max=845172, avg=268758.96, stdev=151867.67
     lat (usec): min=828, max=943684, avg=291009.38, stdev=144469.68
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[   37], 10.00th=[   69], 20.00th=[  132],
     | 30.00th=[  184], 40.00th=[  226], 50.00th=[  264], 60.00th=[  300],
     | 70.00th=[  338], 80.00th=[  388], 90.00th=[  472], 95.00th=[  542],
     | 99.00th=[  676], 99.50th=[  735], 99.90th=[  793], 99.95th=[  810],
     | 99.99th=[  827]
   bw (  KiB/s): min=  127, max= 4032, per=1.57%, avg=1666.09, stdev=623.78, samples=3822
   iops        : min=    1, max=   63, avg=25.80, stdev= 9.66, samples=3822
  lat (usec)   : 4=0.01%, 10=0.01%, 250=0.01%, 500=0.02%, 750=0.08%
  lat (usec)   : 1000=0.43%
  lat (msec)   : 2=0.40%, 4=0.52%, 10=0.74%, 20=1.03%, 50=3.58%
  lat (msec)   : 100=7.90%, 250=31.89%, 500=45.64%, 750=7.36%, 1000=0.38%
  cpu          : usr=0.03%, sys=0.86%, ctx=100872, majf=0, minf=601
  IO depths    : 1=0.1%, 2=0.3%, 4=0.5%, 8=99.1%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.9%, 8=0.1%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwt: total=0,49837,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=8

Run status group 0 (all jobs):
  WRITE: bw=104MiB/s (109MB/s), 104MiB/s-104MiB/s (109MB/s-109MB/s), io=3115MiB (3266MB), run=30058-30058msec
```

### Results - fio - Async ###

```
jzampieron@atlas:~/Documents/Speaking/pgconf2019/tooling$ ./run_fio_async.sh 
test-randwrite: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=128
fio-3.1
Starting 1 process
test-randwrite: Laying out IO file (1 file / 5120MiB)
Jobs: 1 (f=1): [F(1)][100.0%][r=0KiB/s,w=13.8MiB/s][r=0,w=3543 IOPS][eta 00m:00s]
test-randwrite: (groupid=0, jobs=1): err= 0: pid=20108: Sun Mar 10 20:21:20 2019
  write: IOPS=24.0k, BW=93.8MiB/s (98.3MB/s)(2958MiB/31546msec)
    slat (usec): min=15, max=2317, avg=35.93, stdev=16.64
    clat (usec): min=35, max=234172, avg=5032.48, stdev=4071.80
     lat (usec): min=66, max=234203, avg=5068.67, stdev=4074.02
    clat percentiles (msec):
     |  1.00th=[    4],  5.00th=[    5], 10.00th=[    5], 20.00th=[    5],
     | 30.00th=[    5], 40.00th=[    5], 50.00th=[    5], 60.00th=[    5],
     | 70.00th=[    6], 80.00th=[    6], 90.00th=[    7], 95.00th=[    8],
     | 99.00th=[   12], 99.50th=[   13], 99.90th=[   27], 99.95th=[   83],
     | 99.99th=[  226]
   bw (  KiB/s): min=57200, max=118936, per=100.00%, avg=100740.64, stdev=11895.54, samples=59
   iops        : min=14300, max=29734, avg=25185.17, stdev=2973.87, samples=59
  lat (usec)   : 50=0.01%, 100=0.01%, 250=0.01%, 500=0.01%, 750=0.01%
  lat (usec)   : 1000=0.01%
  lat (msec)   : 2=0.01%, 4=3.61%, 10=94.57%, 20=1.50%, 50=0.25%
  lat (msec)   : 100=0.02%, 250=0.03%
  cpu          : usr=6.84%, sys=85.15%, ctx=195532, majf=0, minf=9
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwt: total=0,757246,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=128

Run status group 0 (all jobs):
  WRITE: bw=93.8MiB/s (98.3MB/s), 93.8MiB/s-93.8MiB/s (98.3MB/s-98.3MB/s), io=2958MiB (3102MB), run=31546-31546msec
```

### Results - fio - Async - Large Block ###

```
jzampieron@atlas:~/Documents/Speaking/pgconf2019/tooling$ ./run_fio_async_lb.sh 
test-randwrite: (g=0): rw=randwrite, bs=(R) 64.0KiB-64.0KiB, (W) 64.0KiB-64.0KiB, (T) 64.0KiB-64.0KiB, ioengine=libaio, iodepth=128
fio-3.1
Starting 1 process
test-randwrite: Laying out IO file (1 file / 5120MiB)
Jobs: 1 (f=1): [w(1)][100.0%][r=0KiB/s,w=322MiB/s][r=0,w=5155 IOPS][eta 00m:00s]
test-randwrite: (groupid=0, jobs=1): err= 0: pid=20242: Sun Mar 10 20:23:46 2019
  write: IOPS=4142, BW=259MiB/s (271MB/s)(5120MiB/19775msec)
    slat (usec): min=55, max=1799, avg=119.61, stdev=57.70
    clat (usec): min=1093, max=299152, avg=30424.86, stdev=18697.82
     lat (usec): min=1192, max=299265, avg=30544.91, stdev=18701.03
    clat percentiles (msec):
     |  1.00th=[    7],  5.00th=[   10], 10.00th=[   12], 20.00th=[   16],
     | 30.00th=[   20], 40.00th=[   24], 50.00th=[   28], 60.00th=[   33],
     | 70.00th=[   37], 80.00th=[   42], 90.00th=[   51], 95.00th=[   63],
     | 99.00th=[   86], 99.50th=[   93], 99.90th=[  257], 99.95th=[  264],
     | 99.99th=[  288]
   bw (  KiB/s): min=148224, max=339584, per=100.00%, avg=267808.33, stdev=58828.66, samples=39
   iops        : min= 2316, max= 5306, avg=4184.46, stdev=919.15, samples=39
  lat (msec)   : 2=0.01%, 4=0.03%, 10=6.68%, 20=24.04%, 50=58.68%
  lat (msec)   : 100=10.33%, 250=0.10%, 500=0.13%
  cpu          : usr=3.27%, sys=49.55%, ctx=67978, majf=0, minf=7
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=99.9%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwt: total=0,81920,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=128

Run status group 0 (all jobs):
  WRITE: bw=259MiB/s (271MB/s), 259MiB/s-259MiB/s (271MB/s-271MB/s), io=5120MiB (5369MB), run=19775-19775msec
```