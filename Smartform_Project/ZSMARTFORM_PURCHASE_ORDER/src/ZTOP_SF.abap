DATA: fm_name TYPE  rs38l_fnam,
      control_parameters  TYPE  ssfctrlop,
      output_options  TYPE  ssfcompop.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
PARAMETERS: p_ebeln TYPE ebeln.
SELECTION-SCREEN END OF BLOCK b1.
