# Knowledge Base: DNS Propagation Issues

## Article ID

KB-009

---

# Overview

DNS propagation is the process of distributing updated DNS records across DNS resolvers worldwide. During this period, some users may reach the new server while others continue to reach the previous server.

Understanding DNS propagation is essential when troubleshooting website migrations, domain changes, email delivery issues, and SSL validation.

---

# What is DNS?

The Domain Name System (DNS) translates a human-readable domain name into the IP address of a web server.

Example

```
example.com
      │
      ▼
DNS Resolver
      │
      ▼
203.0.113.25
      │
      ▼
Web Server
```

---

# DNS Propagation Process

```
DNS Record Updated
         │
         ▼
Authoritative Name Server
         │
         ▼
ISP DNS Resolver
         │
         ▼
Local DNS Cache
         │
         ▼
Visitor Browser
```

Propagation does not happen instantly because DNS information is cached at multiple levels.

---

# Typical Propagation Time

| TTL Value | Typical Update Time |
|-----------|---------------------|
| 300 sec | 5–15 minutes |
| 1800 sec | 30–60 minutes |
| 3600 sec | 1–4 hours |
| 86400 sec | Up to 24 hours |

Actual propagation time depends on the resolver and caching behavior.

---

# Common DNS Records

## A Record

Maps a domain to an IPv4 address.

Example

```
example.com

↓

203.0.113.25
```

---

## AAAA Record

Maps a domain to an IPv6 address.

---

## CNAME Record

Creates an alias.

Example

```
www.example.com

↓

example.com
```

---

## MX Record

Controls email routing.

---

## TXT Record

Used for:

- SPF
- DKIM
- DMARC
- Domain verification

---

# Common Symptoms

Customers may report:

- Website works for some users but not others
- Website loads from the old server
- SSL certificate validation fails
- Email stops working
- "Server not found"
- DNS lookup failures
- Random website availability

---

# Troubleshooting Workflow

```
Customer Reports DNS Issue
          │
          ▼
Verify DNS Records
          │
          ▼
Check Propagation
          │
          ▼
Verify Nameservers
          │
          ▼
Inspect DNS Cache
          │
          ▼
Validate Resolution
          │
          ▼
Confirm with Customer
```

---

# Step 1 – Verify DNS Records

Confirm:

- A Record
- AAAA Record
- CNAME
- MX
- TXT

Ensure records point to the correct destination.

---

# Step 2 – Verify Nameservers

Confirm the domain is using the intended authoritative nameservers.

Example

```
ns1.provider.com

ns2.provider.com
```

Incorrect nameservers will prevent new DNS records from being used.

---

# Step 3 – Check Propagation

Useful tools

- DNSChecker
- Google Admin Toolbox
- IntoDNS

Verify from multiple geographic locations.

---

# Step 4 – Test with nslookup

```bash
nslookup example.com
```

Example Output

```text
Server: 8.8.8.8

Name: example.com

Address: 203.0.113.25
```

Compare the returned IP with the expected server IP.

---

# Step 5 – Test with dig

```bash
dig example.com
```

Review:

- Answer Section
- TTL
- Authority Section
- Status

---

# Step 6 – Flush Local DNS Cache

Operating systems cache DNS responses.

Common actions:

Windows

```bash
ipconfig /flushdns
```

macOS

```bash
sudo dscacheutil -flushcache
```

Linux

Restart the local DNS resolver or system service appropriate for the distribution.

---

# Common DNS Problems

## Incorrect A Record

Symptoms

- Website unreachable
- Wrong website displayed

Resolution

- Update A Record
- Verify server IP
- Wait for propagation

---

## Incorrect CNAME

Symptoms

```
example.com works

↓

www.example.com fails
```

Resolution

Correct the CNAME target.

---

## Email Not Working

Possible causes

- Incorrect MX Record
- Missing SPF
- Invalid DKIM

Resolution

Review all mail-related DNS records.

---

## Old Website Still Visible

Possible causes

- DNS propagation
- Browser cache
- CDN cache

Resolution

- Verify DNS propagation
- Clear browser cache
- Purge CDN cache if applicable

---

## SSL Validation Failure

Possible causes

- DNS still pointing to the previous server
- Certificate issued for the wrong endpoint

Resolution

Wait for propagation to complete before validating the certificate again.

---

# Validation Checklist

After making DNS changes:

- Domain resolves correctly
- www resolves correctly
- HTTPS functions normally
- Email delivered successfully
- No DNS lookup failures
- SSL certificate valid
- Website accessible globally

---

# Example Investigation

## Customer Report

> "After migrating the website, some visitors still see the old version."

### Investigation

- Verified A Record
- Confirmed nameservers
- Tested with `dig`
- Checked multiple public DNS resolvers

### Root Cause

Several recursive DNS resolvers were still serving cached records from before the migration.

### Resolution

- Confirmed authoritative DNS records were correct
- Advised waiting for propagation based on TTL
- Cleared local browser and operating system DNS cache
- Verified global propagation over time

### Result

All tested locations resolved to the new server after propagation completed.

---

# Best Practices

- Reduce TTL before planned migrations.
- Verify nameservers before changing records.
- Document all DNS modifications.
- Keep DNS records organized and up to date.
- Test from multiple geographic locations.
- Avoid unnecessary DNS changes during production hours.
- Confirm propagation before troubleshooting unrelated issues.

---

# Related Articles

- ssl-errors.md
- email-issues.md
- checkout-errors.md
- cache-problems.md
- common-fixes.md

---

# References

- RFC 1034 – Domain Concepts and Facilities
- RFC 1035 – Domain Implementation and Specification
- WordPress Developer Documentation
- Cloudflare Learning Center
- ICANN DNS Resources
