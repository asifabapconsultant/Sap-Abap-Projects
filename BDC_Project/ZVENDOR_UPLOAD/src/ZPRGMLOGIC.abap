FORM SELFILE .

CALL FUNCTION 'F4_FILENAME'
* EXPORTING
*   PROGRAM_NAME        = SYST-CPROG
*   DYNPRO_NUMBER       = SYST-DYNNR
*   FIELD_NAME          = ' '
 IMPORTING
   FILE_NAME           = IP_FILE.
          .
ENDFORM.


FORM UPLOADDATA .

IF IP_FILE IS NOT INITIAL.
  CLEAR GV_FILE.
  GV_FILE  = IP_FILE.
CALL FUNCTION 'GUI_UPLOAD'
  EXPORTING
    FILENAME                      = GV_FILE
   FILETYPE                      = 'ASC'
   HAS_FIELD_SEPARATOR           = 'X'
*   HEADER_LENGTH                 = 0
*   READ_BY_LINE                  = 'X'
*   DAT_MODE                      = ' '
*   CODEPAGE                      = ' '
*   IGNORE_CERR                   = ABAP_TRUE
*   REPLACEMENT                   = '#'
*   CHECK_BOM                     = ' '
*   VIRUS_SCAN_PROFILE            =
*   NO_AUTH_CHECK                 = ' '
* IMPORTING
*   FILELENGTH                    =
*   HEADER                        =
  TABLES
    DATA_TAB                      = GT_VEND
* CHANGING
*   ISSCANPERFORMED               = ' '
* EXCEPTIONS
*   FILE_OPEN_ERROR               = 1
*   FILE_READ_ERROR               = 2
*   NO_BATCH                      = 3
*   GUI_REFUSE_FILETRANSFER       = 4
*   INVALID_TYPE                  = 5
*   NO_AUTHORITY                  = 6
*   UNKNOWN_ERROR                 = 7
*   BAD_DATA_FORMAT               = 8
*   HEADER_NOT_ALLOWED            = 9
*   SEPARATOR_NOT_ALLOWED         = 10
*   HEADER_TOO_LONG               = 11
*   UNKNOWN_DP_ERROR              = 12
*   ACCESS_DENIED                 = 13
*   DP_OUT_OF_MEMORY              = 14
*   DISK_FULL                     = 15
*   DP_TIMEOUT                    = 16
*   OTHERS                        = 17
          .
IF SY-SUBRC <> 0.
  MESSAGE 'ERROR WHILE UPLOADING DATA' TYPE 'I'.
ELSE.
  CLEAR GS_VEND.
LOOP AT GT_VEND INTO GS_VEND.

perform bdc_dynpro      using 'SAPMF02K' '0100'.
perform bdc_field       using 'BDC_CURSOR'
                              'RF02K-LIFNR'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'RF02K-LIFNR'
                              GS_VEND-LIFNR.
perform bdc_field       using 'RF02K-KTOKK'
                              '0001'.
perform bdc_dynpro      using 'SAPMF02K' '0110'.
perform bdc_field       using 'BDC_CURSOR'
                              'LFA1-ANRED'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_field       using 'LFA1-ANRED'
                              GS_VEND-ANRED.
perform bdc_field       using 'LFA1-NAME1'
                              GS_VEND-NAME1.
perform bdc_field       using 'LFA1-SORTL'
                              GS_VEND-SORTL.
perform bdc_field       using 'LFA1-LAND1'
                              GS_VEND-LAND1.
perform bdc_dynpro      using 'SAPMF02K' '0120'.
perform bdc_field       using 'BDC_CURSOR'
                              'LFA1-KUNNR'.
perform bdc_field       using 'BDC_OKCODE'
                              '/00'.
perform bdc_dynpro      using 'SAPMF02K' '0130'.
perform bdc_field       using 'BDC_CURSOR'
                              'LFBK-BANKS(01)'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTR'.
perform bdc_dynpro      using 'SAPMF02K' '0380'.
perform bdc_field       using 'BDC_CURSOR'
                              'KNVK-NAMEV(01)'.
perform bdc_field       using 'BDC_OKCODE'
                              '=ENTR'.
perform bdc_transaction using 'XK01'.

CLEAR: GS_VEND,BDCDATA[].
ENDLOOP.

LOOP AT MESSTAB.
  DATA: LV_ID TYPE STRING,
        LV_MSG TYPE STRING.
  LV_ID = MESSTAB-MSGV1.
  IF MESSTAB-MSGTYP EQ 'S'.
    CLEAR LV_MSG.
    CONCATENATE 'VENDOR' LV_ID 'SUCCESFULLY CREATED' INTO LV_MSG SEPARATED BY SPACE.
    WRITE:/ LV_MSG COLOR 5 INVERSE.
  ENDIF.

  IF MESSTAB-MSGTYP EQ 'E'.
    CLEAR LV_MSG.
    CONCATENATE 'ERROR WHILE CREATING' LV_ID INTO LV_MSG SEPARATED BY SPACE.
    WRITE:/ LV_MSG COLOR 6 INVERSE.
  ENDIF.
CLEAR BDCDATA.
ENDLOOP.
ENDIF.
ENDIF.
ENDFORM.                    " UPLOADDATA


FORM BDC_DYNPRO  USING  PROGRAM DYNPRO.
  CLEAR BDCDATA.
  BDCDATA-PROGRAM  = PROGRAM.
  BDCDATA-DYNPRO   = DYNPRO.
  BDCDATA-DYNBEGIN = 'X'.
  APPEND BDCDATA.
ENDFORM.                    " BDC_DYNPRO


FORM BDC_FIELD  USING  FNAM FVAL.
  IF FVAL <> SPACE.
    CLEAR BDCDATA.
    BDCDATA-FNAM = FNAM.
    BDCDATA-FVAL = FVAL.
    APPEND BDCDATA.
  ENDIF.
ENDFORM.                    " BDC_FIELD


FORM BDC_TRANSACTION  USING  TCODE.
CALL TRANSACTION TCODE USING BDCDATA
                        MODE DISMODE
                        UPDATE 'A'
                        MESSAGES INTO MESSTAB.
ENDFORM.                    " BDC_TRANSACTION
