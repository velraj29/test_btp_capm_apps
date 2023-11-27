using CatalogService as service from '../../srv/CatalogServices';

annotate CatalogService.POSet with @(
    UI.SelectionFields      : [
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        GROSS_AMOUNT,
        CURRENCY_code,
        OVERALL_STATUS,
    ],

    UI.LineItem             : [
        {
            $Type: 'UI.DataField',
            Value: PO_ID,
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.COMPANY_NAME,
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Label : 'Boost',
            Inline: True,
            Action: 'CatalogService.boost',
        },
        {
            $Type      : 'UI.DataField',
            Value      : OverallStatus, //OVERALL_STATUS,
            Criticality: criticality,
        },
    ],

    UI.HeaderInfo           : {
        TypeName      : 'Purchase Order',
        TypeNamePlural: 'Purchase Orders',
        Title         : {Value: PO_ID, },
        Description   : {Value: PARTNER_GUID.COMPANY_NAME, },
        ImageUrl      : 'data:image/png;base64,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',
    },

    UI.Identification       : [
        {
            $Type: 'UI.DataField',
            Value: PO_ID,
            Label: 'Purchase Order'
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.COMPANY_NAME,
            Label: 'Seller',
        },
        {
            $Type: 'UI.DataField',
            Value: OVERALL_STATUS,
            Label: 'Status',
        },
    ],

    UI.Facets               : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'More Details',
            Facets: [
                {
                    $Type : 'UI.ReferenceFacet',
                    Target: '@UI.Identification',
                    Label : 'More info',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Target: '@UI.FieldGroup#PriceInfo',
                    Label : 'Price info',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Target: '@UI.FieldGroup#Status',
                    Label : 'Status info',
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Line Item',
            Target: 'Items/@UI.LineItem',
        },
    ],

    UI.FieldGroup #PriceInfo: {
        Label: 'Price Details',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: GROSS_AMOUNT,
            },
            {
                $Type: 'UI.DataField',
                Value: NET_AMOUNT,
            },
            {
                $Type: 'UI.DataField',
                Value: TAX_AMOUNT,
            },
            {
                $Type: 'UI.DataField',
                Value: CURRENCY.code,
            },
        ]
    },

    UI.FieldGroup #Status   : {
        Label: 'Status',
        Data : [{
            $Type: 'UI.DataField',
            Value: LIFECYCLE_STATUS,
        }],
    },
);

annotate CatalogService.POSet with {
    PARTNER_GUID@(
        Common : { 
            Text : PARTNER_GUID.COMPANY_NAME,
         },
         ValueList.entity: CatalogService.BusinessPartnerSet
    )
};

annotate service.POItemSet with {
    PRODUCT_GUID@(
        Common : { 
            Text : PRODUCT_GUID.DESCRIPTION,
         },
         ValueList.entity: CatalogService.ProductSet
    )
};

@cds.odata.valuelist
annotate CatalogService.BusinesspartnerSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : COMPANY_NAME,
    }]
);

@cds.odata.valuelist
annotate CatalogService.ProductSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : DESCRIPTION,
    }]
);

annotate CatalogService.POItemSet with @(
    UI.LineItem      : [
        {
            $Type: 'UI.DataField',
            Value: PO_ITEM_POS,
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID.NODE_KEY,
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: NET_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: TAX_AMOUNT,
        },
    ],

    UI.HeaderInfo    : {
        TypeName      : 'PO Item',
        TypeNamePlural: 'PO Items',
    },

    UI.Facets        : [{
        $Type : 'UI.ReferenceFacet',
        Label : 'More Item Data',
        Target: '@UI.Identification',
    }, ],

    UI.Identification: [
        {
            $Type: 'UI.DataField',
            Label: 'Item Position',
            Value: PO_ITEM_POS,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Product ID',
            Value: PRODUCT_GUID.PRODUCT_ID,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Gross Amount',
            Value: GROSS_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Net Amount',
            Value: NET_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Tax Amount',
            Value: TAX_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Currency',
            Value: CURRENCY.code,
        },
    ]
);
