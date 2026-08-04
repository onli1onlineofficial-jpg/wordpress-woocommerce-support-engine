# Knowledge Base: SSL Certificate Errors

## Article ID

KB-008

---

# Overview

SSL (Secure Sockets Layer) and its successor TLS (Transport Layer Security) encrypt communication between a user's browser and a web server.

A properly configured SSL certificate protects sensitive information, enables HTTPS, improves customer trust, and is required by most payment gateways.

This guide provides a structured approach for diagnosing and resolving SSL-related issues in WordPress and WooCommerce environments.

---

# SSL Connection Flow

```
User Browser
      │
HTTPS Request
      │
      ▼
DNS Resolution
      │
      ▼
Web Server
      │
      ▼
SSL Certificate
      │
      ▼
TLS Handshake
      │
      ▼
Encrypted Connection
```

---

# Common Symptoms

Customers may report:

- Website marked "Not Secure"
- SSL certificate warning
- Mixed content errors
- HTTPS redirect loop
- Checkout not loading
- Browser security warning
- Payment gateway failure
- Certificate expired
- Invalid certificate

---

# Initial Investigation

Collect:

- Website URL
- Hosting provider
- SSL provider
- Browser
- Exact error message
- Date issue started
- Recent DNS changes
- Recent server migration

---

# Common Browser Errors

## NET::ERR_CERT_DATE_INVALID

Meaning

The SSL certificate has expired or is not yet valid.

Resolution

- Renew the certificate
- Verify server date and time
- Restart web services if required

---

## NET::ERR_CERT_COMMON_NAME_INVALID

Meaning

The certificate does not match the requested domain.

Example

```
Certificate:

example.com

↓

Customer visits

shop.example.com
```

Resolution

Install a certificate covering the correct hostname.

---

## NET::ERR_SSL_PROTOCOL_ERROR

Possible causes

- Incorrect server configuration
- Invalid SSL protocol
- Firewall interference

Resolution

Review server SSL configuration and supported TLS versions.

---

## Mixed Content Warning

Example

```
https://example.com

↓

Loads

↓

http://style.css
```

Symptoms

- Broken padlock icon
- Browser security warnings
- Payment gateways may refuse requests

Resolution

Replace all HTTP resources with HTTPS equivalents.

---

# Troubleshooting Workflow

```
Customer Reports SSL Issue
            │
            ▼
Verify HTTPS
            │
            ▼
Inspect Certificate
            │
            ▼
Check DNS
            │
            ▼
Review Redirect Rules
            │
            ▼
Test SSL Configuration
            │
            ▼
Validate Website
```

---

# Step 1 – Verify Certificate

Check:

- Certificate validity
- Expiration date
- Issuing authority
- Covered domains
- Certificate chain

---

# Step 2 – Verify HTTPS

Confirm:

- HTTPS loads successfully
- No browser warnings
- Secure padlock displayed
- HTTP redirects correctly

---

# Step 3 – Inspect Redirect Rules

Review:

- .htaccess
- Nginx configuration
- Reverse proxy
- CDN settings

Common issue

```
HTTP

↓

HTTPS

↓

HTTP

↓

HTTPS

↓

Infinite Loop
```

---

# Step 4 – WordPress Settings

Verify:

```
Settings

↓

General
```

Confirm:

```
WordPress Address

Home Address

↓

https://
```

---

# Step 5 – Search & Replace

Replace HTTP URLs.

Dry Run

```bash
wp search-replace \
"http://example.com" \
"https://example.com" \
--dry-run
```

Execute

```bash
wp search-replace \
"http://example.com" \
"https://example.com"
```

---

# Step 6 – Browser Testing

Test using:

- Chrome
- Firefox
- Edge
- Safari

Also verify:

- Incognito mode
- Mobile browser
- Different network

---

# Step 7 – Clear Cache

Clear:

- Browser cache
- WordPress cache
- CDN cache
- Reverse proxy cache

Useful command

```bash
wp cache flush
```

---

# Common SSL Problems

## Expired Certificate

Symptoms

- Browser warning
- Checkout blocked
- API failures

Resolution

- Renew certificate
- Verify installation
- Restart web server if necessary

---

## Incorrect Redirect

Symptoms

```
ERR_TOO_MANY_REDIRECTS
```

Resolution

- Review redirect rules
- Verify HTTPS configuration
- Check proxy settings

---

## Mixed Content

Symptoms

- Broken lock icon
- CSS or images not loading securely

Resolution

- Update internal URLs
- Replace HTTP resources
- Clear caches

---

## Certificate Mismatch

Symptoms

Certificate valid only for another domain.

Resolution

- Install the correct certificate
- Verify DNS records
- Confirm virtual host configuration

---

# Validation Checklist

After applying the fix:

- HTTPS loads successfully
- Certificate valid
- Secure padlock displayed
- No mixed content
- Checkout functions correctly
- Payment gateway operational
- No redirect loops

---

# Example Investigation

## Customer Report

> "Customers see a security warning before accessing the checkout page."

### Investigation

- Reviewed certificate
- Verified HTTPS
- Checked redirect rules
- Inspected browser console

### Root Cause

Several CSS and JavaScript assets were still loading over HTTP after enabling SSL.

### Resolution

- Updated internal URLs
- Executed search-and-replace
- Cleared WordPress and CDN cache
- Verified HTTPS across the website

### Result

Browser warnings disappeared and secure checkout was restored.

---

# Best Practices

- Renew certificates before expiration.
- Force HTTPS across the entire website.
- Monitor certificate validity.
- Test after server migrations.
- Keep redirect rules simple.
- Remove HTTP references from themes and plugins.
- Verify SSL after DNS changes.

---

# Useful WP-CLI Commands

Check Site URL

```bash
wp option get siteurl
```

Check Home URL

```bash
wp option get home
```

Replace HTTP URLs

```bash
wp search-replace \
"http://example.com" \
"https://example.com"
```

Flush Cache

```bash
wp cache flush
```

---

# Related Articles

- dns-propagation.md
- cache-problems.md
- checkout-errors.md
- wp-debug-log.md
- common-fixes.md

---

# References

- WordPress Developer Documentation
- WP-CLI Documentation
- Let's Encrypt Documentation
- SSL Labs Documentation
- Mozilla SSL Configuration Guidelines
