DROP TABLE S01;
DROP TABLE S02;
DROP TABLE S03;
DROP TABLE S04;
DROP TABLE S05;


DROP TABLE SURVEY;
DROP TABLE WORKER CASCADE CONSTRAINTS;
DROP TABLE DEPARTMENT CASCADE CONSTRAINTS;

CREATE TABLE department(
    dno VARCHAR2(5) PRIMARY KEY ,
    dname VARCHAR2(16) NOT NULL , 
    CONSTRAINT chk_dno CHECK ( dno IN ( 'A', 'B', 'C', 'D', 'E' 
) )
) ;
-- 부서입력
INSERT INTO DEPARTMENT
VALUES ('A', '1팀');

INSERT INTO DEPARTMENT
VALUES ('B', '2팀');

INSERT INTO DEPARTMENT
VALUES ('C', '3팀');

INSERT INTO DEPARTMENT
VALUES ('D', '4팀');

INSERT INTO DEPARTMENT
VALUES ('E', '5팀');


CREATE TABLE worker(
    id VARCHAR2(5) PRIMARY KEY,
    name VARCHAR2(10) NOT NULL,
    dept VARCHAR2(10),
    addr VARCHAR2(10)
);
ALTER TABLE worker
ADD CONSTRAINT FK_dept FOREIGN KEY(dept)
REFERENCES department(dno);

-- 사원입력36명 A-7 B-6 C-10 D-5 E-8 
INSERT INTO WORKER
VALUES ('E001', '이우찬', 'D', '안양');

INSERT INTO WORKER
VALUES ('E002', '양석원', 'D', '건대');

INSERT INTO WORKER
VALUES ('E003', '최규성', 'D', '의정부');

INSERT INTO WORKER
VALUES ('E004', '정진산', 'D', '서울');

INSERT INTO WORKER
VALUES ('E005', '김선우', 'A', '서울');

INSERT INTO WORKER
VALUES ('E006', '권혁태', 'B', '대전');

INSERT INTO WORKER
VALUES ('E007', '김동환', 'E', '대구');

INSERT INTO WORKER
VALUES ('E008', '김성빈', 'C', '부산');

INSERT INTO WORKER
VALUES ('E009', '김소영', 'A', '목포');

INSERT INTO WORKER
VALUES ('E010', '민병욱', 'E', '서울');

INSERT INTO WORKER
VALUES ('E011', '박시연', 'C', '대전');

INSERT INTO WORKER
VALUES ('E012', '박인욱', 'C', '대구');

INSERT INTO WORKER
VALUES ('E013', '박태민', 'B', '목포');

INSERT INTO WORKER
VALUES ('E014', '안수민', 'A', '부산');

INSERT INTO WORKER
VALUES ('E015', '이예진', 'C', '서울');

INSERT INTO WORKER
VALUES ('E016', '임진희', 'A', '대전');

INSERT INTO WORKER
VALUES ('E017', '주민수', 'B', '대구');

INSERT INTO WORKER
VALUES ('E018', '주해연', 'B', '부산');

INSERT INTO WORKER
VALUES ('E019', '하주성', 'E', '서울');

CREATE TABLE survey(
    code VARCHAR2(5) PRIMARY KEY,
    title VARCHAR2(50) NOT NULL,
    memo VARCHAR2(100),
    state VARCHAR2(10) NOT NULL 
    CONSTRAINT chk_state CHECK ( state IN ( 'READY' , 'ONGOING' 
, 'COMPLETE' ) ) ,
    cre_date DATE NOT NULL ,
    start_date DATE ,
    end_date DATE 
) ;

desc worker;


--설문지 샘플
CREATE TABLE S01(
    rater VARCHAR2(5) REFERENCES worker(id) on delete cascade,
    ratee VARCHAR2(5) REFERENCES worker(id) on delete cascade,
    인성 NUMBER(3),
    먹성 NUMBER(3),
    성실성 NUMBER(3),
    CONSTRAINT pk_S01 PRIMARY KEY( rater , ratee )
);
Insert Into SURVEY (code, state, title, memo, cre_date )
values ('S01', 'READY', '최고의 팀원', '재미로 하는 
평가입니다.', SYSTIMESTAMP);


CREATE TABLE S02(
    rater VARCHAR2(5) REFERENCES worker(id) on delete cascade,
    ratee VARCHAR2(5) REFERENCES worker(id) on delete cascade,
    자바 NUMBER(3),
    오라클 NUMBER(3),
    CONSTRAINT pk_S02 PRIMARY KEY( rater , ratee )
);
Insert Into SURVEY (code, state, title, memo, cre_date )
values ('S02', 'READY', '두번째설문', '교육 성취도에 관한 설문', 
SYSTIMESTAMP);


CREATE TABLE S03(
    rater VARCHAR2(5) REFERENCES worker(id) on delete cascade,
    ratee VARCHAR2(5) REFERENCES worker(id) on delete cascade,
    열정 NUMBER(3),
    노력 NUMBER(3),
    끈기 NUMBER(3),
    능력 NUMBER(3),
    CONSTRAINT pk_S03 PRIMARY KEY( rater , ratee )
);
Insert Into SURVEY (code, state, title, memo, cre_date )
values ('S03', 'READY', '세번째설문', '학습과정에서의 설문', 
SYSTIMESTAMP);

CREATE TABLE S04(
    rater VARCHAR2(5) REFERENCES worker(id) on delete cascade,
    ratee VARCHAR2(5) REFERENCES worker(id) on delete cascade,
    열정 NUMBER(3),
    노력 NUMBER(3),
    끈기 NUMBER(3),
    능력 NUMBER(3),
    CONSTRAINT pk_S04 PRIMARY KEY( rater , ratee )
);
Insert Into SURVEY (code, state, title, memo, cre_date )
values ('S04', 'READY', '네번째설문', '테스트용 설문', 
SYSTIMESTAMP);


commit;

SELECT * FROM SURVEY;
SELECT * FROM WORKER;