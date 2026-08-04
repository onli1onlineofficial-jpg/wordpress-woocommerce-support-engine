#!/bin/bash

###############################################################################
# WordPress Cache Clear Utility
#
# Description:
# Clears WordPress cache and attempts to clear cache for common
# caching plugins if they are installed.
#
# Requirements:
# - WP-CLI
# - Bash
#
# Usage:
# chmod +x cache-clear.sh
# ./cache-clear.sh
###############################################################################

set -e

echo "============================================="
echo " WordPress Cache Clear Utility"
echo "============================================="
echo ""

# -------------------------------------------------------
# Verify WordPress Installation
# -------------------------------------------------------

if ! wp core is-installed >/dev/null 2>&1; then
    echo "ERROR: WordPress installation not found."
    exit 1
fi

echo "WordPress installation detected."
echo ""

# -------------------------------------------------------
# Flush WordPress Object Cache
# -------------------------------------------------------

echo "Flushing WordPress object cache..."

wp cache flush

echo "Done."
echo ""

# -------------------------------------------------------
# Detect Installed Cache Plugins
# -------------------------------------------------------

echo "Checking installed cache plugins..."
echo ""

# LiteSpeed Cache
if wp plugin is-installed litespeed-cache; then
    echo "LiteSpeed Cache detected."

    if wp plugin is-active litespeed-cache; then
        wp litespeed-purge all || true
        echo "LiteSpeed cache cleared."
    else
        echo "LiteSpeed Cache is installed but inactive."
    fi

    echo ""
fi

# WP Super Cache
if wp plugin is-installed wp-super-cache; then
    echo "WP Super Cache detected."

    if wp plugin is-active wp-super-cache; then
        wp super-cache flush || true
        echo "WP Super Cache cleared."
    else
        echo "WP Super Cache is installed but inactive."
    fi

    echo ""
fi

# W3 Total Cache
if wp plugin is-installed w3-total-cache; then
    echo "W3 Total Cache detected."

    if wp plugin is-active w3-total-cache; then
        wp w3-total-cache flush all || true
        echo "W3 Total Cache cleared."
    else
        echo "W3 Total Cache is installed but inactive."
    fi

    echo ""
fi

# WP Rocket
if wp plugin is-installed wp-rocket; then
    echo "WP Rocket detected."

    if wp plugin is-active wp-rocket; then
        wp rocket clean || true
        echo "WP Rocket cache cleared."
    else
        echo "WP Rocket is installed but inactive."
    fi

    echo ""
fi

# -------------------------------------------------------
# Flush Rewrite Rules
# -------------------------------------------------------

echo "Refreshing rewrite rules..."

wp rewrite flush

echo "Done."
echo ""

# -------------------------------------------------------
# Completion
# -------------------------------------------------------

echo "============================================="
echo "Cache clearing completed successfully."
echo "============================================="
echo ""
echo "Tasks Performed:"
echo ""
echo "✓ WordPress object cache flushed"
echo "✓ Rewrite rules refreshed"
echo "✓ Supported cache plugins checked"
echo "✓ Plugin-specific cache cleared (where applicable)"
echo ""
echo "It is recommended to:"
echo ""
echo "- Perform a hard browser refresh"
echo "- Purge CDN cache if one is in use"
echo "- Verify changes in an incognito/private browser session"
echo ""
echo "Finished."
