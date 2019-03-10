# Notes on AWS RDS for Postgres #

## My Notes ##

- Multi-AZ RDS is similar to pgpool w/ sync. replication.

## Failover Behavior ##

This text is taken directly from: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.MultiAZ.html
(I have formatted it for my use and occasionally added emphasis.)

### Failover Process for Amazon RDS ###
In the event of a planned or unplanned outage of your DB instance,
Amazon RDS automatically switches to a standby replica in another Availability
Zone if you have enabled Multi-AZ. The time it takes for the failover to complete
depends on the database activity and other conditions at the time the primary DB
instance became unavailable. Failover times are typically *60-120 seconds*.
However, large transactions or a lengthy recovery process can increase failover
time. When the failover is complete, it can take additional time for the RDS
console UI to reflect the new Availability Zone.

The failover mechanism automatically changes the DNS record of the DB
instance to point to the standby DB instance. As a result, you need to
re-establish any existing connections to your DB instance. Due to how the
Java DNS caching mechanism works, you may need to reconfigure your JVM environment.
For more information on how to manage a Java application that caches DNS
values in the case of a failover, see the AWS SDK for Java.

Amazon RDS handles failovers automatically so you can resume database
operations as quickly as possible without administrative intervention.
The primary DB instance switches over automatically to the standby
replica if any of the following conditions occur:

- An Availability Zone outage
- The primary DB instance fails
- The DB instance's server type is changed
- The operating system of the DB instance is undergoing software patching
- A manual failover of the DB instance was initiated using Reboot with failover

There are several ways to determine if your Multi-AZ DB instance has failed over:

DB event subscriptions can be setup to notify you via email or SMS that a
failover has been initiated. For more information about events, see
Using Amazon RDS Event Notification

You can view your DB events by using the Amazon RDS console or API actions.

You can view the current state of your Multi-AZ deployment by using the
Amazon RDS console and API actions.

For information on how you can respond to failovers, reduce recovery time,
and other best practices for Amazon RDS, see Best Practices for Amazon RDS.

