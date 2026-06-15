@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase order item interface view'
define view entity zi_sd_poitem48 as select from zsd_polineitem48
association to parent zi_sd_poheader48 as _header
on $projection.vbeln = _header.vbeln
{
    key vbeln,
    key posnr,
    matnr,
    matkl,
    _header
}
