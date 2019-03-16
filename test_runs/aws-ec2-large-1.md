# Test Runs on AWS-EC2-Large-1 #

See `terraform/aws-ec2-large-1/` for setup details.

## Run 1 ##

- 4x 1TB x 2k IOPS (io1) x RAID0

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
number of transactions actually processed: 3844707
latency average = 7.802 ms
latency stddev = 12.246 ms
tps = 12814.420105 (including connections establishing)
tps = 12814.493271 (excluding connections establishing)
```

## Run 2 ##

- 2x 1TB x 2k IOPS (io1) x RAID0 data
- 2x 1TB x 2k IOPS (io1) x RAID0 WAL

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
number of transactions actually processed: 4717750
latency average = 6.358 ms
latency stddev = 6.785 ms
tps = 15724.297150 (including connections establishing)
tps = 15724.385321 (excluding connections establishing)
```

## FIO ##

### Results for Pathological Sync ###

- This is where RAID0 really helps.
- Sync heavy where while 1 disk is doing a synchronous op the other
    drive is available for a write. Drives the overall latency down.

```
ubuntu@ip-192-168-0-219:/data/tooling$ ./run_fio_sync_heavy.sh
test-randwrite: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=8
...
fio-3.1
Starting 64 processes
test-randwrite: Laying out IO file (1 file / 5120MiB)
Jobs: 64 (f=64): [w(64)][100.0%][r=0KiB/s,w=12.2MiB/s][r=0,w=3129 IOPS][eta 00m:00s]
test-randwrite: (groupid=0, jobs=64): err= 0: pid=10300: Sat Mar 16 22:09:36 2019
  write: IOPS=3214, BW=12.6MiB/s (13.2MB/s)(377MiB/30015msec)
    slat (usec): min=3, max=50353, avg=7191.88, stdev=7366.20
    clat (usec): min=398, max=275695, avg=139322.38, stdev=31600.12
     lat (usec): min=612, max=289527, avg=146514.84, stdev=33685.82
    clat percentiles (msec):
     |  1.00th=[   55],  5.00th=[   92], 10.00th=[  102], 20.00th=[  114],
     | 30.00th=[  124], 40.00th=[  132], 50.00th=[  140], 60.00th=[  146],
     | 70.00th=[  157], 80.00th=[  165], 90.00th=[  180], 95.00th=[  190],
     | 99.00th=[  213], 99.50th=[  224], 99.90th=[  236], 99.95th=[  243],
     | 99.99th=[  257]
   bw (  KiB/s): min=  120, max=  416, per=1.56%, avg=200.02, stdev=33.56, samples=3840
   iops        : min=   30, max=  104, avg=50.00, stdev= 8.39, samples=3840
  lat (usec)   : 500=0.01%, 750=0.01%
  lat (msec)   : 2=0.01%, 4=0.01%, 10=0.10%, 20=0.15%, 50=0.55%
  lat (msec)   : 100=8.29%, 250=90.87%, 500=0.02%
  cpu          : usr=0.06%, sys=0.45%, ctx=672354, majf=0, minf=774
  IO depths    : 1=0.1%, 2=0.1%, 4=0.3%, 8=99.5%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=99.9%, 8=0.1%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwt: total=0,96474,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=8

Run status group 0 (all jobs):
  WRITE: bw=12.6MiB/s (13.2MB/s), 12.6MiB/s-12.6MiB/s (13.2MB/s-13.2MB/s), io=377MiB (395MB), run=30015-30015msec

Disk stats (read/write):
    md0: ios=0/200243, merge=0/0, ticks=0/0, in_queue=0, util=0.00%, aggrios=0/169021, aggrmerge=0/234, aggrticks=0/37768, aggrin_queue=20756, aggrutil=34.02%
  nvme3n1: ios=0/168973, merge=0/329, ticks=0/37864, in_queue=20660, util=33.81%
  nvme2n1: ios=0/169070, merge=0/140, ticks=0/37672, in_queue=20852, util=34.02%
ubuntu@ip-192-168-0-219:/data/tooling$
```
