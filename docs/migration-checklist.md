# WordPress Site Migration Checklist

## Overview

This document provides a structured checklist for planning, executing, and validating WordPress and WooCommerce website migrations while minimizing downtime and reducing operational risk.

The migration process is divided into four stages:

1. Pre-Migration
2. Migration
3. Post-Migration
4. Validation

---

# Migration Workflow

```
Migration Planning
        │
        ▼
Backup Verification
        │
        ▼
Prepare Destination Server
        │
        ▼
Transfer Website Files
        │
        ▼
Import Database
        │
        ▼
Update Configuration
        │
        ▼
DNS Changes
        │
        ▼
Validation
        │
        ▼
Go Live
```

---

# Phase 1 – Pre-Migration

## Site Assessment

- Identify WordPress version
- Identify WooCommerce version
- Check PHP version
- Review active plugins
- Review active theme
- Review custom code
- Check disk usage
- Review server configuration

---

## Backup

Before any migration:

- Full website backup
- Database backup
- Media backup
- wp-config.php backup
- .htaccess backup

Verification Checklist

- Backup completed
- Backup stored securely
- Backup tested
- Restore process verified

---

## Hosting Verification

Confirm destination server supports:

- PHP
- MySQL
- HTTPS
- WP-CLI
- Required PHP extensions
- File permissions

---

# Phase 2 – File Migration

Copy:

```
wp-admin/

wp-content/

wp-includes/

wp-config.php
```

Verify:

- File count
- Permissions
- Ownership

---

# Database Migration

Export database

```bash
wp db export
```

Import database

```bash
wp db import backup.sql
```

Optimize database

```bash
wp db optimize
```

Repair database if necessary

```bash
wp db repair
```

---

# Configuration Updates

Update:

- Database credentials
- Site URL
- Home URL
- File permissions
- Cache configuration

Verify:

```bash
wp option get siteurl
```

```bash
wp option get home
```

---

# Search & Replace

Update old URLs.

Dry run

```bash
wp search-replace \
"http://oldsite.com" \
"https://newsite.com" \
--dry-run
```

Execute

```bash
wp search-replace \
"http://oldsite.com" \
"https://newsite.com"
```

---

# DNS Checklist

Verify:

- A Record
- CNAME
- MX
- TXT

Recommended approach:

- Lower TTL before migration
- Update DNS records
- Monitor propagation

---

# SSL Checklist

Verify:

- SSL installed
- HTTPS enabled
- Certificate valid
- Redirect rules
- Mixed content

---

# WooCommerce Validation

Confirm:

- Products
- Categories
- Orders
- Customers
- Payment gateways
- Shipping methods
- Tax settings
- Checkout process

---

# Plugin Validation

Review:

- Plugin compatibility
- License activation
- Scheduled tasks
- REST API functionality

---

# Theme Validation

Verify:

- Layout
- Navigation
- Mobile responsiveness
- Custom templates
- Widgets
- Menus

---

# Performance Validation

Review:

- Page speed
- Cache
- Images
- Database performance

Recommended tools:

- Google PageSpeed Insights
- GTmetrix
- Lighthouse

---

# Functional Testing

Confirm:

- Home page
- Product pages
- Search
- Login
- Registration
- Password reset
- Contact forms
- Checkout
- Email notifications

---

# SEO Validation

Verify:

- Sitemap
- robots.txt
- Meta titles
- Canonical URLs
- Redirects
- Search Console access

---

# Security Checklist

Confirm:

- File permissions
- HTTPS enforcement
- Admin access
- Backup schedule
- Security plugins
- User roles

---

# Rollback Plan

Before going live ensure:

- Previous server remains available
- Backup is verified
- Rollback steps documented
- DNS rollback prepared

---

# Final Validation

Complete the following before closing the migration:

- Website loads successfully
- Admin dashboard accessible
- SSL working
- DNS resolving correctly
- Media displaying correctly
- Forms functioning
- WooCommerce checkout tested
- Emails delivered
- No PHP errors
- No JavaScript errors
- No database issues

---

# Post-Migration Monitoring

Monitor for at least 24–48 hours:

- Error logs
- Customer reports
- Checkout activity
- Payment processing
- Site performance
- Email delivery
- Server resources

---

# Common Migration Issues

| Issue | Possible Cause | Resolution |
|--------|----------------|------------|
| White Screen | Plugin conflict | Disable plugins and review `debug.log` |
| Mixed Content | HTTP assets | Replace HTTP URLs with HTTPS |
| Login Failure | Incorrect site URL | Verify `home` and `siteurl` options |
| Broken Images | Incorrect uploads path | Verify file transfer and permissions |
| Redirect Loop | SSL or redirect rules | Review `.htaccess` and server configuration |
| Database Error | Import failure | Re-import database and repair tables |

---

# Best Practices

- Always create verified backups.
- Test the migration in a staging environment before production.
- Perform migrations during low-traffic periods.
- Keep stakeholders informed throughout the process.
- Validate every critical feature before announcing completion.
- Document all configuration changes.

---

# Conclusion

A successful WordPress migration is not simply a file transfer. It requires careful planning, validated backups, infrastructure checks, systematic testing, and post-migration monitoring. Following a repeatable checklist reduces risk, minimizes downtime, and helps ensure a smooth experience for both administrators and end users.
