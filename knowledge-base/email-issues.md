# Knowledge Base: WordPress Email Delivery Issues

## Article ID

KB-006

---

# Overview

WordPress relies on PHP mail or SMTP services to send emails such as password resets, contact form notifications, order confirmations, and user registration messages.

Email delivery failures can impact customer communication, WooCommerce order processing, and account management. This guide provides a structured approach for diagnosing and resolving email-related issues.

---

# Common Symptoms

Customers may report:

- Password reset emails not received
- Contact form submissions not delivered
- WooCommerce order confirmation missing
- New user emails not received
- Emails marked as spam
- Delayed email delivery
- SMTP authentication failures

---

# Email Flow

```
WordPress
      │
      ▼
SMTP Plugin / PHP Mail
      │
      ▼
SMTP Server
      │
      ▼
Email Provider
      │
      ▼
Recipient Inbox
```

---

# Initial Investigation

Collect the following information:

- Website URL
- WordPress version
- WooCommerce version
- SMTP plugin (if used)
- Hosting provider
- Email provider
- Sender email address
- Recipient email address
- Time the email was sent
- Error message (if available)

---

# Step 1 – Confirm the Problem

Identify which emails are affected.

Examples:

- Password reset
- Contact form
- Order confirmation
- New account
- Admin notifications

Determine whether:

- All emails fail
- Only one type of email fails
- Emails are delayed
- Emails reach spam folders

---

# Step 2 – Verify SMTP Configuration

Review:

- SMTP Host
- SMTP Port
- Encryption (SSL/TLS)
- Username
- Password
- Authentication Enabled

Typical Ports

| Port | Encryption |
|-------|------------|
| 25 | None |
| 465 | SSL |
| 587 | TLS |

---

# Step 3 – Send a Test Email

Most SMTP plugins include a test email feature.

Verify:

- Email sent successfully
- Email received
- Delivery time
- Spam folder

---

# Step 4 – Verify DNS Records

Check:

- MX Record
- SPF Record
- DKIM Record
- DMARC Record

Common problems:

- Missing SPF
- Invalid DKIM
- Incorrect MX
- DMARC policy errors

Useful tools:

- MXToolbox
- Google Admin Toolbox
- DNSChecker

---

# Step 5 – Review Server Logs

Inspect:

- Mail logs
- SMTP logs
- PHP error logs
- WordPress `debug.log`

Look for:

- Authentication failures
- Connection timeouts
- Permission errors
- Mail transport issues

---

# Step 6 – Verify WooCommerce Email Settings

Navigate to:

```
WooCommerce
    ↓
Settings
    ↓
Emails
```

Verify:

- Email notifications enabled
- Sender name
- Sender email
- Recipient email
- Email templates

---

# Step 7 – Plugin Conflict

Deactivate all plugins except WooCommerce and the SMTP plugin.

```bash
wp plugin deactivate --all
```

Activate WooCommerce.

```bash
wp plugin activate woocommerce
```

Activate the SMTP plugin.

```bash
wp plugin activate smtp-plugin
```

If email works, reactivate other plugins individually until the issue is identified.

---

# Step 8 – Theme Testing

Temporarily activate:

```
Twenty Twenty-Five
```

If emails begin working normally, investigate custom theme functions or overridden templates.

---

# Common Email Problems

## Emails Not Sent

Possible causes:

- SMTP not configured
- PHP mail disabled
- Authentication failure

Resolution:

- Configure SMTP
- Verify credentials
- Send test email

---

## Emails in Spam

Possible causes:

- Missing SPF
- Missing DKIM
- Missing DMARC
- Poor sender reputation

Resolution:

- Configure email authentication
- Verify DNS records

---

## WooCommerce Order Emails Missing

Possible causes:

- Email notifications disabled
- Plugin conflict
- SMTP issue

Resolution:

- Review WooCommerce email settings
- Test order placement
- Check logs

---

## Contact Form Emails Missing

Possible causes:

- Form plugin conflict
- SMTP failure
- Invalid recipient address

Resolution:

- Test with another email address
- Review form configuration
- Verify SMTP connection

---

# Validation Checklist

After implementing the fix:

- Test email delivered
- Password reset email received
- Contact form working
- Order confirmation received
- New account email received
- Email not marked as spam

---

# Example Investigation

## Customer Report

> Customers are placing orders successfully, but order confirmation emails are not received.

### Investigation

- Sent SMTP test email
- Reviewed WooCommerce email settings
- Verified SMTP credentials
- Checked DNS records
- Reviewed mail logs

### Root Cause

SMTP authentication failed after the email account password was changed.

### Resolution

- Updated SMTP credentials
- Sent multiple test emails
- Completed test order
- Confirmed successful email delivery

### Result

Order confirmation emails resumed normal delivery.

---

# Best Practices

- Use SMTP instead of PHP mail whenever possible.
- Configure SPF, DKIM, and DMARC records.
- Test email delivery after configuration changes.
- Monitor mail logs regularly.
- Keep SMTP plugins updated.
- Use a business email domain instead of free email providers for transactional mail.

---

# Related Articles

- dns-propagation.md
- ssl-errors.md
- checkout-errors.md
- wp-debug-log.md
- common-fixes.md

---

# References

- WordPress Developer Documentation
- WooCommerce Documentation
- WP Mail SMTP Documentation
- RFC 5321 (SMTP)
- RFC 7208 (SPF)
