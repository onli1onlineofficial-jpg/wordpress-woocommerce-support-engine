# DNS & SSL Troubleshooting Guide

## Overview

This document provides a practical guide for diagnosing and resolving DNS and SSL/TLS issues commonly encountered in WordPress and WooCommerce environments.

Reliable DNS resolution and correctly configured SSL certificates are essential for website availability, email delivery, secure checkout, API communication, and customer trust.

---

# DNS Fundamentals

DNS (Domain Name System) translates a domain name into the IP address of a web server.

Example:

```
example.com
      │
      ▼
DNS Resolver
      │
      ▼
A Record
      │
      ▼
203.0.113.25
      │
      ▼
Web Server
```

---

# Common DNS Records

## A Record

Maps a domain to an IPv4 address.

Example:

```
example.com

↓

203.0.113.25
```

Example:

```
example.com    A      203.0.113.25
```

---

## CNAME Record

Creates an alias.

Example:

```
www.example.com

↓

example.com
```

```
www    CNAME    example.com
```

---

## MX Record

Responsible for email routing.

Example:

```
example.com

↓

Google Workspace
```

```
example.com MX 10 aspmx.l.google.com
```

---

## TXT Record

Used for verification and email authentication.

Examples:

- SPF
- DKIM
- DMARC
- Domain Verification

Example:

```
v=spf1 include:_spf.google.com ~all
```

---

# DNS Resolution Process

```
User visits website
        │
        ▼
Browser
        │
        ▼
DNS Resolver
        │
        ▼
Root Server
        │
        ▼
TLD Server
        │
        ▼
Authoritative Name Server
        │
        ▼
IP Address Returned
        │
        ▼
Connection to Web Server
```

---

# Common DNS Issues

## Incorrect A Record

Symptoms

- Website not loading
- Wrong server opens
- Connection timeout

Verification

```bash
nslookup example.com
```

or

```bash
dig example.com
```

Resolution

- Verify server IP
- Update A Record
- Wait for propagation

---

## DNS Propagation

Symptoms

- Website works for some users
- Fails for others

Cause

DNS changes require propagation across global DNS servers.

Typical propagation

```
5 minutes
↓

24 hours
↓

48 hours
```

Verification

Use

- DNSChecker.org
- dig
- nslookup

---

## Missing CNAME

Symptoms

```
example.com works

www.example.com fails
```

Resolution

Create

```
www

↓

CNAME

↓

example.com
```

---

# Email Problems

Symptoms

- Email not delivered
- Bounce messages
- Spam classification

Check

- MX Record
- SPF
- DKIM
- DMARC

---

# SSL Overview

SSL (Secure Sockets Layer) and TLS (Transport Layer Security) encrypt communication between visitors and the web server.

```
Browser
     │
HTTPS Request
     │
TLS Handshake
     │
Encrypted Connection
     │
Web Server
```

---

# SSL Handshake

```
Client Hello
        │
        ▼
Server Hello
        │
        ▼
Certificate Exchange
        │
        ▼
Key Exchange
        │
        ▼
Encrypted Session
```

---

# Common SSL Problems

## Expired Certificate

Symptoms

- Browser security warning
- HTTPS unavailable

Verification

```bash
openssl s_client -connect example.com:443
```

Resolution

Renew certificate.

---

## Mixed Content

Symptoms

- Lock icon missing
- Browser warnings

Cause

HTTPS page loading HTTP assets.

Example

```
https://example.com

↓

Loads

↓

http://image.jpg
```

Resolution

Update asset URLs.

---

## Redirect Loop

Symptoms

```
ERR_TOO_MANY_REDIRECTS
```

Possible causes

- Incorrect HTTPS rules
- Cloudflare configuration
- Reverse proxy configuration

Resolution

- Verify redirect rules
- Check SSL mode
- Clear cache

---

# WordPress SSL Checklist

Verify

- WordPress Address
- Site Address
- HTTPS Redirect
- Certificate Status
- Browser Lock Icon
- Mixed Content
- REST API

---

# Useful WP-CLI Commands

Check site URL

```bash
wp option get siteurl
```

Check home URL

```bash
wp option get home
```

Search and replace HTTP

```bash
wp search-replace 'http://example.com' 'https://example.com'
```

Flush cache

```bash
wp cache flush
```

---

# Troubleshooting Workflow

```
Customer reports issue
        │
        ▼
Identify DNS or SSL problem
        │
        ▼
Verify DNS records
        │
        ▼
Verify certificate
        │
        ▼
Test HTTPS
        │
        ▼
Implement fix
        │
        ▼
Validate website
        │
        ▼
Confirm with customer
```

---

# Best Practices

- Enable automatic SSL renewal.
- Keep DNS records documented.
- Minimize unnecessary DNS changes.
- Use HTTPS across the entire website.
- Monitor certificate expiration.
- Test DNS changes before production deployment.
- Keep backups before modifying DNS.

---

# Useful Diagnostic Tools

DNS

- nslookup
- dig
- DNSChecker
- Google Admin Toolbox

SSL

- SSL Labs SSL Test
- OpenSSL
- Chrome DevTools
- Mozilla Observatory

Performance

- GTmetrix
- Google PageSpeed Insights
- Lighthouse

---

# Conclusion

Stable DNS configuration and properly managed SSL certificates are critical for website availability, secure transactions, email reliability, and customer trust. A systematic troubleshooting approach helps identify root causes quickly while minimizing downtime and ensuring a consistent user experience.
