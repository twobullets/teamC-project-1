-- ȸ������ ���̺�
create table users
(
	u_no     int auto_increment           comment 'ȸ����ȣ', -- ȸ����ȣ
	u_name   varchar(50) not null         comment '�̸�', -- �̸�
	id       varchar(50) unique not null  comment '���̵�', -- ���̵�
	pw       varchar(50) not null         comment '��й�ȣ', -- ��й�ȣ
	nick     varchar(50) unique not null  comment '�г���', -- �г���
	admin    boolean                      comment '�����ڿ���', -- ������ ����
	primary key (u_no)
);

-- �Խ��� ���̺�
create table board
(
	u_no     int               					comment 'ȸ����ȣ', -- ȸ����ȣ
	no       int auto_increment					comment '�Խù���ȣ', -- �Խù���ȣ
	title    varchar(255)       			    comment '����', -- ����
	content  text         		      			comment '����', -- ����
	wdate    datetime default current_timestamp comment '�ۼ�����', -- �ۼ�����
	originF  varchar(200)       				comment '�������ϸ�', -- ��������
	realF	 varchar(200)                       comment '�������ϸ�', -- ��������
	hit      int  default 0     				comment '��ȸ��', -- ��ȸ��
	foreign key (u_no) references users(u_no),
	primary key (no)
);

-- ��� ���̺�
create table reply
(
	u_no      int                comment 'ȸ����ȣ', -- ȸ����ȣ
	no        int                comment '�Խù���ȣ', -- �Խù���ȣ
	r_no      int auto_increment comment '��۹�ȣ', -- ��۹�ȣ
	r_date    datetime           comment '�ۼ���', -- �ۼ���
	r_content varchar(200)       comment '����', -- ����
	foreign key (u_no) references users(u_no),
	foreign key (no)   references board(no),
	primary key (r_no)
);
