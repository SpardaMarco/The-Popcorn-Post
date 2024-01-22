SET search_path TO lbaw2356;

DROP FUNCTION IF EXISTS create_imdb_info(query_type VARCHAR(255), imdb_info_id VARCHAR(255));
DROP FUNCTION IF EXISTS create_profile_image(file_name VARCHAR(255));
DROP FUNCTION IF EXISTS create_member(email VARCHAR(255), password VARCHAR(255), username VARCHAR(255), first_name VARCHAR(255), last_name VARCHAR(255), biography TEXT);
DROP FUNCTION IF EXISTS create_admin(email VARCHAR(255), password VARCHAR(255), username VARCHAR(255), first_name VARCHAR(255), last_name VARCHAR(255), biography TEXT);
DROP FUNCTION IF EXISTS create_appeal(body VARCHAR(255), submitter_id INTEGER);
DROP FUNCTION IF EXISTS create_follow_member(follower_id INTEGER, followed_id INTEGER);
DROP FUNCTION IF EXISTS create_topic(name VARCHAR(255));
DROP FUNCTION IF EXISTS create_topic_suggestion(name VARCHAR(255), status statuses, suggester_id INTEGER);
DROP FUNCTION IF EXISTS create_content_item(body TEXT, author_id INTEGER);
DROP FUNCTION IF EXISTS create_article(title VARCHAR(255), body TEXT, author_id INTEGER, topic_id INTEGER, imdb_info_id INTEGER);
DROP FUNCTION IF EXISTS create_article_image(file_name VARCHAR(255), article_id INTEGER);
DROP FUNCTION IF EXISTS create_tag(name VARCHAR(255));
DROP FUNCTION IF EXISTS create_tag_article(tag_id INTEGER, article_id INTEGER);
DROP FUNCTION IF EXISTS create_follow_tag(tag_id INTEGER, member_id INTEGER);
DROP FUNCTION IF EXISTS create_comment(body TEXT, author_id INTEGER, is_reply BOOLEAN, article_id INTEGER, reply_id INTEGER);
DROP FUNCTION IF EXISTS create_edit(altered_field VARCHAR(255), old_value TEXT, new_value TEXT, content_item_id INTEGER, author_id INTEGER);
DROP FUNCTION IF EXISTS create_vote(member_id INTEGER, content_item_id INTEGER, weight INTEGER);
DROP FUNCTION IF EXISTS create_report(body TEXT, submitter_id INTEGER);
DROP FUNCTION IF EXISTS create_content_report(body TEXT, submitter_id INTEGER, motive motives, content_item_id INTEGER);
DROP FUNCTION IF EXISTS create_member_report(body TEXT, submitter_id INTEGER, misconduct misconduct_types, member_id INTEGER);
DROP FUNCTION IF EXISTS create_notification(notified_id INTEGER);
DROP FUNCTION IF EXISTS create_comment_notification(notified_id INTEGER, comment_id INTEGER);
DROP FUNCTION IF EXISTS create_content_notification(notified_id INTEGER, content_item_id INTEGER);
DROP FUNCTION IF EXISTS create_upvote_notification(notified_id INTEGER, content_item_id INTEGER, amount INTEGER);
DROP FUNCTION IF EXISTS create_edit_notification(notified_id INTEGER, content_item_id INTEGER);
DROP FUNCTION IF EXISTS create_removal_notification(notified_id INTEGER, content_item_id INTEGER);
DROP FUNCTION IF EXISTS create_undefined_topic_notification(notified_id INTEGER, content_item_id INTEGER);
DROP FUNCTION IF EXISTS create_block_notification(notified_id INTEGER);
DROP FUNCTION IF EXISTS create_follow_notification(notified_id INTEGER, follower_id INTEGER);

CREATE FUNCTION create_imdb_info(query_type VARCHAR(255), imdb_info_id VARCHAR(255))
RETURNS VOID AS
$BODY$
BEGIN
    INSERT INTO imdb_info (query_type, imdb_info_id)
    VALUES (query_type, imdb_info_id);
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_profile_image(file_name VARCHAR(255))
RETURNS VOID AS
$BODY$
BEGIN
    INSERT INTO profile_image (file_name)
    VALUES (file_name);
END
$BODY$
LANGUAGE plpgsql;


CREATE FUNCTION create_member(email VARCHAR(255), password VARCHAR(255), username VARCHAR(255), first_name VARCHAR(255), last_name VARCHAR(255), biography TEXT)
RETURNS INTEGER AS
$BODY$
DECLARE
    member_id INTEGER;
BEGIN
    INSERT INTO member (email, password, username, first_name, last_name, biography)
    VALUES (email, password, username, first_name, last_name, biography)
    RETURNING id INTO member_id;

    RETURN member_id;
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_admin(email VARCHAR(255), password VARCHAR(255), username VARCHAR(255), first_name VARCHAR(255), last_name VARCHAR(255), biography TEXT)
RETURNS VOID AS
$BODY$
DEClARE
    member_id INTEGER;
BEGIN
    member_id := create_member(email, password, username, first_name, last_name, biography);
    UPDATE member
    SET is_admin = TRUE
    WHERE id = member_id;
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_appeal(body VARCHAR(255), submitter_id INTEGER)
RETURNS VOID AS
$BODY$
BEGIN
    INSERT INTO appeal (body, submitter_id)
    VALUES (body, submitter_id);
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_follow_member(follower_id INTEGER, followed_id INTEGER)
RETURNS VOID AS
$BODY$
BEGIN
    INSERT INTO follow_member (follower_id, followed_id)
    VALUES (follower_id, followed_id);
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_topic(name VARCHAR(255))
RETURNS VOID AS
$BODY$
BEGIN
    INSERT INTO topic (name)
    VALUES (name);
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_topic_suggestion(name VARCHAR(255), status statuses, suggester_id INTEGER)
RETURNS VOID AS
$BODY$
BEGIN
    INSERT INTO topic_suggestion (name, status, suggester_id)
    VALUES (name, status, suggester_id);
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_content_item(body TEXT, author_id INTEGER)
RETURNS INTEGER AS
$BODY$
DECLARE
    content_item_id INTEGER;    
BEGIN
    INSERT INTO content_item (body, author_id)
    VALUES (body, author_id)
    RETURNING id INTO content_item_id;

    RETURN content_item_id;
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_article(title VARCHAR(255), body TEXT, author_id INTEGER, topic_id INTEGER, imdb_info_id INTEGER)
RETURNS VOID AS
$BODY$
DECLARE
    id INTEGER;
BEGIN
    id := create_content_item(body, author_id);

    INSERT INTO article (id, title, topic_id, imdb_info_id)
    VALUES (id, title, topic_id, imdb_info_id);
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_article_image(file_name VARCHAR(255), article_id INTEGER)
RETURNS VOID AS
$BODY$
BEGIN
    INSERT INTO article_image (file_name, article_id)
    VALUES (file_name, article_id);
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_tag(name VARCHAR(255))
RETURNS VOID AS
$BODY$
BEGIN
    INSERT INTO tag (name)
    VALUES (name);
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_tag_article(tag_id INTEGER, article_id INTEGER)
RETURNS VOID AS
$BODY$
BEGIN
    INSERT INTO tag_article (tag_id, article_id)
    VALUES (tag_id, article_id);
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_follow_tag(tag_id INTEGER, member_id INTEGER)
RETURNS VOID AS
$BODY$
BEGIN
    INSERT INTO follow_tag (tag_id, member_id)
    VALUES (tag_id, member_id);
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_comment(body TEXT, author_id INTEGER, is_reply BOOLEAN, article_id INTEGER, reply_id INTEGER)
RETURNS VOID AS
$BODY$
DECLARE
    id INTEGER;
BEGIN
    id := create_content_item(body, author_id);
    INSERT INTO comment (id, is_reply, article_id, reply_id)
    VALUES (id, is_reply, article_id, reply_id);
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_edit(altered_field VARCHAR(255), old_value TEXT, new_value TEXT, content_item_id INTEGER, author_id INTEGER)
RETURNS VOID AS
$BODY$
BEGIN
    INSERT INTO edit (altered_field, old_value, new_value, content_item_id, author_id)
    VALUES (altered_field, old_value, new_value, content_item_id, author_id);
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_vote(member_id INTEGER, content_item_id INTEGER, weight INTEGER)
RETURNS VOID AS
$BODY$
BEGIN
    INSERT INTO vote (member_id, content_item_id, weight)
    VALUES (member_id, content_item_id, weight);
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_report(body TEXT, submitter_id INTEGER)
RETURNS INTEGER AS
$BODY$
DECLARE
    report_id INTEGER;
BEGIN
    INSERT INTO report (body, submitter_id)
    VALUES (body, submitter_id)
    RETURNING id INTO report_id;

    RETURN report_id;
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_content_report(body TEXT, submitter_id INTEGER, motive motives, content_item_id INTEGER)
RETURNS VOID AS
$BODY$
DECLARE
    id INTEGER;
BEGIN
    id := create_report(body, submitter_id);
    INSERT INTO content_report (id, motive, content_item_id)
    VALUES (id, motive, content_item_id);
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_member_report(body TEXT, submitter_id INTEGER, misconduct misconduct_types, member_id INTEGER)
RETURNS VOID AS
$BODY$
DECLARE 
    id INTEGER;
BEGIN
    id := create_report(body, submitter_id);
    INSERT INTO member_report (id, misconduct, member_id)
    VALUES (id, misconduct, member_id);
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_notification(notified_id INTEGER)
RETURNS INTEGER AS
$BODY$
DECLARE
    notification_id INTEGER;
BEGIN
    INSERT INTO notification (notified_id)
    VALUES (notified_id)
    RETURNING id INTO notification_id;

    RETURN notification_id;
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_comment_notification(notified_id INTEGER, comment_id INTEGER)
RETURNS VOID AS
$BODY$
DECLARE
    id INTEGER;
BEGIN
    id := create_notification(comment_id);
    INSERT INTO comment_notification (id, comment_id)
    VALUES (id, comment_id);
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_content_notification(notified_id INTEGER, content_item_id INTEGER)
RETURNS INTEGER AS
$BODY$
DECLARE
    id INTEGER;
BEGIN
    id := create_notification(notified_id);
    INSERT INTO content_notification (id, content_item_id)
    VALUES (id, content_item_id);

    RETURN id;
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_upvote_notification(notified_id INTEGER, content_item_id INTEGER, amount INTEGER)
RETURNS VOID AS
$BODY$
DECLARE
    id INTEGER;
BEGIN
    id := create_content_notification(notified_id, content_item_id);
    INSERT INTO upvote_notification (id, amount)
    VALUES (id, amount);
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_edit_notification(notified_id INTEGER, content_item_id INTEGER)
RETURNS VOID AS
$BODY$
DECLARE
    id INTEGER;
BEGIN
    id := create_content_notification(notified_id, content_item_id);
    INSERT INTO edit_notification (id)
    VALUES (id);
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_removal_notification(notified_id INTEGER, content_item_id INTEGER)
RETURNS VOID AS
$BODY$
DECLARE
    id INTEGER;
BEGIN
    id := create_content_notification(notified_id, content_item_id);
    INSERT INTO removal_notification (id)
    VALUES (id);
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_undefined_topic_notification(notified_id INTEGER, content_item_id INTEGER)
RETURNS VOID AS
$BODY$
DECLARE
    id INTEGER;
BEGIN
    id := create_content_notification(notified_id, content_item_id);
    INSERT INTO undefined_topic_notification (id)
    VALUES (id);
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_block_notification(notified_id INTEGER)
RETURNS VOID AS
$BODY$
DECLARE
    id INTEGER;
BEGIN
    id := create_notification(notified_id);
    INSERT INTO block_notification (id)
    VALUES (id);
END
$BODY$
LANGUAGE plpgsql;

CREATE FUNCTION create_follow_notification(notified_id INTEGER, follower_id INTEGER)
RETURNS VOID AS
$BODY$
DECLARE
    id INTEGER;
BEGIN
    id := create_notification(notified_id);
    INSERT INTO follow_notification (id, follower_id)
    VALUES (id, follower_id);
END
$BODY$
LANGUAGE plpgsql;



SELECT create_imdb_info('movie', 'tt0111161');
SELECT create_imdb_info('movie', 'tt0068646');
SELECT create_imdb_info('name', 'tt0071562');

INSERT INTO profile_image (id, file_name) VALUES (0, 'default.jpg');
SELECT create_profile_image('profile_image_1.jpg');
SELECT create_profile_image('profile_image_2.jpg');
SELECT create_profile_image('profile_image_3.jpg');

SELECT create_member('harvey.specter@popcornpost.com', 'password', 'harveyspecter', 'Harvey', 'Specter', 'When you are backed against the wall, break the goddamn thing down.');
SELECT create_member('mike.ross@popcornpost.com', 'password', 'mikeross', 'Mike', 'Ross', 'The Rules Dictate That You Must Be Precise As The Law Is A Precise Endeavor.');
SELECT create_member('donna.paulsen@popcornpost.com', 'password', 'donnapaulsen', 'Donna', 'Paulsen', 'I am too busy being a badass and worrying about my hair');
SELECT create_member('louis.litt@popcorpost.com', 'password', 'louislitt', 'Louis', 'Litt', 'Mud and cats... mud and cats...');
SELECT create_admin('jessica.pearson@popcornpost.com', 'password', 'jessicapearson', 'Jessica', 'Pearson', 'I deal with children on a daily basis.');
SELECT create_member('harold.jakowski@popcornpost.com', 'password', 'haroldjakowski', 'Harold', 'Jakowski', NULL);

SELECT create_follow_member(1,2);
SELECT create_follow_member(1,3);
SELECT create_follow_member(1,5);
SELECT create_follow_member(2,1);
SELECT create_follow_member(2,3);
SELECT create_follow_member(2,5);
SELECT create_follow_member(3,1);
SELECT create_follow_member(3,2);
SELECT create_follow_member(3,4);
SELECT create_follow_member(3,5);
SELECT create_follow_member(4,1);

INSERT INTO topic (id, name) VALUES (0, 'Undefined');
SELECT create_topic('Review');
SELECT create_topic('Leaks');
SELECT create_topic('Interview');
SELECT create_topic('Analysis');
SELECT create_topic('Announcement');

SELECT create_topic_suggestion('Awards', 'Pending', 1);
SELECT create_topic_suggestion('Rumors', 'Pending', 3);
SELECT create_topic_suggestion('Drama', 'Rejected', 4);
UPDATE topic_suggestion SET status = 'Accepted' WHERE id = 2;

SELECT create_article('The Godfather: A Cinematic Masterpiece that Suits Every Taste', 'Francis Ford Coppola''s ''The Godfather'' is an undeniable masterpiece that transcends time. Released in 1972, this cinematic gem continues to captivate audiences worldwide. Marlon Brando''s iconic portrayal of Don Vito Corleone, along with Al Pacino, James Caan, and Robert Duvall''s stellar performances, has left an indelible mark on the history of cinema. The film''s narrative intricacy, compelling characters, and a hauntingly beautiful score by Nino Rota make it an immersive experience. ''The Godfather'' doesn''t just tell a story; it immerses you in the complex world of the Italian-American mafia. From its unforgettable opening scene to the iconic ''offer you can''t refuse,'' the film''s dialogue and cinematography are a work of art. With a flawless blend of crime, family, and morality, ''The Godfather'' is not just a film; it''s a cinematic journey through the dark alleys of power and loyalty. A must-see for cinephiles and a timeless classic.', 1, 1, 1);
SELECT create_article('Defending the Silver Screen: Hollywood''s Legal Dramas', 'In the world of legal dramas, Hollywood has always been a courtroom where gripping stories are tried and tested. From Atticus Finch''s unwavering moral compass in To Kill a Mockingbird to the charismatic maneuvers of Daniel Kaffee in A Few Good Men, the silver screen has presented us with a gallery of memorable attorneys. But it''s not just about the lawyers; it''s about the riveting cases they take on, the intense cross-examinations, and the moral dilemmas that keep us on the edge of our seats. So, let''s embark on a cinematic journey through the hallowed halls of justice. We''ll explore some of the most iconic legal thrillers, dissect the courtroom strategies, and maybe even find a lesson or two in the fine art of persuasion. As Harvey Specter would say, It''s not about the law; it''s about the game.', 1, 5, NULL);
SELECT create_article('Donna Paulsen unveils Donna Paulsen''s show - Suits', 'Donna Paulsen, the sharp-witted and stylish legal powerhouse known for her role in ''Suits,'' has graciously decided to reveal some exclusive behind-the-scenes insights into the beloved legal drama series that captivated audiences worldwide. ''Suits,'' the hit TV show that aired for nine gripping seasons, showcased Donna Paulsen''s character, played by Sarah Rafferty, as a central figure in the high-stakes world of Manhattan law firms. Now, Donna steps off the screen and into our world to share anecdotes, trivia, and personal experiences from her time on set. In this revealing article, Donna discusses the camaraderie among the cast, the meticulous attention to detail in recreating a high-powered law firm atmosphere, and some of the unforgettable moments that made ''Suits'' an iconic show. Donna''s stories, peppered with her characteristic charm and wit, provide fans with an exclusive look into the making of ''Suits.'' Discover the inspiration behind the characters, the challenges faced during filming, and how this legal drama became a fan-favorite. If you''re a die-hard ''Suits'' fan or simply intrigued by the inner workings of the entertainment industry, Donna Paulsen''s insights into the world of ''Suits'' are a must-read. Get ready to step behind the curtain and explore the magic that brought ''Suits'' to life on your screens.', 3, 2, 2);
SELECT create_article('Luis Litt''s Favorite Movie: A Lesson in Tenacity', 'Hey, it''s me, Luis Litt! The man with the charm, the style, and the legal prowess that makes the world spin. But today, I''m not here to talk about my legal victories. I want to take a moment to share with you my all-time favorite movie, a film that embodies the spirit of never giving up and fighting for what you believe in. The movie that holds a special place in my heart is none other than "Rocky"! Directed by John G. Avildsen and starring Sylvester Stallone, this cinematic masterpiece is a tale of resilience, determination, and the unyielding human spirit. "Rocky" is not just a boxing movie; it''s a story of an underdog who defied all odds. Just like me in the world of law, Rocky Balboa rose from obscurity to take on the heavyweight champion of the world, Apollo Creed. The parallels are uncanny. Rocky, a small-time boxer from Philadelphia, goes the distance with Creed and doesn''t give up, no matter how tough the fight gets. The character of Rocky Balboa represents the essence of tenacity, and that''s something I can truly appreciate. In the courtroom, I''ve faced numerous challenges and adversaries, but I always stand my ground and fight for justice. Just like Rocky, I''m not one to back down from a challenge. The film also showcases the importance of mentorship, as Rocky''s relationship with his trainer, Mickey, is a source of inspiration. It reminds me of the guidance I received from Harvey Specter.  Stay strong, keep pushing forward, and never forget, it''s not about how hard you hit; it''s about how hard you can get hit and keep moving forward. That''s how winning is done. - Luis Litt', 4, 4, NULL);

SELECT create_article_image('article_image_1.jpg', 1);
SELECT create_article_image('article_image_2.jpg', 1);
SELECT create_article_image('article_image_3.jpg', 1);
SELECT create_article_image('article_image_4.jpg', 3);
SELECT create_article_image('article_image_5.jpg', 3);
SELECT create_article_image('article_image_6.jpg', 4);

SELECT create_tag('godfather');
SELECT create_tag('suits');
SELECT create_tag('donna_paulsen');
SELECT create_tag('basketball');
SELECT create_tag('opera');

SELECT create_tag_article(1, 1);
SELECT create_tag_article(2, 3);
SELECT create_tag_article(3, 3);

SELECT create_follow_tag(1, 1);
SELECT create_follow_tag(1, 2);
SELECT create_follow_tag(2, 1);
SELECT create_follow_tag(2, 2);
SELECT create_follow_tag(2, 3);
SELECT create_follow_tag(2, 4);
SELECT create_follow_tag(2, 5);
SELECT create_follow_tag(3, 3);
SELECT create_follow_tag(4, 1);
SELECT create_follow_tag(5, 3);
SELECT create_follow_tag(5, 4);

SELECT create_comment('I love this movie! It is a masterpiece!', 2, FALSE, 1, NULL);
SELECT create_comment('I have seen better...', 4, TRUE, 1, 5);
SELECT create_comment('I have read better articles', 4, FALSE, 1, NULL);
SELECT create_comment('Louis... cut it out.', 3, TRUE, 1, 5);
SELECT create_comment('Fantastic work, I wish more people shared this view.', 5, FALSE, 2, NULL);
SELECT create_comment('I do share this view as well.', 2, TRUE, 2, 9);
SELECT create_comment('Only you to write an article about yourself.', 1, FALSE, 3, NULL);
SELECT create_comment('Wow... just, wow...', 2, TRUE, 3, 11);
SELECT create_comment('Wonderful read!', 4, FALSE, 3, NULL);

SELECT create_edit('title', 'Donna Paulsen unveils the Donna Paulsen ', 'Donna Paulsen Uncovers Exclusive Behind-the-Scenes Secrets of ''Suits''', 3, 5);
UPDATE article SET title = 'Donna Paulsen Uncovers Exclusive Behind-the-Scenes Secrets of ''Suits''' WHERE id = 3;

UPDATE article SET topic_id = 0 WHERE id = 3;

SELECT create_edit('body', 'I love this movie! It is a masterpiece!', 'I love this movie!', 5, 2);
UPDATE content_item SET body = 'I love this movie!' WHERE id = 5;

SELECT create_vote(2, 1, 1);
SELECT create_vote(3, 1, 1);
SELECT create_vote(4, 1, -1);
SELECT create_vote(5, 1, -1);
SELECT create_vote(2, 2, 1);
SELECT create_vote(3, 2, 1);
SELECT create_vote(4, 2, -1);
SELECT create_vote(1, 3, 1);
SELECT create_vote(2, 3, 1);
SELECT create_vote(4, 3, 1);
SELECT create_vote(5, 3, 1);
SELECT create_vote(6, 3, 1);
SELECT create_vote(3, 4, 1);
SELECT create_vote(1, 4, -1);
SELECT create_vote(1, 5, 1);
SELECT create_vote(1, 6, -1);
SELECT create_vote(2, 6, -1);
SELECT create_vote(3, 6, -1);
SELECT create_vote(5, 6, -1);
SELECT create_vote(1, 7, -1);
SELECT create_vote(2, 7, -1);
SELECT create_vote(2, 8, 1);
SELECT create_vote(5, 8, 1);
SELECT create_vote(1, 9, 1);
SELECT create_vote(3, 11, 1);
SELECT create_vote(3, 12, 1);
SELECT create_vote(3, 13, 1);

SELECT create_upvote_notification(3, 3, 5);

SELECT create_content_report(NULL, 1, 'Misinformation', 4);

SELECT create_member_report('This member is a disgrace to the legal profession.', 4, 'InnapropriateContent', 1);

UPDATE content_item SET is_deleted = TRUE WHERE id = 4;
SELECT create_edit('is_deleted', 'FALSE', 'TRUE', 4, 5);

UPDATE member SET is_blocked = TRUE WHERE id = 4;

SELECT create_appeal('I did not do anything wrong, I demand to be unblocked!', 4);
