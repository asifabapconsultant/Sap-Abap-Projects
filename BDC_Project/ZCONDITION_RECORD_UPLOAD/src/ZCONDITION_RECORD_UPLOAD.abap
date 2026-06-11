
REPORT zcondition_record_upload.
INCLUDE ztop_sm.
INCLUDE zlogic_sm.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  PERFORM selfile.

START-OF-SELECTION.
  PERFORM upload_data.

END-OF-SELECTION.
