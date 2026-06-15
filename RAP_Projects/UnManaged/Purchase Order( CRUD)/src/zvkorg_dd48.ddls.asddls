@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'drop down'
define view entity zvkorg_dd48 as select from zsd_poheader48
{
    key vbeln,
        vkorg
}
