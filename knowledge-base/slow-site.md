# Knowledge Base: Slow WordPress Website Performance

## Article ID

KB-005

---

# Overview

Website performance directly affects user experience, SEO rankings, conversion rates, and customer satisfaction. A slow WordPress website can result from multiple factors, including inefficient plugins, database overhead, hosting limitations, unoptimized media, or excessive HTTP requests.

This guide provides a systematic approach for diagnosing and resolving WordPress performance issues.

---

# Common Symptoms

Customers may report:

- Website loads slowly
- Admin dashboard is unresponsive
- Product pages take several seconds to open
- Checkout is slow
- Images load slowly
- Timeouts occur
- Pages occasionally fail to load
- High server resource usage

---

# Performance Investigation Workflow

```
Customer Reports Slow Website
            │
            ▼
Collect Site Information
            │
            ▼
Measure Performance
            │
            ▼
Inspect Server Resources
            │
            ▼
Review Plugins & Theme
            │
            ▼
Analyze Database
            │
            ▼
Check Caching
            │
            ▼
Optimize & Validate
```

---

# Initial Information Collection

Gather:

- Website URL
- WordPress version
- WooCommerce version
- PHP version
- Hosting provider
- Number of active plugins
- Active theme
- Traffic volume
- Recent updates

---

# Performance Testing Tools

Recommended tools:

- Google PageSpeed Insights
- GTmetrix
- Lighthouse
- Chrome DevTools

Review:

- First Contentful Paint (FCP)
- Largest Contentful Paint (LCP)
- Time To First Byte (TTFB)
- Total Blocking Time (TBT)
- Cumulative Layout Shift (CLS)

---

# Common Causes

## Heavy Plugins

Symptoms

- Slow dashboard
- Slow page generation
- High CPU usage

Investigation

```bash
wp plugin list
```

Look for:

- Multiple cache plugins
- Unused plugins
- Poorly maintained plugins

Resolution

- Remove unused plugins
- Replace inefficient plugins
- Keep plugins updated

---

## Database Overhead

Common causes

- Expired transients
- Revision history
- Orphaned metadata
- Large options table

Useful commands

```bash
wp db optimize
```

```bash
wp db repair
```

---

## Poor Hosting Performance

Symptoms

- High TTFB
- Random slowdowns
- Resource exhaustion

Review

- CPU usage
- Memory usage
- Disk usage
- PHP workers

---

## Large Images

Symptoms

- Slow page rendering
- Large downloads

Recommendations

- Compress images
- Use modern formats (WebP where supported)
- Enable lazy loading
- Resize oversized media

---

## Excessive HTTP Requests

Review using Chrome DevTools.

Common causes

- Multiple CSS files
- Large JavaScript bundles
- External fonts
- Third-party scripts

---

# Cache Verification

Check:

- Page cache
- Browser cache
- Object cache
- CDN cache

Useful command

```bash
wp cache flush
```

---

# Theme Investigation

Temporarily activate:

```
Twenty Twenty-Five
```

If performance improves significantly, review:

- Custom templates
- JavaScript
- CSS
- Page builders

---

# WooCommerce Performance

Verify:

- Product count
- Order count
- Payment gateway response
- Shipping calculations
- Database queries

Common bottlenecks

- Dynamic checkout
- Product filtering
- Large product catalogs

---

# Debugging Slow Queries

Review:

- Database logs
- Slow query logs
- `debug.log`
- Server error logs

Possible causes

- Missing indexes
- Excessive database requests
- Plugin-generated queries

---

# WP-CLI Commands

Check WordPress version

```bash
wp core version
```

List plugins

```bash
wp plugin list
```

Optimize database

```bash
wp db optimize
```

Repair database

```bash
wp db repair
```

Flush cache

```bash
wp cache flush
```

---

# Example Investigation

## Customer Report

> "The website became slow after installing a new plugin."

### Investigation

- Measured page performance
- Reviewed active plugins
- Enabled debug logging
- Tested with a default theme
- Cleared caches

### Root Cause

A recently installed plugin generated excessive database queries on every page request.

### Resolution

- Removed the plugin
- Optimized the database
- Cleared all caches
- Retested website performance

### Result

- Improved page load time
- Reduced server response time
- Customer confirmed normal performance

---

# Performance Optimization Checklist

- Update WordPress
- Update plugins
- Update theme
- Optimize database
- Compress images
- Enable caching
- Remove unused plugins
- Minify CSS and JavaScript
- Enable GZIP/Brotli compression
- Use a CDN where appropriate

---

# Validation Checklist

After optimization:

- Home page loads correctly
- Product pages load normally
- Checkout functions correctly
- Admin dashboard is responsive
- No PHP errors
- No JavaScript errors
- Performance tests show improvement

---

# Best Practices

- Monitor performance regularly.
- Test plugin updates before production deployment.
- Optimize the database periodically.
- Keep media libraries organized.
- Minimize unnecessary third-party scripts.
- Document recurring performance issues.

---

# Related Articles

- plugin-conflicts.md
- wp-debug-log.md
- cache-problems.md
- checkout-errors.md
- common-fixes.md

---

# References

- WordPress Developer Documentation
- WooCommerce Documentation
- Google PageSpeed Insights
- GTmetrix Documentation
- WP-CLI Documentation
