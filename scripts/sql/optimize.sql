/*
===============================================================================
WordPress Database Optimization Script
-------------------------------------------------------------------------------
Description:
Optimizes common WordPress database tables to improve performance.

Compatible:
- MySQL
- MariaDB

Important:
Always create a full database backup before executing.
===============================================================================
*/

-- ==========================================================
-- Optimize WordPress Core Tables
-- ==========================================================

OPTIMIZE TABLE wp_posts;

OPTIMIZE TABLE wp_postmeta;

OPTIMIZE TABLE wp_options;

OPTIMIZE TABLE wp_comments;

OPTIMIZE TABLE wp_commentmeta;

OPTIMIZE TABLE wp_users;

OPTIMIZE TABLE wp_usermeta;

OPTIMIZE TABLE wp_terms;

OPTIMIZE TABLE wp_term_taxonomy;

OPTIMIZE TABLE wp_term_relationships;

OPTIMIZE TABLE wp_links;

-- ==========================================================
-- WooCommerce Tables
-- ==========================================================

OPTIMIZE TABLE wp_wc_orders;

OPTIMIZE TABLE wp_wc_order_addresses;

OPTIMIZE TABLE wp_wc_order_operational_data;

OPTIMIZE TABLE wp_wc_order_product_lookup;

OPTIMIZE TABLE wp_wc_order_stats;

OPTIMIZE TABLE wp_wc_customer_lookup;

OPTIMIZE TABLE wp_wc_download_log;

OPTIMIZE TABLE wp_wc_product_meta_lookup;

OPTIMIZE TABLE wp_wc_tax_rate_classes;

-- ==========================================================
-- Action Scheduler
-- ==========================================================

OPTIMIZE TABLE wp_actionscheduler_actions;

OPTIMIZE TABLE wp_actionscheduler_claims;

OPTIMIZE TABLE wp_actionscheduler_groups;

OPTIMIZE TABLE wp_actionscheduler_logs;

-- ==========================================================
-- Verify Database Status
-- ==========================================================

CHECK TABLE wp_posts;

CHECK TABLE wp_postmeta;

CHECK TABLE wp_options;

CHECK TABLE wp_users;

CHECK TABLE wp_usermeta;

CHECK TABLE wp_wc_orders;

-- ==========================================================
-- Display Database Version
-- ==========================================================

SELECT VERSION() AS Database_Version;

-- ==========================================================
-- Display Current Database
-- ==========================================================

SELECT DATABASE() AS Current_Database;

-- ==========================================================
-- Display Table Sizes
-- ==========================================================

SELECT
    table_name,
    ROUND((data_length + index_length) / 1024 / 1024, 2) AS Size_MB
FROM information_schema.TABLES
WHERE table_schema = DATABASE()
ORDER BY Size_MB DESC;

-- ==========================================================
-- Count Records
-- ==========================================================

SELECT COUNT(*) AS Total_Posts
FROM wp_posts;

SELECT COUNT(*) AS Total_Users
FROM wp_users;

SELECT COUNT(*) AS Total_Orders
FROM wp_wc_orders;

-- ==========================================================
-- Script Complete
-- ==========================================================

SELECT 'Database optimization completed successfully.' AS Status;
