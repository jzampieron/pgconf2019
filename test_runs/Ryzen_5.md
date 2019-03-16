# Test Runs on AMD Ryzen 5 #

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

- File system is *btrfs* RAID1 

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
number of transactions actually processed: 1875362
latency average = 15.995 ms
latency stddev = 45.437 ms
tps = 6249.950008 (including connections establishing)
tps = 6250.004449 (excluding connections establishing)
```

### Results - fio - Sync Heavy ###

```
jzampieron@hercules:~/Documents/Speaking/pgconf2019/terraform/modules/aws-ec2/tooling$ ./run_fio_sync_heavy.sh 
test-randwrite: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=8
...
fio-3.1
Starting 64 processes
test-randwrite: Laying out IO file (1 file / 5120MiB)
Jobs: 64 (f=64): [w(64)][100.0%][r=0KiB/s,w=22.0MiB/s][r=0,w=5632 IOPS][eta 00m:00s]
test-randwrite: (groupid=0, jobs=64): err= 0: pid=4781: Sat Mar 16 19:50:53 2019
  write: IOPS=8405, BW=32.8MiB/s (34.4MB/s)(986MiB/30031msec)
    slat (usec): min=11, max=97303, avg=4591.77, stdev=5591.15
    clat (usec): min=185, max=261498, avg=53274.90, stdev=22945.01
     lat (usec): min=225, max=267795, avg=57868.04, stdev=22968.51
    clat percentiles (msec):
     |  1.00th=[    7],  5.00th=[   18], 10.00th=[   25], 20.00th=[   34],
     | 30.00th=[   41], 40.00th=[   47], 50.00th=[   53], 60.00th=[   59],
     | 70.00th=[   66], 80.00th=[   72], 90.00th=[   82], 95.00th=[   89],
     | 99.00th=[  114], 99.50th=[  129], 99.90th=[  169], 99.95th=[  182],
     | 99.99th=[  215]
   bw (  KiB/s): min=  161, max= 1014, per=1.56%, avg=525.83, stdev=118.24, samples=3840
   iops        : min=   40, max=  253, avg=131.25, stdev=29.49, samples=3840
  lat (usec)   : 250=0.01%, 500=0.12%, 750=0.08%, 1000=0.03%
  lat (msec)   : 2=0.08%, 4=0.28%, 10=1.26%, 20=4.87%, 50=38.72%
  lat (msec)   : 100=52.45%, 250=2.11%, 500=0.01%
  cpu          : usr=0.09%, sys=6.80%, ctx=3895258, majf=0, minf=741
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=99.8%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.1%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwt: total=0,252416,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=8

Run status group 0 (all jobs):
  WRITE: bw=32.8MiB/s (34.4MB/s), 32.8MiB/s-32.8MiB/s (34.4MB/s-34.4MB/s), io=986MiB (1034MB), run=30031-30031msec
jzampieron@hercules:~/Documents/Speaking/pgconf2019/terraform/modules/aws-ec2/tooling$
```

### Results - fio - Sync Heavy - Large Block ###

```
jzampieron@hercules:~/Documents/Speaking/pgconf2019/terraform/modules/aws-ec2/tooling$ ./run_fio_sync_heavy_lb.sh 
test-randwrite: (g=0): rw=randwrite, bs=(R) 64.0KiB-64.0KiB, (W) 64.0KiB-64.0KiB, (T) 64.0KiB-64.0KiB, ioengine=libaio, iodepth=8
...
fio-3.1
Starting 64 processes
test-randwrite: Laying out IO file (1 file / 5120MiB)
Jobs: 64 (f=64): [w(64)][100.0%][r=0KiB/s,w=335MiB/s][r=0,w=5366 IOPS][eta 00m:00s]
test-randwrite: (groupid=0, jobs=64): err= 0: pid=4869: Sat Mar 16 19:51:42 2019
  write: IOPS=6154, BW=385MiB/s (403MB/s)(11.3GiB/30056msec)
    slat (usec): min=9, max=122369, avg=6765.56, stdev=9821.13
    clat (usec): min=5, max=310633, avg=72673.12, stdev=32225.36
     lat (usec): min=393, max=310747, avg=79440.11, stdev=32516.14
    clat percentiles (msec):
     |  1.00th=[    8],  5.00th=[   27], 10.00th=[   39], 20.00th=[   50],
     | 30.00th=[   56], 40.00th=[   63], 50.00th=[   68], 60.00th=[   74],
     | 70.00th=[   83], 80.00th=[   94], 90.00th=[  116], 95.00th=[  134],
     | 99.00th=[  171], 99.50th=[  190], 99.90th=[  224], 99.95th=[  234],
     | 99.99th=[  257]
   bw (  KiB/s): min= 3206, max= 9984, per=1.57%, avg=6200.52, stdev=1168.10, samples=3840
   iops        : min=   50, max=  156, avg=96.44, stdev=18.24, samples=3840
  lat (usec)   : 10=0.01%, 20=0.01%, 50=0.01%, 100=0.01%, 250=0.01%
  lat (usec)   : 500=0.16%, 750=0.29%, 1000=0.07%
  lat (msec)   : 2=0.04%, 4=0.07%, 10=0.69%, 20=2.11%, 50=17.57%
  lat (msec)   : 100=62.32%, 250=16.65%, 500=0.01%
  cpu          : usr=0.11%, sys=6.26%, ctx=4376978, majf=0, minf=677
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=99.8%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.1%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwt: total=0,184979,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=8

Run status group 0 (all jobs):
  WRITE: bw=385MiB/s (403MB/s), 385MiB/s-385MiB/s (403MB/s-403MB/s), io=11.3GiB (12.1GB), run=30056-30056msec
jzampieron@hercules:~/Documents/Speaking/pgconf2019/terraform/modules/aws-ec2/tooling$
```

### Results - fio - Pathological Sync ###

```
jzampieron@hercules:~/Documents/Speaking/pgconf2019/terraform/modules/aws-ec2/tooling$ ./run_fio_pathological_sync.sh 
test-randwrite: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=8
...
fio-3.1
Starting 64 processes
test-randwrite: Laying out IO file (1 file / 5120MiB)
Jobs: 64 (f=64): [w(64)][100.0%][r=0KiB/s,w=12.7MiB/s][r=0,w=3263 IOPS][eta 00m:00s]
test-randwrite: (groupid=0, jobs=64): err= 0: pid=4968: Sat Mar 16 19:52:46 2019
  write: IOPS=3469, BW=13.6MiB/s (14.2MB/s)(407MiB/30018msec)
    slat (usec): min=18, max=71386, avg=8524.84, stdev=7952.60
    clat (usec): min=3, max=342362, avg=128950.51, stdev=52909.46
     lat (msec): min=4, max=375, avg=137.48, stdev=55.37
    clat percentiles (msec):
     |  1.00th=[   48],  5.00th=[   57], 10.00th=[   62], 20.00th=[   70],
     | 30.00th=[   81], 40.00th=[  120], 50.00th=[  138], 60.00th=[  148],
     | 70.00th=[  161], 80.00th=[  176], 90.00th=[  197], 95.00th=[  213],
     | 99.00th=[  249], 99.50th=[  262], 99.90th=[  288], 99.95th=[  300],
     | 99.99th=[  321]
   bw (  KiB/s): min=  104, max=  472, per=1.56%, avg=216.05, stdev=92.91, samples=3840
   iops        : min=   26, max=  118, avg=53.97, stdev=23.18, samples=3840
  lat (usec)   : 4=0.01%, 10=0.01%, 20=0.01%, 50=0.02%, 100=0.01%
  lat (usec)   : 250=0.01%
  lat (msec)   : 10=0.01%, 20=0.03%, 50=1.50%, 100=34.35%, 250=63.16%
  lat (msec)   : 500=0.90%
  cpu          : usr=0.04%, sys=7.39%, ctx=4445370, majf=0, minf=682
  IO depths    : 1=0.1%, 2=0.1%, 4=0.2%, 8=99.6%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.9%, 8=0.1%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwt: total=0,104138,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=8

Run status group 0 (all jobs):
  WRITE: bw=13.6MiB/s (14.2MB/s), 13.6MiB/s-13.6MiB/s (14.2MB/s-14.2MB/s), io=407MiB (427MB), run=30018-30018msec
jzampieron@hercules:~/Documents/Speaking/pgconf2019/terraform/modules/aws-ec2/tooling$ 
```

### Results - fio - Async ###

```
jzampieron@hercules:~/Documents/Speaking/pgconf2019/terraform/modules/aws-ec2/tooling$ ./run_fio_async.sh 
test-randwrite: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=128
fio-3.1
Starting 1 process
test-randwrite: Laying out IO file (1 file / 5120MiB)
Jobs: 1 (f=1): [F(1)][100.0%][r=0KiB/s,w=16.5MiB/s][r=0,w=4231 IOPS][eta 00m:00s]
test-randwrite: (groupid=0, jobs=1): err= 0: pid=5061: Sat Mar 16 19:53:36 2019
  write: IOPS=40.8k, BW=159MiB/s (167MB/s)(4944MiB/31026msec)
    slat (usec): min=9, max=611, avg=21.22, stdev= 8.62
    clat (usec): min=13, max=31026, avg=3010.94, stdev=960.60
     lat (usec): min=31, max=31040, avg=3032.49, stdev=964.07
    clat percentiles (usec):
     |  1.00th=[ 2376],  5.00th=[ 2474], 10.00th=[ 2507], 20.00th=[ 2573],
     | 30.00th=[ 2606], 40.00th=[ 2671], 50.00th=[ 2737], 60.00th=[ 2835],
     | 70.00th=[ 2966], 80.00th=[ 3195], 90.00th=[ 3654], 95.00th=[ 4752],
     | 99.00th=[ 5604], 99.50th=[ 6456], 99.90th=[15926], 99.95th=[17171],
     | 99.99th=[26870]
   bw (  KiB/s): min=145568, max=183760, per=100.00%, avg=168743.49, stdev=8360.90, samples=59
   iops        : min=36392, max=45940, avg=42185.85, stdev=2090.20, samples=59
  lat (usec)   : 20=0.01%, 50=0.01%, 100=0.01%, 250=0.01%, 500=0.01%
  lat (usec)   : 750=0.01%, 1000=0.01%
  lat (msec)   : 2=0.01%, 4=91.84%, 10=7.85%, 20=0.27%, 50=0.02%
  cpu          : usr=6.80%, sys=89.00%, ctx=139345, majf=0, minf=10
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwt: total=0,1265652,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=128

Run status group 0 (all jobs):
  WRITE: bw=159MiB/s (167MB/s), 159MiB/s-159MiB/s (167MB/s-167MB/s), io=4944MiB (5184MB), run=31026-31026msec
jzampieron@hercules:~/Documents/Speaking/pgconf2019/terraform/modules/aws-ec2/tooling$ 
```

### Results - fio - Async - Large Block ###

```
jzampieron@hercules:~/Documents/Speaking/pgconf2019/terraform/modules/aws-ec2/tooling$ ./run_fio_async_lb.sh 
test-randwrite: (g=0): rw=randwrite, bs=(R) 64.0KiB-64.0KiB, (W) 64.0KiB-64.0KiB, (T) 64.0KiB-64.0KiB, ioengine=libaio, iodepth=128
fio-3.1
Starting 1 process
test-randwrite: Laying out IO file (1 file / 5120MiB)
Jobs: 1 (f=1): [w(1)][100.0%][r=0KiB/s,w=1280MiB/s][r=0,w=20.5k IOPS][eta 00m:00s]
test-randwrite: (groupid=0, jobs=1): err= 0: pid=5106: Sat Mar 16 19:54:08 2019
  write: IOPS=19.6k, BW=1227MiB/s (1286MB/s)(5120MiB/4174msec)
    slat (usec): min=23, max=264, avg=43.82, stdev=13.65
    clat (usec): min=2807, max=36952, avg=6315.05, stdev=2521.86
     lat (usec): min=2854, max=36986, avg=6359.31, stdev=2523.98
    clat percentiles (usec):
     |  1.00th=[ 4555],  5.00th=[ 4752], 10.00th=[ 4817], 20.00th=[ 4948],
     | 30.00th=[ 5080], 40.00th=[ 5276], 50.00th=[ 5473], 60.00th=[ 5800],
     | 70.00th=[ 6325], 80.00th=[ 7242], 90.00th=[ 8717], 95.00th=[10028],
     | 99.00th=[17171], 99.50th=[21890], 99.90th=[32637], 99.95th=[34866],
     | 99.99th=[36439]
   bw (  MiB/s): min= 1184, max= 1350, per=100.00%, avg=1255.80, stdev=51.88, samples=8
   iops        : min=18946, max=21606, avg=20092.75, stdev=830.17, samples=8
  lat (msec)   : 4=0.27%, 10=94.70%, 20=4.33%, 50=0.69%
  cpu          : usr=5.85%, sys=86.87%, ctx=14968, majf=0, minf=9
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=99.9%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwt: total=0,81920,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=128

Run status group 0 (all jobs):
  WRITE: bw=1227MiB/s (1286MB/s), 1227MiB/s-1227MiB/s (1286MB/s-1286MB/s), io=5120MiB (5369MB), run=4174-4174msec
jzampieron@hercules:~/Documents/Speaking/pgconf2019/terraform/modules/aws-ec2/tooling$
```
