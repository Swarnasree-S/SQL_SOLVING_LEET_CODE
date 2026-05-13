# InfluxDB TSM Corruption Recovery Steps

## Issue Observed

InfluxDB started throwing the following error:

```bash
Unexpected error: (500)
Reason: Internal Server Error

unexpected error writing points to database:
not attempting to open shard 16167;
opening shard previously failed with:

[shard 16167] cannot read corrupt file
/var/lib/influxdb2/engine/data/fbb6b9d4433fc304/autogen/16167/000000017-000000001.tsm
```

---

# Recovery Steps Performed

## 1. Login to InfluxDB Container

```bash
docker exec -it influxdb_influxdb.1.mg867tbek7e4kxe6ky6z8g896 bash
```

---

## 2. Verify InfluxDB Version

```bash
influxd version
```

Output:

```bash
InfluxDB v2.7.12
```

---

## 3. Verify TSM Files

Command used:

```bash
influxd inspect verify-tsm \
  --engine-path /var/lib/influxdb2/engine/data/fbb6b9d4433fc304/autogen/16167 \
  --verbose
```

Output confirmed healthy files:

```bash
000000008-000000002.tsm: healthy
000000016-000000002.tsm: healthy
Broken Blocks: 0 / 29853
```

---

# Root Cause

InfluxDB was trying to access a corrupted TSM file:

```bash
000000017-000000001.tsm
```

This file had already been renamed/moved as:

```bash
000000017-000000001.tsm.bad
```

But InfluxDB was still attempting to process it.

---

# Final Fix Performed

Removed the bad/corrupted file:

```bash
rm 000000017-000000001.tsm.bad
```

Path:

```bash
/var/lib/influxdb2/engine/data/fbb6b9d4433fc304/autogen/16167/
```

---

# Result

After removing the corrupted `.tsm.bad` file:

* InfluxDB started working normally
* Writes resumed successfully
* No further shard corruption errors observed

---

# Additional Recommended Checks

## Check Disk Space

```bash
df -h
```

## Check InfluxDB Logs

```bash
docker service logs influxdb_influxdb --tail 100
```

## Verify WAL Integrity

```bash
influxd inspect verify-wal \
  --engine-path /var/lib/influxdb2/engine
```

---

# Possible Causes of TSM Corruption

* Sudden VM/container shutdown
* Disk full condition
* Storage I/O issues
* Filesystem corruption
* Unclean Docker restart
* Power/network interruption during writes

---

# Preventive Recommendations

* Monitor disk usage regularly
* Enable proper container restart policies
* Take periodic InfluxDB backups
* Avoid abrupt shutdowns/reboots
* Monitor Docker host filesystem health
* Configure alerts for high disk utilization
