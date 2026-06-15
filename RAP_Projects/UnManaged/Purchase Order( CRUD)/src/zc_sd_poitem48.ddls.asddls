@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase order item consumption view'
@Metadata.allowExtensions: true
define view entity zc_sd_poitem48 as projection on zi_sd_poitem48
{
    key vbeln,
    key posnr,
    matnr,
    matkl,
    /* Associations */
    _header: redirected to parent zc_sd_poheader48
}
