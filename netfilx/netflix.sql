--이메일 본인인증을 위한 단독 테이블
CREATE TABLE certification
(
	`no` INT(11) primary key,
	`pass` varchar(32)
);

-- users Table Create SQL
CREATE TABLE users
(
    `users_num`  INT            NOT NULL    AUTO_INCREMENT COMMENT '������ȣ', 
    `id`         VARCHAR(50)    NOT NULL    COMMENT '���̵�', 
    `pwd`        VARCHAR(30)    NOT NULL    COMMENT '��й�ȣ', 
    `birth`      INT            NOT NULL    COMMENT '�ֹε�Ϲ�ȣ', 
    `point`      INT            NULL        COMMENT '����Ʈ', 
    PRIMARY KEY (users_num)
);

ALTER TABLE users COMMENT '����';

ALTER TABLE users
    ADD CONSTRAINT UC_id UNIQUE (id);


-- profile_img Table Create SQL
CREATE TABLE profile_img
(
    `pimg_num`  INT             NOT NULL    AUTO_INCREMENT COMMENT '�������̹�����ȣ', 
    `pimg_src`  VARCHAR(100)    NOT NULL    COMMENT '�������̹����ּ�', 
    PRIMARY KEY (pimg_num)
);

ALTER TABLE profile_img COMMENT '�������̹���';


-- profile Table Create SQL
CREATE TABLE profile
(
    `profile_num`      INT            NOT NULL    AUTO_INCREMENT COMMENT '�����ʹ�ȣ', 
    `nickname`         VARCHAR(20)    NOT NULL    COMMENT '�г���', 
    `users_num`        INT            NOT NULL    COMMENT '������ȣ', 
    `pimg_num`         INT            NOT NULL    COMMENT '�������̹�����ȣ', 
    `profile_age`      INT            NOT NULL    COMMENT '�����ʿ���', 
    `profile_pwd`      VARCHAR(10)    NOT NULL    COMMENT '�����ʺ�й�ȣ', 
    `profile_first`    TINYINT        NOT NULL    COMMENT '��ǥ������', 
    `profile_regdate`  DATE           NOT NULL    COMMENT '������', 
    PRIMARY KEY (profile_num)
);

ALTER TABLE profile COMMENT '������ ��ǥ ���ϴ°� �߰��ؾ��ϴµ�..';

ALTER TABLE profile ADD CONSTRAINT FK_profile_users_num_users_users_num FOREIGN KEY (users_num)
 REFERENCES users (users_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE profile ADD CONSTRAINT FK_profile_pimg_num_profile_img_pimg_num FOREIGN KEY (pimg_num)
 REFERENCES profile_img (pimg_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- staff Table Create SQL
CREATE TABLE staff
(
    `staff_num`       INT            NOT NULL    AUTO_INCREMENT COMMENT '���ǹ�ȣ', 
    `staff_position`  TINYINT        NOT NULL    COMMENT '���/����', 
    `staff_name`      VARCHAR(45)    NOT NULL    COMMENT '�̸�', 
    `staff_age`       INT            NOT NULL    COMMENT '����', 
    `staff_gender`    VARCHAR(10)    NOT NULL    COMMENT '����', 
    PRIMARY KEY (staff_num)
);

ALTER TABLE staff COMMENT '����';


-- category Table Create SQL
CREATE TABLE category
(
    `category_num`   INT            NOT NULL    AUTO_INCREMENT COMMENT '������ȣ', 
    `category_name`  VARCHAR(20)    NOT NULL    COMMENT '������', 
    PRIMARY KEY (category_num)
);

ALTER TABLE category COMMENT 'ī�װ�';


-- series Table Create SQL
CREATE TABLE series
(
    `series_num`   INT             NOT NULL    AUTO_INCREMENT COMMENT '�ø����ȣ', 
    `series_name`  VARCHAR(100)    NOT NULL    COMMENT '�ø����', 
    `season`       VARCHAR(100)    NOT NULL    COMMENT '����', 
    PRIMARY KEY (series_num)
);

ALTER TABLE series COMMENT '�ø���';


-- content Table Create SQL
CREATE TABLE content
(
    `content_num`      INT              NOT NULL    AUTO_INCREMENT COMMENT '��������ȣ', 
    `content_name`     VARCHAR(50)      NOT NULL    COMMENT '��������', 
    `orgsrc`           VARCHAR(100)     NOT NULL    COMMENT '�������', 
    `savesrc`          VARCHAR(100)     NOT NULL    COMMENT '������', 
    `content_sunmer`   VARCHAR(1000)    NOT NULL    COMMENT '�ٰŸ�', 
    `trailer_orgsrc`   VARCHAR(100)     NOT NULL    COMMENT '������������', 
    `trailer_savesrc`  VARCHAR(100)     NOT NULL    COMMENT '������������', 
    `content_size`     INT              NOT NULL    COMMENT '����������ũ��', 
    `trailer_size`     INT              NOT NULL    COMMENT '����������ũ��', 
    `content_post1`    VARCHAR(100)     NOT NULL    COMMENT '����Ʈ���1', 
    `content_post2`    VARCHAR(100)     NOT NULL    COMMENT '����Ʈ���2', 
    `release`          DATE             NOT NULL    COMMENT '����/�濵��', 
    `category_num`     INT              NOT NULL    COMMENT '������ȣ', 
    `watch_age`        INT              NOT NULL    COMMENT '��û����', 
    `content_regdate`  DATE             NOT NULL    COMMENT '�����', 
    `series_num`       INT              NOT NULL    COMMENT '�ø����ȣ', 
    `staff_num`        INT              NOT NULL    COMMENT '���ǹ�ȣ', 
    PRIMARY KEY (content_num)
);

ALTER TABLE content COMMENT '������';

ALTER TABLE content ADD CONSTRAINT FK_content_category_num_category_category_num FOREIGN KEY (category_num)
 REFERENCES category (category_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE content ADD CONSTRAINT FK_content_series_num_series_series_num FOREIGN KEY (series_num)
 REFERENCES series (series_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE content ADD CONSTRAINT FK_content_staff_num_staff_staff_num FOREIGN KEY (staff_num)
 REFERENCES staff (staff_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- survey Table Create SQL
CREATE TABLE survey
(
    `survey_num`      INT             NOT NULL    AUTO_INCREMENT COMMENT '������ȣ', 
    `survey_name`     VARCHAR(100)    NOT NULL    COMMENT '������', 
    `survey_start`    DATE            NOT NULL    COMMENT '����������', 
    `survey_end`      DATE            NOT NULL    COMMENT '����������', 
    `users_num`       INT             NOT NULL    COMMENT '������ȣ', 
    `survey_content`  VARCHAR(500)    NOT NULL    COMMENT '��������', 
    PRIMARY KEY (survey_num)
);

ALTER TABLE survey COMMENT '����';

ALTER TABLE survey ADD CONSTRAINT FK_survey_users_num_users_users_num FOREIGN KEY (users_num)
 REFERENCES users (users_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- survey_question Table Create SQL
CREATE TABLE survey_question
(
    `sq_num`      INT             NOT NULL    AUTO_INCREMENT COMMENT '������ȣ', 
    `sq_content`  VARCHAR(500)    NOT NULL    COMMENT '��������', 
    `survey_num`  INT             NOT NULL    COMMENT '������ȣ', 
    `sq_type`     INT             NOT NULL    COMMENT '����Ÿ��', 
    PRIMARY KEY (sq_num)
);

ALTER TABLE survey_question COMMENT '��������';

ALTER TABLE survey_question ADD CONSTRAINT FK_survey_question_survey_num_survey_survey_num FOREIGN KEY (survey_num)
 REFERENCES survey (survey_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- content_comment Table Create SQL
CREATE TABLE content_comment
(
    `comment_num`   INT             NOT NULL    AUTO_INCREMENT COMMENT '��������۹�ȣ', 
    `comment`       VARCHAR(500)    NOT NULL    COMMENT '���', 
    `c_lev`         INT             NOT NULL    COMMENT 'c_lev', 
    `c_step`        INT             NOT NULL    COMMENT 'c_step', 
    `content_num`   INT             NOT NULL    COMMENT '��������ȣ', 
    `profile_num`   INT             NOT NULL    COMMENT '�����ʹ�ȣ', 
    `comment_open`  TINYINT         NOT NULL    COMMENT '����/�����', 
    `bookmark`      TINYINT         NOT NULL    COMMENT 'å��������', 
    PRIMARY KEY (comment_num)
);

ALTER TABLE content_comment COMMENT '�ڸ�Ʈ';

ALTER TABLE content_comment ADD CONSTRAINT FK_content_comment_content_num_content_content_num FOREIGN KEY (content_num)
 REFERENCES content (content_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE content_comment ADD CONSTRAINT FK_content_comment_profile_num_profile_profile_num FOREIGN KEY (profile_num)
 REFERENCES profile (profile_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- grade Table Create SQL
CREATE TABLE grade
(
    `grade_num`    INT            NOT NULL    AUTO_INCREMENT COMMENT '��޹�ȣ', 
    `grade_name`   VARCHAR(20)    NOT NULL    COMMENT '��޸�', 
    `grade_price`  VARCHAR(5)     NOT NULL    COMMENT '��ް���', 
    PRIMARY KEY (grade_num)
);

ALTER TABLE grade COMMENT '���';


-- alarm_info Table Create SQL
CREATE TABLE alarm_info
(
    `alarm_num`      INT             NOT NULL    AUTO_INCREMENT COMMENT '�˶�������ȣ', 
    `alarm_content`  VARCHAR(500)    NOT NULL    COMMENT '�˶���������', 
    `alarm_date`     DATE            NOT NULL    COMMENT '�˸���', 
    PRIMARY KEY (alarm_num)
);

ALTER TABLE alarm_info COMMENT '�˶�����';


-- genre Table Create SQL
CREATE TABLE genre
(
    `genre_num`     INT            NOT NULL    AUTO_INCREMENT COMMENT '�帣��ȣ', 
    `genre_name`    VARCHAR(45)    NOT NULL    COMMENT '�帣��', 
    `category_num`  INT            NOT NULL    COMMENT '������ȣ', 
    PRIMARY KEY (genre_num)
);

ALTER TABLE genre COMMENT '�帣';

ALTER TABLE genre ADD CONSTRAINT FK_genre_category_num_category_category_num FOREIGN KEY (category_num)
 REFERENCES category (category_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- qna Table Create SQL
CREATE TABLE qna
(
    `qna_num`      INT              NOT NULL    AUTO_INCREMENT COMMENT '���ǹ�ȣ', 
    `qna_title`    VARCHAR(100)     NOT NULL    COMMENT '��������', 
    `qna_content`  VARCHAR(1000)    NOT NULL    COMMENT '���ǳ���', 
    `qna_regdate`  DATE             NOT NULL    COMMENT '���ǰԽ���', 
    `qna_open`     TINYINT          NOT NULL    COMMENT '����/�����', 
    `lev`          INT              NOT NULL    COMMENT 'lev', 
    `step`         INT              NOT NULL    COMMENT 'step', 
    `users_num`    INT              NULL        COMMENT '������ȣ', 
    PRIMARY KEY (qna_num)
);

ALTER TABLE qna COMMENT '���ǰԽ���';

ALTER TABLE qna ADD CONSTRAINT FK_qna_users_num_users_users_num FOREIGN KEY (users_num)
 REFERENCES users (users_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- count_limit Table Create SQL
CREATE TABLE count_limit
(
    `cl_num`     INT    NOT NULL    AUTO_INCREMENT COMMENT '��û���ѹ�ȣ', 
    `count`      INT    NOT NULL    COMMENT 'count', 
    `users_num`  INT    NOT NULL    COMMENT '������ȣ', 
    PRIMARY KEY (cl_num)
);

ALTER TABLE count_limit COMMENT '��û����';

ALTER TABLE count_limit ADD CONSTRAINT FK_count_limit_users_num_users_users_num FOREIGN KEY (users_num)
 REFERENCES users (users_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- survey_in Table Create SQL
CREATE TABLE survey_in
(
    `si_num`      INT    NOT NULL    AUTO_INCREMENT COMMENT '�������ι�ȣ', 
    `users_num`   INT    NOT NULL    COMMENT '������ȣ', 
    `survey_num`  INT    NOT NULL    COMMENT '������ȣ', 
    PRIMARY KEY (si_num)
);

ALTER TABLE survey_in COMMENT '��������';

ALTER TABLE survey_in ADD CONSTRAINT FK_survey_in_users_num_users_users_num FOREIGN KEY (users_num)
 REFERENCES users (users_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE survey_in ADD CONSTRAINT FK_survey_in_survey_num_survey_survey_num FOREIGN KEY (survey_num)
 REFERENCES survey (survey_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- pay_info Table Create SQL
CREATE TABLE pay_info
(
    `pay_num`    INT            NOT NULL    AUTO_INCREMENT COMMENT '������ȣ', 
    `pay_start`  DATE           NOT NULL    COMMENT '������', 
    `pay_end`    DATE           NOT NULL    COMMENT '������', 
    `payment`    VARCHAR(15)    NOT NULL    COMMENT '�������', 
    `users_num`  INT            NOT NULL    COMMENT '������ȣ', 
    `grade_num`  INT            NOT NULL    COMMENT '��޹�ȣ', 
    PRIMARY KEY (pay_num)
);

ALTER TABLE pay_info COMMENT '���� ��ġ';

ALTER TABLE pay_info ADD CONSTRAINT FK_pay_info_users_num_users_users_num FOREIGN KEY (users_num)
 REFERENCES users (users_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE pay_info ADD CONSTRAINT FK_pay_info_grade_num_grade_grade_num FOREIGN KEY (grade_num)
 REFERENCES grade (grade_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- good Table Create SQL
CREATE TABLE good
(
    `good_num`     INT    NOT NULL    AUTO_INCREMENT COMMENT '���ƿ�ѹ�', 
    `comment_num`  INT    NOT NULL    COMMENT '��������۹�ȣ', 
    `profile_num`  INT    NOT NULL    COMMENT '�����ʹ�ȣ', 
    PRIMARY KEY (good_num)
);

ALTER TABLE good COMMENT '���ƿ�';

ALTER TABLE good ADD CONSTRAINT FK_good_comment_num_content_comment_comment_num FOREIGN KEY (comment_num)
 REFERENCES content_comment (comment_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE good ADD CONSTRAINT FK_good_profile_num_profile_profile_num FOREIGN KEY (profile_num)
 REFERENCES profile (profile_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- record Table Create SQL
CREATE TABLE record
(
    `record_num`   INT     NOT NULL    AUTO_INCREMENT COMMENT '��û��Ϲ�ȣ', 
    `next_watch`   TIME    NOT NULL    COMMENT '�̾��', 
    `total_time`   TIME    NOT NULL    COMMENT '������û�ð�', 
    `profile_num`  INT     NOT NULL    COMMENT '�����ʹ�ȣ', 
    `content_num`  INT     NOT NULL    COMMENT '��������ȣ', 
    PRIMARY KEY (record_num)
);

ALTER TABLE record COMMENT '��û���';

ALTER TABLE record ADD CONSTRAINT FK_record_profile_num_profile_profile_num FOREIGN KEY (profile_num)
 REFERENCES profile (profile_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE record ADD CONSTRAINT FK_record_content_num_content_content_num FOREIGN KEY (content_num)
 REFERENCES content (content_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- interasts Table Create SQL
CREATE TABLE interasts
(
    `interasts_num`  INT    NOT NULL    AUTO_INCREMENT COMMENT '���ȣ', 
    `profile_num`    INT    NOT NULL    COMMENT '�����ʹ�ȣ', 
    `content_num`    INT    NOT NULL    COMMENT '��������ȣ', 
    PRIMARY KEY (interasts_num)
);

ALTER TABLE interasts COMMENT '�򿵻�';

ALTER TABLE interasts ADD CONSTRAINT FK_interasts_profile_num_profile_profile_num FOREIGN KEY (profile_num)
 REFERENCES profile (profile_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE interasts ADD CONSTRAINT FK_interasts_content_num_content_content_num FOREIGN KEY (content_num)
 REFERENCES content (content_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- rates Table Create SQL
CREATE TABLE rates
(
    `rates_num`    INT      NOT NULL    AUTO_INCREMENT COMMENT '������ȣ', 
    `rates_score`  FLOAT    NOT NULL    COMMENT '������', 
    `profile_num`  INT      NOT NULL    COMMENT '�����ʹ�ȣ', 
    `content_num`  INT      NOT NULL    COMMENT '��������ȣ', 
    PRIMARY KEY (rates_num)
);

ALTER TABLE rates COMMENT '����';

ALTER TABLE rates ADD CONSTRAINT FK_rates_profile_num_profile_profile_num FOREIGN KEY (profile_num)
 REFERENCES profile (profile_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE rates ADD CONSTRAINT FK_rates_content_num_content_content_num FOREIGN KEY (content_num)
 REFERENCES content (content_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- survey_answer Table Create SQL
CREATE TABLE survey_answer
(
    `sa_num`     INT             NOT NULL    AUTO_INCREMENT COMMENT '�亯��ȣ', 
    `sa_answer`  VARCHAR(500)    NOT NULL    COMMENT '�����亯', 
    `sq_num`     INT             NOT NULL    COMMENT '������ȣ', 
    PRIMARY KEY (sa_num)
);

ALTER TABLE survey_answer COMMENT '�����亯';

ALTER TABLE survey_answer ADD CONSTRAINT FK_survey_answer_sq_num_survey_question_sq_num FOREIGN KEY (sq_num)
 REFERENCES survey_question (sq_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- survey_result Table Create SQL
CREATE TABLE survey_result
(
    `sr_num`     INT             NOT NULL    AUTO_INCREMENT COMMENT '���������ȣ', 
    `sq_num`     INT             NOT NULL    COMMENT '������ȣ', 
    `sr_answer`  VARCHAR(500)    NOT NULL    COMMENT '�亯', 
    PRIMARY KEY (sr_num)
);

ALTER TABLE survey_result COMMENT '�������';

ALTER TABLE survey_result ADD CONSTRAINT FK_survey_result_sq_num_survey_question_sq_num FOREIGN KEY (sq_num)
 REFERENCES survey_question (sq_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- content_genre Table Create SQL
CREATE TABLE content_genre
(
    `cgenre_num`   INT    NOT NULL    AUTO_INCREMENT COMMENT '�������帣��ȣ', 
    `content_num`  INT    NOT NULL    COMMENT '��������ȣ', 
    `genre_num`    INT    NOT NULL    COMMENT '�帣��ȣ', 
    PRIMARY KEY (cgenre_num)
);

ALTER TABLE content_genre COMMENT '�������帣';

ALTER TABLE content_genre ADD CONSTRAINT FK_content_genre_content_num_content_content_num FOREIGN KEY (content_num)
 REFERENCES content (content_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE content_genre ADD CONSTRAINT FK_content_genre_genre_num_genre_genre_num FOREIGN KEY (genre_num)
 REFERENCES genre (genre_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- static_question Table Create SQL
CREATE TABLE static_question
(
    `stq_num`      INT             NOT NULL    AUTO_INCREMENT COMMENT '�ڹ���ȣ', 
    `stq_title`    VARCHAR(100)    NOT NULL    COMMENT '�ڹ�����', 
    `stq_content`  VARCHAR(100)    NOT NULL    COMMENT '�ڹ�����', 
    `stq_hit`      INT             NOT NULL    COMMENT '�ڹ���ȸ��', 
    PRIMARY KEY (stq_num)
);

ALTER TABLE static_question COMMENT '���ֹ�������';


-- survey_content Table Create SQL
CREATE TABLE survey_content
(
    `sc_num`      INT            NOT NULL    AUTO_INCREMENT COMMENT '���������ȣ', 
    `sc_`         VARCHAR(45)    NOT NULL    COMMENT '���ϰ��', 
    `survey_num`  INT            NOT NULL    COMMENT '������ȣ', 
    PRIMARY KEY (sc_num)
);

ALTER TABLE survey_content COMMENT '��������';

ALTER TABLE survey_content ADD CONSTRAINT FK_survey_content_survey_num_survey_survey_num FOREIGN KEY (survey_num)
 REFERENCES survey (survey_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- bookmark Table Create SQL
CREATE TABLE bookmark
(
    `bookmark_num`   INT     NOT NULL    AUTO_INCREMENT COMMENT 'å���ǹ�ȣ', 
    `comment_num`    INT     NOT NULL    COMMENT '��������۹�ȣ', 
    `bookmark_time`  TIME    NOT NULL    COMMENT 'å���ǽð�', 
    PRIMARY KEY (bookmark_num)
);

ALTER TABLE bookmark COMMENT 'å����';

ALTER TABLE bookmark ADD CONSTRAINT FK_bookmark_comment_num_content_comment_comment_num FOREIGN KEY (comment_num)
 REFERENCES content_comment (comment_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- content_staff Table Create SQL
CREATE TABLE content_staff
(
    `cs_num`       INT    NOT NULL    AUTO_INCREMENT COMMENT '���������ܹ�ȣ', 
    `staff_num`    INT    NOT NULL    COMMENT '���ǹ�ȣ', 
    `content_num`  INT    NOT NULL    COMMENT '��������ȣ', 
    PRIMARY KEY (cs_num)
);

ALTER TABLE content_staff COMMENT '���������ܹ�';

ALTER TABLE content_staff ADD CONSTRAINT FK_content_staff_staff_num_staff_staff_num FOREIGN KEY (staff_num)
 REFERENCES staff (staff_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE content_staff ADD CONSTRAINT FK_content_staff_content_num_content_content_num FOREIGN KEY (content_num)
 REFERENCES content (content_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- alarm_user Table Create SQL
CREATE TABLE alarm_user
(
    `au_num`       INT        NOT NULL    AUTO_INCREMENT COMMENT '�˶�����ڹ�ȣ', 
    `alarm_num`    INT        NOT NULL    COMMENT '�˶�������ȣ', 
    `alarm_state`  TINYINT    NOT NULL    COMMENT '����', 
    `profile_num`  INT        NOT NULL    COMMENT '�����ʹ�ȣ', 
    PRIMARY KEY (au_num)
);

ALTER TABLE alarm_user COMMENT '�˶������';

ALTER TABLE alarm_user ADD CONSTRAINT FK_alarm_user_alarm_num_alarm_info_alarm_num FOREIGN KEY (alarm_num)
 REFERENCES alarm_info (alarm_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE alarm_user ADD CONSTRAINT FK_alarm_user_profile_num_profile_profile_num FOREIGN KEY (profile_num)
 REFERENCES profile (profile_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- report Table Create SQL
CREATE TABLE report
(
    `report_num`      INT             NOT NULL    AUTO_INCREMENT COMMENT '�Ű�����ȣ', 
    `profile_num`     INT             NOT NULL    COMMENT '�����ʹ�ȣ', 
    `report_content`  VARCHAR(100)    NOT NULL    COMMENT '�Ű���', 
    `survey_num`      INT             NOT NULL    COMMENT '������ȣ', 
    PRIMARY KEY (report_num)
);

ALTER TABLE report COMMENT '�Ű���';

ALTER TABLE report ADD CONSTRAINT FK_report_survey_num_survey_survey_num FOREIGN KEY (survey_num)
 REFERENCES survey (survey_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE report ADD CONSTRAINT FK_report_profile_num_profile_profile_num FOREIGN KEY (profile_num)
 REFERENCES profile (profile_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;