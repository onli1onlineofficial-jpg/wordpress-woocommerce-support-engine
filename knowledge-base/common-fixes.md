# Knowledge Base: Common WordPress Fixes

## Article ID

KB-010

---

# Overview

This document contains the most frequently used troubleshooting techniques for resolving common WordPress and WooCommerce issues.

It is intended as a quick-reference guide before performing more detailed diagnostics.

---

# Quick Troubleshooting Flow

```
Customer Reports Issue
        │
        ▼
Identify Category
        │
        ▼
Review Logs
        │
        ▼
Test in Staging
        │
        ▼
Apply Fix
        │
        ▼
Validate
        │
        ▼
Document Resolution
```

---

# 1. White Screen of Death

## Symptoms

- Blank page
- Admin inaccessible
- HTTP 500

## Possible Causes

- Plugin conflict
- Theme conflict
- PHP fatal error
- Memory exhaustion

## Resolution

Enable debugging.

```php
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', false);
```

Review:

```
wp-content/debug.log
```

Deactivate plugins.

```bash
wp plugin deactivate --all
```

---

# 2. Internal Server Error (500)

## Possible Causes

- Corrupted `.htaccess`
- Plugin failure
- PHP configuration
- File permissions

## Resolution

- Rename `.htaccess`
- Flush rewrite rules
- Disable plugins
- Review server logs

---

# 3. Login Problems

## Symptoms

- Redirect loop
- Invalid login
- Session expired

## Resolution

- Clear browser cookies
- Disable cache
- Verify Site URL
- Reset password

Useful command

```bash
wp user update admin --user_pass=NewPassword123
```

---

# 4. Website Running Slowly

## Possible Causes

- Heavy plugins
- Database overhead
- Poor hosting
- Large media files

## Resolution

```bash
wp db optimize
```

```bash
wp cache flush
```

Review:

- Database
- Images
- Cache
- Plugins

---

# 5. Plugin Conflict

Resolution

```bash
wp plugin list
```

Deactivate all plugins.

```bash
wp plugin deactivate --all
```

Reactivate individually until the issue returns.

---

# 6. Theme Conflict

Activate a default theme.

```bash
wp theme activate twentytwentyfive
```

Retest the issue.

---

# 7. Checkout Failure

Verify:

- Payment Gateway
- Shipping
- SSL
- WooCommerce Logs
- Plugin Conflicts

Test checkout after each change.

---

# 8. Payment Gateway Failure

Check:

- API Credentials
- Webhooks
- SSL
- Gateway Logs

Review:

```
WooCommerce

↓

Status

↓

Logs
```

---

# 9. SSL Errors

Verify

- Certificate valid
- HTTPS enabled
- No mixed content
- Redirects working

Useful command

```bash
wp search-replace \
"http://example.com" \
"https://example.com"
```

---

# 10. DNS Problems

Review

- A Record
- CNAME
- MX
- TXT

Verify

```bash
nslookup example.com
```

or

```bash
dig example.com
```

---

# 11. Cache Problems

Clear

- Browser Cache
- WordPress Cache
- CDN Cache
- Object Cache

Useful command

```bash
wp cache flush
```

---

# 12. Email Delivery Issues

Verify

- SMTP
- SPF
- DKIM
- DMARC
- MX Records

Send a test email after every configuration change.

---

# 13. Database Problems

Repair

```bash
wp db repair
```

Optimize

```bash
wp db optimize
```

Export

```bash
wp db export
```

---

# 14. Broken Images

Verify

- Uploads directory
- File permissions
- URLs
- CDN

Regenerate thumbnails

```bash
wp media regenerate
```

---

# 15. WordPress Updates Fail

Check

- File permissions
- Disk space
- PHP version
- Plugin compatibility

Verify

```bash
wp core version
```

Update

```bash
wp core update
```

---

# 16. REST API Errors

Verify

- Permalinks
- Security plugins
- Server configuration
- Authentication

Flush rewrite rules

```bash
wp rewrite flush
```

---

# 17. Scheduled Tasks Not Running

Review

```bash
wp cron event list
```

Execute pending events

```bash
wp cron event run --due-now
```

---

# 18. Maintenance Mode Stuck

Disable maintenance mode

```bash
wp maintenance-mode deactivate
```

If necessary, remove:

```
.maintenance
```

from the WordPress root directory.

---

# 19. Useful WP-CLI Commands

WordPress Version

```bash
wp core version
```

Plugins

```bash
wp plugin list
```

Themes

```bash
wp theme list
```

Database Repair

```bash
wp db repair
```

Database Optimize

```bash
wp db optimize
```

Flush Cache

```bash
wp cache flush
```

Cron

```bash
wp cron event list
```

Maintenance Mode

```bash
wp maintenance-mode status
```

---

# Emergency Troubleshooting Checklist

Before making changes:

- Confirm the issue
- Create backup
- Enable debugging
- Review logs
- Test in staging
- Verify customer report

After implementing the fix:

- Confirm issue resolved
- Review logs
- Test related functionality
- Update documentation
- Inform customer

---

# Best Practices

- Always create verified backups.
- Troubleshoot systematically.
- Test changes in staging whenever possible.
- Avoid multiple simultaneous changes.
- Keep WordPress, themes, and plugins updated.
- Document recurring issues.
- Verify fixes before closing support requests.

---

# Related Articles

- plugin-conflicts.md
- checkout-errors.md
- payment-gateway.md
- wp-debug-log.md
- slow-site.md
- email-issues.md
- cache-problems.md
- ssl-errors.md
- dns-propagation.md

---

# References

- WordPress Developer Documentation
- WooCommerce Documentation
- WP-CLI Documentation
- PHP Documentation
