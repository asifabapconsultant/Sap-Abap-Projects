REPORT zpurch_ord_report.

TABLES: ekko,ekpo.

INCLUDE zdatdecl.

INCLUDE zscrn.

INCLUDE zforms.

START-OF-SELECTION.

  PERFORM getdata.
  PERFORM DISPLAYdata.

END-OF-SELECTION.
