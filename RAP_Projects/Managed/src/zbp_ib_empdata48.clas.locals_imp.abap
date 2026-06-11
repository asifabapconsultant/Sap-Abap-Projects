CLASS lhc_zib_empdata48 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zib_empdata48 RESULT result.

    METHODS setactive FOR MODIFY
      IMPORTING keys FOR ACTION zib_empdata48~setactive RESULT result.

    METHODS setsalary FOR DETERMINE ON SAVE
      IMPORTING keys FOR zib_empdata48~setsalary.

    METHODS validateage FOR VALIDATE ON SAVE
      IMPORTING keys FOR zib_empdata48~validateage.

ENDCLASS.

CLASS lhc_zib_empdata48 IMPLEMENTATION.
READ ENTITIES OF zib_empdata48 IN LOCAL MODE
ENTITY zib_empdata48
ALL FIELDS WITH CORRESPONDING #( keys )
RESULT DATA(employees).

result = VALUE #( FOR employee IN employees
                 LET status = COND #(  WHEN employee-active = abap_true
                 THEN if_abap_behv=>fc-o-disabled
                 ELSE if_abap_behv=>fc-o-enabled )
                 IN (
                 %tky = employee-%tky
                 %action-setActive = status ) ).


ENDMETHOD.

METHOD setactive.
MODIFY ENTITIES OF zib_empdata48 IN LOCAL MODE
ENTITY zib_empdata48
UPDATE
FIELDS ( Active )
WITH VALUE #( FOR key IN keys
            ( %tky = key-%tky
              Active = abap_true
              )
              ).

READ ENTITIES OF zib_empdata48 IN LOCAL MODE
ENTITY zib_empdata48
ALL FIELDS WITH CORRESPONDING #( keys )
RESULT DATA(Employees).

result = VALUE #( FOR employee IN employees
                ( %tky = employee-%tky
                  %param = employee ) ).

ENDMETHOD.

METHOD setsalary.
READ ENTITIES OF zib_empdata48 IN LOCAL MODE
ENTITY zib_empdata48
FIELDS ( Role ) WITH CORRESPONDING #( keys )
RESULT DATA(employees).

LOOP AT employees INTO DATA(employee).
  IF employee-Role = 'Abap Developer'.
    MODIFY ENTITIES OF zib_empdata48 IN LOCAL MODE
    ENTITY zib_empdata48
    UPDATE
    FIELDS ( Salary )
    WITH VALUE #( ( %tky = employee-%tky
                  Salary = '3000' ) ).
  ELSEIF employee-Role = 'Senior Developer'.
    MODIFY ENTITIES OF zib_empdata48 IN LOCAL MODE
      ENTITY zib_empdata48
      UPDATE
      FIELDS ( Salary )
      WITH VALUE #( ( %tky = employee-%tky
                    Salary = 5000 ) ).
  ENDIF.
ENDLOOP.

ENDMETHOD.
METHOD validateage.
READ ENTITIES OF zib_empdata48 IN LOCAL MODE
ENTITY zib_empdata48
FIELDS ( Age ) WITH CORRESPONDING #( keys )
RESULT DATA(employees).

LOOP AT employees INTO DATA(employee).
  IF  employee-Age < 18.
    APPEND VALUE #( %tky = employee-%tky ) TO failed-zib_empdata48.
    APPEND VALUE #( %tky = employee-%tky
                     %msg = new_message( id = 'ZMSG48'
                     number = '001'
                   severity = if_abap_behv_message=>severity-error )
                   ) TO reported-zib_empdata48.
  ENDIF.
ENDLOOP.

ENDMETHOD.

ENDCLASS.
