/*
===============================================================================
WordPress Database Cleanup Script
-------------------------------------------------------------------------------
Description:
Removes common unnecessary data from a WordPress database to improve
performance and reduce database size.

Compatible:
- MySQL
- MariaDB

IMPORTANT:
1. Create a complete database backup before executing.
2. Review each query before running in a production environment.
===============================================================================
*/

-- ============================================================================
-- Delete Expired Transients
-- ============================================================================

DELETE
FROM wp_options
WHERE option_name LIKE '_transient_%'
AND option_name NOT LIKE '_transient_timeout_%';

DELETE
FROM wp_options
WHERE option_name LIKE '_site_transient_%'
AND option_name NOT LIKE '_site_transient_timeout_%';

-- ============================================================================
-- Delete Expired Transient Timeouts
-- ============================================================================

DELETE
FROM wp_options
WHERE option_name LIKE '_transient_timeout_%'
AND option_value < UNIX_TIMESTAMP();

DELETE
FROM wp_options
WHERE option_name LIKE '_site_transient_timeout_%'
AND option_value < UNIX_TIMESTAMP();

-- ============================================================================
-- Delete Post Revisions
-- ============================================================================

DELETE
FROM wp_posts
WHERE post_type = 'revision';

-- ============================================================================
-- Delete Auto Drafts
-- ============================================================================

DELETE
FROM wp_posts
WHERE post_status = 'auto-draft';

-- ============================================================================
-- Delete Spam Comments
-- ============================================================================

DELETE
FROM wp_comments
WHERE comment_approved = 'spam';

-- ============================================================================
-- Delete Trashed Comments
-- ============================================================================

DELETE
FROM wp_comments
WHERE comment_approved = 'trash';

-- ============================================================================
-- Delete Trashed Posts
-- ============================================================================

DELETE
FROM wp_posts
WHERE post_status = 'trash';

-- ============================================================================
-- Remove Orphaned Post Meta
-- ============================================================================

DELETE pm
FROM wp_postmeta pm
LEFT JOIN wp_posts p
ON pm.post_id = p.ID
WHERE p.ID IS NULL;

-- ============================================================================
-- Remove Orphaned Comment Meta
-- ============================================================================

DELETE cm
FROM wp_commentmeta cm
LEFT JOIN wp_comments c
ON cm.comment_id = c.comment_ID
WHERE c.comment_ID IS NULL;

-- ============================================================================
-- Remove Orphaned User Meta
-- ============================================================================

DELETE um
FROM wp_usermeta um
LEFT JOIN wp_users u
ON um.user_id = u.ID
WHERE u.ID IS NULL;

-- ============================================================================
-- Remove Orphaned Term Relationships
-- ============================================================================

DELETE tr
FROM wp_term_relationships tr
LEFT JOIN wp_posts p
ON tr.object_id = p.ID
WHERE p.ID IS NULL;

-- ============================================================================
-- WooCommerce Action Scheduler Cleanup
-- ============================================================================

DELETE
FROM wp_actionscheduler_logs
WHERE log_date_gmt < DATE_SUB(UTC_TIMESTAMP(), INTERVAL 90 DAY);

-- ============================================================================
-- Remove Expired WooCommerce Sessions
-- ============================================================================

DELETE
FROM wp_options
WHERE option_name LIKE '_wc_session_%';

-- ============================================================================
-- Optimize Frequently Used Tables
-- ============================================================================

OPTIMIZE TABLE wp_posts;

OPTIMIZE TABLE wp_postmeta;

OPTIMIZE TABLE wp_options;

OPTIMIZE TABLE wp_comments;

OPTIMIZE TABLE wp_commentmeta;

OPTIMIZE TABLE wp_users;

OPTIMIZE TABLE wp_usermeta;

OPTIMIZE TABLE wp_wc_orders;

OPTIMIZE TABLE wp_wc_customer_lookup;

-- ============================================================================
-- Database Statistics
-- ============================================================================

SELECT
    table_name,
    table_rows,
    ROUND((data_length + index_length) / 1024 / 1024, 2) AS Size_MB
FROM information_schema.TABLES
WHERE table_schema = DATABASE()
ORDER BY Size_MB DESC;

-- ============================================================================
-- Summary
-- ============================================================================

SELECT 'WordPress database cleanup completed successfully.' AS Status;
