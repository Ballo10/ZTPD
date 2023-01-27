-- 1
-- A
CREATE TABLE FIGURY(
    ID NUMBER(1) PRIMARY KEY,
    KSZTALT MDSYS.SDO_GEOMETRY
);

-- B
INSERT INTO FIGURY VALUES(
    1, MDSYS.SDO_GEOMETRY(
    2003,
    NULL,
    NULL,
    MDSYS.SDO_ELEM_INFO_ARRAY(1, 1003, 4),
    MDSYS.SDO_ORDINATE_ARRAY(3,5, 5,7, 7,5)
    )
);

INSERT INTO FIGURY VALUES(
    2, MDSYS.SDO_GEOMETRY(
    2003,
    NULL,
    NULL,
    MDSYS.SDO_ELEM_INFO_ARRAY(1, 1003, 3),
    MDSYS.SDO_ORDINATE_ARRAY(1,1, 5,5)
    )
);

INSERT INTO FIGURY VALUES(
  3, MDSYS.SDO_GEOMETRY(
    2002,
    NULL,
    NULL,
    MDSYS.SDO_ELEM_INFO_ARRAY(1,4,2, 1,2,1, 5,2,2),
    MDSYS.SDO_ORDINATE_ARRAY(3,2, 6,2, 7,3, 8,2, 7,1)
  )
);

SELECT * FROM FIGURY;

-- C
INSERT INTO FIGURY VALUES(
    4, MDSYS.SDO_GEOMETRY(
    2003,
    NULL,
    NULL,
    MDSYS.SDO_ELEM_INFO_ARRAY(1, 1003, 4),
    MDSYS.SDO_ORDINATE_ARRAY(3,5, 4,5, 5,5)
    )
);

-- D
SELECT ID, SDO_GEOM.VALIDATE_GEOMETRY_WITH_CONTEXT(KSZTALT, 0.005) FROM FIGURY;

-- E
DELETE FROM FIGURY
WHERE ID=4;

-- F
COMMIT;