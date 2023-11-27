namespace mypoapp.view;

// lets use master and transation context we had created in the datamodel.cds
using { mypoapp.db.master, mypoapp.db.transaction } from './dataModel';

context CDSViews {
    define view![POWorklist] as
        select from transaction.purchaseorder{
            key PO_ID as![PurchaseOrderId], // purchaseorder-po_id
            // purcahseorder-items field is foreign key linked with poitems table key field
            // hence any field from the poitems table can be selected in this view
            // this is how joins are done in views as it is already embedded with the table definion
            key Items.PO_ITEM_POS as![ItemPosition], //poitems-PO_ITEM_POS
            // purchaseorder-partner_guid is linked with master.businesspartner table
            PARTNER_GUID.BP_ID as![PartnerId], //master.businessparter-bp_id
            PARTNER_GUID.COMPANY_NAME as![CompanyName], //master.businessparter-company_name
            GROSS_AMOUNT as![GrossAmount], //purchaseorder-gross_amount
            NET_AMOUNT as![NetAmount], //purchaseorder-net_amount
            CURRENCY as![CurrencyCode], //purchaseorder-currency
            OVERALL_STATUS as![Status], //purchaseorder-overall_status
            Items.PRODUCT_GUID.PRODUCT_ID as![ProductId], // master.product-product_id
            Items.PRODUCT_GUID.DESCRIPTION as![ProductName], // master.product-description
            PARTNER_GUID.ADDRESS_GUID.CITY as![City], // master.address-city
            PARTNER_GUID.ADDRESS_GUID.COUNTRY as![Country], // master.address-country
        };   

    define view![ProductViewHelp] as
        select from master.product{
            @EndUserText.Label:[
                {
                    language: 'EN',
                    text: 'Product id'
                },
                {
                    language: 'DE',
                    text: 'Prodekt id'
                }
            ]
            PRODUCT_ID as![ProductId],
            @EndUserText.Label:[
                {
                    language: 'EN',
                    text: 'Product Description'
                },
                {
                    language: 'DE',
                    text: 'Prodekt Description'
                }
            ]
            DESCRIPTION as![Description]
        };

    define view![ItemView] as 
        select from transaction.poitems{
            PARENT_KEY.PARTNER_GUID.NODE_KEY as![CustomerId],
            PRODUCT_GUID.NODE_KEY as![ProductId],
            CURRENCY as![CurrencyCode],
            GROSS_AMOUNT as![GrossAmount],
            NET_AMOUNT as![NetAmount],
            TAX_AMOUNT as![TaxAmount],
            PARENT_KEY.OVERALL_STATUS as![Status]
        };

    define view![ProductView] as 
        select from master.product
        // Mixin is a keyword to define lose coupling
        //which will never load items data for product rather load on demand 
        mixin{ // View on View
            PO_ORDER: Association[*] to ItemView on PO_ORDER.ProductId = $projection.ProductId
        } into {
            NODE_KEY as![ProductId],
            DESCRIPTION as![Description],
            CATEGORY as![Category],
            PRICE as![Price],
            SUPPLIER_GUID.BP_ID as![SupplierId],
            SUPPLIER_GUID.COMPANY_NAME as![SupplierName],
            SUPPLIER_GUID.ADDRESS_GUID.CITY as![City],
            SUPPLIER_GUID.ADDRESS_GUID.COUNTRY as![Country],
            //exposed association, at runtime in odata we will see a link to load
            //dependent data
            PO_ORDER as![To_Items]
        };

    define view![CProductValuesView] as
        select from ProductView{
            ProductId,
            Country,
            round(sum(To_Items.GrossAmount),2) as ![TotalPurchaseAmount] : Decimal(10,2),
            To_Items.CurrencyCode as![CurrencyCode]
        } group by ProductId, Country, To_Items.CurrencyCode;
}