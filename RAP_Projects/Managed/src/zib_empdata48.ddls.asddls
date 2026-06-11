@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee Data Basic view'
define root view entity zib_empdata48 as select from zempdata48
{
    key id as Id,
    firstname as Firstname,
    lastname as Lastname,
    age as Age,
    role as Role,
    salary as Salary,
    active as Active,
    last_changed_at as LastChangedAt,
    local_last_changed_at as LocalLastChangedAt
}
