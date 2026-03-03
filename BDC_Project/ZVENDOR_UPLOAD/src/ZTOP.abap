TYPES: BEGIN OF ty_vend,
  lifnr TYPE rf02k-lifnr,
  anred TYPE lfa1-anred,
  name1 TYPE lfa1-name1,
  sortl TYPE lfa1-sortl,
  land1 TYPE lfa1-land1,
END OF ty_vend.

DATA: gv_file TYPE string,
      gt_vend TYPE STANDARD TABLE OF ty_vend,
      gs_vend TYPE ty_vend.

DATA: bdcdata LIKE bdcdata OCCURS 0 WITH HEADER LINE,
       messtab LIKE bdcmsgcoll OCCURS 0 WITH HEADER LINE.


SELECTION-SCREEN BEGIN OF BLOCK bk1 WITH FRAME TITLE text-001.
PARAMETERS: ip_file TYPE localfile,
            dismode TYPE ctu_params-dismode.
SELECTION-SCREEN END OF BLOCK bk1.
