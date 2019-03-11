# Test Runs on Pre-2012 AMD Athlon Phenom II #

Kubutu 18.04.1

| Item                  | Details          |
| --------------------- | ---------------- |
| Model Name            | Custom	   |
| Model Identifier      | AMD Ryzen 5 2600 |
| Processor Name        | AMD Ryzen 5 2600 |
| Processor Speed       | 3.4 GHz        |
| Number of Processors  | 1              |
| Total Number of Cores | 6              |
| Memory                | 16 GB          |
| --------------------- | -------------- |

| Physical Drive        | ----------------------- |
| --------------------- | ----------------------- |
| Device Name           | 2x INTEL SSDPEKNW010T8  |
| Medium Type           | NVMe M.2          |
| Protocol              | PCIe x2/x4        |
| Internal              | Yes               |
| File System           | btrfs - raid1     |
| --------------------- | ----------------- |


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

### Results - fio - Sync Heavy ###

```
jzampieron@hercules:~/Documents/Speaking/pgconf2019/tooling$ ./run_fio_sync_heavy.sh 
test-randwrite: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=8
...
fio-3.1
Starting 64 processes
test-randwrite: Laying out IO file (1 file / 5120MiB)
Jobs: 64 (f=64): [w(64)][100.0%][r=0KiB/s,w=24.0MiB/s][r=0,w=6144 IOPS][eta 00m:00s]
test-randwrite: (groupid=0, jobs=64): err= 0: pid=15471: Sun Mar 10 20:55:07 2019
  write: IOPS=6882, BW=26.9MiB/s (28.2MB/s)(808MiB/30072msec)
    slat (usec): min=11, max=85925, avg=3121.19, stdev=4720.11
    clat (usec): min=202, max=194837, avg=65035.00, stdev=24751.84
     lat (usec): min=315, max=211598, avg=68157.52, stdev=24740.51
    clat percentiles (msec):
     |  1.00th=[    5],  5.00th=[   16], 10.00th=[   26], 20.00th=[   47],
     | 30.00th=[   57], 40.00th=[   64], 50.00th=[   69], 60.00th=[   74],
     | 70.00th=[   80], 80.00th=[   85], 90.00th=[   92], 95.00th=[   99],
     | 99.00th=[  114], 99.50th=[  124], 99.90th=[  148], 99.95th=[  161],
     | 99.99th=[  178]
   bw (  KiB/s): min=  160, max=  732, per=1.57%, avg=431.40, stdev=68.77, samples=3840
   iops        : min=   40, max=  183, avg=107.57, stdev=17.14, samples=3840
  lat (usec)   : 250=0.01%, 500=0.16%, 750=0.13%, 1000=0.05%
  lat (msec)   : 2=0.18%, 4=0.33%, 10=1.68%, 20=4.92%, 50=15.30%
  lat (msec)   : 100=73.07%, 250=4.16%
  cpu          : usr=0.07%, sys=11.37%, ctx=7665771, majf=0, minf=672
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=99.8%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.1%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwt: total=0,206960,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=8

Run status group 0 (all jobs):
  WRITE: bw=26.9MiB/s (28.2MB/s), 26.9MiB/s-26.9MiB/s (28.2MB/s-28.2MB/s), io=808MiB (848MB), run=30072-30072msec

```

### Results - fio - Sync Heavy - Large Block ###

```
jzampieron@hercules:~/Documents/Speaking/pgconf2019/tooling$ ./run_fio_sync_heavy_lb.sh 
test-randwrite: (g=0): rw=randwrite, bs=(R) 64.0KiB-64.0KiB, (W) 64.0KiB-64.0KiB, (T) 64.0KiB-64.0KiB, ioengine=libaio, iodepth=8
...
fio-3.1
Starting 64 processes
Jobs: 64 (f=64): [w(64)][100.0%][r=0KiB/s,w=238MiB/s][r=0,w=3806 IOPS][eta 00m:00s]
test-randwrite: (groupid=0, jobs=64): err= 0: pid=15571: Sun Mar 10 20:56:00 2019
  write: IOPS=4220, BW=264MiB/s (277MB/s)(7929MiB/30058msec)
    slat (usec): min=9, max=154400, avg=5347.66, stdev=10507.20
    clat (usec): min=2, max=447837, avg=106047.85, stdev=44533.86
     lat (usec): min=264, max=459303, avg=111397.17, stdev=44376.53
    clat percentiles (msec):
     |  1.00th=[    4],  5.00th=[   21], 10.00th=[   40], 20.00th=[   79],
     | 30.00th=[   91], 40.00th=[  100], 50.00th=[  108], 60.00th=[  116],
     | 70.00th=[  125], 80.00th=[  136], 90.00th=[  153], 95.00th=[  176],
     | 99.00th=[  234], 99.50th=[  262], 99.90th=[  300], 99.95th=[  313],
     | 99.99th=[  359]
   bw (  KiB/s): min= 1410, max= 6206, per=1.57%, avg=4237.45, stdev=687.41, samples=3840
   iops        : min=   22, max=   96, avg=65.84, stdev=10.68, samples=3840
  lat (usec)   : 4=0.01%, 100=0.01%, 250=0.02%, 500=0.36%, 750=0.25%
  lat (usec)   : 1000=0.12%
  lat (msec)   : 2=0.15%, 4=0.11%, 10=0.82%, 20=2.97%, 50=6.40%
  lat (msec)   : 100=29.48%, 250=58.71%, 500=0.61%
  cpu          : usr=0.07%, sys=10.61%, ctx=7849788, majf=0, minf=551
  IO depths    : 1=0.1%, 2=0.1%, 4=0.2%, 8=99.6%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.9%, 8=0.1%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwt: total=0,126864,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=8

Run status group 0 (all jobs):
  WRITE: bw=264MiB/s (277MB/s), 264MiB/s-264MiB/s (277MB/s-277MB/s), io=7929MiB (8314MB), run=30058-30058msec
```

### Results - fio - Async ###

```
jzampieron@hercules:~/Documents/Speaking/pgconf2019/tooling$ ./run_
run_fio_async_lb.sh       run_fio_sync_heavy.sh     run_pgbench_test.sh       
run_fio_async.sh          run_pgbench_init.sh       run_pg_server.sh          
run_fio_sync_heavy_lb.sh  run_pgbench_init.sh~      run_pg_server.sh~         
jzampieron@hercules:~/Documents/Speaking/pgconf2019/tooling$ ./run_fio_async.sh 
test-randwrite: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=128
fio-3.1
Starting 1 process
test-randwrite: Laying out IO file (1 file / 5120MiB)
Jobs: 1 (f=1): [F(1)][100.0%][r=0KiB/s,w=18.1MiB/s][r=0,w=4646 IOPS][eta 00m:00s]
test-randwrite: (groupid=0, jobs=1): err= 0: pid=15660: Sun Mar 10 20:57:01 2019
  write: IOPS=40.3k, BW=157MiB/s (165MB/s)(4889MiB/31078msec)
    slat (usec): min=10, max=610, avg=21.49, stdev= 8.42
    clat (usec): min=39, max=22568, avg=3044.40, stdev=949.31
     lat (usec): min=58, max=22581, avg=3066.22, stdev=953.08
    clat percentiles (usec):
     |  1.00th=[ 2376],  5.00th=[ 2474], 10.00th=[ 2507], 20.00th=[ 2573],
     | 30.00th=[ 2606], 40.00th=[ 2671], 50.00th=[ 2737], 60.00th=[ 2835],
     | 70.00th=[ 2999], 80.00th=[ 3261], 90.00th=[ 3949], 95.00th=[ 5014],
     | 99.00th=[ 5669], 99.50th=[ 6456], 99.90th=[15008], 99.95th=[16057],
     | 99.99th=[17957]
   bw (  KiB/s): min=145352, max=181632, per=100.00%, avg=166800.64, stdev=8691.64, samples=59
   iops        : min=36338, max=45408, avg=41700.10, stdev=2172.91, samples=59
  lat (usec)   : 50=0.01%, 100=0.01%, 250=0.01%, 500=0.01%, 750=0.01%
  lat (usec)   : 1000=0.01%
  lat (msec)   : 2=0.01%, 4=90.27%, 10=9.42%, 20=0.30%, 50=0.01%
  cpu          : usr=7.13%, sys=89.37%, ctx=115585, majf=0, minf=8
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwt: total=0,1251665,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=128

Run status group 0 (all jobs):
  WRITE: bw=157MiB/s (165MB/s), 157MiB/s-157MiB/s (165MB/s-165MB/s), io=4889MiB (5127MB), run=31078-31078msec

```

### Results - fio - Async - Large Block ###

```
jzampieron@hercules:~/Documents/Speaking/pgconf2019/tooling$ ./run_fio_async_lb.sh 
test-randwrite: (g=0): rw=randwrite, bs=(R) 64.0KiB-64.0KiB, (W) 64.0KiB-64.0KiB, (T) 64.0KiB-64.0KiB, ioengine=libaio, iodepth=128
fio-3.1
Starting 1 process
test-randwrite: Laying out IO file (1 file / 5120MiB)
Jobs: 1 (f=1): [w(1)][100.0%][r=0KiB/s,w=1277MiB/s][r=0,w=20.4k IOPS][eta 00m:00s]
test-randwrite: (groupid=0, jobs=1): err= 0: pid=15683: Sun Mar 10 20:57:37 2019
  write: IOPS=20.3k, BW=1269MiB/s (1330MB/s)(5120MiB/4036msec)
    slat (usec): min=24, max=182, avg=43.48, stdev=14.40
    clat (usec): min=2839, max=27206, avg=6232.13, stdev=2470.50
     lat (usec): min=2923, max=27239, avg=6276.01, stdev=2472.97
    clat percentiles (usec):
     |  1.00th=[ 4555],  5.00th=[ 4752], 10.00th=[ 4817], 20.00th=[ 4883],
     | 30.00th=[ 4948], 40.00th=[ 5080], 50.00th=[ 5276], 60.00th=[ 5538],
     | 70.00th=[ 6194], 80.00th=[ 7177], 90.00th=[ 8717], 95.00th=[10028],
     | 99.00th=[19006], 99.50th=[21365], 99.90th=[25297], 99.95th=[26608],
     | 99.99th=[27132]
   bw (  MiB/s): min= 1173, max= 1329, per=100.00%, avg=1270.05, stdev=49.62, samples=8
   iops        : min=18770, max=21278, avg=20320.75, stdev=794.00, samples=8
  lat (msec)   : 4=0.15%, 10=94.81%, 20=4.27%, 50=0.77%
  cpu          : usr=5.33%, sys=87.96%, ctx=15800, majf=0, minf=10
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=99.9%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwt: total=0,81920,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=128

Run status group 0 (all jobs):
  WRITE: bw=1269MiB/s (1330MB/s), 1269MiB/s-1269MiB/s (1330MB/s-1330MB/s), io=5120MiB (5369MB), run=4036-4036msec

```
