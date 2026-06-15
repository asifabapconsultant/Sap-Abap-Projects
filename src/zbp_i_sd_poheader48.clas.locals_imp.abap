CLASS lhc_zi_sd_poheader48 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.
    DATA: gt_header_db TYPE STANDARD TABLE OF zsd_poheader48   WITH DEFAULT KEY,
          gt_item_db   TYPE STANDARD TABLE OF zsd_polineitem48 WITH DEFAULT KEY.
    CLASS-DATA:
      gt_create_header LIKE gt_header_db,
      gt_update_header LIKE gt_header_db,
      gt_delete_header TYPE TABLE OF zsd_poheader48-vbeln,
      gt_create_item   LIKE gt_item_db.
  PRIVATE SECTION.
    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zi_sd_poheader48.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zi_sd_poheader48.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zi_sd_poheader48.

    METHODS read FOR READ
      IMPORTING keys FOR READ zi_sd_poheader48 RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zi_sd_poheader48.

    METHODS rba_Item FOR READ
      IMPORTING keys_rba FOR READ zi_sd_poheader48\_Item FULL result_requested RESULT result LINK association_links.

    METHODS cba_Item FOR MODIFY
      IMPORTING entities_cba FOR CREATE zi_sd_poheader48\_Item.

ENDCLASS.

CLASS lhc_zi_sd_poheader48 IMPLEMENTATION.

  METHOD create.
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs>).
      DATA(ls_header) = CORRESPONDING zsd_poheader48( <fs> ) .
      IF ls_header-vbeln IS NOT INITIAL.
        APPEND ls_header TO gt_create_header.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD update.
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs>).
      DATA(ls_header) = CORRESPONDING zsd_poheader48( <fs> ).
      APPEND ls_header TO gt_update_header.
    ENDLOOP.
  ENDMETHOD.

  METHOD delete.
    LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs>).
      APPEND <fs>-vbeln TO gt_delete_header.
    ENDLOOP.
  ENDMETHOD.

  METHOD read.
    IF keys IS NOT INITIAL.
      SELECT * FROM zsd_poheader48
      FOR ALL ENTRIES IN @keys
      WHERE vbeln = @keys-vbeln
      INTO CORRESPONDING FIELDS OF TABLE @result.
    ENDIF.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD rba_Item.
    IF keys_rba IS NOT INITIAL.
      SELECT * FROM zsd_polineitem48
        FOR ALL ENTRIES IN @keys_rba
        WHERE vbeln = @keys_rba-vbeln
        INTO TABLE @DATA(lt_items).
    ENDIF.
    LOOP AT lt_items ASSIGNING FIELD-SYMBOL(<ls_item>).
      APPEND VALUE #( source-vbeln = <ls_item>-vbeln
                  target-vbeln = <ls_item>-vbeln ) TO association_links.
    ENDLOOP.
    result = CORRESPONDING #( lt_items ).
  ENDMETHOD.

  METHOD cba_Item.
    LOOP AT entities_cba ASSIGNING FIELD-SYMBOL(<fs>).
      LOOP AT <fs>-%target ASSIGNING FIELD-SYMBOL(<ls_target>).
        DATA(ls_item) = CORRESPONDING zsd_polineitem48( <ls_target> ).
        ls_item-vbeln = <fs>-vbeln.
        IF ls_item-vbeln AND ls_item-posnr IS NOT INITIAL.
          APPEND ls_item TO gt_create_item.
        ENDIF.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_zi_sd_poitem48 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.
    CLASS-DATA:gt_update_item TYPE TABLE OF zsd_polineitem48,
               gt_delete_item TYPE STANDARD TABLE OF zsd_polineitem48 WITH DEFAULT KEY.
  PRIVATE SECTION.
    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zi_sd_poitem48.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zi_sd_poitem48.

    METHODS read FOR READ
      IMPORTING keys FOR READ zi_sd_poitem48 RESULT result.

    METHODS rba_Header FOR READ
      IMPORTING keys_rba FOR READ zi_sd_poitem48\_Header FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_zi_sd_poitem48 IMPLEMENTATION.

  METHOD update.
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs>).
      DATA(ls_item) = CORRESPONDING zsd_polineitem48( <fs> ).
      APPEND ls_item TO gt_update_item.
    ENDLOOP.
  ENDMETHOD.

  METHOD delete.
    LOOP AT keys ASSIGNING FIELD-SYMBOL(<ls_key>).
      DATA: ls_item TYPE zsd_polineitem48.
      ls_item-vbeln = <ls_key>-vbeln.
      ls_item-posnr = <ls_key>-posnr.
      APPEND ls_item TO gt_delete_item.
    ENDLOOP.
  ENDMETHOD.

  METHOD read.
    IF keys IS NOT INITIAL.
      SELECT * FROM zsd_polineitem48
      FOR ALL ENTRIES IN @keys
      WHERE vbeln = @keys-vbeln
      AND posnr = @keys-posnr
      INTO CORRESPONDING FIELDS OF TABLE @result.
    ENDIF.
  ENDMETHOD.

  METHOD rba_Header.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZI_SD_POHEADER48 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_SD_POHEADER48 IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    IF lhc_zi_sd_poheader48=>gt_create_header IS NOT INITIAL.
      INSERT zsd_poheader48 FROM TABLE @lhc_zi_sd_poheader48=>gt_create_header.
    ENDIF.
    IF lhc_zi_sd_poheader48=>gt_create_item IS NOT INITIAL.
      INSERT zsd_polineitem48 FROM TABLE @lhc_zi_sd_poheader48=>gt_create_item.
    ENDIF.
    IF lhc_zi_sd_poheader48=>gt_update_header IS NOT INITIAL.
      UPDATE zsd_poheader48 FROM TABLE @lhc_zi_sd_poheader48=>gt_update_header.
    ENDIF.
    IF lhc_zi_sd_poitem48=>gt_update_item IS NOT INITIAL.
      UPDATE zsd_polineitem48 FROM TABLE @lhc_zi_sd_poitem48=>gt_update_item.
    ENDIF.
    IF lhc_zi_sd_poheader48=>gt_delete_header IS NOT INITIAL.
      LOOP AT lhc_zi_sd_poheader48=>gt_delete_header ASSIGNING FIELD-SYMBOL(<ls_header>).
        DELETE FROM zsd_poheader48 WHERE vbeln = @<ls_header>.
      ENDLOOP.
    ELSE.
      DELETE FROM zsd_poheader48 WHERE vbeln = ''.
    ENDIF.
    IF lhc_zi_sd_poitem48=>gt_delete_item IS NOT INITIAL.
      LOOP AT lhc_zi_sd_poitem48=>gt_delete_item ASSIGNING FIELD-SYMBOL(<fs>).
        DELETE FROM zsd_polineitem48 WHERE vbeln = @<fs>-vbeln AND posnr = @<fs>-posnr.
      ENDLOOP.
    ELSE.
      DELETE FROM zsd_polineitem48 WHERE vbeln = '' AND posnr = '' AND matnr = ''.
    ENDIF.
  ENDMETHOD.

  METHOD cleanup.
    CLEAR: lhc_zi_sd_poheader48=>gt_create_header,lhc_zi_sd_poheader48=>gt_create_item,lhc_zi_sd_poheader48=>gt_delete_header,
           lhc_zi_sd_poheader48=>gt_update_header,lhc_zi_sd_poitem48=>gt_delete_item,lhc_zi_sd_poitem48=>gt_update_item.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
