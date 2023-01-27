-- 1
CREATE TABLE dokumenty(
ID NUMBER(12) PRIMARY KEY,
DOKUMENT CLOB);

-- 2
DECLARE
counter NUMBER:= 1;
tekst CLOB := '';
BEGIN
    LOOP
        counter := counter + 1;
        tekst := CONCAT(tekst, 'Oto tekst.');
        if counter > 10000 then
            exit;
        END IF;
    END LOOP;
    INSERT INTO dokumenty values(1,tekst);
END;

-- 3
SELECT * FROM dokumenty;
SELECT UPPER(dokument) from dokumenty;
SELECT LENGTH(dokument) from dokumenty;
SELECT DBMS_LOB.getlength(dokument) from dokumenty;
SELECT SUBSTR(dokument,1000,5) from dokumenty;
SELECT DBMS_LOB.substr(dokument,1000,5) from dokumenty;

-- 4
INSERT INTO dokumenty values(2, '');

-- 5
INSERT INTO dokumenty values(3, NULL);
COMMIT;

-- 6
SELECT * FROM dokumenty;

-- 7
SELECT DIRECTORY_NAME,DIRECTORY_PATH FROM ALL_DIRECTORIES;

-- 8
DECLARE
    lobd CLOB;
    fils BFILE := BFILENAME('ZSBD_DIR', 'dokument.txt');
    doffset integer := 1;
    soffset integer := 1;
    langctx integer := 0;
    warn integer := null;
BEGIN    
    SELECT dokument INTO lobd from dokumenty WHERE id=2
    FOR UPDATE;
    
    DBMS_LOB.fileopen(fils, DBMS_LOB.file_readonly);
    DBMS_LOB.LOADCLOBFROMFILE(lobd, fils, DBMS_LOB.GETLENGTH(fils),doffset, soffset, 873, langctx, warn);
    DBMS_LOB.FILECLOSE(fils);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Status operacji: '||warn);
END;

SELECT * FROM dokumenty WHERE ID=2;

-- 9
UPDATE dokumenty
SET dokument = TO_CLOB(BFILENAME('ZSBD_DIR','dokument.txt'),873)
WHERE ID=3;

-- 10
SELECT * FROM dokumenty;

-- 11
SELECT id, LENGTH(DOKUMENT) FROM dokumenty;

-- 12
DROP TABLE DOKUMENTY

-- 13

CREATE OR REPLACE PROCEDURE CLOB_CENSOR
(
first_arg IN OUT CLOB,
second_arg IN varchar2
) IS
    position number;
    replacement varchar2(100) := '...................................................................................................';
BEGIN
    LOOP
        position := DBMS_LOB.INSTR(first_arg, second_arg);        
        IF position=0 THEN
            EXIT;
        END IF;
        DBMS_LOB.WRITE(first_arg, length(second_arg), position, replacement);
    END LOOP;
END;

CREATE TABLE BIOGRAPHIES_COPY
AS SELECT * FROM ZSBD_TOOLS.BIOGRAPHIES;

SELECT * FROM BIOGRAPHIES_COPY;

-- 14
DECLARE
    biography clob;
BEGIN
    SELECT BIO INTO biography FROM BIOGRAPHIES_COPY FOR UPDATE;
    CLOB_CENSOR(biography, 'Cimrman');
    COMMIT;
END;

-- 15
DROP TABLE BIOGRAPHIES_COPY;