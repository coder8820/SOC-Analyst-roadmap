Here is a detailed **Splunk Guide for SOC Analysts**, written in Markdown format. Save it as `splunk-guide-for-soc-analysts.md`.

---

```markdown
# Splunk Guide for SOC Analysts

A comprehensive guide to understanding Splunk architecture, searching, alerting, and investigation for Security Operations Centers.

---

## Table of Contents

1. [What is Splunk?](#what-is-splunk)
2. [Splunk Architecture](#splunk-architecture)
3. [How Splunk Works (Data Pipeline)](#how-splunk-works-data-pipeline)
4. [Splunk Components in Detail](#splunk-components-in-detail)
5. [Splunk Search Language (SPL) Basics](#splunk-search-language-spl-basics)
6. [Essential SPL Commands for SOC](#essential-spl-commands-for-soc)
7. [Search Optimization & Best Practices](#search-optimization--best-practices)
8. [Creating Alerts & Correlation Rules](#creating-alerts--correlation-rules)
9. [Dashboards & Visualizations for SOC](#dashboards--visualizations-for-soc)
10. [Threat Hunting with Splunk](#threat-hunting-with-splunk)
11. [Splunk ES (Enterprise Security) Overview](#splunk-es-enterprise-security-overview)
12. [Common SOC Use Cases with Examples](#common-soc-use-cases-with-examples)
13. [Troubleshooting & Performance](#troubleshooting--performance)
14. [Cheat Sheet](#cheat-sheet)

---

## What is Splunk?

**Splunk** is a software platform for searching, monitoring, and analyzing machine-generated data (logs, metrics, events) in real-time. For SOC analysts, Splunk serves as the **SIEM (Security Information and Event Management)** backbone.

### Key Capabilities for SOC

| Capability | Description |
|------------|-------------|
| **Log Aggregation** | Collect logs from Windows, Linux, firewalls, EDR, cloud |
| **Real-time Monitoring** | Detect threats as they happen |
| **Search & Investigation** | Forensic analysis across petabytes of data |
| **Alerting** | Trigger alerts based on correlation rules |
| **Dashboards** | Visualize security posture |
| **Threat Intelligence** | Enrich events with IOCs |
| **Compliance Reporting** | PCI-DSS, HIPAA, SOX reports |

### Splunk Versions

- **Splunk Enterprise:** Self-hosted, full control
- **Splunk Cloud:** SaaS, managed by Splunk
- **Splunk Free:** 500MB/day, no authentication or alerts
- **Splunk Enterprise Security (ES):** Premium security add-on with correlation framework, risk scoring, and asset framework

---

## Splunk Architecture

### High-Level Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────────────┐
│                              Data Sources                                │
│  Windows │ Linux │ Firewall │ EDR │ AWS │ Azure │ 365 │ Threat Intel    │
└─────────────────────────────────────────────────────────────────────────┘
                                      │
                                      ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                           Forwarders (UF / HF)                          │
│  • Universal Forwarder (UF) – Lightweight log collector                 │
│  • Heavy Forwarder (HF) – Parsing, routing, filtering                   │
└─────────────────────────────────────────────────────────────────────────┘
                                      │
                                      ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                        Indexer Cluster (Hot/Warm/Cold)                  │
│  • Parses logs                                                          │
│  • Builds inverted indexes                                              │
│  • Stores raw data + metadata                                           │
└─────────────────────────────────────────────────────────────────────────┘
                                      │
                                      ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                     Search Head Cluster (UI / API)                      │
│  • Distributes searches to indexers                                     │
│  • Consolidates results                                                 │
│  • Manages dashboards, alerts, knowledge objects                        │
└─────────────────────────────────────────────────────────────────────────┘
                                      │
                                      ▼
                              SOC Analyst (UI)
```

### Deployment Roles

| Component | Role | Typical Count |
|-----------|------|---------------|
| **Forwarder** | Collects and sends logs | 1 per source (500+ servers) |
| **Indexer** | Stores and indexes data | 3+ (clustered) |
| **Search Head** | User interface, query distribution | 2+ (clustered) |
| **Deployment Server** | Manages forwarder configurations | 1 |
| **License Master** | Tracks license usage | 1 |
| **Monitoring Console (MC)** | Platform health monitoring | 1 |

---

## How Splunk Works (Data Pipeline)

### The 5 Stages of Data Processing

```
┌────────────┐    ┌────────────┐    ┌────────────┐    ┌────────────┐    ┌────────────┐
│  INPUT     │ -> │  PARSING   │ -> │  INDEXING  │ -> │  SEARCHING │ -> │  ALERTING  │
│  (Forward) │    │ (Transform)│    │ (Store)    │    │ (Retrieve) │    │ (Response) │
└────────────┘    └────────────┘    └────────────┘    └────────────┘    └────────────┘
```

### Stage 1: Input

Logs enter Splunk via:

- **Universal Forwarder (UF):** Lightweight agent, no local parsing
- **Heavy Forwarder (HF):** Can parse, route, filter before sending
- **HTTP Event Collector (HEC):** REST API for JSON/raw logs
- **Scripted Inputs:** Run scripts to fetch logs (e.g., AWS CLI)
- **TCP/UDP Inputs:** Direct log reception (e.g., syslog)

### Stage 2: Parsing (Transform)

The indexer processes raw logs:

```
Raw Log:
2025-01-15 10:30:45 192.168.1.100 user123 Failed password for invalid user admin from 45.33.22.11

After Parsing (fields extracted):
{
  "_time": "2025-01-15T10:30:45.000Z",
  "host": "web-server-01",
  "source": "/var/log/auth.log",
  "sourcetype": "linux_secure",
  "src_ip": "45.33.22.11",
  "dst_ip": "192.168.1.100",
  "user": "admin",
  "action": "failed",
  "message": "Failed password for invalid user admin from 45.33.22.11"
}
```

**Parsing Operations:**
- **Line breaking:** Splits multi-line events
- **Character set normalization:** UTF-8, etc.
- **Timestamp extraction:** Identifies `_time` field
- **Source type classification:** Assigns sourcetype (e.g., `win:eventlog`, `linux:syslog`)
- **Field extraction:** Uses regex, delimiters, or KV mode

### Stage 3: Indexing

Splunk creates two structures:

**1. Raw Data Storage (compressed)**
```
$SPLUNK_HOME/var/lib/splunk/defaultdb/db/
├── hot_v1_123/
│   └── rawdata/journal.gz    # Compressed raw logs
```

**2. Index File (inverted index)**
```
Term          → Document Locations
─────────────────────────────────
"failed"      → bucket1: offset 1000-1500
"45.33.22.11" → bucket1: offset 1200-1300, bucket2: offset 500-600
"admin"       → bucket1: offset 1100-1150
```

**Index Buckets (by age):**

| Bucket Type | Age | Storage | Search Speed |
|-------------|-----|---------|--------------|
| **Hot** | Current - few hours | Fast SSD | Fastest |
| **Warm** | Hours - months | Spinning disk | Fast |
| **Cold** | Months - retention | Cheap storage | Slower |
| **Frozen** | Beyond retention | Archived | Not searchable |
| **Thawed** | Restored from frozen | Temporary | Slow |

### Stage 4: Searching

When a SOC analyst runs a search:

```
1. Search Head → Parses SPL → Identifies time range & indexes
2. Search Head → Sends sub-searches to each Indexer
3. Indexer → Consults inverted index → Finds matching event IDs
4. Indexer → Reads raw data from buckets → Applies field extractions
5. Indexer → Returns results to Search Head
6. Search Head → Merges, dedupes, sorts → Displays to analyst
```

### Stage 5: Alerting

Saved searches run on schedule or real-time:

```
Schedule (e.g., every 5 minutes) → Run search → Evaluate condition → Trigger action
```

**Alert Actions:**
- Email to SOC team
- Create incident in ticketing system (ServiceNow, Jira)
- Send to SOAR (Phantom, Demisto)
- Run custom script
- Index result as new event

---

## Splunk Components in Detail

### 1. Universal Forwarder (UF)

**Purpose:** Lightweight log collection from servers.

**Characteristics:**
- ~30 MB memory footprint
- No parsing or indexing
- Can't search or alert
- Configuration via `inputs.conf` and `outputs.conf`

**Sample inputs.conf:**
```ini
[default]
host = web-server-01

[monitor:///var/log/secure]
index = linux_security
sourcetype = linux_secure
disabled = false

[monitor:///var/log/messages]
index = linux_system
sourcetype = linux_syslog
disabled = false

[WinEventLog://Security]
index = windows_security
sourcetype = WinEventLog:Security
disabled = false
```

### 2. Heavy Forwarder (HF)

**Purpose:** Advanced log processing before indexing.

**Use cases:**
- Filter out sensitive data before sending
- Parse non-standard log formats
- Route logs to multiple destinations
- Aggregate from many UFs

**Sample transforms.conf (filtering):**
```ini
[filter_out_debug]
REGEX = DEBUG
DEST_KEY = queue
FORMAT = nullQueue
```

### 3. Indexer

**Purpose:** Store and index log data.

**Key configurations:**
```ini
# indexes.conf
[main]
homePath = $SPLUNK_DB/main/db
coldPath = $SPLUNK_DB/main/colddb
thawedPath = $SPLUNK_DB/main/thaweddb
maxHotBuckets = 3
maxHotIdleSecs = 86400
maxDataSize = auto_high_volume

[windows_security]
homePath = $SPLUNK_DB/windows_security/db
coldPath = $SPLUNK_DB/windows_security/colddb
frozenTimePeriodInSecs = 7776000  # 90 days
```

### 4. Search Head

**Purpose:** User interface, knowledge object management.

**Knowledge Objects (stored on Search Head):**
- **Searches:** Saved search strings
- **Dashboards:** XML/JSON visualizations
- **Alerts:** Scheduled searches with actions
- **Field extractions:** Custom regex patterns
- **Lookups:** CSV mapping files (e.g., asset DB)
- **Tags:** Alternative names for values (e.g., `src=bad_ip`)
- **Event types:** Named search patterns
- **Macros:** Reusable SPL snippets
- **Data models:** Structured data for Pivot

---

## Splunk Search Language (SPL) Basics

SPL (Search Processing Language) is a pipeline-based language. Data flows from left to right through commands.

### Basic Syntax

```spl
search term | command1 arg1=value1 | command2 arg2=value2 | table fields
```

### Simple Search Examples

```spl
# Basic keyword search
index=windows_security failed password

# Multiple keywords
index=linux_secure "Failed password" OR "Invalid user"

# Field-specific search
index=windows_security EventCode=4625 src_ip=10.0.0.* 

# Time range (implicit or explicit)
index=main error earliest=-1h latest=now

# Boolean operators
index=main (failed OR denied) NOT "successful"
```

### Pipeline Commands

Each command processes the entire set of events and passes results to the next:

```spl
index=windows_security EventCode=4625
| where src_ip != "10.0.0.1"
| stats count by src_ip, user
| sort - count
| head 10
```

---

## Essential SPL Commands for SOC

### Time & Date Commands

| Command | Purpose | Example |
|---------|---------|---------|
| `earliest` / `latest` | Time range filter | `earliest=-24h latest=now` |
| `timechart` | Time-based aggregation | `timechart count by action` |
| `bin` | Bucket events into time spans | `bin _time span=1h` |
| `relative_time` | Calculate relative times | `eval newtime=relative_time(now(), "-1d@d")` |

### Filtering Commands

| Command | Purpose | Example |
|---------|---------|---------|
| `where` | Conditional filter | `where count > 10` |
| `search` | Keyword/field search | `search "Failed password"` |
| `regex` | Pattern match | `regex src_ip="^192\.168\."` |
| `dedup` | Remove duplicates | `dedup src_ip` |
| `head` / `tail` | First/last N events | `head 100` |

### Aggregation Commands

| Command | Purpose | Example |
|---------|---------|---------|
| `stats` | Statistical aggregation | `stats count, avg(bytes) by src_ip` |
| `chart` | Table aggregation | `chart count over src_ip by action` |
| `timechart` | Time-series aggregation | `timechart count by src_ip` |
| `eventstats` | Add stats to events | `eventstats avg(duration) as avg_dur` |
| `streamstats` | Running stats | `streamstats count as event_num` |

### Field Manipulation

| Command | Purpose | Example |
|---------|---------|---------|
| `table` | Display specific fields | `table _time, src_ip, user` |
| `fields` | Keep/remove fields | `fields - _raw` |
| `rename` | Change field names | `rename src_ip as source` |
| `eval` | Create/modify fields | `eval severity = if(count>10, "high", "low")` |
| `rex` | Extract with regex | `rex field=_raw "User=(?<user>\w+)"` |
| `replace` | Substitute values | `replace "192.168" with "internal"` |

### Lookup Commands

| Command | Purpose | Example |
|---------|---------|---------|
| `lookup` | Enrich with CSV/DB | `lookup asset_db ip as src_ip` |
| `inputlookup` | Search lookup file | `inputlookup threat_intel.csv` |
| `outputlookup` | Save results to CSV | `... | outputlookup results.csv` |

### Subsearch & Joins

| Command | Purpose | Example |
|---------|---------|---------|
| `append` | Add results of another search | `... | append [search index=...]` |
| `join` | Combine like SQL JOIN | `join type=left src_ip [search ...]` |
| `map` | Run search per result | `map search="search index=... $src_ip$"` |

### Reporting & Output

| Command | Purpose | Example |
|---------|---------|---------|
| `top` | Most frequent values | `top src_ip limit=10` |
| `rare` | Least frequent values | `rare user` |
| `highlight` | Highlight in UI | `highlight src_ip` |
| `sendemail` | Email results | `sendemail to=soc@company.com` |

---

## Search Optimization & Best Practices

### Performance Rules (Time Picker First)

**Always specify time range before anything else:**

```spl
# BAD (scans all time)
index=main failed password | stats count

# GOOD (only last 24h)
index=main failed password earliest=-24h | stats count
```

### Index Selection

**Use specific indexes, avoid `index=*`:**

```spl
# BAD - scans all indexes
index=* failed password

# GOOD - specific indexes
index=windows_security OR index=linux_secure failed password
```

### Filter Early

**Use search term before pipes:**

```spl
# BAD - pipes too early
index=main | where src_ip="10.0.0.1" | stats count

# GOOD - filter in search term
index=main src_ip="10.0.0.1" | stats count
```

### Use Fields Over Raw Search

**Search field=value is faster than free text:**

```spl
# BAD - searches full raw event
index=main "4625"

# GOOD - searches indexed field
index=windows_security EventCode=4625
```

### Avoid Expensive Operations

| Expensive (Avoid) | Efficient (Use) |
|-------------------|-----------------|
| `regex` | `search` or `where` with wildcards |
| `join` | `append` or `stats` with `by` |
| `transaction` | `stats` with `values` or `list` |
| `dedup` on large data | `stats` with `dc` (distinct count) |
| `subsearch` returning >10K events | `append` or `join` |

### Streaming vs Non-Streaming Commands

**Streaming** (fast, per-event): `where`, `eval`, `fields`, `rename`, `replace`
**Non-streaming** (slower, all events needed): `stats`, `sort`, `dedup`, `top`, `rare`

```spl
# Place streaming commands first
index=main | fields src_ip user | where user="admin" | stats count
```

---

## Creating Alerts & Correlation Rules

### Types of Alerts

| Type | Description | Use Case |
|------|-------------|----------|
| **Scheduled** | Runs every N minutes/hours | Batch detection, reporting |
| **Real-time** | Continuously monitors streaming data | Immediate threat detection |
| **Per-result** | Triggers on each matching event | High-volume, low-latency |

### Creating a Scheduled Alert (UI)

```spl
# Alert: Brute Force Detection
index=windows_security EventCode=4625 earliest=-5m
| stats count by src_ip, user
| where count > 10
```

**Alert Settings:**
- **Schedule:** Every 5 minutes
- **Time range:** Last 5 minutes (earliest=-5m latest=now)
- **Trigger:** When number of results > 0
- **Throttle:** 5 minutes (avoid duplicates)
- **Actions:** Email SOC, Create ticket

### Correlation Example: Multiple Events

```spl
# Alert: Possible Pass-the-Hash
index=windows_security (EventCode=4624 LogonType=3) OR (EventCode=4648)
| stats values(EventCode) as events, count by src_ip, dest_ip, user
| where mvcount(events) > 1
```

### Risk-Based Alerting (Splunk ES)

```spl
# Risk accumulation
index=risk
| stats sum(risk_score) as total_risk by src_ip
| where total_risk > 30
```

### Alert Actions Script Example

```python
# alert_webhook.py - Send to Slack
import requests, json, sys

alert_data = json.loads(sys.stdin.read())
webhook_url = "https://hooks.slack.com/services/XXX"

for result in alert_data['results']:
    message = {
        "text": f"🚨 Alert: {result['count']} failures from {result['src_ip']}"
    }
    requests.post(webhook_url, json=message)
```

---

## Dashboards & Visualizations for SOC

### Essential SOC Dashboard Panels

```xml
<!-- Simple XML Dashboard Example -->
<dashboard>
  <label>SOC Operations Dashboard</label>
  
  <!-- Input: Time Range Picker -->
  <input type="time" token="time_token">
    <default>
      <earliest>-24h</earliest>
      <latest>now</latest>
    </default>
  </input>
  
  <!-- Panel 1: Alert Volume Over Time -->
  <panel>
    <title>Alerts per Hour</title>
    <chart>
      <search>
        <query>index=alerts earliest=$time_token$ | timechart count by severity</query>
      </search>
      <option name="charting.chart">column</option>
    </chart>
  </panel>
  
  <!-- Panel 2: Top Attack Sources -->
  <panel>
    <title>Top 10 Attack Sources</title>
    <table>
      <search>
        <query>index=alerts earliest=$time_token$ | stats count by src_ip | sort - count | head 10</query>
      </search>
    </table>
  </panel>
  
  <!-- Panel 3: Real-time Event Feed -->
  <panel>
    <title>Live Security Events</title>
    <events>
      <search>
        <query>index=alerts | head 50</query>
        <earliest>-15m</earliest>
        <latest>now</latest>
      </search>
    </events>
  </panel>
</dashboard>
```

### Common Visualization Types for SOC

| Visualization | Best For |
|---------------|----------|
| **Line/Area Chart** | Trends over time (alerts per day) |
| **Column/Bar Chart** | Comparisons (top attack types) |
| **Pie/Donut Chart** | Proportions (alert severity distribution) |
| **Heat Map** | Time-based patterns (attacks by hour) |
| **Geographic Map** | Source country tracking |
| **Single Value** | KPIs (total alerts, unique sources) |
| **Table** | Detailed investigation data |
| **Sankey Diagram** | Flow visualization (lateral movement) |

---

## Threat Hunting with Splunk

### Threat Hunting Framework (Hypothesis-Driven)

**Step 1: Hypothesis** - "Attackers are using PowerShell to download payloads"
**Step 2: Hunt Query** - Search for suspicious PowerShell
**Step 3: Investigate** - Review findings
**Step 4: Operationalize** - Create alert if valuable

### Example Hunt Queries

**Hunt 1: PowerShell Download Cradles**
```spl
index=windows_powershell earliest=-7d
(Message="*DownloadString*" OR Message="*WebClient*" OR Message="*Invoke-Expression*" OR Message="*IEX*")
NOT (Message="*windowsupdate*" OR Message="*microsoft*")
| table _time, host, user, Message
```

**Hunt 2: Unusual Service Creation**
```spl
index=windows_security EventCode=7045 earliest=-30d
NOT (ServiceName IN ("Print*", "SQL*", "MSSQL*", "W3SVC*"))
| table _time, host, ServiceName, ServiceFileName
```

**Hunt 3: DNS Tunneling**
```spl
index=dns earliest=-7d
| eval domain_length = len(query)
| where domain_length > 30
| stats count by query, src_ip
| where count > 100
```

**Hunt 4: SMB Lateral Movement**
```spl
index=windows_security EventCode=5140 earliest=-7d
| where ShareName IN ("ADMIN$", "C$", "IPC$")
| stats values(ShareName) as shares, count by src_ip, dest_ip, user
```

**Hunt 5: RDP from Unusual Locations**
```spl
index=windows_security EventCode=4624 LogonType=10 earliest=-30d
| lookup geo_ip src_ip
| where Country NOT IN ("United States", "Canada", "CompanyCountry")
| table _time, src_ip, dest_host, user, Country
```

### Hunting with Baselines

```spl
# Build baseline of normal processes
index=windows_security EventCode=4688 earliest=-30d latest=-1d
| stats dc(CommandLine) as baseline_count by Image
| outputlookup process_baseline.csv

# Hunt for deviations
index=windows_security EventCode=4688 earliest=-1h
| stats count by Image
| lookup process_baseline.csv Image OUTPUT baseline_count
| where isnull(baseline_count) OR count > baseline_count * 2
```

---

## Splunk ES (Enterprise Security) Overview

Splunk ES is a premium add-on that transforms Splunk into a full SIEM.

### ES Components

| Component | Description |
|-----------|-------------|
| **Risk Framework** | Scores based on event severity and confidence |
| **Assets & Identities** | CMDB integration, user context |
| **Correlation Rules** | Pre-built detection rules (700+) |
| **Incident Review** | Centralized investigation dashboard |
| **Threat Intelligence** | IOC ingestion and matching |
| **Glass Tables** | Custom investigation workflows |
| **Notable Events** | Correlated alerts requiring action |

### ES Data Model Acceleration

ES uses pre-aggregated data models for speed:

```
Data Models (Accelerated):
├── Authentication
├── Change
├── Email
├── Endpoint
├── Network_Resolution
├── Network_Sessions
├── Performance
├── Risk
└── Web
```

### ES Search Examples

```spl
# Use datamodel for fast hunting
| datamodel Authentication search
| search Authentication.action="failure"
| stats count by Authentication.src, Authentication.user

# Risk analysis
| from datamodel:Risk.All_Risk
| stats sum(risk_score) as total_risk by src, dest
| where total_risk > 50
```

---

## Common SOC Use Cases with Examples

### Use Case 1: Brute Force Detection

```spl
index=windows_security EventCode=4625 earliest=-15m
| stats count by src_ip, user, dest_host
| where count > 10
| eval severity = if(count > 50, "critical", "high")
| eval description = "Possible brute force from " + src_ip
| table _time, src_ip, dest_host, user, count, severity
```

### Use Case 2: Privilege Escalation (Admin Addition)

```spl
index=windows_security (EventCode=4732 OR EventCode=4728)
| where GroupName IN ("*Admin*", "*Domain Admins*")
| lookup user_info user
| where user_type != "admin"   # Non-admin becoming admin
| table _time, host, user, GroupName, action
```

### Use Case 3: Data Exfiltration Detection

```spl
index=firewall earliest=-1h
| where action="allow" AND dest_port=443
| stats sum(bytes_out) as total_bytes by src_ip, dest_ip
| where total_bytes > 104857600   # 100MB
| eval severity = if(total_bytes > 1048576000, "critical", "high")
| table src_ip, dest_ip, total_bytes, severity
```

### Use Case 4: Impossible Travel

```spl
index=windows_security EventCode=4624 earliest=-1h
| stats earliest(_time) as first, latest(_time) as last by user
| eval travel_time = last - first
| lookup geoip src_ip
| where travel_time < 3600 AND (first_country != last_country)  # <1 hour, diff country
| table user, first_country, last_country, travel_time
```

### Use Case 5: Malware Beaconing

```spl
index=windows_sysmon EventCode=3 earliest=-24h
| bin _time span=5m
| stats count by src_ip, dest_ip, dest_port, _time
| eventstats avg(count) as avg_beacon, stdev(count) as stdev_beacon by src_ip, dest_ip, dest_port
| where stdev_beacon < 5 AND avg_beacon > 3   # Regular intervals
```

### Use Case 6: Phantom Account Creation

```spl
index=windows_security EventCode=4720 earliest=-7d
| inputlookup known_users.csv
| where NOT (user IN known_users)
| table _time, host, user, action, process
```

### Use Case 7: Malicious Office Macro

```spl
index=windows_sysmon EventCode=1 earliest=-7d
| where ParentImage IN ("*winword.exe", "*excel.exe", "*outlook.exe")
| where Image IN ("*cmd.exe", "*powershell.exe", "*wscript.exe", "*mshta.exe")
| table _time, host, user, ParentImage, Image, CommandLine
```

### Use Case 8: Suspicious Scheduled Task

```spl
index=windows_security EventCode=4698 earliest=-7d
| where TaskContent LIKE "%\\Temp\\%" OR TaskContent LIKE "%\\Users\\Public\\%"
| table _time, host, user, TaskName, TaskContent
```

---

## Troubleshooting & Performance

### Common Issues and Solutions

| Issue | Symptoms | Solution |
|-------|----------|----------|
| **Slow searches** | Queries take >30 sec | Add time picker, filter early, use indexed fields |
| **No results** | Empty result set | Check index name, time range, field name case |
| **License violation** | "License volume exceeded" | Reduce data intake, add license, delete old indexes |
| **Forwarder down** | Missing data on host | Check `splunkd.log` on forwarder, network connectivity |
| **Search queue full** | "Search peer failed" | Increase search concurrency, optimize queries |

### Splunk Health Check Commands

```bash
# Check disk usage
df -h $SPLUNK_HOME/var/lib/splunk/

# Check indexer status
splunk show index-status

# Check license usage
splunk list license

# Check forwarder connections
splunk list forward-server

# Check search concurrency
splunk show search-concurrency
```

### Search Job Inspector

```spl
# Add to any search to see performance
| jobid
```

Then go to **Settings > Search Job Inspector** to see:
- Execution time per command
- Events scanned vs. returned
- Disk I/O and memory usage

### Search Performance Analysis

```spl
| makeresults
| eval search='index=_internal "search" "completed"'
| search search=*
| rex field=_raw "scanCount=(?<scanned>\d+)"
| rex field=_raw "resultCount=(?<returned>\d+)"
| eval efficiency = returned/scanned * 100
| table _time, search, scanned, returned, efficiency
| where efficiency < 10   # Inefficient searches
```

---

## Cheat Sheet

### Quick SPL Reference

| Task | SPL Command |
|------|-------------|
| Count events | `stats count` |
| Top 10 values | `top limit=10` |
| Time chart | `timechart count` |
| Filter by condition | `where count > 10` |
| Extract regex | `rex field=_raw "pattern"` |
| Join two searches | `join type=left [search...]` |
| Add calculated field | `eval new_field = old_field * 2` |
| Sort descending | `sort - count` |
| Unique values | `dc(src_ip)` |
| List all values | `values(src_ip)` |
| Concatenate fields | `eval combined = src_ip + ":" + dest_port` |

### Common Source Types for SOC

| Data Source | Source Type | Typical Index |
|-------------|-------------|---------------|
| Windows Security | `WinEventLog:Security` | `windows_security` |
| Windows Sysmon | `WinEventLog:Microsoft-Windows-Sysmon/Operational` | `windows_sysmon` |
| Linux auth | `linux_secure` | `linux_secure` |
| Linux syslog | `linux_syslog` | `linux_syslog` |
| Firewall (Palo Alto) | `pan:threat` | `firewall` |
| Firewall (Checkpoint) | `cp_log:fw` | `firewall` |
| AWS CloudTrail | `aws:cloudtrail` | `aws` |
| Azure Activity | `azure:activity` | `azure` |
| O365 | `o365:management` | `o365` |
| EDR (CrowdStrike) | `crowdstrike:event` | `edr` |

### Time Modifiers

| Modifier | Meaning |
|----------|---------|
| `earliest=-15m` | Last 15 minutes |
| `earliest=-1h` | Last hour |
| `earliest=-24h` | Last 24 hours |
| `earliest=-7d` | Last 7 days |
| `earliest=-30d` | Last 30 days |
| `earliest=-1d@d` | Yesterday (start of day) |
| `earliest=@d` | Today (start of day) |
| `earliest=@w` | This week (start of Monday) |
| `latest=now` | Current time |

### Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl + Enter` | Run search |
| `Ctrl + /` | Comment/uncomment line |
| `Ctrl + Space` | Auto-complete command |
| `Ctrl + F` | Find in search |
| `Ctrl + Shift + F` | Format search |
| `Esc` | Clear search bar |
| `Up/Down` | Navigate history |

### Useful Macros for SOC

Save these as macros in Settings > Advanced Search > Search Macros:

```spl
# Macro: brute_force(threshold)
index=windows_security EventCode=4625
| stats count by src_ip
| where count > $threshold$

# Macro: last_7d
earliest=-7d latest=now

# Macro: lookup_threat_intel(field)
$field$ IN ([inputlookup threat_intel.csv | fields indicator])

# Macro: high_severity_ports(threshold)
dest_port IN (22,3389,445,5985,135,139) AND bytes_out > $threshold$
```

---

## Conclusion

Splunk is a powerful SIEM platform that enables SOC analysts to:

1. **Collect** logs from any source
2. **Index** and store petabytes of data efficiently
3. **Search** and investigate using SPL
4. **Alert** on suspicious patterns in real-time
5. **Visualize** security posture with dashboards
6. **Hunt** for threats proactively

**Key Takeaways for SOC Analysts:**
- Always use time pickers for performance
- Prefer field-based search over raw text
- Use streaming commands before aggregation
- Build and use macros for common patterns
- Leverage lookups for context (asset DB, threat intel)
- Document and share effective hunts

---

## Additional Resources

- **Splunk Documentation:** https://docs.splunk.com
- **Splunk Answers:** https://community.splunk.com
- **Splunk Security Essentials App:** Free app with 400+ detections
- **BOTS (Boss of the SOC):** Free Splunk CTF competition
- **SPL Search Reference:** https://docs.splunk.com/Documentation/Splunk/latest/SearchReference

```

---

This `.md` file is ready to save and use for study, reference, or team training. Let me know if you want an expanded section on Splunk ES, SOAR integration, or additional hunting queries.