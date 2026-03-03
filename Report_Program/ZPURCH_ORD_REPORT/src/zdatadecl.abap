TYPES: BEGIN OF ty_list,

    sel,
  ebeln TYPE ekko-ebeln,
  bsart TYPE ekko-bsart,
  aedat TYPE ekko-aedat,
  ernam TYPE ekko-ernam,
  lifnr TYPE ekko-lifnr,
  name1 TYPE lfa1-name1,
  ebelp TYPE ekpo-ebelp,
  txz01 TYPE ekpo-txz01,
  matnr TYPE ekpo-matnr,
  menge TYPE ekpo-menge,
  meins TYPE ekpo-meins,
  netpr TYPE ekpo-netpr,
  netwr TYPE ekpo-netwr,
  r_colour(4),

END OF ty_list.

DATA: gt_list TYPE STANDARD TABLE OF ty_list,
      gs_list TYPE ty_list.

DATA : gt_fcat TYPE lvc_t_fcat,
       gs_fcat LIKE LINE OF gt_fcat,
       gs_layout TYPE lvc_s_layo,
       gs_variant TYPE disvariant,
       gs_grid TYPE lvc_s_glay,
       gv_cnt TYPE i.


TYPES: BEGIN OF ty_eket,
ebeln	TYPE ebeln,
ebelp	TYPE ebelp,
etenr	TYPE eeten,
eindt	TYPE eindt,
menge	TYPE etmen,
END OF ty_eket.


DATA: gt_eket TYPE STANDARD TABLE OF ty_eket,
      gs_eket TYPE ty_eket.

DATA : gt_fcat1 TYPE lvc_t_fcat,
        gs_fcat1 LIKE LINE OF gt_fcat,
          gs_layout1 TYPE lvc_s_layo,
            gs_variant1 TYPE disvariant,
            gs_grid1 TYPE lvc_s_glay,
             gv_cnt1 TYPE i.

DATA: gt_header TYPE slis_t_listheader,
      gs_header TYPE slis_listheader,
      rdate TYPE datum,
      rtime TYPE uzeit.
