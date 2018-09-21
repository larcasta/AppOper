CREATE OR REPLACE PACKAGE CTS.PK_BIPUBLISHER AS 
  TYPE GENERIC_ARRAY is varray(2) of varchar2(255);
  TYPE GENERIC_ARRAY_TYPE IS TABLE OF GENERIC_ARRAY;
  
  /* TODO enter package declarations (types, exceptions, methods etc) here */ 
  FUNCTION F_CALL_REPORT(pw_filename VARCHAR2,
                         pw_format VARCHAR2,
                         pw_bireport VARCHAR2,
                         pw_array GENERIC_ARRAY_TYPE) RETURN VARCHAR2;

END PK_BIPUBLISHER;
/


CREATE OR REPLACE PUBLIC SYNONYM PK_BIPUBLISHER FOR CTS.PK_BIPUBLISHER;
