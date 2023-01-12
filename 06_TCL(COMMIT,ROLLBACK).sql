-- TCL(TRANSACTION CONTROL LANGUAGE) : 트랜잭션 제어 언어
-- COMMIT(트랜잭션 종료 후 저장), ROLLBACK(트랜잭션 취소), SAVEPOINT(임시 저장);


-- DML(INSERT, UPDATE, DELETE) 관련 되어 있다.
-- 배고프다
/* TRANSACTION이란?
 * - 데이터베이스 논리적 연산 단위
 * --> 데이터베이스의 상태를 변화 시키기 위해서, 수행하는 작업 단위
 * 
 * - 데이터 변경 사항(DML)을 묶어 하나의 트랜잭션에 담아서 처리한다.
 * 
 * - 트랜잭션의 대상이 되는 데이터 변경 사항 : INSERT, UPDATE, DELETE(DML) + MERGE
 * 
 * 
 * EX) INSERT 수행 ----------------------------------> DB에 반영된다? 아님
 *  
 * 실제로는 INSERT 수행 --> 트랜잭션 추가 --> COMMIT --> DB반영
 * 
 * IF INSERT 10번 수행 --> 트랜잭션 1개에 10개가 추가됨 --> ROLLBACK --> 10개 전부 다 반영 X
 * 
 * 
 * 
 * 1) COMMIT : 메모리 버퍼(트랜잭션)에 임시 저장된 데이터 변경 사항을 DB에 반영
 * 
 * 2) ROLLBACK : 메모리 버퍼(트랜잭션)에 임시 저장된 데이터 변경 사항을 삭제 하고, 
 *              마지막 COMMIT 상태(시점)으로 돌아간다. --> DB에 반영 안 됨
 * 
 * 3) SAVEPOINT : 메모리 버퍼(트랜잭션)에 저장 지점을 정의하여, 
 * 					ROLLBACK 수행 시, 전체 작업을 삭제하는 것이 아닌,
 * 					저장 지점까지만 일부 ROLLBACK
 * 
 * [SAVEPOINT 사용법]
 * 
 * SAVEPOINT 포인트명1;
 * .....
 * SAVEPOINT 포인트명2;
 * .....
 * ROLLBACK TO 포인트명1; --> 포인트명1 지점으로 돌아감 
 * --> 포인트1 지점까지 데이터 변경사항 삭제.
 * */




-- 테이블 복사 구문


SELECT *
FROM DEPARTMENT2;


-- 새로운 데이터 INSERT 하기

INSERT INTO DEPARTMENT2 VALUES('T1','개발1팀','L2');
INSERT INTO DEPARTMENT2 VALUES('T2','개발2팀','L2');
INSERT INTO DEPARTMENT2 VALUES('T3','개발3팀','L2');

--> DB에 반영이 안 된 상태
--> SQL 수행 시, 메모리 버퍼(트랜잭션)에 임시 저장된 상태

ROLLBACK;


-- COMMIT 해보자


COMMIT;

--> DB에 반영이 된 상태
--> ROLLBACK 안 됨


-- SAVEPOINT 확인 용도

INSERT INTO DEPARTMENT2 VALUES('T4','개발4팀','L2');
SAVEPOINT SP1; -- SAVEPOINT 지정

INSERT INTO DEPARTMENT2 VALUES('T5','개발5팀','L2');
SAVEPOINT SP2;

INSERT INTO DEPARTMENT2 VALUES('T6','개발6팀','L2');
SAVEPOINT SP3;


ROLLBACK TO SP1; 
-- SP1으로 돌아가고, SP2, SP3 돌아갈 순 없다.






