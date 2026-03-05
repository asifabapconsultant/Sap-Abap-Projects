# SAP ABAP Enhancement – Material Availability Check in ME21N

## 📌 Project Overview
This project implements a BAdI enhancement to validate material stock availability 
during Purchase Order creation (ME21N).

If the requested quantity exceeds available stock in MARD-LABST, 
the system throws an error message.

## 🛠 Technical Details

- BAdI: ME_PROCESS_PO_CUST
- Interface: IF_EX_ME_PROCESS_PO_CUST
- Implementation Class: ZCL_MATERIAL_CHECK
- Method Used: PROCESS_ITEM
- Transaction Code: ME21N
- Table Used: MARD (Field: LABST)

## 📂 Logic Location

Class: ZCL_MATERIAL_CHECK  
Method: IF_EX_ME_PROCESS_PO_CUST~PROCESS_ITEM

## 💻 ABAP Code

```abap
METHOD if_ex_me_process_po_cust~process_item.

  DATA: re_data TYPE mepoitem,
        lv_labst TYPE mard-labst,
        lv_msg   TYPE string,
        lv_string TYPE string.

  CALL METHOD im_item->get_data
    RECEIVING
      re_data = re_data.

  IF re_data-matnr IS NOT INITIAL AND re_data-menge IS NOT INITIAL.
    CLEAR lv_labst.

    SELECT SINGLE labst
      FROM mard
      INTO lv_labst
      WHERE matnr = re_data-matnr
      AND   werks = re_data-werks.

    IF lv_labst > 0 AND lv_labst < re_data-menge.
      lv_string = lv_labst.
      CONCATENATE 'Available Stock for material is'
                  lv_string
             INTO lv_msg SEPARATED BY space.

      MESSAGE lv_msg TYPE 'E'.
    ELSEIF lv_labst = 0.
      lv_string = re_data-matnr.
      CONCATENATE 'Stock Not Available for the Material'
                  lv_string
             INTO lv_msg SEPARATED BY space.
      MESSAGE lv_msg TYPE 'E'.
    ENDIF
  ENDIF.
ENDMETHOD.

## 📸 Screenshots Location

Placed screenshots inside:
screenshots/
Screenshots:
1. BAdI Definition Screen (SE18)
2. Implementation Creation (SE19)
3. Class Implementation Code
4. Error message in ME21N


## 🚀 How to Test
1. Go to ME21N
2. Enter material with low/no stock
3. Enter quantity greater than available stock
4. System throws error messag

## 📚 Business Scenario
During Purchase Order creation, user should not order material 
more than available unrestricted stock in plant.

This enhancement ensures real-time validation before PO save.


## 👤 Author
S MAHAMMAD ASIF
SAP ABAP Consultant
