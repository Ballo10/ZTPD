-- 1
drop table MOVIES;
create table MOVIES (
    ID NUMBER(12) PRIMARY KEY,
    TITLE VARCHAR2(200) NOT NULL,
    CATEGORY VARCHAR2(50),
    YEAR CHAR(4),
    CAST VARCHAR2(4000),
    DIRECTORY VARCHAR2(4000),
    STORY VARCHAR2(4000),
    PRICE NUMBER(5,2),
    COVER BLOB,
    MIME_TYPE VARCHAR2(50)
);

select descriptions.* from descriptions;
select * from covers;
select * FROM MOVIES;

describe descriptions

-- 2
--SELECT descriptions.id, descriptions.TITLE, descriptions.CATEGORY, descriptions.YEAR, descriptions.CAST, descriptions.DIRECTOR, descriptions.STORY, descriptions.PRICE, covers.IMAGE, covers.MIME_TYPE
INSERT INTO MOVIES
SELECT descriptions.id, descriptions.TITLE, descriptions.CATEGORY, TRIM(descriptions.YEAR), descriptions.CAST, descriptions.DIRECTOR, descriptions.STORY, descriptions.PRICE, covers.IMAGE, covers.MIME_TYPE
        from descriptions
        FULL OUTER JOIN covers ON descriptions.id = covers.MOVIE_ID
        WHERE descriptions.id < 67;
        
-- 3
SELECT TITLE FROM MOVIES
WHERE  COVER IS NULL;

-- 4
SELECT TITLE, length(COVER) as "FILESIZE" FROM MOVIES
WHERE  COVER IS NOT NULL;

-- 5
SELECT TITLE, length(COVER) as "FILESIZE" FROM MOVIES
WHERE  COVER IS NULL;

-- 6

SELECT * FROM ALL_DIRECTORIES;

-- 7

UPDATE MOVIES
SET COVER = EMPTY_BLOB(),
MIME_TYPE = 'image/jpeg'
WHERE ID LIKE 66;

-- 8
SELECT TITLE, length(COVER) as "FILESIZE", ID FROM MOVIES
WHERE ID > 64;

-- 9

DECLARE
lobd blob;
fils BFILE := BFILENAME('ZSBD_DIR','escape.jpg');
BEGIN

SELECT cover INTO lobd
FROM MOVIES
where id like 66

FOR UPDATE;
DBMS_LOB.fileopen(fils, DBMS_LOB.file_readonly);
DBMS_LOB.LOADFROMFILE(lobd,fils,DBMS_LOB.GETLENGTH(fils));
DBMS_LOB.FILECLOSE(fils);
COMMIT;
END;


-- 10
DROP TABLE TEMP_COVERS;
CREATE TABLE TEMP_COVERS (
 movie_id NUMBER(12),
 image BFILE,
 mime_type VARCHAR2(50)
)

-- 11
DECLARE
lobd blob;
fils BFILE := BFILENAME('ZSBD_DIR','eagles.jpg');
BEGIN
INSERT INTO TEMP_COVERS(movie_id, image, mime_type)
VALUES (65, fils, 'image/jpeg');
COMMIT;
END;

-- 12
SELECT * FROM TEMP_COVERS;
SELECT MOVIE_ID, DBMS_LOB.GETLENGTH(IMAGE) FROM TEMP_COVERS;

-- 13

DECLARE
fils BFILE;
m_type VARCHAR2(50);
tlob blob;
BEGIN

SELECT image INTO fils
FROM TEMP_COVERS
where movie_id=66;

SELECT mime_type INTO m_type
FROM TEMP_COVERS
WHERE MOVIE_ID=66

FOR UPDATE;
DBMS_LOB.fileopen(fils, DBMS_LOB.file_readonly);
DBMS_LOB.LOADFROMFILE(tlob,fils,DBMS_LOB.GETLENGTH(fils));
DBMS_LOB.FILECLOSE(fils);

UPDATE MOVIES
SET cover = tlob,
MIME_TYPE = m_type;
COMMIT;
END;