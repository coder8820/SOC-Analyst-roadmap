# Networking Fundamentals for Cybersecurity

> **Purpose:** A cybersecurity-focused networking reference covering the core concepts required for SOC Analysis, Blue Team, Penetration Testing, Web Security, Cloud Security, CTFs, and Security Operations.

---

## 1. What is Computer Networking?

A **computer network** is a collection of devices connected together to communicate and exchange data.

### Common Network Devices

| Device        | Purpose                            |
| ------------- | ---------------------------------- |
| Host          | Any network-connected device       |
| Client        | Requests services/resources        |
| Server        | Provides services/resources        |
| Switch        | Connects devices within a LAN      |
| Router        | Connects different networks        |
| Firewall      | Controls network traffic           |
| Access Point  | Provides wireless connectivity     |
| Modem         | Connects a network to an ISP       |
| Proxy         | Acts as an intermediary            |
| Load Balancer | Distributes traffic across servers |

### Cybersecurity Perspective

As a security professional, you should be able to answer:

* Who is communicating with whom?
* Which IP addresses are involved?
* Which ports are being used?
* Which protocol is being used?
* Is the traffic encrypted?
* Is the traffic legitimate or malicious?
* Where did the traffic originate?
* What service is running on the destination port?

---

# 2. Network Types

### LAN — Local Area Network

A network within a limited geographical area.

Example:

```text
PC ──┐
     ├── Switch ── Router
Laptop ─┘
```

### WAN — Wide Area Network

Connects networks across large geographical areas.

The Internet is the largest example of a WAN.

### WLAN

Wireless LAN using technologies such as Wi-Fi.

### PAN

Personal Area Network.

Example:

```text
Phone ── Bluetooth ── Headphones
```

### VPN

A **Virtual Private Network** creates an encrypted tunnel between endpoints.

```text
User
 |
 | Encrypted Tunnel
 v
VPN Server
 |
 v
Internal Network
```

---

# 3. OSI Model

The **OSI Model** divides network communication into seven layers.

```text
7  Application
6  Presentation
5  Session
4  Transport
3  Network
2  Data Link
1  Physical
```

## Layer 7 — Application

Provides network services to applications.

Examples:

* HTTP
* HTTPS
* DNS
* FTP
* SMTP
* SSH

### Security relevance

Attackers frequently target application-layer services.

Examples:

* SQL Injection
* XSS
* HTTP Request Smuggling
* Authentication attacks

---

## Layer 6 — Presentation

Responsible for:

* Data formatting
* Encoding
* Encryption
* Compression

Examples:

* TLS-related encoding/encryption
* JSON
* XML

---

## Layer 5 — Session

Manages communication sessions.

Security concepts:

* Session management
* Session hijacking
* Session fixation

---

## Layer 4 — Transport

Responsible for end-to-end communication.

Main protocols:

* TCP
* UDP

Security concepts:

* Port scanning
* SYN flood
* TCP hijacking
* Connection analysis

---

## Layer 3 — Network

Responsible for logical addressing and routing.

Main protocol:

* IP

Security concepts:

* IP spoofing
* Routing attacks
* ICMP attacks
* Network scanning

---

## Layer 2 — Data Link

Responsible for communication within a local network.

Examples:

* Ethernet
* ARP
* MAC addresses

Security concepts:

* ARP spoofing
* ARP poisoning
* MAC spoofing
* VLAN attacks

---

## Layer 1 — Physical

Deals with physical transmission.

Examples:

* Cables
* Radio signals
* Fiber optics
* Network hardware

---

# 4. TCP/IP Model

The TCP/IP model is commonly used in real-world networking.

```text
Application
Transport
Internet
Network Access
```

### OSI vs TCP/IP

| OSI          | TCP/IP         |
| ------------ | -------------- |
| Application  | Application    |
| Presentation | Application    |
| Session      | Application    |
| Transport    | Transport      |
| Network      | Internet       |
| Data Link    | Network Access |
| Physical     | Network Access |

### Important Point

You should understand both models, but **TCP/IP is especially important when working with real network traffic.**

---

# 5. IP Addressing

An **IP address** identifies a device/interface on a network.

## IPv4

IPv4 uses 32 bits.

Example:

```text
192.168.1.10
```

IPv4 consists of four octets.

Each octet ranges from:

```text
0 - 255
```

---

# 6. Private IP Addresses

Private IPv4 ranges:

```text
10.0.0.0/8

172.16.0.0/12

192.168.0.0/16
```

Example:

```text
192.168.1.25
```

Private IPs are commonly used inside local networks.

---

# 7. Public IP Address

A public IP is routable on the Internet.

Example:

```text
8.8.8.8
```

Public IP addresses are important during:

* Threat intelligence
* Incident investigation
* Log analysis
* Network reconnaissance

---

# 8. Loopback Address

IPv4 loopback:

```text
127.0.0.1
```

Common hostname:

```text
localhost
```

It refers to the local machine.

Example:

```bash
ping 127.0.0.1
```

---

# 9. IPv6

IPv6 uses 128-bit addresses.

Example:

```text
2001:db8::1
```

IPv6 was introduced primarily because IPv4 address space is limited.

Security professionals should understand:

* IPv6 addressing
* IPv6 routing
* IPv6 firewall rules
* IPv6 reconnaissance
* IPv6-related attack surfaces

---

# 10. MAC Address

A **MAC address** identifies a network interface at Layer 2.

Example:

```text
00:1A:2B:3C:4D:5E
```

MAC addresses are associated with Ethernet networking.

### Security relevance

Important in:

* ARP attacks
* Network monitoring
* Device identification
* MAC spoofing
* LAN investigations

---

# 11. ARP — Address Resolution Protocol

ARP maps an IPv4 address to a MAC address within a local network.

Example:

```text
Who has 192.168.1.1?

192.168.1.1 is at
AA:BB:CC:DD:EE:FF
```

View ARP information:

```bash
arp -a
```

or:

```bash
ip neigh
```

### ARP Spoofing

An attacker sends forged ARP messages to associate their MAC address with another device's IP.

Potential consequences:

* Man-in-the-Middle
* Traffic interception
* Session theft
* Traffic manipulation

---

# 12. Subnetting

Subnetting divides a network into smaller networks.

Example:

```text
192.168.1.0/24
```

A `/24` network provides:

```text
256 total addresses
```

Traditionally:

```text
Network:   192.168.1.0
Usable:    192.168.1.1 - 192.168.1.254
Broadcast: 192.168.1.255
```

### Important CIDR prefixes

```text
/8
/16
/24
/25
/26
/27
/28
/30
```

You should understand:

* Network address
* Host address
* Broadcast address
* CIDR
* Subnet mask
* Number of hosts

---

# 13. Default Gateway

A default gateway is the device used to reach networks outside the local network.

Example:

```text
PC
 |
 v
192.168.1.1
 |
 v
Internet
```

Usually the gateway is a router.

---

# 14. Routing

Routing determines where packets should go.

Example:

```text
Client
 |
 v
Router A
 |
 v
Router B
 |
 v
Server
```

Useful command:

```bash
ip route
```

Windows:

```cmd
route print
```

---

# 15. TCP

**Transmission Control Protocol** is connection-oriented and reliable.

TCP provides:

* Reliable delivery
* Ordering
* Error detection
* Retransmission
* Flow control

Common TCP services:

```text
HTTP    80
HTTPS   443
SSH     22
FTP     21
SMTP    25
```

---

# 16. TCP Three-Way Handshake

TCP connection establishment:

```text
Client                    Server
  |                         |
  | ------ SYN -----------> |
  | <----- SYN/ACK -------- |
  | ------ ACK -----------> |
  |                         |
  |      Connection         |
```

### Meaning

```text
SYN     = Synchronize
SYN/ACK = Synchronize + Acknowledge
ACK     = Acknowledge
```

### Security relevance

Understanding the handshake helps analyze:

* Port scans
* SYN floods
* Connection anomalies
* Firewall behavior
* Packet captures

---

# 17. UDP

**User Datagram Protocol** is connectionless.

UDP does not provide TCP-style:

* Connection establishment
* Guaranteed delivery
* Ordering
* Retransmission

Common UDP services:

```text
DNS       53
DHCP      67/68
SNMP      161
NTP       123
```

UDP is commonly used where speed and low overhead are important.

---

# 18. TCP vs UDP

| TCP                 | UDP                    |
| ------------------- | ---------------------- |
| Connection-oriented | Connectionless         |
| Reliable            | Best effort            |
| Ordered             | No guaranteed ordering |
| More overhead       | Lower overhead         |
| Uses handshake      | No TCP handshake       |
| Web/SSH/FTP         | DNS/DHCP/VoIP etc.     |

---

# 19. Ports

A **port** identifies a service/process endpoint.

Port range:

```text
0 - 65535
```

### Common Ports

|  Port | Protocol/Service      |
| ----: | --------------------- |
| 20/21 | FTP                   |
|    22 | SSH                   |
|    23 | Telnet                |
|    25 | SMTP                  |
|    53 | DNS                   |
| 67/68 | DHCP                  |
|    80 | HTTP                  |
|   110 | POP3                  |
|   123 | NTP                   |
|   143 | IMAP                  |
|   161 | SNMP                  |
|   389 | LDAP                  |
|   443 | HTTPS                 |
|   445 | SMB                   |
|   587 | SMTP Submission       |
|   636 | LDAPS                 |
|   993 | IMAPS                 |
|   995 | POP3S                 |
|  3306 | MySQL                 |
|  3389 | RDP                   |
|  5432 | PostgreSQL            |
|  6379 | Redis                 |
|  8080 | Common HTTP alternate |

> **Security rule:** Never assume a service based only on its port. A service can run on a non-standard port.

---

# 20. Socket

A socket represents an endpoint of network communication.

Conceptually:

```text
IP Address + Port + Protocol
```

Example:

```text
192.168.1.10:443/TCP
```

---

# 21. DNS

**Domain Name System** converts domain names into IP addresses.

Example:

```text
google.com
     |
     v
142.250.x.x
```

### Important DNS Record Types

| Record | Purpose                    |
| ------ | -------------------------- |
| A      | Domain → IPv4              |
| AAAA   | Domain → IPv6              |
| CNAME  | Alias                      |
| MX     | Mail server                |
| NS     | Name server                |
| TXT    | Text information           |
| PTR    | Reverse DNS                |
| SOA    | Zone authority information |

Useful commands:

```bash
nslookup example.com
```

```bash
dig example.com
```

### DNS Security

Important concepts:

* DNS spoofing
* DNS poisoning
* DNS tunneling
* DNS rebinding
* Subdomain enumeration
* DNSSEC

---

# 22. DHCP

**Dynamic Host Configuration Protocol** automatically provides network configuration.

DHCP can provide:

* IP address
* Subnet mask
* Default gateway
* DNS server

Basic process:

```text
DORA

Discover
Offer
Request
Acknowledge
```

---

# 23. HTTP

HTTP is an application-layer protocol used for web communication.

Basic flow:

```text
Client
  |
  | HTTP Request
  v
Web Server
  |
  | HTTP Response
  v
Client
```

Example request:

```http
GET / HTTP/1.1
Host: example.com
```

Example response:

```http
HTTP/1.1 200 OK
Content-Type: text/html
```

### Important HTTP Methods

```text
GET
POST
PUT
PATCH
DELETE
HEAD
OPTIONS
```

---

# 24. HTTP Status Codes

### 2xx — Success

```text
200 OK
201 Created
204 No Content
```

### 3xx — Redirection

```text
301 Moved Permanently
302 Found
304 Not Modified
```

### 4xx — Client Error

```text
400 Bad Request
401 Unauthorized
403 Forbidden
404 Not Found
405 Method Not Allowed
429 Too Many Requests
```

### 5xx — Server Error

```text
500 Internal Server Error
502 Bad Gateway
503 Service Unavailable
504 Gateway Timeout
```

---

# 25. HTTPS and TLS

HTTPS is HTTP protected using TLS.

```text
HTTP
 +
TLS
 =
HTTPS
```

HTTPS provides:

* Confidentiality
* Integrity
* Server authentication

Basic concept:

```text
Client
  |
  | TLS Handshake
  v
Server
  |
  | Encrypted Communication
  v
Client
```

### Cybersecurity relevance

Understand:

* TLS certificates
* Certificate authorities
* Encryption
* TLS versions
* Certificate validation
* Man-in-the-Middle attacks

---

# 26. SSH

SSH provides secure remote access.

Default port:

```text
22/TCP
```

Example:

```bash
ssh user@192.168.1.10
```

SSH can be used for:

* Remote administration
* Secure file transfer
* Tunneling
* Port forwarding

Security considerations:

* Strong authentication
* Key-based authentication
* Disable unnecessary access
* Restrict users
* Monitor authentication logs

---

# 27. FTP

FTP is used for file transfer.

Default ports:

```text
21/TCP  → Control
20/TCP  → Traditional data channel
```

FTP does not provide encryption by default.

Safer alternatives include:

```text
SFTP
FTPS
```

---

# 28. Email Protocols

### SMTP

Used for sending email.

Common ports:

```text
25
465
587
```

### POP3

Used for retrieving email.

```text
110
995
```

### IMAP

Used for accessing/managing email.

```text
143
993
```

Cybersecurity relevance:

* Phishing
* Email spoofing
* SPF
* DKIM
* DMARC
* Malicious attachments

---

# 29. ICMP

**Internet Control Message Protocol** is used for network diagnostics and error reporting.

Example:

```bash
ping 8.8.8.8
```

ICMP is also relevant to:

* Network discovery
* Troubleshooting
* Reconnaissance
* ICMP tunneling
* Network attacks

---

# 30. NAT

**Network Address Translation** translates between private and public addresses.

Example:

```text
Private Network
192.168.1.10
      |
      v
   Router/NAT
      |
      v
Public IP
      |
      v
Internet
```

NAT is commonly used to allow multiple internal devices to share a public IP.

---

# 31. Firewall

A firewall controls traffic based on security rules.

Example:

```text
Source       Destination       Port       Action
192.168.1.0  Server             443       ALLOW
Internet     Server             22        DENY
```

Firewall types include:

* Network firewall
* Host-based firewall
* Stateful firewall
* Next-Generation Firewall (NGFW)
* Web Application Firewall (WAF)

---

# 32. Stateful vs Stateless Firewall

### Stateless

Examines individual packets independently.

### Stateful

Tracks the state of network connections.

Example:

```text
Client → Server
SYN
SYN/ACK
ACK
```

A stateful firewall understands that these packets belong to the same connection.

---

# 33. Proxy

A proxy acts as an intermediary.

```text
Client
  |
  v
Proxy
  |
  v
Internet
```

Types:

* Forward proxy
* Reverse proxy

### Reverse Proxy

Commonly placed in front of web servers.

```text
Internet
   |
   v
Reverse Proxy
   |
   +---- Web Server 1
   |
   +---- Web Server 2
```

Examples:

* Nginx
* HAProxy
* Cloudflare

---

# 34. Load Balancer

Distributes incoming traffic across multiple servers.

```text
             ┌── Server 1
Client ──> Load Balancer
             ├── Server 2
             └── Server 3
```

Security relevance:

* DDoS protection
* TLS termination
* Traffic distribution
* High availability

---

# 35. VLAN

A **Virtual LAN** logically separates devices within a switched network.

Example:

```text
VLAN 10 → Employees
VLAN 20 → Servers
VLAN 30 → Guests
```

Security benefit:

Network segmentation reduces unnecessary communication between systems.

---

# 36. VPN

VPN creates a protected communication tunnel.

Common technologies:

* IPsec
* WireGuard
* OpenVPN
* SSL/TLS VPN

Cybersecurity use cases:

* Secure remote access
* Protect traffic over untrusted networks
* Connect remote offices
* Access internal resources

---

# 37. Network Segmentation

Segmentation separates a network into security zones.

Example:

```text
Internet
   |
Firewall
   |
DMZ
   |
Firewall
   |
Internal Network
   |
Critical Servers
```

Benefits:

* Limits lateral movement
* Reduces attack surface
* Improves monitoring
* Protects critical systems

---

# 38. DMZ

A **Demilitarized Zone** is a network segment used for systems that need controlled exposure to external networks.

Common DMZ services:

* Public web server
* Mail gateway
* DNS server
* Reverse proxy

Example:

```text
Internet
    |
 Firewall
    |
   DMZ
    |
 Firewall
    |
Internal Network
```

---

# 39. IDS and IPS

## IDS — Intrusion Detection System

Detects suspicious activity and generates alerts.

```text
Traffic → IDS → Alert
```

## IPS — Intrusion Prevention System

Can actively block malicious traffic.

```text
Traffic → IPS → Detect → Block
```

### Cybersecurity relevance

Understand:

* Signature-based detection
* Anomaly detection
* False positives
* False negatives
* Network traffic inspection

---

# 40. Packet

A packet is a unit of network data.

Conceptually:

```text
+------------------+
| Header           |
+------------------+
| Payload          |
+------------------+
```

Headers may contain:

* Source IP
* Destination IP
* Source port
* Destination port
* Protocol information
* Flags

---

# 41. Packet Capture

Packet capture allows security professionals to inspect network traffic.

Important tool:

```text
Wireshark
```

Command-line tool:

```text
tcpdump
```

Example:

```bash
tcpdump -i eth0
```

Useful Wireshark filters:

```text
ip.addr == 192.168.1.10
```

```text
tcp.port == 443
```

```text
http
```

```text
dns
```

```text
icmp
```

---

# 42. Network Scanning

Network scanning identifies hosts, ports, and services.

Common tool:

```text
Nmap
```

Basic host discovery:

```bash
nmap -sn 192.168.1.0/24
```

Basic port scan:

```bash
nmap 192.168.1.10
```

Service detection:

```bash
nmap -sV 192.168.1.10
```

OS detection:

```bash
nmap -O 192.168.1.10
```

### Important

Only scan systems you own or have explicit authorization to test.

---

# 43. Reconnaissance

Reconnaissance is the information-gathering phase of security testing.

Information may include:

* IP addresses
* Domains
* Subdomains
* Open ports
* Running services
* Technologies
* DNS records
* Network ranges

Typical workflow:

```text
Recon
  ↓
Discovery
  ↓
Enumeration
  ↓
Vulnerability Identification
  ↓
Exploitation
  ↓
Reporting
```

---

# 44. Common Network Attacks

### Port Scanning

Identifying accessible ports.

### ARP Spoofing

Manipulating ARP mappings.

### DNS Spoofing

Providing false DNS information.

### IP Spoofing

Forging the source IP address.

### MAC Spoofing

Changing/spoofing a network interface's MAC address.

### Man-in-the-Middle

Attacker positions themselves between communicating parties.

```text
Client
  |
  v
Attacker
  |
  v
Server
```

### DoS / DDoS

Attempting to make a service unavailable.

### SYN Flood

Abusing TCP connection establishment with large numbers of SYN requests.

---

# 45. Network Security Monitoring

A SOC analyst continuously monitors network activity.

Important data sources:

```text
Firewall Logs
     +
IDS/IPS Alerts
     +
DNS Logs
     +
Proxy Logs
     +
VPN Logs
     +
Network Traffic
     +
Endpoint Logs
```

These can be analyzed inside a:

```text
SIEM
```

Examples:

* Splunk
* Microsoft Sentinel
* Elastic Security
* IBM QRadar

---

# 46. Important SOC Networking Concepts

A SOC analyst should understand:

### Source IP

Where traffic originated.

### Destination IP

Where traffic is going.

### Source Port

Originating communication port.

### Destination Port

Target service port.

### Protocol

Examples:

```text
TCP
UDP
ICMP
HTTP
DNS
```

### Timestamp

When communication occurred.

### Direction

```text
Inbound
Outbound
Internal
```

### Action

Examples:

```text
ALLOW
DENY
DROP
BLOCK
```

---

# 47. Example SOC Investigation

Suppose a firewall log shows:

```text
Source:      185.x.x.x
Destination: 10.0.0.20
Port:        3389
Protocol:    TCP
Action:      ALLOW
```

Port `3389` is commonly associated with RDP.

A SOC analyst should investigate:

1. Is the source IP trusted?
2. Is RDP exposed externally?
3. Was authentication successful?
4. Which account was targeted?
5. Were there multiple attempts?
6. Was there successful login?
7. What happened after authentication?
8. Are other hosts communicating with the same source?
9. Does threat intelligence identify the source as malicious?

---

# 48. Essential Linux Networking Commands

### Show interfaces

```bash
ip addr
```

### Show routes

```bash
ip route
```

### Show ARP/neighbors

```bash
ip neigh
```

### Test connectivity

```bash
ping <IP>
```

### DNS lookup

```bash
nslookup example.com
```

```bash
dig example.com
```

### Trace route

```bash
traceroute example.com
```

### View listening ports

```bash
ss -tulnp
```

### Network connections

```bash
ss -ant
```

### Packet capture

```bash
tcpdump -i eth0
```

---

# 49. Essential Windows Networking Commands

### IP configuration

```cmd
ipconfig
```

Detailed:

```cmd
ipconfig /all
```

### Test connectivity

```cmd
ping 8.8.8.8
```

### DNS lookup

```cmd
nslookup example.com
```

### Trace route

```cmd
tracert example.com
```

### ARP table

```cmd
arp -a
```

### Routing table

```cmd
route print
```

### Active connections

```cmd
netstat -ano
```

---

# 50. Networking Tools for Cybersecurity

| Tool               | Main Use                    |
| ------------------ | --------------------------- |
| Wireshark          | Packet analysis             |
| tcpdump            | CLI packet capture          |
| Nmap               | Network scanning            |
| Netcat             | Network connections/testing |
| Burp Suite         | Web traffic analysis        |
| Metasploit         | Security testing            |
| Scapy              | Packet manipulation         |
| traceroute/tracert | Path analysis               |
| dig                | DNS analysis                |
| nslookup           | DNS queries                 |

---

# 51. Netcat

Netcat is a versatile networking utility.

Basic syntax:

```bash
nc <IP> <PORT>
```

It can be used for:

* Connectivity testing
* Port testing
* Network debugging
* Banner grabbing
* Lab-based security testing

Use it only on systems where you have authorization.

---

# 52. Network Authentication Concepts

Important authentication mechanisms include:

```text
Password Authentication
Public Key Authentication
Kerberos
NTLM
Certificates
MFA
```

Cybersecurity professionals should understand the difference between:

```text
Authentication
Authorization
Accounting
```

### Authentication

**Who are you?**

### Authorization

**What are you allowed to do?**

### Accounting

**What did you do?**

This is commonly called:

```text
AAA
```

---

# 53. Zero Trust Networking

Zero Trust follows the principle:

> **Never trust, always verify.**

Instead of automatically trusting internal network traffic, systems continuously verify:

* User identity
* Device identity
* Application
* Context
* Risk
* Access permissions

Core principle:

```text
Network Location ≠ Trust
```

---

# 54. Network Security Principles

### Least Privilege

Give users/services only the access they need.

### Defense in Depth

Use multiple layers of security.

```text
Firewall
   ↓
IDS/IPS
   ↓
Endpoint Security
   ↓
Authentication
   ↓
Application Security
```

### Segmentation

Separate sensitive systems.

### Encryption

Protect data in transit.

### Monitoring

Continuously observe network activity.

### Logging

Maintain useful security records.

---

# 55. Important Networking Terms

You should know these terms before moving into advanced cybersecurity:

```text
IP
MAC
TCP
UDP
ICMP
ARP
DNS
DHCP
NAT
VPN
VLAN
CIDR
Subnet
Gateway
Router
Switch
Firewall
Proxy
DMZ
Port
Socket
Packet
Protocol
Routing
HTTP
HTTPS
TLS
SSH
FTP
SMTP
IDS
IPS
SIEM
```

---

# 56. Cybersecurity Networking Learning Path

Follow this order:

```text
1. Network Fundamentals
        ↓
2. OSI Model
        ↓
3. TCP/IP
        ↓
4. IPv4 Addressing
        ↓
5. Subnetting & CIDR
        ↓
6. MAC & ARP
        ↓
7. TCP & UDP
        ↓
8. Ports & Services
        ↓
9. DNS & DHCP
        ↓
10. HTTP/HTTPS
        ↓
11. Routing & NAT
        ↓
12. Firewalls
        ↓
13. VPN & VLAN
        ↓
14. Packet Analysis
        ↓
15. Network Scanning
        ↓
16. IDS/IPS
        ↓
17. Network Attacks
        ↓
18. SOC Network Monitoring
```

---

# 57. Practical Labs

Theory alone is not enough. Practice networking in a controlled lab.

## Lab 1 — Basic Network Information

Run:

```bash
ip addr
ip route
ip neigh
```

Understand:

* Your IP
* Network interface
* Gateway
* Routing table
* Neighbor/MAC information

---

## Lab 2 — DNS

Try:

```bash
nslookup google.com
```

Then:

```bash
dig google.com
```

Identify:

* A record
* AAAA record
* Name servers
* Response information

---

## Lab 3 — Nmap

Create your own lab machine and run:

```bash
nmap <LAB-IP>
```

Then:

```bash
nmap -sV <LAB-IP>
```

Understand:

* Open ports
* Closed ports
* Services
* Service versions

---

## Lab 4 — Wireshark

Capture traffic and identify:

```text
DNS
TCP
TLS
ICMP
HTTP
```

Observe:

* Source IP
* Destination IP
* Source port
* Destination port
* TCP flags
* Packet contents

---

## Lab 5 — TCP Handshake

Capture a TCP connection in Wireshark.

Identify:

```text
SYN
SYN/ACK
ACK
```

Understand exactly how a TCP connection starts.

---

# 58. Cybersecurity Skills You Should Build from Networking

After completing this document, you should be able to:

* Explain the OSI and TCP/IP models.
* Understand IPv4 and IPv6.
* Calculate basic subnets.
* Identify private and public IPs.
* Explain TCP and UDP.
* Understand TCP three-way handshake.
* Identify common ports and services.
* Explain DNS and DHCP.
* Understand ARP.
* Explain NAT.
* Understand routing.
* Explain firewalls.
* Understand VPNs and VLANs.
* Analyze basic packets.
* Use Wireshark.
* Use tcpdump.
* Perform authorized Nmap scanning.
* Understand common network attacks.
* Read basic firewall and network logs.
* Investigate suspicious IP/port activity.
* Understand how network traffic appears in a SOC.

---

# 59. Networking → Cybersecurity Connection

The goal is not to memorize networking definitions.

You should learn to think like a security analyst:

```text
Network Event
     ↓
What happened?
     ↓
Which host?
     ↓
Which IP?
     ↓
Which port?
     ↓
Which protocol?
     ↓
Which service?
     ↓
Is it expected?
     ↓
Is it malicious?
     ↓
What evidence supports it?
     ↓
What should be done?
```

This mindset is essential for:

```text
SOC Analyst
Blue Team
Network Security Engineer
Penetration Tester
Incident Responder
Threat Hunter
Security Engineer
Cloud Security Engineer
```

---

# 60. Final Networking Checklist

Before moving to advanced cybersecurity networking, make sure you can confidently explain:

* [ ] OSI Model
* [ ] TCP/IP Model
* [ ] IPv4
* [ ] IPv6 basics
* [ ] Private vs Public IP
* [ ] MAC Address
* [ ] ARP
* [ ] Subnetting
* [ ] CIDR
* [ ] Default Gateway
* [ ] Routing
* [ ] TCP
* [ ] UDP
* [ ] TCP Three-Way Handshake
* [ ] Ports
* [ ] Sockets
* [ ] DNS
* [ ] DHCP
* [ ] HTTP
* [ ] HTTPS
* [ ] TLS
* [ ] SSH
* [ ] FTP/SFTP
* [ ] SMTP/IMAP/POP3
* [ ] ICMP
* [ ] NAT
* [ ] Firewall
* [ ] Proxy
* [ ] VPN
* [ ] VLAN
* [ ] DMZ
* [ ] IDS/IPS
* [ ] Packet Capture
* [ ] Wireshark
* [ ] tcpdump
* [ ] Nmap
* [ ] Basic Network Attacks
* [ ] Network Logs
* [ ] SOC Network Monitoring
* [ ] Zero Trust
* [ ] Network Segmentation

---

## Key Takeaway

> **Networking is the foundation of cybersecurity.**

If you understand how devices communicate, how packets move, how protocols work, how ports expose services, and how network traffic can be monitored and manipulated, advanced cybersecurity concepts become significantly easier to understand.

**Recommended next topics after this file:**

```text
Advanced Networking
        ↓
Network Security
        ↓
Wireshark & Packet Analysis
        ↓
Nmap & Network Enumeration
        ↓
Web Networking
        ↓
Active Directory Networking
        ↓
SOC & SIEM
        ↓
Network Attacks & Defense
        ↓
Advanced Penetration Testing
```
