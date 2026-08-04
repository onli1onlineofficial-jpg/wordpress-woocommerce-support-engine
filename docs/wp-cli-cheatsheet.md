# WP-CLI Cheat Sheet

## Overview

WP-CLI (WordPress Command Line Interface) is the official command-line tool for managing WordPress installations. It enables administrators and support engineers to perform maintenance, troubleshooting, updates, and automation without using the WordPress dashboard.

Official Documentation:
https://developer.wordpress.org/cli/commands/

---

# Verify Installation

Check the installed WP-CLI version.

```bash
wp --info
```

Example Output

```text
OS: Linux
PHP Version: 8.2
WP-CLI Version: 2.11
```

---

# WordPress Core

Check WordPress version

```bash
wp core version
```

Download WordPress

```bash
wp core download
```

Install WordPress

```bash
wp core install \
--url="example.com" \
--title="Example Site" \
--admin_user=admin \
--admin_password=password \
--admin_email=admin@example.com
```

Update WordPress

```bash
wp core update
```

Verify checksums

```bash
wp core verify-checksums
```

---

# Plugin Management

List installed plugins

```bash
wp plugin list
```

Install plugin

```bash
wp plugin install woocommerce
```

Activate plugin

```bash
wp plugin activate woocommerce
```

Deactivate plugin

```bash
wp plugin deactivate woocommerce
```

Delete plugin

```bash
wp plugin delete hello
```

Update all plugins

```bash
wp plugin update --all
```

---

# Theme Management

List themes

```bash
wp theme list
```

Install theme

```bash
wp theme install astra
```

Activate theme

```bash
wp theme activate astra
```

Update themes

```bash
wp theme update --all
```

Delete theme

```bash
wp theme delete twentytwentytwo
```

---

# User Management

List users

```bash
wp user list
```

Create user

```bash
wp user create john john@example.com
```

Reset password

```bash
wp user update admin --user_pass=newpassword
```

Delete user

```bash
wp user delete username
```

---

# Database Commands

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

Repair database

```bash
wp db repair
```

Reset database

```bash
wp db reset
```

---

# Cache Management

Flush cache

```bash
wp cache flush
```

Flush rewrite rules

```bash
wp rewrite flush
```

---

# Media

Regenerate thumbnails

```bash
wp media regenerate
```

Import media

```bash
wp media import image.jpg
```

---

# Search & Replace

Replace HTTP with HTTPS

```bash
wp search-replace \
"http://example.com" \
"https://example.com"
```

Dry run

```bash
wp search-replace \
"http://example.com" \
"https://example.com" \
--dry-run
```

---

# Options

View site URL

```bash
wp option get siteurl
```

View home URL

```bash
wp option get home
```

Update site URL

```bash
wp option update siteurl https://example.com
```

---

# Maintenance Mode

Enable

```bash
wp maintenance-mode activate
```

Disable

```bash
wp maintenance-mode deactivate
```

Status

```bash
wp maintenance-mode status
```

---

# Cron Jobs

List scheduled events

```bash
wp cron event list
```

Run cron manually

```bash
wp cron event run --due-now
```

---

# WooCommerce

List products

```bash
wp post list --post_type=product
```

List orders (High-Performance Order Storage disabled)

```bash
wp post list --post_type=shop_order
```

---

# Debugging

Enable debug mode

```php
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', false);
```

Log location

```text
wp-content/debug.log
```

---

# Useful Linux Commands

Current directory

```bash
pwd
```

List files

```bash
ls -la
```

Disk usage

```bash
df -h
```

Memory

```bash
free -m
```

Processes

```bash
top
```

---

# Typical Troubleshooting Workflow

```text
Customer reports issue
        │
        ▼
Check WordPress version

        │
        ▼
List active plugins

        │
        ▼
Review debug.log

        │
        ▼
Check Site URL

        │
        ▼
Flush Cache

        │
        ▼
Repair Database

        │
        ▼
Validate Fix

        │
        ▼
Close Ticket
```

---

# Best Practices

- Create a database backup before performing major operations.
- Test updates in a staging environment whenever possible.
- Verify plugin compatibility before updating.
- Use `--dry-run` for search-and-replace operations when available.
- Review `debug.log` before making assumptions about the root cause.
- Keep WP-CLI updated to the latest stable version.
- Document all production changes.

---

# References

- WP-CLI Official Documentation
- WordPress Developer Documentation
- WooCommerce Developer Documentation
