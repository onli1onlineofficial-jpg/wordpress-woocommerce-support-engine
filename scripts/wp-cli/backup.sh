#!/bin/bash

###############################################################################
# WordPress Backup Script
#
# Description:
# Creates a timestamped backup of the WordPress database and wp-content
# directory using WP-CLI and standard Linux utilities.
#
# Requirements:
# - WP-CLI
# - zip
# - Bash
#
# Usage:
# chmod +x backup.sh
# ./backup.sh
###############################################################################

set -e

# ----------------------------
# Configuration
# ----------------------------

BACKUP_DIR="$HOME/wp-backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

DB_FILE="database-$TIMESTAMP.sql"
FILES_FILE="wp-content-$TIMESTAMP.zip"

# ----------------------------
# Create Backup Directory
# ----------------------------

mkdir -p "$BACKUP_DIR"

echo "=========================================="
echo " WordPress Backup Utility"
echo "=========================================="
echo ""

# ----------------------------
# Verify WP Installation
# ----------------------------

if ! wp core is-installed >/dev/null 2>&1; then
    echo "ERROR: No WordPress installation detected."
    exit 1
fi

echo "WordPress installation detected."
echo ""

# ----------------------------
# Database Backup
# ----------------------------

echo "Creating database backup..."

wp db export "$BACKUP_DIR/$DB_FILE"

echo "Database backup completed."

echo ""

# ----------------------------
# Files Backup
# ----------------------------

echo "Compressing wp-content directory..."

zip -rq "$BACKUP_DIR/$FILES_FILE" wp-content

echo "Files archived."

echo ""

# ----------------------------
# Backup Summary
# ----------------------------

echo "Backup Complete"
echo "-------------------------------"

echo "Database:"
echo "$BACKUP_DIR/$DB_FILE"

echo ""

echo "Files:"
echo "$BACKUP_DIR/$FILES_FILE"

echo ""

echo "Backup Time:"
echo "$TIMESTAMP"

echo ""

echo "Finished Successfully."

echo "=========================================="
