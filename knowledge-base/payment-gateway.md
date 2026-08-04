# Knowledge Base: WooCommerce Payment Gateway Troubleshooting

## Article ID

KB-003

---

# Overview

Payment gateways enable customers to securely complete online transactions. WooCommerce supports multiple payment providers, each requiring proper configuration, authentication, and communication with external APIs.

This guide documents a structured approach to identifying and resolving payment gateway issues in WooCommerce.

---

# Payment Flow

```
Customer
    │
    ▼
Checkout Page
    │
    ▼
WooCommerce
    │
    ▼
Payment Gateway Plugin
    │
    ▼
Gateway API
    │
    ▼
Bank / Card Network
    │
    ▼
Transaction Result
    │
    ▼
WooCommerce Order
```

---

# Common Symptoms

Customers may report:

- Payment failed
- Order not created
- Payment pending indefinitely
- Card declined
- Gateway timeout
- Invalid API credentials
- Duplicate payment attempts
- Payment successful but order remains unpaid
- Webhook not updating order status

---

# Initial Information Collection

Before troubleshooting, collect:

- WooCommerce version
- WordPress version
- PHP version
- Payment gateway name
- Error message
- Order number
- Browser used
- Device used
- Time of transaction
- Test or Live mode

---

# Diagnostic Workflow

```
Customer Reports Payment Issue
        │
        ▼
Reproduce Problem
        │
        ▼
Review Gateway Logs
        │
        ▼
Verify API Credentials
        │
        ▼
Check Webhooks
        │
        ▼
Validate SSL
        │
        ▼
Test Transaction
        │
        ▼
Confirm Resolution
```

---

# Step 1 – Review WooCommerce Logs

Navigate to:

```
WooCommerce
    ↓
Status
    ↓
Logs
```

Review:

- API requests
- API responses
- Authentication failures
- Timeout errors
- Webhook activity

---

# Step 2 – Verify API Credentials

Confirm:

- API Key
- Secret Key
- Client ID
- Webhook Secret
- Merchant Account
- Live/Test Mode

Common problems:

- Incorrect credentials
- Expired API keys
- Wrong environment selected
- Disabled API access

---

# Step 3 – Verify SSL

Payment gateways require HTTPS.

Confirm:

- Valid SSL certificate
- HTTPS redirect working
- No mixed content
- Certificate not expired

---

# Step 4 – Review Webhooks

Check:

- Webhook URL
- Response status
- Retry attempts
- Delivery logs

Expected response:

```
HTTP 200 OK
```

Common issues:

- 404 Not Found
- 401 Unauthorized
- 500 Internal Server Error
- Timeout

---

# Step 5 – Test Checkout

Perform a complete test transaction.

Verify:

- Cart
- Shipping
- Taxes
- Payment
- Order creation
- Confirmation email
- Order status

---

# Step 6 – Plugin Conflict

Deactivate all plugins except WooCommerce and the payment gateway.

```bash
wp plugin deactivate --all
```

Activate WooCommerce.

```bash
wp plugin activate woocommerce
```

Activate the gateway plugin.

```bash
wp plugin activate gateway-plugin
```

If the issue disappears, reactivate plugins individually until the conflict is identified.

---

# Step 7 – Theme Testing

Temporarily activate:

```
Twenty Twenty-Five
```

If payment succeeds, investigate:

- Checkout template overrides
- JavaScript conflicts
- Custom checkout code

---

# Step 8 – Debug Logging

Enable debugging.

```php
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
```

Review:

```
wp-content/debug.log
```

Look for:

- PHP Fatal Errors
- API Exceptions
- Plugin Errors
- Database Errors

---

# Common Payment Errors

## Invalid API Credentials

Symptoms

- Authentication failed
- Unauthorized request

Resolution

- Verify API credentials
- Regenerate keys
- Test again

---

## Payment Timeout

Symptoms

- Loading spinner
- Transaction expires

Possible causes

- Slow server
- Gateway unavailable
- Firewall restrictions

Resolution

- Review server logs
- Test gateway status
- Increase PHP execution limits if appropriate

---

## Webhook Failure

Symptoms

- Payment completed
- Order remains Pending

Resolution

- Verify webhook URL
- Review webhook logs
- Test webhook delivery
- Confirm HTTP 200 response

---

## Duplicate Orders

Possible causes

- Customer refreshed checkout
- Slow gateway response
- JavaScript issue

Resolution

- Review logs
- Verify transaction IDs
- Prevent duplicate submissions

---

## Payment Declined

Possible causes

- Bank rejection
- Incorrect card information
- Fraud prevention rules

Resolution

- Verify gateway response
- Ask customer to contact their bank if necessary
- Retry using another payment method

---

# Validation Checklist

Before closing the issue:

- Test payment completed
- Order created successfully
- Order status updated
- Confirmation email received
- Gateway logs reviewed
- Customer confirmed success

---

# Example Case

## Customer Report

> Payments fail immediately after clicking "Place Order."

### Investigation

- Reviewed WooCommerce logs
- Verified API credentials
- Tested SSL certificate
- Completed test transaction
- Reviewed `debug.log`

### Root Cause

Incorrect Live API Secret Key configured after a recent credential update.

### Resolution

- Updated API credentials
- Cleared cache
- Executed multiple successful test transactions

### Result

Payments processed successfully and order creation returned to normal.

---

# Best Practices

- Use HTTPS for all payment pages.
- Keep payment plugins updated.
- Test gateway configuration after updates.
- Monitor webhook delivery logs.
- Enable logging during troubleshooting.
- Avoid unnecessary customizations to checkout.
- Test in staging before deploying significant changes.

---

# Related Articles

- checkout-errors.md
- plugin-conflicts.md
- wp-debug-log.md
- ssl-errors.md
- common-fixes.md

---

# References

- WooCommerce Documentation
- WordPress Developer Resources
- Payment Gateway Provider Documentation
