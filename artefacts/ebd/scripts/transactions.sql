BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

INSERT INTO content_item (body, author_id)
        VALUES ($body, $author_id);

INSERT INTO article (id, title, topic_id, imdb_info_id)
        VALUES (currval('content_item_id_seq'), $title, $topic_id, $imdb_info_id);

DO
$$
DECLARE
    tag INT;
    tags_array INT[] := ARRAY $tags;
BEGIN
    FOREACH tag IN ARRAY tags_array
    LOOP
        INSERT INTO tag_article(article_id, tag_id)
        VALUES (currval('content_item_id_seq'), tag);
    END LOOP;
END
$$
LANGUAGE plpgsql;

COMMIT;

-----------------------------------

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

INSERT INTO content_item (body, author_id)
        VALUES ($body, $author_id);

INSERT INTO comment (id, is_reply, article_id, reply_id)
        VALUES (currval('content_item_id_seq'), $is_reply, $article_id, $reply_id);

COMMIT;

---------------------------------------

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

INSERT INTO notification (notified_id)
        VALUES ($notified_id);

INSERT INTO content_notification (id, content_item_id)
        VALUES (currval('notification_id_seq'), $content_item_id);

INSERT INTO upvote_notification (id, amount)
        VALUES (currval('notification_id_seq'), $amount);

COMMIT;

---------------------------------------

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

INSERT INTO report (body, submitter_id)
        VALUES ($body, $submitter_id);

INSERT INTO content_report (id, motive, content_item_id)
        VALUES (currval('report_id_seq'), $motive, $content_item_id);

COMMIT;

---------------------------------------

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

INSERT INTO report (body, submitter_id)
        VALUES ($body, $submitter_id);

INSERT INTO member_report (id, misconduct, member_id)
        VALUES (currval('report_id_seq'), $misconduct, $member_id);

COMMIT;

---------------------------------------

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ READ ONLY;

SELECT COUNT(*) FROM comment WHERE article_id = $article_id;

SELECT comment.*, member.first_name, member.last_name, profile_image.file_name, content_item.* FROM comment
    INNER JOIN content_item ON comment.id = content_item.id
    INNER JOIN member ON content_item.author_id = member.id
    INNER JOIN profile_image ON member.profile_image_id = profile_image.id
    WHERE article_id = $article_id AND content_item.is_deleted = false
    ORDER BY content_item.date_time DESC;

COMMIT;

---------------------------------------

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ READ ONLY;

SELECT article.id, article.title, content_item.body, topic.name, member.first_name, member.last_name, content_item.date_time, content_item.academy_score, imdb_info.query_type, imdb_info.imdb_id FROM article
    INNER JOIN topic ON article.topic_id = topic.id
    INNER JOIN imdb_info ON article.imdb_info_id = imdb_info.id
    INNER JOIN content_item ON article.id = content_item.id
    INNER JOIN member ON content_item.author_id = member.id
    WHERE article.id = $article_id AND content_item.is_deleted = false;

SELECT article_image.id, article_image.file_name FROM article_image
    WHERE article_image.article_id = $article_id;

SELECT tag.id, tag.name FROM tag
    INNER JOIN tag_article ON tag.id = tag_article.tag_id
    WHERE tag_article.article_id = $article_id;

COMMIT;

---------------------------------------

BEGIN TRANSACTION;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ READ ONLY;
SELECT article.id, article.title, content_item.date_time, content_item.academy_score FROM article
    INNER JOIN content_item ON article.id = content_item.id
    INNER JOIN topic ON article.topic_id = topic.id
    WHERE article.topic_id = $topic_id AND article.id != $article_id AND content_item.is_deleted = false
    ORDER BY content_item.date_time DESC;

SELECT article.id, article.title, content_item.date_time, content_item.academy_score FROM article
    INNER JOIN content_item ON article.id = content_item.id
    INNER JOIN topic ON article.topic_id = topic.id
    INNER JOIN tag_article ON article.id = tag_article.article_id
    INNER JOIN tag ON tag_article.tag_id = tag.id
    WHERE tag.id = ANY($tags) AND article.id != $article_id AND content_item.is_deleted = false
    ORDER BY content_item.date_time DESC;

COMMIT;

---------------------------------------

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ READ ONLY;

SELECT COUNT(*) FROM notification WHERE notified_id = $member_id AND was_read = false;

SELECT notification.id, notification.date_time, comment_notification.comment_id FROM notification
    INNER JOIN comment_notification ON notification.id = comment_notification.id
    WHERE notification.notified_id = $member_id AND notification.was_read = false;

SELECT notification.id, notification.date_time, content_notification.content_item_id, upvote_notification.amount FROM notification
    INNER JOIN content_notification ON notification.id = content_notification.id
    INNER JOIN upvote_notification ON notification.id = upvote_notification.id
    WHERE notification.notified_id = $member_id AND notification.was_read = false;

SELECT notification.id, notification.date_time, content_notification.content_item_id FROM notification
    INNER JOIN content_notification ON notification.id = content_notification.id
    INNER JOIN edit_notification ON notification.id = edit_notification.id
    WHERE notification.notified_id = $member_id AND notification.was_read = false;

SELECT notification.id, notification.date_time, content_notification.content_item_id FROM notification
    INNER JOIN content_notification ON notification.id = content_notification.id
    INNER JOIN removal_notification ON notification.id = removal_notification.id
    WHERE notification.notified_id = $member_id AND notification.was_read = false;

SELECT notification.id, notification.date_time, content_notification.content_item_id FROM notification
    INNER JOIN content_notification ON notification.id = content_notification.id
    INNER JOIN undefined_topic_notification ON notification.id = undefined_topic_notification.id
    WHERE notification.notified_id = $member_id AND notification.was_read = false;

SELECT notification.id, notification.date_time FROM notification
    INNER JOIN block_notification ON notification.id = block_notification.id
    WHERE notification.notified_id = $member_id AND notification.was_read = false;

SELECT notification.id, notification.date_time, follow_notification.follower_id FROM notification
    INNER JOIN follow_notification ON notification.id = follow_notification.id
    WHERE notification.notified_id = $member_id AND notification.was_read = false;

COMMIT;

---------------------------------------

BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ READ ONLY;

SELECT COUNT(*) FROM content_report;

SELECT content_report.id, content_report.motive, content_report.content_item_id, report.date_time, report.body, member.id, member.username, member.first_name, member.last_name FROM content_report
    INNER JOIN report ON content_report.id = report.id
    INNER JOIN member ON report.submitter_id = member.id;

SELECT COUNT(*) FROM member_report;

SELECT member_report.id, member_report.misconduct, member_report.member_id, report.date_time, report.body, member.id, member.username, member.first_name, member.last_name FROM member_report
    INNER JOIN report ON member_report.id = report.id
    INNER JOIN member ON report.submitter_id = member.id;

COMMIT;
