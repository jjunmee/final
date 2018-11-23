-- 테이블 순서는 관계를 고려하여 한 번에 실행해도 에러가 발생하지 않게 정렬되었습니다.
-- trigger 마지막에 추가 --
delimiter //
create trigger alarm_tr after insert on content for each row
begin
	declare no int;
    DECLARE done INT DEFAULT FALSE;
    declare  cur cursor for (select distinct B.profile_num from content A, interasts B where A.content_num = B.content_num AND A.series_num = new.series_num)union(select distinct B.profile_num from content A, record B where A.content_num = B.content_num AND A.series_num = new.series_num);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    if new.series_num != 0 then 
      set @num = (select ifnull(max(alarm_num)+1,1) from alarm_info);
      insert into alarm_info values(@num,new.content_name, now(),new.content_num);
      open cur;
	  recom_loop:Loop
	  fetch  cur into no;
	  if done then
       LEAVE recom_loop;
	  end if;	
      insert into alarm_user values(0,@num,0,no);
      end Loop;
    close cur;
   end if;
end
//
delimiter ;

-- profile_group Table Create SQL
CREATE TABLE profile_group
(
    `pro_group_no`    INT            NOT NULL    AUTO_INCREMENT COMMENT '기본키', 
    `pro_group_name`  VARCHAR(45)    NULL        COMMENT '명칭', 
    PRIMARY KEY (pro_group_no)
);

ALTER TABLE profile_group COMMENT '프로필 분류';


-- users Table Create SQL
CREATE TABLE users
(
    `users_num`  INT             NOT NULL    AUTO_INCREMENT COMMENT '유저번호', 
    `id`         VARCHAR(50)     NOT NULL    COMMENT '아이디', 
    `pwd`        VARCHAR(30)     NOT NULL    COMMENT '비밀번호', 
    `birth`      DATE            NOT NULL    COMMENT '주민등록번호', 
    `point`      INT             NULL        COMMENT '포인트', 
    `sts`        INT             NOT NULL    COMMENT '상태값', 
    `pwd2`       VARCHAR(450)    NOT NULL    COMMENT '비밀번호', 
    PRIMARY KEY (users_num)
);

ALTER TABLE users COMMENT '유저';

ALTER TABLE users
    ADD CONSTRAINT UC_id UNIQUE (id);


-- profile_img Table Create SQL
CREATE TABLE profile_img
(
    `pimg_num`      INT             NOT NULL    AUTO_INCREMENT COMMENT '프로필이미지번호', 
    `pro_group_no`  INT             NOT NULL    COMMENT '그룹 번호', 
    `pimg_src`      VARCHAR(100)    NOT NULL    COMMENT '프로필이미지주소', 
    PRIMARY KEY (pimg_num)
);

ALTER TABLE profile_img COMMENT '프로필이미지';

ALTER TABLE profile_img ADD CONSTRAINT FK_profile_img_pro_group_no_profile_group_pro_group_no FOREIGN KEY (pro_group_no)
 REFERENCES profile_group (pro_group_no)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- profile Table Create SQL
CREATE TABLE profile
(
    `profile_num`      INT            NOT NULL    AUTO_INCREMENT COMMENT '프로필번호', 
    `nickname`         VARCHAR(20)    NOT NULL    COMMENT '닉네임', 
    `users_num`        INT            NOT NULL    COMMENT '유저번호', 
    `pimg_num`         INT            NOT NULL    COMMENT '프로필이미지번호', 
    `profile_age`      INT            NOT NULL    COMMENT '프로필연령', 
    `profile_pwd`      VARCHAR(10)    NOT NULL    COMMENT '프로필비밀번호', 
    `profile_first`    TINYINT        NOT NULL    COMMENT '대표프로필', 
    `profile_regdate`  DATE           NOT NULL    COMMENT '생성일', 
    PRIMARY KEY (profile_num)
);

ALTER TABLE profile COMMENT '프로필 대표 정하는거 추가해야하는데..';

ALTER TABLE profile ADD CONSTRAINT FK_profile_users_num_users_users_num FOREIGN KEY (users_num)
 REFERENCES users (users_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE profile ADD CONSTRAINT FK_profile_pimg_num_profile_img_pimg_num FOREIGN KEY (pimg_num)
 REFERENCES profile_img (pimg_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- content Table Create SQL
CREATE TABLE content
(
    `content_num`      INT              NOT NULL    COMMENT '컨텐츠번호', 
    `content_name`     VARCHAR(50)      NOT NULL    COMMENT '컨텐츠명', 
    `orgsrc`           VARCHAR(100)     NOT NULL    COMMENT '원본경로', 
    `savesrc`          VARCHAR(100)     NOT NULL    COMMENT '저장경로', 
    `content_summary`  VARCHAR(1000)    NOT NULL    COMMENT '줄거리', 
    `trailer_orgsrc`   VARCHAR(100)     NOT NULL    COMMENT '예고편원본경로', 
    `trailer_savesrc`  VARCHAR(100)     NOT NULL    COMMENT '예고편저장경로', 
    `content_size`     INT              NOT NULL    COMMENT '컨텐츠파일크기', 
    `trailer_size`     INT              NOT NULL    COMMENT '예고편파일크기', 
    `content_post1`    VARCHAR(100)     NOT NULL    COMMENT '포스트경로1', 
    `content_post2`    VARCHAR(100)     NOT NULL    COMMENT '포스트경로2', 
    `release_date`     DATE             NOT NULL    COMMENT '개봉/방영일', 
    `watch_age`        INT              NOT NULL    COMMENT '시청연령', 
    `content_regdate`  DATE             NOT NULL    COMMENT '등록일', 
    `series_num`       INT              NOT NULL    COMMENT '시리즈번호', 
    PRIMARY KEY (content_num)
);

ALTER TABLE content COMMENT '컨텐츠';


-- survey Table Create SQL
CREATE TABLE survey
(
    `surveyNum`          INT             NOT NULL    AUTO_INCREMENT COMMENT '설문번호', 
    `userNum`            INT             NOT NULL    COMMENT '유저번호', 
    `surveyName`         VARCHAR(100)    NOT NULL    COMMENT '설문명', 
    `surveyDescription`  VARCHAR(100)    NOT NULL    COMMENT '설문설명', 
    `surveyStart`        DATE            NOT NULL    COMMENT '설문시작일', 
    `surveyEnd`          DATE            NOT NULL    COMMENT '설문종료일', 
    `spoint`             INT             NOT NULL    COMMENT '설문결제포인트', 
    `joinNum`            INT             NOT NULL    COMMENT '참여인원', 
    `state`              VARCHAR(20)     NOT NULL    COMMENT '설문상태', 
    PRIMARY KEY (surveyNum)
);

ALTER TABLE survey COMMENT '설문';

ALTER TABLE survey ADD CONSTRAINT FK_survey_userNum_users_users_num FOREIGN KEY (userNum)
 REFERENCES users (users_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- survey_question Table Create SQL
CREATE TABLE survey_question
(
    `sqNum`      INT             NOT NULL    AUTO_INCREMENT COMMENT '질문번호', 
    `surveyNum`  INT             NOT NULL    COMMENT '설문번호', 
    `sqTitle`    VARCHAR(500)    NOT NULL    COMMENT '질문제목', 
    `sqType`     INT             NOT NULL    COMMENT '질문타입', 
    PRIMARY KEY (sqNum)
);

ALTER TABLE survey_question COMMENT '설문질문';

ALTER TABLE survey_question ADD CONSTRAINT FK_survey_question_surveyNum_survey_surveyNum FOREIGN KEY (surveyNum)
 REFERENCES survey (surveyNum)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- content_comment Table Create SQL
CREATE TABLE content_comment
(
    `comment_num`   INT             NOT NULL    AUTO_INCREMENT COMMENT '컨텐츠댓글번호', 
    `comment`       VARCHAR(500)    NOT NULL    COMMENT '댓글', 
    `c_lev`         INT             NOT NULL    COMMENT 'c_lev', 
    `c_step`        INT             NOT NULL    COMMENT 'c_step', 
    `content_num`   INT             NOT NULL    COMMENT '컨텐츠번호', 
    `profile_num`   INT             NOT NULL    COMMENT '프로필번호', 
    `comment_open`  TINYINT         NOT NULL    COMMENT '공개/비공개', 
    `bookmark`      TINYINT         NOT NULL    COMMENT '책갈피유무', 
    PRIMARY KEY (comment_num)
);

ALTER TABLE content_comment COMMENT '코멘트';

ALTER TABLE content_comment ADD CONSTRAINT FK_content_comment_content_num_content_content_num FOREIGN KEY (content_num)
 REFERENCES content (content_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE content_comment ADD CONSTRAINT FK_content_comment_profile_num_profile_profile_num FOREIGN KEY (profile_num)
 REFERENCES profile (profile_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- category Table Create SQL
CREATE TABLE category
(
    `category_num`   INT            NOT NULL    AUTO_INCREMENT COMMENT '종류번호', 
    `category_name`  VARCHAR(20)    NOT NULL    COMMENT '종류명', 
    PRIMARY KEY (category_num)
);

ALTER TABLE category COMMENT '카테고리';


-- grade Table Create SQL
CREATE TABLE grade
(
    `grade_num`    INT            NOT NULL    AUTO_INCREMENT COMMENT '등급번호', 
    `grade_name`   VARCHAR(20)    NOT NULL    COMMENT '등급명', 
    `grade_price`  VARCHAR(5)     NOT NULL    COMMENT '등급가격', 
    PRIMARY KEY (grade_num)
);

ALTER TABLE grade COMMENT '등급';


-- alarm_info Table Create SQL
CREATE TABLE alarm_info
(
    `alarm_num`      INT             NOT NULL    COMMENT '알람정보번호', 
    `alarm_content`  VARCHAR(500)    NOT NULL    COMMENT '알람정보내용', 
    `alarm_date`     DATE            NOT NULL    COMMENT '알림일', 
    `content_num`    INT             NOT NULL    COMMENT '콘텐츠번호', 
    PRIMARY KEY (alarm_num)
);

ALTER TABLE alarm_info COMMENT '알람정보';


-- genre Table Create SQL
CREATE TABLE genre
(
    `genre_num`     INT            NOT NULL    AUTO_INCREMENT COMMENT '장르번호', 
    `genre_name`    VARCHAR(45)    NOT NULL    COMMENT '장르명', 
    `category_num`  INT            NOT NULL    COMMENT '종류번호', 
    PRIMARY KEY (genre_num)
);

ALTER TABLE genre COMMENT '장르';

ALTER TABLE genre ADD CONSTRAINT FK_genre_category_num_category_category_num FOREIGN KEY (category_num)
 REFERENCES category (category_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- staff Table Create SQL
CREATE TABLE staff
(
    `staff_num`       INT            NOT NULL    AUTO_INCREMENT COMMENT '스탭번호', 
    `staff_position`  TINYINT        NOT NULL    COMMENT '배우/감독', 
    `staff_name`      VARCHAR(45)    NOT NULL    COMMENT '이름', 
    `staff_age`       INT            NOT NULL    COMMENT '나이', 
    `staff_gender`    VARCHAR(10)    NOT NULL    COMMENT '성별', 
    `staff_debut`     VARCHAR(45)    NOT NULL    COMMENT '데뷔작', 
    PRIMARY KEY (staff_num)
);

ALTER TABLE staff COMMENT '스탭';


-- qna Table Create SQL
CREATE TABLE qna
(
    `qna_num`      INT              NOT NULL    AUTO_INCREMENT COMMENT '문의번호', 
    `qna_title`    VARCHAR(100)     NOT NULL    COMMENT '문의제목', 
    `qna_content`  VARCHAR(1000)    NOT NULL    COMMENT '문의내용', 
    `qna_regdate`  DATE             NOT NULL    COMMENT '문의게시일', 
    `qna_open`     TINYINT          NOT NULL    COMMENT '공개/비공개', 
    `lev`          INT              NOT NULL    COMMENT 'lev', 
    `step`         INT              NOT NULL    COMMENT 'step', 
    `users_num`    INT              NULL        COMMENT '유저번호', 
    PRIMARY KEY (qna_num)
);

ALTER TABLE qna COMMENT '문의게시판';

ALTER TABLE qna ADD CONSTRAINT FK_qna_users_num_users_users_num FOREIGN KEY (users_num)
 REFERENCES users (users_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- count_limit Table Create SQL
CREATE TABLE count_limit
(
    `cl_num`     INT    NOT NULL    AUTO_INCREMENT COMMENT '시청제한번호', 
    `count`      INT    NOT NULL    COMMENT 'count', 
    `users_num`  INT    NOT NULL    COMMENT '유저번호', 
    PRIMARY KEY (cl_num)
);

ALTER TABLE count_limit COMMENT '시청제한';

ALTER TABLE count_limit ADD CONSTRAINT FK_count_limit_users_num_users_users_num FOREIGN KEY (users_num)
 REFERENCES users (users_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- survey_in Table Create SQL
CREATE TABLE survey_in
(
    `siNum`      INT    NOT NULL    AUTO_INCREMENT COMMENT '설문여부번호', 
    `userNum`    INT    NOT NULL    COMMENT '유저번호', 
    `surveyNum`  INT    NOT NULL    COMMENT '설문번호', 
    PRIMARY KEY (siNum)
);

ALTER TABLE survey_in COMMENT '설문여부';

ALTER TABLE survey_in ADD CONSTRAINT FK_survey_in_userNum_users_users_num FOREIGN KEY (userNum)
 REFERENCES users (users_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE survey_in ADD CONSTRAINT FK_survey_in_surveyNum_survey_surveyNum FOREIGN KEY (surveyNum)
 REFERENCES survey (surveyNum)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- pay_info Table Create SQL
CREATE TABLE pay_info
(
    `pay_num`    INT            NOT NULL    AUTO_INCREMENT COMMENT '결제번호', 
    `pay_start`  DATE           NOT NULL    COMMENT '시작일', 
    `pay_end`    DATE           NOT NULL    COMMENT '만료일', 
    `payment`    VARCHAR(15)    NOT NULL    COMMENT '결제방법', 
    `users_num`  INT            NOT NULL    COMMENT '유저번호', 
    `grade_num`  INT            NOT NULL    COMMENT '등급번호', 
    PRIMARY KEY (pay_num)
);

ALTER TABLE pay_info COMMENT '만료 배치';

ALTER TABLE pay_info ADD CONSTRAINT FK_pay_info_users_num_users_users_num FOREIGN KEY (users_num)
 REFERENCES users (users_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE pay_info ADD CONSTRAINT FK_pay_info_grade_num_grade_grade_num FOREIGN KEY (grade_num)
 REFERENCES grade (grade_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- good Table Create SQL
CREATE TABLE good
(
    `good_num`     INT    NOT NULL    AUTO_INCREMENT COMMENT '좋아요넘버', 
    `comment_num`  INT    NOT NULL    COMMENT '컨텐츠댓글번호', 
    `profile_num`  INT    NOT NULL    COMMENT '프로필번호', 
    PRIMARY KEY (good_num)
);

ALTER TABLE good COMMENT '좋아요';

ALTER TABLE good ADD CONSTRAINT FK_good_comment_num_content_comment_comment_num FOREIGN KEY (comment_num)
 REFERENCES content_comment (comment_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE good ADD CONSTRAINT FK_good_profile_num_profile_profile_num FOREIGN KEY (profile_num)
 REFERENCES profile (profile_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- record Table Create SQL
CREATE TABLE record
(
    `record_num`   INT    NOT NULL    AUTO_INCREMENT COMMENT '시청기록번호', 
    `next_watch`   INT    NOT NULL    COMMENT '이어보기', 
    `total_time`   INT    NOT NULL    COMMENT '누적시청시간', 
    `profile_num`  INT    NOT NULL    COMMENT '프로필번호', 
    `content_num`  INT    NOT NULL    COMMENT '컨텐츠번호', 
    PRIMARY KEY (record_num)
);

ALTER TABLE record COMMENT '시청기록';

ALTER TABLE record ADD CONSTRAINT FK_record_profile_num_profile_profile_num FOREIGN KEY (profile_num)
 REFERENCES profile (profile_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE record ADD CONSTRAINT FK_record_content_num_content_content_num FOREIGN KEY (content_num)
 REFERENCES content (content_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- interasts Table Create SQL
CREATE TABLE interasts
(
    `interasts_num`  INT    NOT NULL    AUTO_INCREMENT COMMENT '찜번호', 
    `profile_num`    INT    NOT NULL    COMMENT '프로필번호', 
    `content_num`    INT    NOT NULL    COMMENT '컨텐츠번호', 
    PRIMARY KEY (interasts_num)
);

ALTER TABLE interasts COMMENT '찜영상';

ALTER TABLE interasts ADD CONSTRAINT FK_interasts_profile_num_profile_profile_num FOREIGN KEY (profile_num)
 REFERENCES profile (profile_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE interasts ADD CONSTRAINT FK_interasts_content_num_content_content_num FOREIGN KEY (content_num)
 REFERENCES content (content_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- rates Table Create SQL
CREATE TABLE rates
(
    `rates_num`    INT      NOT NULL    AUTO_INCREMENT COMMENT '평점번호', 
    `rates_score`  FLOAT    NOT NULL    COMMENT '평가점수', 
    `profile_num`  INT      NOT NULL    COMMENT '프로필번호', 
    `content_num`  INT      NOT NULL    COMMENT '컨텐츠번호', 
    PRIMARY KEY (rates_num)
);

ALTER TABLE rates COMMENT '평점';

ALTER TABLE rates ADD CONSTRAINT FK_rates_profile_num_profile_profile_num FOREIGN KEY (profile_num)
 REFERENCES profile (profile_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE rates ADD CONSTRAINT FK_rates_content_num_content_content_num FOREIGN KEY (content_num)
 REFERENCES content (content_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- survey_answer Table Create SQL
CREATE TABLE survey_answer
(
    `saNum`     INT             NOT NULL    AUTO_INCREMENT COMMENT '답변번호', 
    `sqNum`     INT             NOT NULL    COMMENT '질문번호', 
    `saAnswer`  VARCHAR(500)    NOT NULL    COMMENT '설문답변', 
    PRIMARY KEY (saNum)
);

ALTER TABLE survey_answer COMMENT '설문답변';

ALTER TABLE survey_answer ADD CONSTRAINT FK_survey_answer_sqNum_survey_question_sqNum FOREIGN KEY (sqNum)
 REFERENCES survey_question (sqNum)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- survey_result Table Create SQL
CREATE TABLE survey_result
(
    `srNum`     INT             NOT NULL    AUTO_INCREMENT COMMENT '설문결과번호', 
    `sqNum`     INT             NOT NULL    COMMENT '질문번호', 
    `srAnswer`  VARCHAR(500)    NOT NULL    COMMENT '답변', 
    PRIMARY KEY (srNum)
);

ALTER TABLE survey_result COMMENT '설문결과';

ALTER TABLE survey_result ADD CONSTRAINT FK_survey_result_sqNum_survey_question_sqNum FOREIGN KEY (sqNum)
 REFERENCES survey_question (sqNum)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- content_genre Table Create SQL
CREATE TABLE content_genre
(
    `cgenre_num`   INT    NOT NULL    AUTO_INCREMENT COMMENT '컨텐츠장르번호', 
    `content_num`  INT    NOT NULL    COMMENT '컨텐츠번호', 
    `genre_num`    INT    NOT NULL    COMMENT '장르번호', 
    PRIMARY KEY (cgenre_num)
);

ALTER TABLE content_genre COMMENT '컨텐츠장르';

ALTER TABLE content_genre ADD CONSTRAINT FK_content_genre_content_num_content_content_num FOREIGN KEY (content_num)
 REFERENCES content (content_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE content_genre ADD CONSTRAINT FK_content_genre_genre_num_genre_genre_num FOREIGN KEY (genre_num)
 REFERENCES genre (genre_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- static_question Table Create SQL
CREATE TABLE static_question
(
    `stq_num`      INT             NOT NULL    AUTO_INCREMENT COMMENT '자묻번호', 
    `stq_title`    VARCHAR(100)    NOT NULL    COMMENT '자묻제목', 
    `stq_content`  VARCHAR(100)    NOT NULL    COMMENT '자묻내용', 
    `stq_hit`      INT             NOT NULL    COMMENT '자묻조회수', 
    PRIMARY KEY (stq_num)
);

ALTER TABLE static_question COMMENT '자주묻는질문';


-- survey_video Table Create SQL
CREATE TABLE survey_video
(
    `svNum`      INT             NOT NULL    AUTO_INCREMENT COMMENT '설문영상번호', 
    `surveyNum`  INT             NOT NULL    COMMENT '설문번호', 
    `svOrgSrc`   VARCHAR(100)    NOT NULL    COMMENT '파일원본이름', 
    `svSaveSrc`  VARCHAR(100)    NOT NULL    COMMENT '파일저장이름', 
    PRIMARY KEY (svNum)
);

ALTER TABLE survey_video COMMENT '설문영상';

ALTER TABLE survey_video ADD CONSTRAINT FK_survey_video_surveyNum_survey_surveyNum FOREIGN KEY (surveyNum)
 REFERENCES survey (surveyNum)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- series Table Create SQL
CREATE TABLE series
(
    `series_num`   INT             NOT NULL    AUTO_INCREMENT COMMENT '시리즈번호', 
    `series_name`  VARCHAR(100)    NOT NULL    COMMENT '시리즈명', 
    `season`       VARCHAR(100)    NOT NULL    COMMENT '시즌', 
    PRIMARY KEY (series_num)
);

ALTER TABLE series COMMENT '시리즈';


-- bookmark Table Create SQL
CREATE TABLE bookmark
(
    `bookmark_num`   INT    NOT NULL    AUTO_INCREMENT COMMENT '책갈피번호', 
    `comment_num`    INT    NOT NULL    COMMENT '컨텐츠댓글번호', 
    `bookmark_time`  INT    NOT NULL    COMMENT '책갈피시간', 
    PRIMARY KEY (bookmark_num)
);

ALTER TABLE bookmark COMMENT '책갈피';

ALTER TABLE bookmark ADD CONSTRAINT FK_bookmark_comment_num_content_comment_comment_num FOREIGN KEY (comment_num)
 REFERENCES content_comment (comment_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- content_staff Table Create SQL
CREATE TABLE content_staff
(
    `cs_num`       INT    NOT NULL    AUTO_INCREMENT COMMENT '컨텐츠스텝번호', 
    `staff_num`    INT    NOT NULL    COMMENT '스탭번호', 
    `content_num`  INT    NOT NULL    COMMENT '컨텐츠번호', 
    PRIMARY KEY (cs_num)
);

ALTER TABLE content_staff COMMENT '컨텐츠스텝';

ALTER TABLE content_staff ADD CONSTRAINT FK_content_staff_staff_num_staff_staff_num FOREIGN KEY (staff_num)
 REFERENCES staff (staff_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE content_staff ADD CONSTRAINT FK_content_staff_content_num_content_content_num FOREIGN KEY (content_num)
 REFERENCES content (content_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- alarm_user Table Create SQL
CREATE TABLE alarm_user
(
    `au_num`       INT        NOT NULL    AUTO_INCREMENT COMMENT '알람사용자번호', 
    `alarm_num`    INT        NOT NULL    COMMENT '알람정보번호', 
    `alarm_state`  TINYINT    NOT NULL    COMMENT '상태', 
    `profile_num`  INT        NOT NULL    COMMENT '프로필번호', 
    PRIMARY KEY (au_num)
);

ALTER TABLE alarm_user COMMENT '알람사용자';

ALTER TABLE alarm_user ADD CONSTRAINT FK_alarm_user_alarm_num_alarm_info_alarm_num FOREIGN KEY (alarm_num)
 REFERENCES alarm_info (alarm_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE alarm_user ADD CONSTRAINT FK_alarm_user_profile_num_profile_profile_num FOREIGN KEY (profile_num)
 REFERENCES profile (profile_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- report Table Create SQL
CREATE TABLE report
(
    `report_num`      INT             NOT NULL    AUTO_INCREMENT COMMENT '신고내역번호', 
    `profile_num`     INT             NOT NULL    COMMENT '프로필번호', 
    `report_content`  VARCHAR(100)    NOT NULL    COMMENT '신고내용', 
    `survey_num`      INT             NOT NULL    COMMENT '설문번호', 
    PRIMARY KEY (report_num)
);

ALTER TABLE report COMMENT '신고내역';

ALTER TABLE report ADD CONSTRAINT FK_report_survey_num_survey_surveyNum FOREIGN KEY (survey_num)
 REFERENCES survey (surveyNum)  ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE report ADD CONSTRAINT FK_report_profile_num_profile_profile_num FOREIGN KEY (profile_num)
 REFERENCES profile (profile_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


-- certification Table Create SQL
CREATE TABLE certification
(
    `no`    INT(11)        NOT NULL    COMMENT '등록번호', 
    `pass`  VARCHAR(32)    NOT NULL    COMMENT 'key', 
    PRIMARY KEY (no)
);

ALTER TABLE certification COMMENT '이메일 본인인증 키';


-- point_info Table Create SQL
CREATE TABLE point_info
(
    `point_num`      INT             NOT NULL    AUTO_INCREMENT COMMENT '포인트번호', 
    `point_date`     DATE            NOT NULL    COMMENT '날짜', 
    `usage`          VARCHAR(100)    NOT NULL    COMMENT '사용내역', 
    `point_payment`  VARCHAR(15)     NOT NULL    COMMENT '결제방법', 
    `users_num`      INT             NOT NULL    COMMENT '유저번호', 
    PRIMARY KEY (point_num)
);

ALTER TABLE point_info COMMENT '포인트내역';

ALTER TABLE point_info ADD CONSTRAINT FK_point_info_users_num_users_users_num FOREIGN KEY (users_num)
 REFERENCES users (users_num)  ON DELETE RESTRICT ON UPDATE RESTRICT;


