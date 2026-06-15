@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase order header consumption view'
@Metadata.allowExtensions: true
define root view entity zc_sd_poheader48
provider contract transactional_query
 as projection on zi_sd_poheader48
{
    key vbeln,
    erdat,
    ernam,
    auart,
    @Semantics.amount.currencyCode: 'waerk'
    netwr,
    waerk,
    vkorg,
    vtweg,
    spart,
    /* Associations */
    _item: redirected to composition child zc_sd_poitem48
     // Make association public
}
