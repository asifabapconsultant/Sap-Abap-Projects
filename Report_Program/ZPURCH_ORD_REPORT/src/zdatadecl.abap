TYPES: BEGIN OF ty_list,
    SEL,
  EBELN TYPE EKKO-EBELN,
  BSART TYPE EKKO-BSART,
  AEDAT TYPE EKKO-AEDAT,
  ERNAM TYPE EKKO-ERNAM,
  LIFNR TYPE EKKO-LIFNR,
  NAME1 TYPE LFA1-NAME1,
  EBELP TYPE EKPO-EBELP,
  TXZ01 TYPE EKPO-TXZ01,
  MATNR TYPE EKPO-MATNR,
  MENGE TYPE EKPO-MENGE,
  MEINS TYPE EKPO-MEINS,
  NETPR TYPE EKPO-NETPR,
  NETWR TYPE EKPO-NETWR,
  R_COLOUR(4),
END OF ty_list.

DATA: gt_list TYPE STANDARD TABLE OF ty_list,
      gs_list TYPE ty_list.

data : gt_fcat type lvc_t_fcat,
         gs_fcat like LINE OF gt_fcat,
         gs_layout type lvc_s_layo,
         gs_variant type disvariant,
         gs_grid type lvc_s_glay,
         gv_cnt type i.


TYPES: BEGIN OF TY_EKET,
EBELN	TYPE EBELN,
EBELP	TYPE EBELP,
ETENR	TYPE EETEN,
EINDT	TYPE EINDT,
MENGE	TYPE ETMEN,
END OF TY_EKET.


DATA: GT_EKET TYPE STANDARD TABLE OF TY_EKET,
      GS_EKET TYPE TY_EKET.

data : gt_fcat1 type lvc_t_fcat,
       gs_fcat1 like LINE OF gt_fcat,
       gs_layout1 type lvc_s_layo,
       gs_variant1 type disvariant,
       gs_grid1 type lvc_s_glay,
       gv_cnt1 type i.

DATA: gt_header TYPE slis_t_listheader,
      gs_header TYPE slis_listheader,
      Rdate TYPE DATUM,
      Rtime TYPE UZEIT.
