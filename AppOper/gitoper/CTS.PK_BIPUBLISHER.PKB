CREATE OR REPLACE PACKAGE BODY CTS.PK_BIPUBLISHER AS

  FUNCTION P_CALL_BIPUBLISHER (pw_data VARCHAR2) RETURN VARCHAR2 IS
    /*
    Crea una conexion HTTP para enviar el mensaje JSON a la aplicacion MyHPH
    */
    
    /*ojito aqui*/
    t_http_req      UTL_HTTP.req;
    t_http_resp     UTL_HTTP.resp;
    t_request_body  VARCHAR2(32000);
    t_respond       VARCHAR2(30000);


  BEGIN
/*Esto es un comentario de ejemplo para el CVS*/
/*otro ejemplo*/
/**otro ejemplo*/
/*con git instalado*/
    t_http_req          := UTL_HTTP.begin_request('http://10.129.201.39:9030/wsBIpublisher/resources/biPublisher/generateReport', 'POST', 'HTTP/1.1');


      t_request_body := pw_data;
      UTL_HTTP.set_header(t_http_req, 'Content-Type', 'application/json;charset=UTF-8');
      UTL_HTTP.set_header(t_http_req, 'Content-Length', LENGTH(t_request_body));


      UTL_HTTP.write_text(t_http_req, t_request_body);
      t_http_resp         := UTL_HTTP.get_response(t_http_req);

      UTL_HTTP.read_text(t_http_resp, t_respond);


      UTL_HTTP.end_response(t_http_resp);
      
      RETURN t_respond;

  EXCEPTION
    WHEN OTHERS THEN
      UTL_HTTP.end_response(t_http_resp);
      RETURN '[P_CALL_BIPUBLISHER] ERROR WHEN OTHERS '||SQLERRM;
  END;

  FUNCTION F_CALL_REPORT(pw_filename VARCHAR2,
                         pw_format VARCHAR2,
                         pw_bireport VARCHAR2,
                         pw_array GENERIC_ARRAY_TYPE)  RETURN VARCHAR2 AS
    lw_size NUMBER;
    lw_message VARCHAR2(30000);
    lw_answer VARCHAR2(30000);
  BEGIN
    lw_size := pw_array.COUNT;
    
    lw_message := '
    {
    "absolutePath" : "/~weblogic/Rafael/CTSR3160.xdo",
    "filePath" : "/Oracle/config/domains/Hph12cDomain/tmp/'||pw_filename||'",
    "format" : "'||pw_format||'",
    "locale" : "EN-US",
    "passWord" : "welcome1",
    "reportParam" : [
        {
            "parameterName" : "p_traffic",
            "parameterValue" : "IMPO"
        },
        {
            "parameterName" : "p_period",
            "parameterValue" : "2015-DEC-"
        }
    ],
    "userName" : "weblogic"
}  ';
    /*
    DBMS_OUTPUT.PUT_LINE(pw_array(1)(1));
    DBMS_OUTPUT.PUT_LINE(pw_array(1)(2));
    DBMS_OUTPUT.PUT_LINE(pw_array(2)(1));
    DBMS_OUTPUT.PUT_LINE(pw_array(2)(2));
    */
    
    lw_answer := P_CALL_BIPUBLISHER (lw_message);
    RETURN lw_answer;
  EXCEPTION
    WHEN OTHERS THEN
    RETURN '[F_CALL_REPORT] ERROR WHEN OTHERS '||SQLERRM;
  END F_CALL_REPORT;

END PK_BIPUBLISHER;
/


CREATE OR REPLACE PUBLIC SYNONYM PK_BIPUBLISHER FOR CTS.PK_BIPUBLISHER;
