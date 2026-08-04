#!/bin/bash

###############################################################################
# WordPress Plugin Update Utility
#
# Description:
# Safely updates all WordPress plugins using WP-CLI.
# A database backup is created before updates begin.
#
# Requirements:
# - WP-CLI
# - Bash
#
# Usage:
# chmod +x plugin-update.sh
# ./plugin-update.sh
###############################################################################

set -e

# -------------------------------------------------------
# Configuration
# -------------------------------------------------------

BACKUP_DIR="$HOME/wp-backups"
LOG_DIR="$HOME/wp-logs"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

DB_BACKUP="$BACKUP_DIR/pre-plugin-update-$TIMESTAMP.sql"
LOG_FILE="$LOG_DIR/plugin-update-$TIMESTAMP.log"

mkdir -p "$BACKUP_DIR"
mkdir -p "$LOG_DIR"

# -------------------------------------------------------
# Banner
# -------------------------------------------------------

echo "==========================================="
echo " WordPress Plugin Update Utility"
echo "==========================================="

# -------------------------------------------------------
# Verify WordPress
# -------------------------------------------------------

if ! wp core is-installed >/dev/null 2>&1; then
    echo "ERROR: WordPress installation not found."
    exit 1
fi

echo "WordPress installation detected."
echo ""

# -------------------------------------------------------
# Database Backup
# -------------------------------------------------------

echo "Creating database backup..."

wp db export "$DB_BACKUP"

echo "Backup saved:"
echo "$DB_BACKUP"
echo ""

# -------------------------------------------------------
# Plugin Status
# -------------------------------------------------------

echo "Installed Plugins"
echo "-----------------"

wp plugin list

echo ""

# -------------------------------------------------------
# Available Updates
# -------------------------------------------------------

echo "Checking for available updates..."

UPDATES=$(wp plugin list --update=available --field=name)

if [ -z "$UPDATES" ]; then
    echo "All plugins are already up to date."
    exit 0
fi

echo ""
echo "Plugins requiring updates:"
echo "$UPDATES"

echo ""

# -------------------------------------------------------
# Update Plugins
# -------------------------------------------------------

echo "Updating plugins..."

wp plugin update --all | tee "$LOG_FILE"

echo ""

# -------------------------------------------------------
# Verify Updates
# -------------------------------------------------------

echo "Verifying plugin status..."

wp plugin list

echo ""

# -------------------------------------------------------
# Flush Cache
# -------------------------------------------------------

echo "Flushing WordPress cache..."

wp cache flush

echo ""

# -------------------------------------------------------
# Completion
# -------------------------------------------------------

echo "==========================================="
echo "Plugin update completed successfully."
echo ""
echo "Database Backup:"
echo "$DB_BACKUP"
echo ""
echo "Log File:"
echo "$LOG_FILE"
echo "==========================================="
