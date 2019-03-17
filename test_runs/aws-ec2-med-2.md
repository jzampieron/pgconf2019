# Test Runs on AWS-EC2-Med-2 #

See `terraform/aws-ec2-med-2/` for setup details.

## Cost ##

Using: https://calculator.s3.amazonaws.com/index.html

4x 1TB x 2k IOPS

| Service     | Cost        |
| ----------- | ----------- |
| Compute     | 140.55  USD |
| EBS Vol     | 500     USD |
| EBS IOPS    | 520     USD |
| Snaps       | 200     USD |
| ** Total ** | 1360.55 USD |

## Run 1 ##

- 4x 1TB x 2k IOPS (io1) SW RAID 0

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
number of transactions actually processed: 1133278
latency average = 26.470 ms
latency stddev = 14.634 ms
tps = 3775.791651 (including connections establishing)
tps = 3775.837383 (excluding connections establishing)
```

### Results - fio - Sync Heavy ###

```
ubuntu@ip-192-168-0-109:/data/tooling$ ./run_fio_sync_heavy.sh
test-randwrite: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=8
...
fio-3.1
Starting 64 processes
test-randwrite: Laying out IO file (1 file / 5120MiB)
Jobs: 64 (f=64): [w(64)][100.0%][r=0KiB/s,w=29.7MiB/s][r=0,w=7603 IOPS][eta 00m:00s]
test-randwrite: (groupid=0, jobs=64): err= 0: pid=8081: Sat Mar 16 21:43:50 2019
  write: IOPS=7677, BW=29.0MiB/s (31.4MB/s)(901MiB/30039msec)
    slat (usec): min=3, max=194168, avg=3765.52, stdev=11423.29
    clat (nsec): min=1611, max=552327k, avg=59109093.57, stdev=37573996.97
     lat (usec): min=337, max=552332, avg=62874.94, stdev=39656.14
    clat percentiles (usec):
     |  1.00th=[   449],  5.00th=[  1303], 10.00th=[ 23725], 20.00th=[ 29492],
     | 30.00th=[ 34866], 40.00th=[ 44827], 50.00th=[ 55313], 60.00th=[ 62129],
     | 70.00th=[ 69731], 80.00th=[ 85459], 90.00th=[104334], 95.00th=[126354],
     | 99.00th=[183501], 99.50th=[212861], 99.90th=[283116], 99.95th=[308282],
     | 99.99th=[408945]
   bw (  KiB/s): min=   96, max= 1354, per=1.57%, avg=481.26, stdev=130.97, samples=3840
   iops        : min=   24, max=  338, avg=120.00, stdev=32.70, samples=3840
  lat (usec)   : 2=0.01%, 50=0.01%, 100=0.01%, 250=0.01%, 500=1.73%
  lat (usec)   : 750=2.53%, 1000=0.58%
  lat (msec)   : 2=0.28%, 4=0.04%, 10=0.14%, 20=2.16%, 50=36.82%
  lat (msec)   : 100=44.14%, 250=11.36%, 500=0.22%, 750=0.01%
  cpu          : usr=0.04%, sys=0.26%, ctx=298067, majf=0, minf=558
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=99.8%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.1%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwt: total=0,230635,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=8

Run status group 0 (all jobs):
  WRITE: bw=29.0MiB/s (31.4MB/s), 29.0MiB/s-29.0MiB/s (31.4MB/s-31.4MB/s), io=901MiB (945MB), run=30039-30039msec

Disk stats (read/write):
    md0: ios=0/297274, merge=0/0, ticks=0/0, in_queue=0, util=0.00%, aggrios=0/130250, aggrmerge=0/118, aggrticks=0/59378, aggrin_queue=47442, aggrutil=37.78%
  nvme0n1: ios=0/130112, merge=0/117, ticks=0/40816, in_queue=30860, util=26.03%
  nvme3n1: ios=0/130298, merge=0/127, ticks=0/56884, in_queue=44556, util=35.07%
  nvme1n1: ios=0/130249, merge=0/107, ticks=0/74020, in_queue=60868, util=37.78%
  nvme4n1: ios=0/130343, merge=0/124, ticks=0/65792, in_queue=53484, util=35.49%
ubuntu@ip-192-168-0-109:/data/tooling$
```

### Results - fio - Sync Heavy - Large Block ###

```
ubuntu@ip-192-168-0-109:/data/tooling$ ./run_fio_sync_heavy_lb.sh
test-randwrite: (g=0): rw=randwrite, bs=(R) 64.0KiB-64.0KiB, (W) 64.0KiB-64.0KiB, (T) 64.0KiB-64.0KiB, ioengine=libaio, iodepth=8
...
fio-3.1
Starting 64 processes
test-randwrite: Laying out IO file (1 file / 5120MiB)
Jobs: 64 (f=64): [w(64)][100.0%][r=0KiB/s,w=406MiB/s][r=0,w=6492 IOPS][eta 00m:00s]
test-randwrite: (groupid=0, jobs=64): err= 0: pid=8541: Sat Mar 16 21:44:44 2019
  write: IOPS=6587, BW=412MiB/s (432MB/s)(12.1GiB/30013msec)
    slat (usec): min=5, max=179889, avg=4959.51, stdev=12789.81
    clat (usec): min=591, max=345735, avg=68280.69, stdev=39875.62
     lat (usec): min=603, max=357490, avg=73240.52, stdev=42062.59
    clat percentiles (usec):
     |  1.00th=[   881],  5.00th=[  4424], 10.00th=[ 25560], 20.00th=[ 35390],
     | 30.00th=[ 47449], 40.00th=[ 60031], 50.00th=[ 64750], 60.00th=[ 68682],
     | 70.00th=[ 76022], 80.00th=[ 94897], 90.00th=[125305], 95.00th=[141558],
     | 99.00th=[193987], 99.50th=[210764], 99.90th=[252707], 99.95th=[265290],
     | 99.99th=[299893]
   bw (  KiB/s): min= 2446, max=12462, per=1.57%, avg=6626.21, stdev=1259.16, samples=3840
   iops        : min=   38, max=  194, avg=103.10, stdev=19.68, samples=3840
  lat (usec)   : 750=0.38%, 1000=1.22%
  lat (msec)   : 2=2.37%, 4=0.91%, 10=1.07%, 20=1.37%, 50=24.13%
  lat (msec)   : 100=51.07%, 250=17.36%, 500=0.11%
  cpu          : usr=0.07%, sys=0.21%, ctx=211546, majf=0, minf=679
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=99.8%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.1%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwt: total=0,197715,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=8

Run status group 0 (all jobs):
  WRITE: bw=412MiB/s (432MB/s), 412MiB/s-412MiB/s (432MB/s-432MB/s), io=12.1GiB (12.0GB), run=30013-30013msec

Disk stats (read/write):
    md0: ios=0/228044, merge=0/0, ticks=0/0, in_queue=0, util=0.00%, aggrios=0/84045, aggrmerge=0/44, aggrticks=0/232084, aggrin_queue=212207, aggrutil=63.90%
  nvme0n1: ios=0/83069, merge=0/4, ticks=0/201996, in_queue=183256, util=54.78%
  nvme3n1: ios=0/83140, merge=0/35, ticks=0/224044, in_queue=204308, util=62.93%
  nvme1n1: ios=0/83087, merge=0/29, ticks=0/243932, in_queue=223048, util=63.90%
  nvme4n1: ios=0/86884, merge=0/110, ticks=0/258364, in_queue=238216, util=63.28%
ubuntu@ip-192-168-0-109:/data/tooling$
```

### Results - fio - Async ###

```
ubuntu@ip-192-168-0-109:/data/tooling$ ./run_fio_async.sh
test-randwrite: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=128
fio-3.1
Starting 1 process
test-randwrite: Laying out IO file (1 file / 5120MiB)
Jobs: 1 (f=1): [w(1)][100.0%][r=0KiB/s,w=31.1MiB/s][r=0,w=7953 IOPS][eta 00m:00s]
test-randwrite: (groupid=0, jobs=1): err= 0: pid=8620: Sat Mar 16 21:45:45 2019
  write: IOPS=8141, BW=31.8MiB/s (33.3MB/s)(956MiB/30046msec)
    slat (usec): min=2, max=16110, avg=121.41, stdev=422.63
    clat (usec): min=458, max=47703, avg=15582.61, stdev=7309.97
     lat (usec): min=463, max=47837, avg=15704.12, stdev=7497.34
    clat percentiles (usec):
     |  1.00th=[ 1500],  5.00th=[ 7504], 10.00th=[ 9110], 20.00th=[10552],
     | 30.00th=[11863], 40.00th=[11994], 50.00th=[13435], 60.00th=[13829],
     | 70.00th=[15926], 80.00th=[25035], 90.00th=[27132], 95.00th=[28705],
     | 99.00th=[31589], 99.50th=[33424], 99.90th=[40633], 99.95th=[42730],
     | 99.99th=[45351]
   bw (  KiB/s): min=29496, max=94200, per=100.00%, avg=32604.18, stdev=8125.43, samples=60
   iops        : min= 7374, max=23550, avg=8151.03, stdev=2031.36, samples=60
  lat (usec)   : 500=0.01%, 750=0.03%, 1000=0.06%
  lat (msec)   : 2=3.08%, 4=0.90%, 10=8.66%, 20=62.58%, 50=24.68%
  cpu          : usr=1.12%, sys=4.28%, ctx=21745, majf=0, minf=8
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwt: total=0,244627,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=128

Run status group 0 (all jobs):
  WRITE: bw=31.8MiB/s (33.3MB/s), 31.8MiB/s-31.8MiB/s (33.3MB/s-33.3MB/s), io=956MiB (1002MB), run=30046-30046msec

Disk stats (read/write):
    md0: ios=0/246761, merge=0/0, ticks=0/0, in_queue=0, util=0.00%, aggrios=0/62117, aggrmerge=0/0, aggrticks=0/257254, aggrin_queue=242101, aggrutil=98.81%
  nvme0n1: ios=0/61686, merge=0/0, ticks=0/36512, in_queue=27280, util=23.87%
  nvme3n1: ios=0/62591, merge=0/0, ticks=0/900252, in_queue=870740, util=98.81%
  nvme1n1: ios=0/62051, merge=0/0, ticks=0/54808, in_queue=43304, util=30.08%
  nvme4n1: ios=0/62141, merge=0/0, ticks=0/37444, in_queue=27080, util=25.66%
ubuntu@ip-192-168-0-109:/data/tooling$
```

### Results - fio - Async - Large Block ###

```
ubuntu@ip-192-168-0-109:/data/tooling$ ./run_fio_async_lb.sh
test-randwrite: (g=0): rw=randwrite, bs=(R) 64.0KiB-64.0KiB, (W) 64.0KiB-64.0KiB, (T) 64.0KiB-64.0KiB, ioengine=libaio, iodepth=128
fio-3.1
Starting 1 process
test-randwrite: Laying out IO file (1 file / 5120MiB)
Jobs: 1 (f=1): [w(1)][100.0%][r=0KiB/s,w=417MiB/s][r=0,w=6674 IOPS][eta 00m:00s]
test-randwrite: (groupid=0, jobs=1): err= 0: pid=8633: Sat Mar 16 21:46:21 2019
  write: IOPS=7267, BW=454MiB/s (476MB/s)(5120MiB/11272msec)
    slat (usec): min=4, max=73987, avg=136.11, stdev=568.98
    clat (usec): min=1096, max=155589, avg=17471.09, stdev=9843.37
     lat (usec): min=1106, max=155598, avg=17607.28, stdev=9981.78
    clat percentiles (msec):
     |  1.00th=[    3],  5.00th=[    3], 10.00th=[    5], 20.00th=[   10],
     | 30.00th=[   13], 40.00th=[   15], 50.00th=[   17], 60.00th=[   19],
     | 70.00th=[   22], 80.00th=[   26], 90.00th=[   31], 95.00th=[   34],
     | 99.00th=[   39], 99.50th=[   46], 99.90th=[   93], 99.95th=[  107],
     | 99.99th=[  148]
   bw (  KiB/s): min=300928, max=1269632, per=100.00%, avg=465741.18, stdev=207221.96, samples=22
   iops        : min= 4702, max=19838, avg=7277.18, stdev=3237.83, samples=22
  lat (msec)   : 2=0.52%, 4=8.29%, 10=11.72%, 20=44.48%, 50=34.53%
  lat (msec)   : 100=0.40%, 250=0.06%
  cpu          : usr=4.00%, sys=4.22%, ctx=9824, majf=0, minf=8
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=99.9%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.1%
     issued rwt: total=0,81920,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=128

Run status group 0 (all jobs):
  WRITE: bw=454MiB/s (476MB/s), 454MiB/s-454MiB/s (476MB/s-476MB/s), io=5120MiB (5369MB), run=11272-11272msec

Disk stats (read/write):
    md0: ios=0/81923, merge=0/0, ticks=0/0, in_queue=0, util=0.00%, aggrios=0/20482, aggrmerge=0/0, aggrticks=0/122795, aggrin_queue=115181, aggrutil=83.65%
  nvme0n1: ios=0/20484, merge=0/0, ticks=0/128880, in_queue=121884, util=58.00%
  nvme3n1: ios=0/20482, merge=0/0, ticks=0/66416, in_queue=59308, util=64.47%
  nvme1n1: ios=0/20482, merge=0/0, ticks=0/205328, in_queue=196248, util=83.65%
  nvme4n1: ios=0/20482, merge=0/0, ticks=0/90556, in_queue=83284, util=67.81%
ubuntu@ip-192-168-0-109:/data/tooling$
```