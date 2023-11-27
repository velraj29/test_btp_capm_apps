using { mypoapp.db.master, mypoapp.db.transaction } from '../db/dataModel';

service CatalogService @(path: 'CatalogService') {
    entity EmployeeSet as projection on master.employees;
    entity BusinesspartnerSet as projection on master.businesspartner;
    entity AddressSet as projection on master.address;
    entity ProductSet as projection on master.product;
    entity POSet @(odata.draft.enabled: true)
    as projection on transaction.purchaseorder{
        *, // all the columns
        case OVERALL_STATUS
            when 'O' then 'Open'
            when 'A' then 'Approved'
            when 'X' then 'Rejected'
            when 'N' then 'New'
            when 'D' then 'Delivered'
            else OVERALL_STATUS
            end as OverallStatus : String(10),
            case OVERALL_STATUS
            when 'O' then '0'
            when 'A' then '3'
            when 'X' then '1'
            when 'N' then '1'
            when 'D' then '2'
            else '0'
            end as criticality : String(1)
    } actions{
        @cds.odata.bindingparameter.name : '_anyname'
        @Common.SideEffects : {
            TargetProperties : ['_anyname/GROSS_AMOUNT'],
        }
        action boost();
        function largestOrder() returns array of POSet;
    };
    entity POItemSet as projection on transaction.poitems;
}