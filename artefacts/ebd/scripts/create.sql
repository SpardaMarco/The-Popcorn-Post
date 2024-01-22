DROP SCHEMA IF EXISTS lbaw2356 CASCADE;
CREATE SCHEMA lbaw2356;
SET search_path TO lbaw2356;

-----------------------------------------
-- Drop Tables and Types
-----------------------------------------

DROP TABLE IF EXISTS follow_notification CASCADE;
DROP TABLE IF EXISTS block_notification CASCADE;
DROP TABLE IF EXISTS undefined_topic_notification CASCADE;
DROP TABLE IF EXISTS removal_notification CASCADE;
DROP TABLE IF EXISTS edit_notification CASCADE;
DROP TABLE IF EXISTS upvote_notification CASCADE;
DROP TABLE IF EXISTS content_notification CASCADE;
DROP TABLE IF EXISTS comment_notification CASCADE;
DROP TABLE IF EXISTS notification CASCADE;
DROP TABLE IF EXISTS member_report CASCADE;
DROP TABLE IF EXISTS content_report CASCADE;
DROP TABLE IF EXISTS report CASCADE;
DROP TABLE IF EXISTS vote CASCADE;
DROP TABLE IF EXISTS edit CASCADE;
DROP TABLE IF EXISTS comment CASCADE;
DROP TABLE IF EXISTS follow_tag CASCADE;
DROP TABLE IF EXISTS tag_article CASCADE;
DROP TABLE IF EXISTS tag CASCADE;
DROP TABLE IF EXISTS article_image CASCADE;
DROP TABLE IF EXISTS article CASCADE;
DROP TABLE IF EXISTS content_item CASCADE;
DROP TABLE IF EXISTS topic_suggestion CASCADE;
DROP TABLE IF EXISTS topic CASCADE;
DROP TABLE IF EXISTS follow_member CASCADE;
DROP TABLE IF EXISTS appeal CASCADE;
DROP TABLE IF EXISTS member CASCADE;
DROP TABLE IF EXISTS profile_image CASCADE;
DROP TABLE IF EXISTS imdb_info CASCADE;

DROP TYPE IF EXISTS motives;
DROP TYPE IF EXISTS misconduct_types;
DROP TYPE IF EXISTS statuses;


-----------------------------------------
-- Drop Triggers and Functions
-----------------------------------------

DROP TRIGGER IF EXISTS data_anonymization ON member CASCADE;
DROP FUNCTION IF EXISTS data_anonymization();
DROP TRIGGER IF EXISTS delete_content_item ON content_item CASCADE;
DROP FUNCTION IF EXISTS delete_content_item();
DROP TRIGGER IF EXISTS before_permanent_delete_article ON article CASCADE;
DROP FUNCTION IF EXISTS before_permanent_delete_article();
DROP TRIGGER IF EXISTS after_permanent_delete_article ON article CASCADE;
DROP FUNCTION IF EXISTS after_permanent_delete_article();
DROP TRIGGER IF EXISTS before_delete_comment ON comment CASCADE;
DROP FUNCTION IF EXISTS before_delete_comment();
DROP TRIGGER IF EXISTS after_delete_comment ON comment CASCADE;
DROP FUNCTION IF EXISTS after_delete_comment();
DROP TRIGGER IF EXISTS ban_tag ON tag CASCADE;
DROP FUNCTION IF EXISTS ban_tag();
DROP TRIGGER IF EXISTS edit_content_notification ON edit CASCADE;
DROP FUNCTION IF EXISTS edit_content_notification();
DROP TRIGGER IF EXISTS remove_topic ON topic CASCADE;
DROP FUNCTION IF EXISTS remove_topic();
DROP TRIGGER IF EXISTS notify_undefined_topic ON article CASCADE;
DROP FUNCTION IF EXISTS notify_undefined_topic();
DROP FUNCTION IF EXISTS generate_undefined_topic_notification(author_id INT, article_id INT);
DROP TRIGGER IF EXISTS vote_for_own_content ON vote CASCADE;
DROP FUNCTION IF EXISTS vote_for_own_content();
DROP TRIGGER IF EXISTS news_article_tags ON tag_article CASCADE;
DROP FUNCTION IF EXISTS news_article_tags();
DROP TRIGGER IF EXISTS blocked_user_appeal ON appeal CASCADE;
DROP FUNCTION IF EXISTS blocked_user_appeal();
DROP TRIGGER IF EXISTS topic_control ON topic_suggestion CASCADE;
DROP FUNCTION IF EXISTS topic_control();
DROP TRIGGER IF EXISTS comment_date_validation ON comment CASCADE;
DROP FUNCTION IF EXISTS comment_date_validation();
DROP TRIGGER IF EXISTS comment_reply_validation ON comment CASCADE;
DROP FUNCTION IF EXISTS comment_reply_validation();
DROP TRIGGER IF EXISTS reply_to_comment_validation ON comment CASCADE;
DROP FUNCTION IF EXISTS reply_to_comment_validation();
DROP TRIGGER IF EXISTS report_self ON member_report CASCADE;
DROP FUNCTION IF EXISTS report_self();
DROP TRIGGER IF EXISTS report_self_content ON content_report CASCADE;
DROP FUNCTION IF EXISTS report_self_content();
DROP TRIGGER IF EXISTS generate_block_notification ON member CASCADE;
DROP FUNCTION IF EXISTS generate_block_notification();
DROP TRIGGER IF EXISTS generate_follow_notification ON follow_member CASCADE;
DROP FUNCTION IF EXISTS generate_follow_notification();
DROP TRIGGER IF EXISTS generate_comment_notification ON comment CASCADE;
DROP FUNCTION IF EXISTS generate_comment_notification();
DROP TRIGGER IF EXISTS update_content_item_academy_score ON vote CASCADE;
DROP FUNCTION IF EXISTS update_content_item_academy_score();
DROP TRIGGER IF EXISTS update_member_academy_score ON content_item CASCADE;
DROP FUNCTION IF EXISTS update_member_academy_score();
DROP TRIGGER IF EXISTS generate_removal_notification ON edit CASCADE;
DROP FUNCTION IF EXISTS generate_removal_notification();
DROP FUNCTION IF EXISTS content_item_search_update() CASCADE;
DROP TRIGGER IF EXISTS content_item_search_update ON content_item CASCADE;
DROP FUNCTION IF EXISTS article_search_update() CASCADE;
DROP TRIGGER IF EXISTS article_search_update ON article CASCADE;
DROP FUNCTION IF EXISTS member_search_update() CASCADE;
DROP TRIGGER IF EXISTS member_search_update ON member CASCADE;
DROP FUNCTION IF EXISTS email_lowercase() CASCADE;
DROP TRIGGER IF EXISTS email_lowercase ON member CASCADE;
DROP FUNCTION IF EXISTS tag_lowercase() CASCADE;
DROP TRIGGER IF EXISTS tag_lowercase ON tag CASCADE;

-----------------------------------------
-- Drop Indexes
-----------------------------------------

DROP INDEX IF EXISTS content_item_date;
DROP INDEX IF EXISTS content_item_academy_score;
DROP INDEX IF EXISTS article_topic;
DROP INDEX IF EXISTS content_item_search;
DROP INDEX IF EXISTS member_search;


-----------------------------------------
-- Types
-----------------------------------------

CREATE TYPE motives AS ENUM ('Hateful', 'Spam', 'Violent', 'NSFW', 'Misinformation', 'Plagiarism', 'Other');
CREATE TYPE misconduct_types AS ENUM ('Hateful', 'Harassment', 'Spam', 'Impersonation', 'InnapropriateContent', 'Other');
CREATE TYPE statuses AS ENUM ('Pending', 'Accepted', 'Rejected');


-----------------------------------------
-- Tables
-----------------------------------------

CREATE TABLE imdb_info (
    id              SERIAL,
    query_type      VARCHAR(255)    NOT NULL,
    imdb_info_id         VARCHAR(255)    UNIQUE NOT NULL,
    CONSTRAINT imdb_info_pk PRIMARY KEY (id),
    CONSTRAINT imdb_info_imdb_info_id_unique UNIQUE (imdb_info_id)
);

CREATE TABLE profile_image (
    id              SERIAL,
    file_name       VARCHAR(255)    UNIQUE NOT NULL,
    CONSTRAINT profile_image_pk PRIMARY KEY (id),
    CONSTRAINT profile_image_file_name_unique UNIQUE (file_name)
);

CREATE TABLE member (
    id              SERIAL,
    email           VARCHAR(255)    UNIQUE NOT NULL,
    password        VARCHAR(255)    NOT NULL,
    username        VARCHAR(255)    UNIQUE NOT NULL,
    first_name      VARCHAR(255)    NOT NULL,
    last_name       VARCHAR(255)    NOT NULL,
    biography       TEXT,
    is_blocked      BOOLEAN         NOT NULL DEFAULT FALSE,
    is_admin        BOOLEAN         NOT NULL DEFAULT FALSE,
    is_deleted      BOOLEAN         NOT NULL DEFAULT FALSE,
    academy_score   INTEGER         NOT NULL DEFAULT 0,
    profile_image_id INTEGER       NOT NULL DEFAULT 0,
    CONSTRAINT member_pk PRIMARY KEY (id),
    CONSTRAINT member_email_unique UNIQUE (email),
    CONSTRAINT member_username_unique UNIQUE (username),
    CONSTRAINT member_profile_image_fk FOREIGN KEY (profile_image_id) REFERENCES profile_image(id)
);

CREATE TABLE appeal (
    id              SERIAL,
    date_time       TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    body            TEXT,
    submitter_id    INTEGER         NOT NULL,
    CONSTRAINT appeal_pk PRIMARY KEY (id),
    CONSTRAINT appeal_submitter_fk FOREIGN KEY (submitter_id) REFERENCES member(id)
);

CREATE TABLE follow_member (
    follower_id     INTEGER         NOT NULL,
    followed_id     INTEGER         NOT NULL,
    CONSTRAINT follow_pk PRIMARY KEY (follower_id, followed_id),
    CONSTRAINT follow_follower_fk FOREIGN KEY (follower_id) REFERENCES member(id) ON DELETE CASCADE,
    CONSTRAINT follow_followed_fk FOREIGN KEY (followed_id) REFERENCES member(id) ON DELETE CASCADE,
    CONSTRAINT follow_check CHECK (follower_id != followed_id)
);

CREATE TABLE topic (
    id              SERIAL,
    name            VARCHAR(255)    UNIQUE NOT NULL,
    CONSTRAINT topic_pk PRIMARY KEY (id),
    CONSTRAINT topic_name_unique UNIQUE (name)
);

CREATE TABLE topic_suggestion (
    id              SERIAL,
    name            VARCHAR(255)    UNIQUE NOT NULL,
    status          statuses        NOT NULL DEFAULT 'Pending',
    suggester_id     INTEGER         NOT NULL,
    CONSTRAINT topic_suggestion_pk PRIMARY KEY (id),
    CONSTRAINT topic_suggestion_name_unique UNIQUE (name),
    CONSTRAINT topic_suggester_fk FOREIGN KEY (suggester_id) REFERENCES member(id)
);

CREATE TABLE content_item (
    id              SERIAL,
    date_time       TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    body            TEXT            NOT NULL,
    is_deleted      BOOLEAN         NOT NULL DEFAULT FALSE,
    academy_score   INTEGER         NOT NULL DEFAULT 0,
    author_id       INTEGER         NOT NULL,
    CONSTRAINT content_item_pk PRIMARY KEY (id),
    CONSTRAINT content_item_author_fk FOREIGN KEY (author_id) REFERENCES member(id)
);

CREATE TABLE article (
    id              INTEGER,
    title           VARCHAR(255)    NOT NULL,
    topic_id        INTEGER         NOT NULL,
    imdb_info_id    INTEGER,
    CONSTRAINT article_pk PRIMARY KEY (id),
    CONSTRAINT article_content_item_fk FOREIGN KEY (id) REFERENCES content_item(id) ON DELETE CASCADE,
    CONSTRAINT article_topic_fk FOREIGN KEY (topic_id) REFERENCES topic(id),
    CONSTRAINT article_imdb_info_fk FOREIGN KEY (imdb_info_id) REFERENCES imdb_info(id)
);

CREATE TABLE article_image (
    id              SERIAL,
    file_name       VARCHAR(255)    UNIQUE NOT NULL,
    article_id      INTEGER         NOT NULL,
    CONSTRAINT article_image_pk PRIMARY KEY (id),
    CONSTRAINT article_image_file_name_unique UNIQUE (file_name),
    CONSTRAINT article_image_article_fk FOREIGN KEY (article_id) REFERENCES article(id)
);

CREATE TABLE tag (
    id              SERIAL,
    name            VARCHAR(255)    UNIQUE NOT NULL,
    is_banned       BOOLEAN         NOT NULL DEFAULT FALSE,
    CONSTRAINT tag_pk PRIMARY KEY (id),
    CONSTRAINT tag_name_unique UNIQUE (name)
);

CREATE TABLE tag_article (
    tag_id          INTEGER         NOT NULL,
    article_id      INTEGER         NOT NULL,
    CONSTRAINT tag_article_pk PRIMARY KEY (tag_id, article_id),
    CONSTRAINT tag_article_tag_fk FOREIGN KEY (tag_id) REFERENCES tag(id) ON DELETE CASCADE,
    CONSTRAINT tag_article_article_fk FOREIGN KEY (article_id) REFERENCES article(id) ON DELETE CASCADE
);

CREATE TABLE follow_tag (
    tag_id     INTEGER         NOT NULL,
    member_id     INTEGER         NOT NULL,
    CONSTRAINT follow_tag_pk PRIMARY KEY (tag_id, member_id),
    CONSTRAINT follow_tag_tag_fk FOREIGN KEY (tag_id) REFERENCES tag(id) ON DELETE CASCADE,
    CONSTRAINT follow_tag_member_fk FOREIGN KEY (member_id) REFERENCES member(id) ON DELETE CASCADE
);

CREATE TABLE comment (
    id              INTEGER,
    is_reply        BOOLEAN         NOT NULL,
    article_id      INTEGER         NOT NULL,
    reply_id        INTEGER,
    CONSTRAINT comment_pk PRIMARY KEY (id),
    CONSTRAINT comment_content_item_fk FOREIGN KEY (id) REFERENCES content_item(id) ON DELETE CASCADE,
    CONSTRAINT comment_article_fk FOREIGN KEY (article_id) REFERENCES article(id),
    CONSTRAINT comment_reply_fk FOREIGN KEY (reply_id) REFERENCES comment(id),
    CONSTRAINT comment_reply_check CHECK (is_reply = TRUE AND reply_id IS NOT NULL OR is_reply = FALSE AND reply_id IS NULL)
);

CREATE TABLE edit (
    id              SERIAL,
    altered_field   VARCHAR(255)    NOT NULL,
    old_value       TEXT            NOT NULL,
    new_value       TEXT            NOT NULL,
    content_item_id INTEGER         NOT NULL,
    author_id       INTEGER         NOT NULL,
    CONSTRAINT edit_pk PRIMARY KEY (id),
    CONSTRAINT edit_content_item_fk FOREIGN KEY (content_item_id) REFERENCES content_item(id) ON DELETE CASCADE,
    CONSTRAINT edit_author_fk FOREIGN KEY (author_id) REFERENCES member(id)
);

CREATE TABLE vote (
    member_id       INTEGER         NOT NULL,
    content_item_id INTEGER         NOT NULL,
    weight          INTEGER         NOT NULL CHECK (weight = 1 OR weight = -1),
    CONSTRAINT vote_pk PRIMARY KEY (member_id, content_item_id),
    CONSTRAINT vote_member_fk FOREIGN KEY (member_id) REFERENCES member(id),
    CONSTRAINT vote_content_item_fk FOREIGN KEY (content_item_id) REFERENCES content_item(id)
);

CREATE TABLE report (
    id              SERIAL,
    date_time       TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    body            TEXT,
    submitter_id    INTEGER         NOT NULL,
    CONSTRAINT report_pk PRIMARY KEY (id),
    CONSTRAINT report_submitter_fk FOREIGN KEY (submitter_id) REFERENCES member(id)
);

CREATE TABLE content_report (
    id              INTEGER,
    motive          motives         NOT NULL,
    content_item_id INTEGER         NOT NULL,
    CONSTRAINT content_report_pk PRIMARY KEY (id),
    CONSTRAINT content_report_report_fk FOREIGN KEY (id) REFERENCES report(id) ON DELETE CASCADE,
    CONSTRAINT content_report_content_item_fk FOREIGN KEY (content_item_id) REFERENCES content_item(id)
);

CREATE TABLE member_report (
    id              INTEGER,
    misconduct      misconduct_types NOT NULL, 
    member_id       INTEGER         NOT NULL,
    CONSTRAINT member_report_pk PRIMARY KEY (id),
    CONSTRAINT member_report_report_fk FOREIGN KEY (id) REFERENCES report(id) ON DELETE CASCADE,
    CONSTRAINT member_report_member_fk FOREIGN KEY (member_id) REFERENCES member(id)
);

CREATE TABLE notification (
    id              SERIAL,
    was_read        BOOLEAN         NOT NULL DEFAULT FALSE,
    date_time       TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    notified_id     INTEGER         NOT NULL,
    CONSTRAINT notification_pk PRIMARY KEY (id),
    CONSTRAINT notification_notified_fk FOREIGN KEY (notified_id) REFERENCES member(id) ON DELETE CASCADE
);

CREATE TABLE comment_notification (
    id              INTEGER,
    comment_id      INTEGER         NOT NULL,
    CONSTRAINT comment_notification_pk PRIMARY KEY (id),
    CONSTRAINT comment_notification_notification_fk FOREIGN KEY (id) REFERENCES notification(id) ON DELETE CASCADE,
    CONSTRAINT comment_notification_comment_fk FOREIGN KEY (comment_id) REFERENCES comment(id) ON DELETE CASCADE
);

CREATE TABLE content_notification (
    id              INTEGER,
    content_item_id INTEGER         NOT NULL,
    CONSTRAINT content_notification_pk PRIMARY KEY (id),
    CONSTRAINT content_notification_notification_fk FOREIGN KEY (id) REFERENCES notification(id) ON DELETE CASCADE,
    CONSTRAINT content_notification_content_item_fk FOREIGN KEY (content_item_id) REFERENCES content_item(id) ON DELETE CASCADE
);

CREATE TABLE upvote_notification (
    id              INTEGER,
    amount          INTEGER         NOT NULL,
    CONSTRAINT upvote_notification_pk PRIMARY KEY (id),
    CONSTRAINT upvote_notification_content_notification_fk FOREIGN KEY (id) REFERENCES content_notification(id) ON DELETE CASCADE,
    CONSTRAINT upvote_notification_amount_check CHECK (amount > 0)
);

CREATE TABLE edit_notification (
    id              INTEGER,
    CONSTRAINT edit_notification_pk PRIMARY KEY (id),
    CONSTRAINT edit_notification_content_notification_fk FOREIGN KEY (id) REFERENCES content_notification(id) ON DELETE CASCADE
);

CREATE TABLE removal_notification (
    id              INTEGER,
    CONSTRAINT removal_notification_pk PRIMARY KEY (id),
    CONSTRAINT removal_notification_content_notification_fk FOREIGN KEY (id) REFERENCES content_notification(id) ON DELETE CASCADE
);

CREATE TABLE undefined_topic_notification (
    id              INTEGER,
    CONSTRAINT undefined_topic_notification_pk PRIMARY KEY (id),
    CONSTRAINT undefined_topic_notification_content_notification_fk FOREIGN KEY (id) REFERENCES content_notification(id) ON DELETE CASCADE
);

CREATE TABLE block_notification (
    id              INTEGER,
    CONSTRAINT block_notification_pk PRIMARY KEY (id),
    CONSTRAINT block_notification_notification_fk FOREIGN KEY (id) REFERENCES notification(id) ON DELETE CASCADE
);

CREATE TABLE follow_notification (
    id              INTEGER,
    follower_id     INTEGER         NOT NULL,
    CONSTRAINT follow_notification_pk PRIMARY KEY (id),
    CONSTRAINT follow_notification_notification_fk FOREIGN KEY (id) REFERENCES notification(id) ON DELETE CASCADE,
    CONSTRAINT follow_notification_follower_fk FOREIGN KEY (follower_id) REFERENCES member(id)
);


-----------------------------------------
-- Triggers and Functions
-----------------------------------------

CREATE FUNCTION data_anonymization() 
RETURNS TRIGGER AS
$BODY$
BEGIN
    UPDATE member SET
        email = '',
        username = '',
        password = '',
        first_name = 'Deleted',
        last_name = 'User',
        biography = '',
        profile_image_id = 0
    WHERE id = OLD.id;

    DELETE FROM profile_image WHERE id != 0 AND id = OLD.profile_image_id;

    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER data_anonymization 
    AFTER UPDATE OF is_deleted ON member
    FOR EACH ROW
    WHEN (OLD.is_deleted = false AND NEW.is_deleted = true)
    EXECUTE PROCEDURE data_anonymization();


CREATE FUNCTION delete_content_item()
RETURNS TRIGGER AS
$BODY$
BEGIN
    IF (OLD.id IN (SELECT id FROM article)) THEN
        UPDATE content_item AS ct
        SET is_deleted = TRUE
        FROM comment AS c
        WHERE c.article_id = OLD.id AND c.id = ct.id AND c.is_reply = FALSE;
    ELSIF (OLD.id IN (SELECT id FROM comment)) THEN
        IF ((SELECT is_reply FROM comment WHERE comment.id = OLD.id) = FALSE) THEN
            UPDATE content_item AS ct
            SET is_deleted = TRUE
            FROM comment AS c
            WHERE c.reply_id = OLD.id AND c.id = ct.id AND c.is_reply = TRUE;
        END IF;
    END IF;

    UPDATE member 
    SET academy_score = member.academy_score - OLD.academy_score
    WHERE member.id = OLD.author_id;

    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER delete_content_item
    BEFORE UPDATE OF is_deleted ON content_item
    FOR EACH ROW
    WHEN (NEW.is_deleted = TRUE AND OLD.is_deleted = FALSE)
    EXECUTE PROCEDURE delete_content_item();

CREATE FUNCTION before_permanent_delete_article()
RETURNS TRIGGER AS
$BODY$
BEGIN
    DELETE FROM vote
    WHERE vote.content_item_id = OLD.id;

    DELETE FROM comment
    WHERE comment.article_id = OLD.id AND comment.is_reply = FALSE;

    DELETE FROM article_image
    WHERE article_image.article_id = OLD.id;

    RETURN OLD;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER before_permanent_delete_article 
    BEFORE DELETE ON article
    FOR EACH ROW
    EXECUTE PROCEDURE before_permanent_delete_article();


CREATE FUNCTION after_permanent_delete_article()
RETURNS TRIGGER AS
$BODY$
BEGIN
    DELETE FROM content_item
    WHERE content_item.id = OLD.id;

    RETURN NULL;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER after_permanent_delete_article
    AFTER DELETE ON article
    FOR EACH ROW
    EXECUTE PROCEDURE after_permanent_delete_article();


CREATE FUNCTION before_delete_comment()
RETURNS TRIGGER AS
$BODY$
BEGIN
    DELETE FROM vote
    WHERE vote.content_item_id = OLD.id;

    IF (OLD.is_reply = FALSE) THEN
        DELETE FROM comment
        WHERE comment.reply_id = OLD.id AND comment.is_reply = TRUE;
    END IF;

    RETURN OLD;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER before_delete_comment 
    BEFORE DELETE ON comment
    FOR EACH ROW
    EXECUTE PROCEDURE before_delete_comment();


CREATE FUNCTION after_delete_comment()
RETURNS TRIGGER AS
$BODY$
BEGIN
    DELETE FROM content_item
    WHERE content_item.id = OLD.id;

    RETURN NULL;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER after_delete_comment
    AFTER DELETE ON comment
    FOR EACH ROW
    EXECUTE PROCEDURE after_delete_comment();


CREATE FUNCTION ban_tag()
RETURNS TRIGGER AS
$BODY$
BEGIN
    DELETE FROM tag_article
    WHERE tag_article.tag_id = OLD.id;

    DELETE FROM follow_tag
    WHERE follow_tag.tag_id = OLD.id;

    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER ban_tag 
    BEFORE UPDATE OF is_banned ON tag
    FOR EACH ROW
    WHEN (OLD.is_banned = false AND NEW.is_banned = true)
    EXECUTE PROCEDURE ban_tag();


CREATE FUNCTION edit_content_notification()
RETURNS TRIGGER AS
$BODY$
DECLARE
    notification_id INT;
BEGIN
    IF (NEW.author_id = (SELECT author_id FROM content_item WHERE content_item.id = NEW.content_item_id)) THEN
        RETURN NULL;
    END IF;

    INSERT INTO notification (notified_id)
    VALUES ((SELECT author_id FROM content_item WHERE content_item.id = NEW.content_item_id))
    RETURNING id INTO notification_id;

    INSERT INTO content_notification (id, content_item_id)
    VALUES (notification_id, NEW.content_item_id);
    
    INSERT INTO edit_notification (id)
    VALUES (notification_id);

    RETURN NULL;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER edit_content_notification 
    AFTER INSERT ON edit
    FOR EACH ROW
    WHEN (NEW.altered_field != 'is_deleted')
    EXECUTE FUNCTION edit_content_notification(); 


CREATE FUNCTION remove_topic()
RETURNS TRIGGER AS
$BODY$
BEGIN
    UPDATE article 
    SET topic_id = 0
    WHERE topic_id = OLD.id;

    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER remove_topic 
    BEFORE DELETE ON topic
    FOR EACH ROW
    EXECUTE PROCEDURE remove_topic();


CREATE FUNCTION generate_undefined_topic_notification(author_id INT, article_id INT)
RETURNS VOID AS
$BODY$
DECLARE
    notification_id INTEGER;
BEGIN
    INSERT INTO notification (notified_id)
    VALUES (author_id)
    RETURNING id INTO notification_id;

    INSERT INTO content_notification (id, content_item_id)
    VALUES (notification_id, article_id);

    INSERT INTO undefined_topic_notification (id)
    VALUES (notification_id);

    RETURN;
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION notify_undefined_topic()
RETURNS TRIGGER AS
$BODY$
DECLARE
    author_id INTEGER;
BEGIN
    SELECT content_item.author_id, content_item.id
    FROM content_item
    WHERE content_item.id = OLD.id
    INTO author_id;

    EXECUTE generate_undefined_topic_notification(author_id, OLD.id);

    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;


CREATE TRIGGER notify_undefined_topic 
    AFTER UPDATE OF topic_id ON article
    FOR EACH ROW
    WHEN (OLD.topic_id != 0 AND NEW.topic_id = 0)
    EXECUTE FUNCTION notify_undefined_topic();


CREATE FUNCTION vote_for_own_content()
RETURNS TRIGGER AS
$BODY$
BEGIN
    IF (NEW.member_id = (SELECT author_id FROM content_item WHERE content_item.id = NEW.content_item_id)) THEN
        RAISE EXCEPTION 'Members cannot vote on their own content';
    END IF;

    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER vote_for_own_content
    BEFORE INSERT ON vote
    FOR EACH ROW
    EXECUTE FUNCTION vote_for_own_content();


CREATE FUNCTION news_article_tags()
RETURNS TRIGGER AS
$BODY$
BEGIN
    IF ((6 < (SELECT COUNT(*) FROM tag_article WHERE tag_article.article_id = NEW.article_id))) THEN 
        RAISE EXCEPTION 'Cannot add more than 6 tags to a news article';
    END IF;

    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER news_article_tags
    BEFORE INSERT ON tag_article
    FOR EACH ROW
    EXECUTE PROCEDURE news_article_tags();


CREATE FUNCTION blocked_user_appeal()
RETURNS TRIGGER AS
$BODY$
BEGIN
    IF ((SELECT COUNT(*) FROM appeal WHERE appeal.submitter_id = NEW.submitter_id) > 0) THEN
        RAISE EXCEPTION 'Cannot appeal more than one time';
    END IF;

    IF ((SELECT is_blocked FROM member WHERE member.id = NEW.submitter_id) = false) THEN
        RAISE EXCEPTION 'Cannot appeal if not blocked';
    END IF;

    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER blocked_user_appeal
    BEFORE INSERT ON appeal
    FOR EACH ROW
    EXECUTE PROCEDURE blocked_user_appeal();


CREATE FUNCTION topic_control()
RETURNS TRIGGER AS
$BODY$
BEGIN
    INSERT INTO TOPIC (name)
    VALUES (NEW.name);

    RETURN NULL;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER topic_control
    AFTER UPDATE OF status ON topic_suggestion
    FOR EACH ROW
    WHEN (OLD.status = 'Pending' AND NEW.status = 'Accepted')
    EXECUTE PROCEDURE topic_control();


CREATE FUNCTION comment_date_validation()
RETURNS TRIGGER AS
$BODY$
BEGIN
    IF ((SELECT date_time FROM content_item WHERE content_item.id = NEW.id) < (SELECT date_time FROM content_item WHERE content_item.id = NEW.article_id)) THEN
        RAISE EXCEPTION 'Comment date cannot precede article date';
    END IF;

    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER comment_date_validation
    BEFORE INSERT ON comment
    FOR EACH ROW
    EXECUTE PROCEDURE comment_date_validation();


CREATE FUNCTION comment_reply_validation()
RETURNS TRIGGER AS
$BODY$
BEGIN
    IF (
        NEW.is_reply = TRUE
        AND 
        (SELECT date_time FROM content_item WHERE content_item.id = NEW.reply_id)
        > 
        (SELECT date_time FROM content_item WHERE content_item.id = NEW.id)
    ) THEN
        RAISE EXCEPTION 'Reply date cannot precede comment date';
    END IF;

    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER comment_reply_validation
    BEFORE INSERT ON comment
    FOR EACH ROW
    EXECUTE PROCEDURE comment_reply_validation();


CREATE FUNCTION reply_to_comment_validation()
RETURNS TRIGGER AS
$BODY$
BEGIN
    IF (
        NEW.is_reply = TRUE
        AND 
        (SELECT is_reply FROM comment WHERE comment.id = NEW.reply_id) = TRUE
    ) THEN
        RAISE EXCEPTION 'Cannot reply to a reply';
    END IF;

    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;


CREATE TRIGGER reply_to_comment_validation
    BEFORE INSERT ON comment
    FOR EACH ROW
    EXECUTE PROCEDURE reply_to_comment_validation();


CREATE FUNCTION report_self()
RETURNS TRIGGER AS
$BODY$
BEGIN
    IF ((SELECT submitter_id FROM report WHERE report.id = NEW.id) = NEW.member_id) THEN
        RAISE EXCEPTION 'A member is not allowed to report themselves';
    END IF;

    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER report_self
    BEFORE INSERT ON member_report
    FOR EACH ROW
    EXECUTE PROCEDURE report_self();


CREATE FUNCTION report_self_content()
RETURNS TRIGGER AS
$BODY$
BEGIN
    IF ((SELECT submitter_id FROM report WHERE report.id = NEW.id) = (SELECT author_id FROM content_item WHERE content_item.id = NEW.content_item_id)) THEN
        RAISE EXCEPTION 'A member is not allowed to report their own content';
    END IF;

    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER report_self_content
    BEFORE INSERT ON content_report
    FOR EACH ROW
    EXECUTE PROCEDURE report_self_content();


CREATE FUNCTION generate_block_notification()
RETURNS TRIGGER AS
$BODY$
DECLARE
    notification_id INT;
BEGIN
    INSERT INTO notification (notified_id)
    VALUES (NEW.id)
    RETURNING id INTO notification_id;

    INSERT INTO block_notification (id)
    VALUES (notification_id);

    RETURN NULL;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER generate_block_notification
    AFTER UPDATE OF is_blocked ON member
    FOR EACH ROW
    WHEN (OLD.is_blocked = false AND NEW.is_blocked = true)
    EXECUTE PROCEDURE generate_block_notification();


CREATE FUNCTION generate_follow_notification()
RETURNS TRIGGER AS
$BODY$
DECLARE
    notification_id INT;
BEGIN
    INSERT INTO notification (notified_id)
    VALUES (NEW.followed_id)
    RETURNING id INTO notification_id;

    INSERT INTO follow_notification (id, follower_id)
    VALUES (notification_id, NEW.follower_id);

    RETURN NULL;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER generate_follow_notification
    AFTER INSERT ON follow_member
    FOR EACH ROW
    EXECUTE PROCEDURE generate_follow_notification();


CREATE FUNCTION generate_comment_notification()
RETURNS TRIGGER AS
$BODY$
DECLARE
    notification_id INT;
BEGIN
    INSERT INTO notification (notified_id)
    VALUES ((SELECT author_id FROM content_item WHERE content_item.id = NEW.article_id))
    RETURNING id INTO notification_id;

    INSERT INTO comment_notification (id, comment_id)
    VALUES (notification_id, NEW.id);

    RETURN NULL;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER generate_comment_notification
    AFTER INSERT ON comment
    FOR EACH ROW
    EXECUTE PROCEDURE generate_comment_notification();


CREATE FUNCTION update_content_item_academy_score()
RETURNS TRIGGER AS
$BODY$
DECLARE
    total_score INTEGER;
    vote_print vote;
    count INTEGER;
BEGIN
    IF (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN
        SELECT SUM(weight) INTO total_score
        FROM vote
        WHERE vote.content_item_id = NEW.content_item_id;
    ELSIF (TG_OP = 'DELETE') THEN
        SELECT SUM(weight) INTO total_score
        FROM vote
        WHERE content_item_id = OLD.content_item_id;
    END IF;

    UPDATE content_item
    SET academy_score = COALESCE(total_score, 0)
    WHERE content_item.id = COALESCE(NEW.content_item_id, OLD.content_item_id);

    RETURN NULL;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER update_content_item_academy_score
    AFTER INSERT OR DELETE OR UPDATE ON vote
    FOR EACH ROW
    EXECUTE PROCEDURE update_content_item_academy_score();


CREATE FUNCTION update_member_academy_score()
RETURNS TRIGGER AS
$BODY$
DECLARE
    total_score INT;
BEGIN
    SELECT SUM(academy_score) INTO total_score
    FROM content_item
    WHERE author_id = NEW.author_id AND is_deleted = FALSE;

    UPDATE member
    SET academy_score = total_score
    WHERE member.id = NEW.author_id;

    RETURN NULL;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER update_member_academy_score
    AFTER UPDATE OF academy_score ON content_item
    FOR EACH ROW
    EXECUTE PROCEDURE update_member_academy_score();

CREATE FUNCTION generate_removal_notification()
RETURNS TRIGGER AS
$BODY$
DECLARE
    notification_id INT;
BEGIN

    IF (NEW.author_id = (SELECT author_id FROM content_item WHERE content_item.id = NEW.content_item_id)) THEN
        RETURN NULL;
    END IF;

    INSERT INTO notification (notified_id)
    VALUES ((SELECT author_id FROM content_item WHERE content_item.id = NEW.content_item_id))
    RETURNING id INTO notification_id;

    INSERT INTO content_notification (id, content_item_id)
    VALUES (notification_id, NEW.content_item_id);

    INSERT INTO removal_notification (id)
    VALUES (notification_id);

    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;
    
CREATE TRIGGER generate_removal_notification
    AFTER INSERT ON edit
    FOR EACH ROW
    WHEN (NEW.altered_field = 'is_deleted' AND NEW.old_value = 'FALSE' AND NEW.new_value = 'TRUE')
    EXECUTE PROCEDURE generate_removal_notification();

CREATE FUNCTION email_lowercase()
RETURNS TRIGGER AS
$BODY$
BEGIN
    NEW.email = LOWER(NEW.email);	
    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER email_lowercase
    BEFORE INSERT OR UPDATE ON member
    FOR EACH ROW
    EXECUTE PROCEDURE email_lowercase();


CREATE FUNCTION tag_lowercase()
RETURNS TRIGGER AS
$BODY$
BEGIN
    NEW.name = LOWER(NEW.name);
    RETURN NEW;
END
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER tag_lowercase
    BEFORE INSERT OR UPDATE ON tag
    FOR EACH ROW
    EXECUTE PROCEDURE tag_lowercase();


-----------------------------------------
-- Indexes
-----------------------------------------

-- Performance Indexes

CREATE INDEX content_item_date ON content_item USING btree (date_time);
CREATE INDEX content_item_academy_score ON content_item USING btree (academy_score);
CREATE INDEX article_topic ON article USING hash (topic_id);


-- Full-text Search Indexes

ALTER TABLE content_item
ADD COLUMN tsvectors tsvector;

CREATE FUNCTION content_item_search_update() RETURNS TRIGGER AS $$
BEGIN
 IF TG_OP = 'INSERT' THEN
        IF (NEW.id IN (SELECT id FROM article)) THEN
            NEW.tsvectors = (
                setweight(to_tsvector('english', (SELECT title FROM article WHERE article.id = NEW.id)), 'A') ||
                setweight(to_tsvector('english', NEW.body), 'B')
            );
        ELSE
            NEW.tsvectors = (
                setweight(to_tsvector('english', NEW.body), 'B')
            );
        END IF;
 END IF;
 
 IF TG_OP = 'UPDATE' THEN
        IF (NEW.id IN (SELECT id FROM article)) THEN
            IF (NEW.body <> OLD.body) THEN
                NEW.tsvectors = (
                    setweight(to_tsvector('english', (SELECT title FROM article WHERE article.id = NEW.id)), 'A') ||
                    setweight(to_tsvector('english', NEW.body), 'B')
                );
            END IF;
        ELSE
            IF (NEW.body <> OLD.body) THEN
                NEW.tsvectors = (
                    setweight(to_tsvector('english', NEW.body), 'B')
                );
            END IF;
        END IF;
 END IF;
 RETURN NEW;
END $$
LANGUAGE plpgsql;

CREATE TRIGGER content_item_search_update
BEFORE INSERT OR UPDATE ON content_item
FOR EACH ROW
EXECUTE PROCEDURE content_item_search_update();


CREATE FUNCTION article_search_update() RETURNS TRIGGER AS $$
BEGIN
 IF TG_OP = 'INSERT' THEN
        IF (NEW.id IN (SELECT id FROM content_item)) THEN
            UPDATE content_item
            SET tsvectors = (
                setweight(to_tsvector('english', (SELECT title FROM article WHERE article.id = NEW.id)), 'A') ||
                setweight(to_tsvector('english', (SELECT body FROM content_item WHERE content_item.id = NEW.id)), 'B')
            )
            WHERE content_item.id = NEW.id;
        END IF;
 END IF;

 IF TG_OP = 'UPDATE' THEN
        IF (NEW.id IN (SELECT id FROM content_item)) THEN
            IF (NEW.title <> OLD.title) THEN
                UPDATE content_item
                SET tsvectors = (
                    setweight(to_tsvector('english', (SELECT title FROM article WHERE article.id = NEW.id)), 'A') ||
                    setweight(to_tsvector('english', (SELECT body FROM content_item WHERE content_item.id = NEW.id)), 'B')
                )
                WHERE content_item.id = NEW.id;
            END IF;
        END IF;
 END IF;
 RETURN NEW;
END $$
LANGUAGE plpgsql;

CREATE TRIGGER article_search_update
BEFORE INSERT OR UPDATE ON article
FOR EACH ROW
EXECUTE PROCEDURE article_search_update();


CREATE INDEX content_item_search ON content_item USING GIST (tsvectors);

ALTER TABLE member 
ADD COLUMN tsvectors tsvector;

CREATE FUNCTION member_search_update() RETURNS TRIGGER AS $$
BEGIN
 IF TG_OP = 'INSERT' THEN
        NEW.tsvectors = (
            setweight(to_tsvector('english', NEW.username), 'A') ||
            setweight(to_tsvector('english', NEW.first_name), 'B') ||
            setweight(to_tsvector('english', NEW.last_name), 'B')
        );
 END IF;
 
 IF TG_OP = 'UPDATE' THEN
        IF (NEW.username <> OLD.username) THEN
            NEW.tsvectors = (
                setweight(to_tsvector('english', NEW.username), 'A') ||
                setweight(to_tsvector('english', NEW.first_name), 'B') ||
                setweight(to_tsvector('english', NEW.last_name), 'B')
            );
        END IF;
 END IF;
 RETURN NEW;
END $$

LANGUAGE plpgsql;

CREATE TRIGGER member_search_update
BEFORE INSERT OR UPDATE ON member
FOR EACH ROW
EXECUTE PROCEDURE member_search_update();

CREATE INDEX member_search ON member USING GIN (tsvectors);
