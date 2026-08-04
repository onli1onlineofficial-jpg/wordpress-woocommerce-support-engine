# Knowledge Base: WordPress Cache Problems

## Article ID

KB-007

---

# Overview

Caching improves website performance by storing previously generated content and serving it quickly to visitors. However, incorrect or outdated cache data can lead to broken layouts, missing updates, login issues, checkout problems, and inconsistent user experiences.

This guide explains how to identify, troubleshoot, and resolve common WordPress caching issues.

---

# Common Symptoms

Customers may report:

- Website changes are not visible
- Old content still appears
- CSS changes do not load
- JavaScript not updating
- Checkout not working
- Login redirects
- Admin bar missing
- Random website behavior
- Different users see different pages

---

# Cache Architecture

```
Visitor
   │
   ▼
Browser Cache
   │
   ▼
CDN Cache
   │
   ▼
Web Server Cache
   │
   ▼
Object Cache
   │
   ▼
Database
```

---

# Types of Cache

## Browser Cache

Stored inside the visitor's browser.

Caches:

- Images
- CSS
- JavaScript
- Fonts

---

## Page Cache

Stores fully generated HTML pages.

Benefits

- Faster page loading
- Reduced server load

---

## Object Cache

Stores database query results in memory.

Common systems

- Redis
- Memcached

---

## CDN Cache

Caches static assets globally.

Examples

- Images
- CSS
- JavaScript

---

## Opcode Cache

Caches compiled PHP scripts.

Common implementation

- OPcache

---

# Troubleshooting Workflow

```
Customer Reports Issue
        │
        ▼
Identify Cache Layer
        │
        ▼
Clear Browser Cache
        │
        ▼
Clear Website Cache
        │
        ▼
Clear CDN Cache
        │
        ▼
Flush Object Cache
        │
        ▼
Verify Changes
```

---

# Step 1 – Browser Cache

Symptoms

- Old styles
- Missing updates
- Incorrect layout

Resolution

- Hard refresh
- Clear browser cache
- Test in private/incognito mode

---

# Step 2 – WordPress Cache

Review installed cache plugins.

Useful command

```bash
wp plugin list
```

Common cache plugins

- LiteSpeed Cache
- WP Super Cache
- W3 Total Cache
- WP Rocket

Clear cache using the plugin interface or supported WP-CLI commands.

---

# Step 3 – Flush WordPress Cache

```bash
wp cache flush
```

Verify that updated content is visible after the cache has been cleared.

---

# Step 4 – CDN Cache

If a CDN is in use, purge cached assets.

Typical procedure

```
CDN Dashboard
      ↓
Cache
      ↓
Purge Cache
```

---

# Step 5 – Object Cache

Common object cache systems

- Redis
- Memcached

Verify:

- Connection status
- Cache hit rate
- Configuration
- Service availability

---

# Step 6 – OPCache

Restart PHP or clear OPcache if updated PHP files are not reflected.

Typical symptoms

- Updated PHP code ignored
- Old functionality remains

---

# Step 7 – Verify Dynamic Pages

Pages that should generally bypass aggressive caching include:

- Cart
- Checkout
- My Account
- Login
- Password Reset

Confirm that these pages are excluded from page caching.

---

# Common Cache Issues

## Website Changes Not Visible

Possible causes

- Browser cache
- CDN cache
- Page cache

Resolution

- Clear all cache layers
- Hard refresh browser
- Verify deployment completed

---

## Checkout Displays Old Data

Possible causes

- Checkout page cached
- Session cache
- CDN misconfiguration

Resolution

- Exclude checkout from caching
- Clear session cache
- Retest purchase flow

---

## CSS Not Updating

Possible causes

- Browser cache
- Minification cache
- CDN cache

Resolution

- Purge caches
- Regenerate CSS assets
- Version static files

---

## Login Redirect Loop

Possible causes

- Cached login page
- Cookie conflicts
- Session cache

Resolution

- Clear cookies
- Exclude login pages from cache
- Flush cache

---

## Logged-in Users See Cached Pages

Possible causes

- Incorrect cache configuration

Resolution

- Disable page caching for authenticated users
- Verify cache rules

---

# Validation Checklist

After clearing cache:

- Website loads correctly
- Recent changes visible
- Checkout functions normally
- Login works
- CSS loads correctly
- JavaScript loads correctly
- Images display correctly
- No stale content remains

---

# Example Investigation

## Customer Report

> "I updated my homepage, but visitors still see the previous version."

### Investigation

- Tested in incognito mode
- Reviewed cache plugin
- Checked CDN configuration
- Flushed WordPress cache
- Purged CDN cache

### Root Cause

Cached HTML was being served from the CDN after deployment.

### Resolution

- Purged CDN cache
- Cleared WordPress page cache
- Performed browser cache refresh
- Verified changes globally

### Result

Updated homepage displayed correctly for all users.

---

# Best Practices

- Do not cache dynamic WooCommerce pages.
- Clear cache after major updates.
- Test changes in a private browser session.
- Keep only one primary page caching solution active.
- Review cache exclusions regularly.
- Monitor cache performance after configuration changes.

---

# Useful WP-CLI Commands

Flush cache

```bash
wp cache flush
```

List plugins

```bash
wp plugin list
```

Check WordPress version

```bash
wp core version
```

---

# Related Articles

- slow-site.md
- plugin-conflicts.md
- checkout-errors.md
- wp-debug-log.md
- common-fixes.md

---

# References

- WordPress Developer Documentation
- WP-CLI Documentation
- LiteSpeed Cache Documentation
- Redis Documentation
- Memcached Documentation
