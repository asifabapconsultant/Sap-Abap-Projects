    DATA: re_data TYPE mepoitem.

    DATA: lv_labst TYPE mard-labst,
          lv_msg TYPE string,
          lv_string TYPE string.

    CALL METHOD im_item->get_data
      RECEIVING
        re_data = re_data.    " Purchase Order Item

    IF re_data-matnr IS NOT INITIAL AND re_data-menge IS NOT INITIAL.
      CLEAR: lv_labst.
      SELECT SINGLE labst FROM mard INTO lv_labst WHERE matnr = re_data-matnr
                                                          AND werks = re_data-werks.
      IF sy-subrc = 0.
        IF lv_labst GT 0 AND re_data-menge gt lv_labst.
          CLEAR: lv_string,lv_msg.
          lv_string = lv_labst.
          CONCATENATE 'Available Stock for material is' lv_string INTO lv_msg SEPARATED BY space.
          MESSAGE lv_msg TYPE 'E'.
        ELSEIF lv_labst EQ 0.
          CLEAR: lv_msg,lv_string.
          lv_string = re_data-matnr.
          CONCATENATE 'Stock Not Available for the Material' lv_string INTO lv_msg SEPARATED BY space.
          MESSAGE lv_msg TYPE 'E'.
        ENDIF.
      ENDIF.
    ENDIF.
