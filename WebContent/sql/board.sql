-- 회원정보 테이블
create table users
(
	u_no     int auto_increment           comment '회원번호', -- 회원번호
	u_name   varchar(50) not null         comment '이름', -- 이름
	id       varchar(50) unique not null  comment '아이디', -- 아이디
	pw       varchar(50) not null         comment '비밀번호', -- 비밀번호
	nick     varchar(50) unique not null  comment '닉네임', -- 닉네임
	admin    boolean                      comment '관리자여부', -- 관리자 여부
	primary key (u_no)
);

-- 게시판 테이블
create table board
(
	u_no     int               					comment '회원번호', -- 회원번호
	no       int auto_increment					comment '게시물번호', -- 게시물번호
	title    varchar(255)       			    comment '제목', -- 제목
	content  text         		      			comment '내용', -- 내용
	wdate    datetime default current_timestamp comment '작성일자', -- 작성일자
	originF  varchar(200)       				comment '원본파일명', -- 원본파일
	realF	 varchar(200)                       comment '실제파일명', -- 실제파일
	hit      int  default 0     				comment '조회수', -- 조회수
	foreign key (u_no) references users(u_no),
	primary key (no)
);

-- 댓글 테이블
create table reply
(
	u_no      int                comment '회원번호', -- 회원번호
	no        int                comment '게시물번호', -- 게시물번호
	r_no      int auto_increment comment '댓글번호', -- 댓글번호
	r_date    datetime           comment '작성일', -- 작성일
	r_content varchar(200)       comment '내용', -- 내용
	foreign key (u_no) references users(u_no),
	foreign key (no)   references board(no),
	primary key (r_no)
);
