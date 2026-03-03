TYPES: BEGIN OF ty_tab,
  vkorg(4),
  vtweg(2),
  matnr TYPE matnr,
  amount(15),
END OF ty_tab.

DATA: gs_itab TYPE ty_tab,
      gt_itab TYPE STANDARD TABLE OF ty_tab.


DATA: gv_file TYPE string.

DATA: s_no TYPE i,
      gv_sno TYPE string,
      gv_ms TYPE string.

DATA: bdcdata LIKE bdcdata OCCURS 0 WITH HEADER LINE.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.

PARAMETERS: p_file TYPE localfile OBLIGATORY.

SELECTION-SCREEN END OF BLOCK b1.
