FORM getdata .

  SELECT a~ebeln
         a~bsart
         a~aedat
         a~ernam
         a~lifnr

         b~name1

         c~ebelp
         c~txz01
         c~matnr
         c~menge
         c~meins
         c~netpr
         c~netwr

    FROM ekko AS a INNER JOIN lfa1 AS b
    ON a~lifnr = b~lifnr
    INNER JOIN ekpo AS c
    ON  a~ebeln = c~ebeln
    INTO CORRESPONDING FIELDS OF TABLE gt_list
    WHERE a~ebeln IN s_ebeln
      AND a~aedat IN s_aedat
      AND a~bsart IN s_bsart
      AND c~matnr IN s_matnr.

*CL_DEMO_OUTPUT=>DISPLAY( gt_list ).
ENDFORM.                    " GETDATA


FORM displaydata .
  CLEAR: gs_layout,gs_variant,gs_fcat,gt_fcat[].

  gs_layout-col_opt = 'X'.
  gs_layout-box_fname = 'SEL'.
  gs_fcat-ifieldname = 'R_COLOR'.

  gs_variant-report = sy-repid.

  gv_cnt = gv_cnt + 1.
  gs_fcat-col_pos = gv_cnt.
  gs_fcat-fieldname = 'EBELN'.
  gs_fcat-coltext = 'PO Number'.
  gs_fcat-emphasize = 'C3'.
  gs_fcat-hotspot = 'X'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR gs_fcat.

  gv_cnt = gv_cnt + 1.
  gs_fcat-col_pos      =  gv_cnt.
  gs_fcat-fieldname    = 'AEDAT'.
  gs_fcat-coltext      = 'PO Date'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR : gs_fcat.

  gv_cnt = gv_cnt + 1.
  gs_fcat-col_pos      =  gv_cnt.
  gs_fcat-fieldname    = 'ERNAM'.
  gs_fcat-coltext      = 'Created By'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR : gs_fcat.

  gv_cnt = gv_cnt + 1.
  gs_fcat-col_pos      =  gv_cnt.
  gs_fcat-fieldname    = 'BSART'.
  gs_fcat-coltext      = 'Doc. Type'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR : gs_fcat.

  gv_cnt = gv_cnt + 1.
  gs_fcat-col_pos      =  gv_cnt.
  gs_fcat-fieldname    = 'LIFNR'.
  gs_fcat-coltext      = 'Vendor ID'.
  gs_fcat-no_zero      =  'X'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR : gs_fcat.


  gv_cnt = gv_cnt + 1.
  gs_fcat-col_pos      =  gv_cnt.
  gs_fcat-fieldname    = 'NAME1'.
  gs_fcat-coltext      = 'Vendor Name'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR : gs_fcat.

  gv_cnt = gv_cnt + 1.
  gs_fcat-col_pos      =  gv_cnt.
  gs_fcat-fieldname    = 'EBELP'.
  gs_fcat-coltext      = 'Line item'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR : gs_fcat.

  gv_cnt = gv_cnt + 1.
  gs_fcat-col_pos      =  gv_cnt.
  gs_fcat-fieldname    = 'TXZ01'.
  gs_fcat-coltext      = 'Material text'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR : gs_fcat.


  gv_cnt = gv_cnt + 1.
  gs_fcat-col_pos      =  gv_cnt.
  gs_fcat-fieldname    = 'MATNR'.
  gs_fcat-coltext      = 'Material'.
  gs_fcat-no_zero      =  'X'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR : gs_fcat.



  gv_cnt = gv_cnt + 1.
  gs_fcat-col_pos      =  gv_cnt.
  gs_fcat-fieldname    = 'MENGE'.
  gs_fcat-coltext      = 'Quantity'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR : gs_fcat.


  gv_cnt = gv_cnt + 1.
  gs_fcat-col_pos      =  gv_cnt.
  gs_fcat-fieldname    = 'MEINS'.
  gs_fcat-coltext      = 'UOM'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR : gs_fcat.


  gv_cnt = gv_cnt + 1.
  gs_fcat-col_pos      =  gv_cnt.
  gs_fcat-fieldname    = 'NETPR'.
  gs_fcat-coltext      = 'Net Price'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR : gs_fcat.

  gv_cnt = gv_cnt + 1.
  gs_fcat-col_pos      =  gv_cnt.
  gs_fcat-fieldname    = 'NETWR'.
  gs_fcat-coltext      = 'Total Amount'.
  APPEND gs_fcat TO gt_fcat.
  CLEAR : gs_fcat.


  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
*     I_INTERFACE_CHECK       = ' '
*     I_BYPASSING_BUFFER      =
*     I_BUFFER_ACTIVE         =
      i_callback_program      = sy-repid
*     I_CALLBACK_PF_STATUS_SET          = ' '
      i_callback_user_command = 'USER_COMMAND'
      i_callback_top_of_page  = 'TOP_OF_REPORT'
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME        =
*     I_BACKGROUND_ID         = ' '
*     I_GRID_TITLE            =
*     I_GRID_SETTINGS         =
      is_layout_lvc           = gs_layout
      it_fieldcat_lvc         = gt_fcat[]
*     IT_EXCLUDING            =
*     IT_SPECIAL_GROUPS_LVC   =
*     IT_SORT_LVC             =
*     IT_FILTER_LVC           =
*     IT_HYPERLINK            =
*     IS_SEL_HIDE             =
      i_default               = 'X'
      i_save                  = 'A'
      is_variant              = gs_variant
*     IT_EVENTS               =
*     IT_EVENT_EXIT           =
*     IS_PRINT_LVC            =
*     IS_REPREP_ID_LVC        =
*     I_SCREEN_START_COLUMN   = 0
*     I_SCREEN_START_LINE     = 0
*     I_SCREEN_END_COLUMN     = 0
*     I_SCREEN_END_LINE       = 0
*     I_HTML_HEIGHT_TOP       =
*     I_HTML_HEIGHT_END       =
*     IT_ALV_GRAPHICS         =
*     IT_EXCEPT_QINFO_LVC     =
*     IR_SALV_FULLSCREEN_ADAPTER        =
* IMPORTING
*     E_EXIT_CAUSED_BY_CALLER =
*     ES_EXIT_CAUSED_BY_USER  =
    TABLES
      t_outtab                = gt_list
* EXCEPTIONS
*     PROGRAM_ERROR           = 1
*     OTHERS                  = 2
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.                    " DISPLAYDATA

FORM user_command USING r_ucomm TYPE sy-ucomm
                        r_selfield TYPE slis_selfield.
  CASE r_ucomm.
    WHEN '&IC1'.

      READ TABLE gt_list INTO gs_list INDEX r_selfield-tabindex.

      IF gs_list-ebeln IS NOT INITIAL AND r_selfield-fieldname = 'EBELN'.

        SET PARAMETER ID 'BES' FIELD gs_list-ebeln.
        CALL TRANSACTION 'ME23' AND SKIP FIRST SCREEN.

      ELSEIF gs_list-ebeln IS NOT INITIAL.

        SELECT * FROM eket INTO CORRESPONDING FIELDS OF TABLE gt_eket WHERE ebeln = gs_list-ebeln.
        PERFORM display_eket.
      ENDIF.
    WHEN 'BACK'.
      SET SCREEN 0.
  ENDCASE.

ENDFORM.


FORM display_eket .

  CLEAR : gv_cnt1, gt_fcat1[], gs_fcat1.

  gs_layout1-col_opt    =  'X'.

  gs_variant1-report    = sy-repid.


  gv_cnt1 = gv_cnt + 1.
  gs_fcat1-col_pos      =  gv_cnt1.
  gs_fcat1-fieldname    = 'EBELN'.
  gs_fcat1-coltext      = 'PO Number'.
  APPEND gs_fcat1 TO gt_fcat1.
  CLEAR : gs_fcat1.


  gv_cnt1 = gv_cnt + 1.
  gs_fcat1-col_pos      =  gv_cnt1.
  gs_fcat1-fieldname    = 'EBELP'.
  gs_fcat1-coltext      = 'ITEM Number'.
  APPEND gs_fcat1 TO gt_fcat1.
  CLEAR : gs_fcat1.

  gv_cnt1 = gv_cnt + 1.
  gs_fcat1-col_pos      =  gv_cnt1.
  gs_fcat1-fieldname    = 'ETENR'.
  gs_fcat1-coltext      = 'SCHEDULE LINE'.
  APPEND gs_fcat1 TO gt_fcat1.
  CLEAR : gs_fcat1.

  gv_cnt1 = gv_cnt + 1.
  gs_fcat1-col_pos      =  gv_cnt1.
  gs_fcat1-fieldname    = 'EINDT'.
  gs_fcat1-coltext      = 'PO DELIVERY DATE'.
  APPEND gs_fcat1 TO gt_fcat1.
  CLEAR : gs_fcat1.

  gv_cnt1 = gv_cnt + 1.
  gs_fcat1-col_pos      =  gv_cnt1.
  gs_fcat1-fieldname    = 'MENGE'.
  gs_fcat1-coltext      = 'QUANTITY'.
  APPEND gs_fcat1 TO gt_fcat1.
  CLEAR : gs_fcat1.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
*     I_INTERFACE_CHECK  = ' '
*     I_BYPASSING_BUFFER =
*     I_BUFFER_ACTIVE    =
      i_callback_program = sy-repid
*     I_CALLBACK_PF_STATUS_SET          = 'PF-STATUS'
*     I_CALLBACK_USER_COMMAND           = 'USER-COMMAND'
*     I_CALLBACK_TOP_OF_PAGE            = 'TOP-OF-PAGE'
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME   =
*     I_BACKGROUND_ID    = ' '
*     I_GRID_TITLE       =
*     I_GRID_SETTINGS    =
      is_layout_lvc      = gs_layout1
      it_fieldcat_lvc    = gt_fcat1[]
*     IT_EXCLUDING       =
*     IT_SPECIAL_GROUPS_LVC             =
*     IT_SORT_LVC        =
*     IT_FILTER_LVC      =
*     IT_HYPERLINK       =
*     IS_SEL_HIDE        =
      i_default          = 'X'
      i_save             = 'A'
      is_variant         = gs_variant1
*     IT_EVENTS          =
*     IT_EVENT_EXIT      =
*     IS_PRINT_LVC       =
*     IS_REPREP_ID_LVC   =
*     I_SCREEN_START_COLUMN             = 0
*     I_SCREEN_START_LINE               = 0
*     I_SCREEN_END_COLUMN               = 0
*     I_SCREEN_END_LINE  = 0
*     I_HTML_HEIGHT_TOP  =
*     I_HTML_HEIGHT_END  =
*     IT_ALV_GRAPHICS    =
*     IT_EXCEPT_QINFO_LVC               =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER           =
*     ES_EXIT_CAUSED_BY_USER            =
    TABLES
      t_outtab           = gt_eket
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.                    " DISPLAY_EKET

FORM top_of_report.

  rdate = sy-datum.
  rtime = sy-uzeit.

  CLEAR gs_header.
  gs_header-typ = 'H'.
  gs_header-info = 'PURCHASE ORDER DETAILS'.
  APPEND gs_header TO gt_header.

  CLEAR gs_header.
  gs_header-typ = 'S'.
  gs_header-key = 'REPORTING DATE'.
  gs_header-info = rdate.
  APPEND gs_header TO gt_header.

  CLEAR gs_header.
  gs_header-typ = 'S'.
  gs_header-key = 'REPORTING TIME'.
  gs_header-info = rtime.
  APPEND gs_header TO gt_header.


  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = gt_header
      i_logo             = 'ENJOYSAP_LOGO'
*     I_END_OF_LIST_GRID =
*     I_ALV_FORM         =
    .

ENDFORM.
