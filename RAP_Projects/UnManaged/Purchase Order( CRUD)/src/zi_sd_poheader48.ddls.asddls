@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase order header interface view'
define root view entity zi_sd_poheader48 as select from zsd_poheader48
composition[1..*] of zi_sd_poitem48 as _item
{
    key vbeln,
    erdat,
    ernam,
    auart,
    @Semantics.amount.currencyCode: 'Waerk'
    netwr,
    waerk,
    vkorg,
    vtweg,
    spart,
    _item
     // Make association public
}
