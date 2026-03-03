FORM upload_data .
  IF p_file IS NOT INITIAL.
    gv_file = p_file.

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
*     IMPORTING
*       FILELENGTH          =
*       HEADER              =
      TABLES
        data_tab            = gt_itab
*     CHANGING
*       ISSCANPERFORMED     = ' '
*     EXCEPTIONS
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
* Implement suitable error handling here
    ENDIF.

    CALL FUNCTION 'BDC_OPEN_GROUP'
      EXPORTING
        client              = sy-mandt
*       DEST                = FILLER8
        group               = 'VK11_SS'
*       HOLDDATE            = FILLER8
        keep                = 'X'
        user                = sy-uname
*       RECORD              = FILLER1
        prog                = sy-repid
*       DCPFM               = '%'
*       DATFM               = '%'
* IMPORTING
*       QID                 =
      EXCEPTIONS
        client_invalid      = 1
        destination_invalid = 2
        group_invalid       = 3
        group_is_locked     = 4
        holddate_invalid    = 5
        internal_error      = 6
        queue_error         = 7
        running             = 8
        system_lock_error   = 9
        user_invalid        = 10
        OTHERS              = 11.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.



    PERFORM bdc_dynpro      USING 'SAPMV13A' '0100'.
    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'RV13A-KSCHL'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '/00'.
    PERFORM bdc_field       USING 'RV13A-KSCHL'
                                  'K004'.

    PERFORM bdc_dynpro      USING 'SAPMV13A' '1004'.
    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'KOMG-VTWEG'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '/00'.

    LOOP AT gt_itab INTO gs_itab.

      PERFORM bdc_field       USING 'KOMG-VKORG'
                                    gs_itab-vkorg. "gs_itab-VKORG.
      PERFORM bdc_field       USING 'KOMG-VTWEG'
                                    gs_itab-vtweg. "gs_itab-VTWEG.


      s_no = s_no + 1.
      gv_sno = s_no.
      CONCATENATE 'KOMG-MATNR' '(' gv_sno ')' INTO gv_ms.

      PERFORM bdc_dynpro      USING 'SAPMV13A' '1004'.
      PERFORM bdc_field       USING 'BDC_CURSOR'
                                    gv_ms.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '/00'.
      PERFORM bdc_field       USING gv_ms
                                    gs_itab-matnr.

      CLEAR gv_ms.

      CONCATENATE 'KONP-KBETR' '(' gv_sno ')' INTO gv_ms.

      PERFORM bdc_dynpro      USING 'SAPMV13A' '1004'.
      PERFORM bdc_field       USING 'BDC_CURSOR'
                                    gv_ms.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '/00'.
      PERFORM bdc_field       USING gv_ms
                                    gs_itab-amount.

      CLEAR: gs_itab,gv_sno,gv_ms.
    ENDLOOP.

    PERFORM bdc_dynpro      USING 'SAPMV13A' '1004'.
    PERFORM bdc_field       USING 'BDC_CURSOR'
                                  'KONP-KBETR(02)'.
    PERFORM bdc_field       USING 'BDC_OKCODE'
                                  '=SICH'.


    CALL FUNCTION 'BDC_INSERT'
      EXPORTING
        tcode            = 'VK11'
*       POST_LOCAL       = NOVBLOCAL
*       PRINTING         = NOPRINT
*       SIMUBATCH        = ' '
*       CTUPARAMS        = ' '
      TABLES
        dynprotab        = bdcdata
      EXCEPTIONS
        internal_error   = 1
        not_open         = 2
        queue_error      = 3
        tcode_invalid    = 4
        printing_invalid = 5
        posting_invalid  = 6
        OTHERS           = 7.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.

    CALL FUNCTION 'BDC_CLOSE_GROUP'
      EXCEPTIONS
        not_open    = 1
        queue_error = 2
        OTHERS      = 3.
    IF sy-subrc EQ 0.
      MESSAGE 'Session Created on SM35' TYPE 'S'.
* Implement suitable error handling here
    ENDIF.

  ENDIF.
ENDFORM.


FORM bdc_dynpro USING program dynpro.
  CLEAR bdcdata.
  bdcdata-program  = program.
  bdcdata-dynpro   = dynpro.
  bdcdata-dynbegin = 'X'.
  APPEND bdcdata.
ENDFORM.

*----------------------------------------------------------------------*
*        Insert field                                                  *
*----------------------------------------------------------------------*
FORM bdc_field USING fnam fval.
  IF fval <> space.
    CLEAR bdcdata.
    bdcdata-fnam = fnam.
    bdcdata-fval = fval.
    APPEND bdcdata.
  ENDIF.
ENDFORM.                    " UPLOAD_DATA
*&---------------------------------------------------------------------*
*&      Form  SELFILE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM selfile .
  CALL FUNCTION 'F4_FILENAME'
*   EXPORTING
*     PROGRAM_NAME        = SYST-CPROG
*     DYNPRO_NUMBER       = SYST-DYNNR
*     FIELD_NAME          = ' '
    IMPORTING
      file_name = p_file.
ENDFORM.                    " SELFILE
