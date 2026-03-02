FORM GETDATA .
SELECT a~EBELN
       a~BSART
       a~AEDAT
       a~ERNAM
       a~LIFNR
       B~NAME1
       c~EBELp
       c~TXZ01
       c~MATNR
       c~menge
       c~MEINS
       c~NETPR
       c~netwr
  FROM ekko as a INNER JOIN LFA1 AS B
  ON A~LIFNR = B~LIFNR
  INNER JOIN EKPO AS C
  ON  A~EBELN = C~EBELN
  INTO CORRESPONDING FIELDS OF TABLE gt_list
  WHERE A~EBELN IN s_ebeln
    AND A~AEDAT IN s_aedat
    AND A~BSART IN s_bsart
    AND C~MATNR IN s_matnr.
ENDFORM.                    " GETDATA


FORM DISPLAYDATA .
CLEAR: gs_layout,gs_variant,gs_fcat,gT_fcat[].

GS_LAYOUT-COL_OPT = 'X'.
GS_LAYOUT-BOX_FNAME = 'SEL'.
gs_fcat-IFIELDNAME = 'R_COLOR'.

gs_variant-REPORT = SY-REPID.

GV_CNT = gv_cnt + 1.
gs_fcat-COL_POS = GV_CNT.
gs_fcat-FIELDNAME = 'EBELN'.
gs_fcat-COLTEXT = 'PO Number'.
gs_fcat-EMPHASIZE = 'C3'.
gs_fcat-HOTSPOT = 'X'.
APPEND gs_fcat TO gt_fcat.
CLEAR gs_fcat.

gv_cnt = gv_cnt + 1.
gs_fcat-col_pos      =  gv_cnt.
gs_fcat-fieldname    = 'AEDAT'.
gs_fcat-coltext      = 'PO Date'.
append gs_fcat to gt_fcat.
clear : gs_fcat.

gv_cnt = gv_cnt + 1.
gs_fcat-col_pos      =  gv_cnt.
gs_fcat-fieldname    = 'ERNAM'.
gs_fcat-coltext      = 'Created By'.
append gs_fcat to gt_fcat.
clear : gs_fcat.

gv_cnt = gv_cnt + 1.
gs_fcat-col_pos      =  gv_cnt.
gs_fcat-fieldname    = 'BSART'.
gs_fcat-coltext      = 'Doc. Type'.
append gs_fcat to gt_fcat.
clear : gs_fcat.

gv_cnt = gv_cnt + 1.
gs_fcat-col_pos      =  gv_cnt.
gs_fcat-fieldname    = 'LIFNR'.
gs_fcat-coltext      = 'Vendor ID'.
gs_fcat-no_zero      =  'X'.
append gs_fcat to gt_fcat.
clear : gs_fcat.


gv_cnt = gv_cnt + 1.
gs_fcat-col_pos      =  gv_cnt.
gs_fcat-fieldname    = 'NAME1'.
gs_fcat-coltext      = 'Vendor Name'.
append gs_fcat to gt_fcat.
clear : gs_fcat.

gv_cnt = gv_cnt + 1.
gs_fcat-col_pos      =  gv_cnt.
gs_fcat-fieldname    = 'EBELP'.
gs_fcat-coltext      = 'Line item'.
append gs_fcat to gt_fcat.
clear : gs_fcat.

gv_cnt = gv_cnt + 1.
gs_fcat-col_pos      =  gv_cnt.
gs_fcat-fieldname    = 'TXZ01'.
gs_fcat-coltext      = 'Material text'.
append gs_fcat to gt_fcat.
clear : gs_fcat.

gv_cnt = gv_cnt + 1.
gs_fcat-col_pos      =  gv_cnt.
gs_fcat-fieldname    = 'MATNR'.
gs_fcat-coltext      = 'Material'.
gs_fcat-no_zero      =  'X'.
append gs_fcat to gt_fcat.
clear : gs_fcat.

gv_cnt = gv_cnt + 1.
gs_fcat-col_pos      =  gv_cnt.
gs_fcat-fieldname    = 'MENGE'.
gs_fcat-coltext      = 'Quantity'.
append gs_fcat to gt_fcat.
clear : gs_fcat.

gv_cnt = gv_cnt + 1.
gs_fcat-col_pos      =  gv_cnt.
gs_fcat-fieldname    = 'MEINS'.
gs_fcat-coltext      = 'UOM'.
append gs_fcat to gt_fcat.
clear : gs_fcat.

gv_cnt = gv_cnt + 1.
gs_fcat-col_pos      =  gv_cnt.
gs_fcat-fieldname    = 'NETPR'.
gs_fcat-coltext      = 'Net Price'.
append gs_fcat to gt_fcat.
clear : gs_fcat.

gv_cnt = gv_cnt + 1.
gs_fcat-col_pos      =  gv_cnt.
gs_fcat-fieldname    = 'NETWR'.
gs_fcat-coltext      = 'Total Amount'.
append gs_fcat to gt_fcat.
clear : gs_fcat.


CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
 EXPORTING
*   I_INTERFACE_CHECK                 = ' '
*   I_BYPASSING_BUFFER                =
*   I_BUFFER_ACTIVE                   =
   I_CALLBACK_PROGRAM                = SY-REPID
*   I_CALLBACK_PF_STATUS_SET          = ' '
   I_CALLBACK_USER_COMMAND           = 'USER_COMMAND'
   I_CALLBACK_TOP_OF_PAGE            = 'TOP_OF_REPORT'
*   I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*   I_CALLBACK_HTML_END_OF_LIST       = ' '
*   I_STRUCTURE_NAME                  =
*   I_BACKGROUND_ID                   = ' '
*   I_GRID_TITLE                      =
*   I_GRID_SETTINGS                   =
   IS_LAYOUT_LVC                     = gs_layout
   IT_FIELDCAT_LVC                   = gt_fcat[]
*   IT_EXCLUDING                      =
*   IT_SPECIAL_GROUPS_LVC             =
*   IT_SORT_LVC                       =
*   IT_FILTER_LVC                     =
*   IT_HYPERLINK                      =
*   IS_SEL_HIDE                       =
   I_DEFAULT                         = 'X'
   I_SAVE                            = 'A'
   IS_VARIANT                        = gs_variant
*   IT_EVENTS                         =
*   IT_EVENT_EXIT                     =
*   IS_PRINT_LVC                      =
*   IS_REPREP_ID_LVC                  =
*   I_SCREEN_START_COLUMN             = 0
*   I_SCREEN_START_LINE               = 0
*   I_SCREEN_END_COLUMN               = 0
*   I_SCREEN_END_LINE                 = 0
*   I_HTML_HEIGHT_TOP                 =
*   I_HTML_HEIGHT_END                 =
*   IT_ALV_GRAPHICS                   =
*   IT_EXCEPT_QINFO_LVC               =
*   IR_SALV_FULLSCREEN_ADAPTER        =
* IMPORTING
*   E_EXIT_CAUSED_BY_CALLER           =
*   ES_EXIT_CAUSED_BY_USER            =
  TABLES
    T_OUTTAB                          = gt_list
* EXCEPTIONS
*   PROGRAM_ERROR                     = 1
*   OTHERS                            = 2
          .
IF SY-SUBRC <> 0.
* Implement suitable error handling here
ENDIF.
ENDFORM.                    " DISPLAYDATA


FORM USER_COMMAND USING R_UCOMM TYPE SY-UCOMM
                        R_SELFIELD TYPE SLIS_SELFIELD.
  CASE R_UCOMM.
    WHEN '&IC1'.

 READ TABLE GT_LIST INTO GS_LIST INDEX R_SELFIELD-TABINDEX.
 IF GS_LIST-EBELN IS NOT INITIAL AND R_SELFIELD-FIELDNAME = 'EBELN'.
   SET PARAMETER ID 'BES' FIELD GS_LIST-EBELN.
   CALL TRANSACTION 'ME23' AND SKIP FIRST SCREEN.
 ELSEIF GS_LIST-EBELN IS NOT INITIAL.
    SELECT * FROM EKET INTO CORRESPONDING FIELDS OF TABLE GT_EKET WHERE EBELN = GS_LIST-EBELN.
    PERFORM DISPLAY_EKET.
   ENDIF.
    WHEN 'BACK'.
      SET SCREEN 0.
  ENDCASE.
ENDFORM.

FORM DISPLAY_EKET .

clear : gv_cnt1, gt_fcat1[], gs_fcat1.

gs_layout1-col_opt    =  'X'.

gs_variant1-report    = sy-repid.

gv_cnt1 = gv_cnt + 1.
gs_fcat1-col_pos      =  gv_cnt1.
gs_fcat1-fieldname    = 'EBELN'.
gs_fcat1-coltext      = 'PO Number'.
append gs_fcat1 to gt_fcat1.
clear : gs_fcat1.

gv_cnt1 = gv_cnt + 1.
gs_fcat1-col_pos      =  gv_cnt1.
gs_fcat1-fieldname    = 'EBELP'.
gs_fcat1-coltext      = 'ITEM Number'.
append gs_fcat1 to gt_fcat1.
clear : gs_fcat1.

gv_cnt1 = gv_cnt + 1.
gs_fcat1-col_pos      =  gv_cnt1.
gs_fcat1-fieldname    = 'ETENR'.
gs_fcat1-coltext      = 'SCHEDULE LINE'.
append gs_fcat1 to gt_fcat1.
clear : gs_fcat1.

gv_cnt1 = gv_cnt + 1.
gs_fcat1-col_pos      =  gv_cnt1.
gs_fcat1-fieldname    = 'EINDT'.
gs_fcat1-coltext      = 'PO DELIVERY DATE'.
append gs_fcat1 to gt_fcat1.
clear : gs_fcat1.

gv_cnt1 = gv_cnt + 1.
gs_fcat1-col_pos      =  gv_cnt1.
gs_fcat1-fieldname    = 'MENGE'.
gs_fcat1-coltext      = 'QUANTITY'.
append gs_fcat1 to gt_fcat1.
clear : gs_fcat1.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
   EXPORTING
*     I_INTERFACE_CHECK                 = ' '
*     I_BYPASSING_BUFFER                =
*     I_BUFFER_ACTIVE                   =
     I_CALLBACK_PROGRAM                = sy-repid
*     I_CALLBACK_PF_STATUS_SET          = 'PF-STATUS'
*     I_CALLBACK_USER_COMMAND           = 'USER-COMMAND'
*     I_CALLBACK_TOP_OF_PAGE            = 'TOP-OF-PAGE'
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME                  =
*     I_BACKGROUND_ID                   = ' '
*     I_GRID_TITLE                      =
*     I_GRID_SETTINGS                   =
     IS_LAYOUT_LVC                     = gs_layout1
     IT_FIELDCAT_LVC                   = GT_FCAT1[]
*     IT_EXCLUDING                      =
*     IT_SPECIAL_GROUPS_LVC             =
*     IT_SORT_LVC                       =
*     IT_FILTER_LVC                     =
*     IT_HYPERLINK                      =
*     IS_SEL_HIDE                       =
     I_DEFAULT                         = 'X'
     I_SAVE                            = 'A'
     IS_VARIANT                        = GS_VARIANT1
*     IT_EVENTS                         =
*     IT_EVENT_EXIT                     =
*     IS_PRINT_LVC                      =
*     IS_REPREP_ID_LVC                  =
*     I_SCREEN_START_COLUMN             = 0
*     I_SCREEN_START_LINE               = 0
*     I_SCREEN_END_COLUMN               = 0
*     I_SCREEN_END_LINE                 = 0
*     I_HTML_HEIGHT_TOP                 =
*     I_HTML_HEIGHT_END                 =
*     IT_ALV_GRAPHICS                   =
*     IT_EXCEPT_QINFO_LVC               =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER           =
*     ES_EXIT_CAUSED_BY_USER            =
    TABLES
      T_OUTTAB                          = GT_EKET
   EXCEPTIONS
     PROGRAM_ERROR                     = 1
     OTHERS                            = 2
            .
  IF SY-SUBRC <> 0.
* Implement suitable error handling here
  ENDIF.
ENDFORM.                    " DISPLAY_EKET


FORM TOP_OF_REPORT.

  Rdate = SY-DATUM.
  Rtime = SY-UZEIT.

  CLEAR gs_header.
  gs_header-TYP = 'H'.
  gs_header-INFO = 'PURCHASE ORDER DETAILS'.
  APPEND gs_header TO gt_header.

  CLEAR gs_header.
  gs_header-TYP = 'S'.
  gs_header-KEY = 'REPORTING DATE'.
  gs_header-INFO = RDATE.
  APPEND gs_header TO gt_header.

  CLEAR gs_header.
  gs_header-TYP = 'S'.
  gs_header-KEY = 'REPORTING TIME'.
    gs_header-INFO = RTIME.
  APPEND gs_header TO gt_header.


CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
  EXPORTING
    IT_LIST_COMMENTARY       = gt_header
   I_LOGO                   = 'ENJOYSAP_LOGO'
*   I_END_OF_LIST_GRID       =
*   I_ALV_FORM               =
          .
ENDFORM.
