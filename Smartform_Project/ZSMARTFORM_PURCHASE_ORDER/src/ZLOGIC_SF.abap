FORM print_purch_order .

  CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
    EXPORTING
      formname           = 'ZSMARTFORM_PURCHASE_ORDER'
*     VARIANT            = ' '
*     DIRECT_CALL        = ' '
    IMPORTING
      fm_name            = fm_name
    EXCEPTIONS
      no_form            = 1
      no_function_module = 2
      OTHERS             = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


  IF fm_name IS NOT INITIAL.

    control_parameters-preview = 'X'.
    control_parameters-no_dialog = 'X'.

    output_options-tddest = 'LP01'.


    CALL FUNCTION fm_name "'/1BCDWB/SF00000295'
      EXPORTING
*       ARCHIVE_INDEX      =
*       ARCHIVE_INDEX_TAB  =
*       ARCHIVE_PARAMETERS =
        control_parameters = control_parameters
*       MAIL_APPL_OBJ      =
*       MAIL_RECIPIENT     =
*       MAIL_SENDER        =
        output_options     = output_options
        user_settings      = 'X'
        ip_ebeln           = p_ebeln
* IMPORTING
*       DOCUMENT_OUTPUT_INFO       =
*       JOB_OUTPUT_INFO    =
*       JOB_OUTPUT_OPTIONS =
      EXCEPTIONS
        formatting_error   = 1
        internal_error     = 2
        send_error         = 3
        user_canceled      = 4
        OTHERS             = 5.
    IF sy-subrc <> 0.
      DATA: lv_msg TYPE string,
            lv_ebeln TYPE string.
      lv_ebeln = p_ebeln.
      CONCATENATE 'NO PURCHASE EXHIST FOR' lv_ebeln INTO lv_msg SEPARATED BY space.
* Implement suitable error handling here
    ENDIF.

  ELSE.
    MESSAGE 'NO SMARTFORM EXHIST' TYPE 'E'.
  ENDIF.

ENDFORM.                    " PRINT_PURCH_ORDER
