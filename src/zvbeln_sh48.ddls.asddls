@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'search help'
define view entity zvbeln_sh48 as select from zsd_poheader48
{
    key vbeln
}
