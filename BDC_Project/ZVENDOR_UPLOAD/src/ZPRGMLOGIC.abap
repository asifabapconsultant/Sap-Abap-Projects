FORM selfile .

  CALL FUNCTION 'F4_FILENAME'
* EXPORTING
*   PROGRAM_NAME        = SYST-CPROG
*   DYNPRO_NUMBER       = SYST-DYNNR
*   FIELD_NAME          = ' '
    IMPORTING
      file_name = ip_file.
  .
ENDFORM.


FORM uploaddata .

  IF ip_file IS NOT INITIAL.
    CLEAR gv_file.
    gv_file  = ip_file.
    CALL FUNCTION 'GUI_UPLOAD'
      EXPORTING
        filename            = gv_file
        filetype            = 'ASC'
        has_field_separator = 'X'
*       HEADER_LENGTH       = 0
*       READ_BY_LINE        = 'X'
*       DAT_MODE            = ' '
*       CODEPAGE            = ' '
*       IGNORE_CERR         = ABAP_TRUE
*       REPLACEMENT         = '#'
*       CHECK_BOM           = ' '
*       VIRUS_SCAN_PROFILE  =
*       NO_AUTH_CHECK       = ' '
* IMPORTING
*       FILELENGTH          =
*       HEADER              =
      TABLES
        data_tab            = gt_vend
* CHANGING
*       ISSCANPERFORMED     = ' '
* EXCEPTIONS
*       FILE_OPEN_ERROR     = 1
*       FILE_READ_ERROR     = 2
*       NO_BATCH            = 3
*       GUI_REFUSE_FILETRANSFER       = 4
*       INVALID_TYPE        = 5
*       NO_AUTHORITY        = 6
*       UNKNOWN_ERROR       = 7
*       BAD_DATA_FORMAT     = 8
*       HEADER_NOT_ALLOWED  = 9
*       SEPARATOR_NOT_ALLOWED         = 10
*       HEADER_TOO_LONG     = 11
*       UNKNOWN_DP_ERROR    = 12
*       ACCESS_DENIED       = 13
*       DP_OUT_OF_MEMORY    = 14
*       DISK_FULL           = 15
*       DP_TIMEOUT          = 16
*       OTHERS              = 17
      .
    IF sy-subrc <> 0.
      MESSAGE 'ERROR WHILE UPLOADING DATA' TYPE 'I'.
    ELSE.
      CLEAR gs_vend.
      LOOP AT gt_vend INTO gs_vend.

        PERFORM bdc_dynpro      USING 'SAPMF02K' '0100'.
        PERFORM bdc_field       USING 'BDC_CURSOR'
                                      'RF02K-LIFNR'.
        PERFORM bdc_field       USING 'BDC_OKCODE'
                                      '/00'.
        PERFORM bdc_field       USING 'RF02K-LIFNR'
                                      gs_vend-lifnr.
        PERFORM bdc_field       USING 'RF02K-KTOKK'
                                      '0001'.
        PERFORM bdc_dynpro      USING 'SAPMF02K' '0110'.
        PERFORM bdc_field       USING 'BDC_CURSOR'
                                      'LFA1-ANRED'.
        PERFORM bdc_field       USING 'BDC_OKCODE'
                                      '/00'.
        PERFORM bdc_field       USING 'LFA1-ANRED'
                                      gs_vend-anred.
        PERFORM bdc_field       USING 'LFA1-NAME1'
                                      gs_vend-name1.
        PERFORM bdc_field       USING 'LFA1-SORTL'
                                      gs_vend-sortl.
        PERFORM bdc_field       USING 'LFA1-LAND1'
                                      gs_vend-land1.
        PERFORM bdc_dynpro      USING 'SAPMF02K' '0120'.
        PERFORM bdc_field       USING 'BDC_CURSOR'
                                      'LFA1-KUNNR'.
        PERFORM bdc_field       USING 'BDC_OKCODE'
                                      '/00'.
        PERFORM bdc_dynpro      USING 'SAPMF02K' '0130'.
        PERFORM bdc_field       USING 'BDC_CURSOR'
                                      'LFBK-BANKS(01)'.
        PERFORM bdc_field       USING 'BDC_OKCODE'
                                      '=ENTR'.
        PERFORM bdc_dynpro      USING 'SAPMF02K' '0380'.
        PERFORM bdc_field       USING 'BDC_CURSOR'
                                      'KNVK-NAMEV(01)'.
        PERFORM bdc_field       USING 'BDC_OKCODE'
                                      '=ENTR'.
        PERFORM bdc_transaction USING 'XK01'.

        CLEAR: gs_vend,bdcdata[].
      ENDLOOP.

      LOOP AT messtab.
        DATA: lv_id TYPE string,
              lv_msg TYPE string.
        lv_id = messtab-msgv1.
        IF messtab-msgtyp EQ 'S'.
          CLEAR lv_msg.
          CONCATENATE 'VENDOR' lv_id 'SUCCESFULLY CREATED' INTO lv_msg SEPARATED BY space.
          WRITE:/ lv_msg COLOR 5 INVERSE.
        ENDIF.

        IF messtab-msgtyp EQ 'E'.
          CLEAR lv_msg.
          CONCATENATE 'ERROR WHILE CREATING' lv_id INTO lv_msg SEPARATED BY space.
          WRITE:/ lv_msg COLOR 6 INVERSE.
        ENDIF.
        CLEAR bdcdata.
      ENDLOOP.
    ENDIF.
  ENDIF.
ENDFORM.                    " UPLOADDATA


FORM bdc_dynpro  USING  program dynpro.
  CLEAR bdcdata.
  bdcdata-program  = program.
  bdcdata-dynpro   = dynpro.
  bdcdata-dynbegin = 'X'.
  APPEND bdcdata.
ENDFORM.                    " BDC_DYNPRO


FORM bdc_field  USING  fnam fval.
  IF fval <> space.
    CLEAR bdcdata.
    bdcdata-fnam = fnam.
    bdcdata-fval = fval.
    APPEND bdcdata.
  ENDIF.
ENDFORM.                    " BDC_FIELD


FORM bdc_transaction  USING  tcode.
  CALL TRANSACTION tcode USING bdcdata
                          MODE dismode
                          UPDATE 'A'
                          MESSAGES INTO messtab.
ENDFORM.                    " BDC_TRANSACTION
