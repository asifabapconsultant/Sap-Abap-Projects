@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee Data Consumption View'
@Metadata.allowExtensions: true
define root view entity zc_empdata48
provider contract transactional_query
 as projection on zib_empdata48 {
    key Id,
    Firstname,
    Lastname,
    Age,
    Role,
    Salary,
    Active,
    LastChangedAt,
    LocalLastChangedAt
}
