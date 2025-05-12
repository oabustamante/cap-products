using CatalogService as service from '../../srv/catalog-service';

annotate service.Products with @(
    UI.HeaderInfo                : {
        TypeName      : '{i18n>Product}',
        TypeNamePlural: '{i18n>Products}',
        ImageUrl      : ImageUrl,
        Title         : {Value: ProductName},
        Description   : {Value: Description}
    },
    UI.HeaderFacets              : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.DataPoint#AverageRating'
    }],
    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : '{i18n>GeneralInformation1}',
            Target: '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet2',
            Label : '{i18n>GeneralInformation2}',
            Target: '@UI.FieldGroup#GeneratedGroup',
        }
    ],
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            // {
            //     $Type: 'UI.DataField',
            //     Label: 'ProductName',
            //     Value: ProductName,
            // },
            // {
            //     $Type: 'UI.DataField',
            //     Label: 'Description',
            //     Value: Description,
            // },
            // {
            //     $Type: 'UI.DataField',
            //     Label: 'ImageUrl',
            //     Value: ImageUrl,
            // },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>ReleaseDate}',
                Value: ReleaseDate,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>DiscontinuedDate}',
                Value: DiscontinuedDate,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Price}',
                Value: Price,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Height}',
                Value: Height,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Width}',
                Value: Width,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i8n>Depth}',
                Value: Depth,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Quantity}',
                Value: Quantity,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>ToUnitOfMeasure_ID}',
                Value: ToUnitOfMeasure_ID,
            },
            {
                $Type: 'UI.DataField',
                //Label: '{i18n>ToCurrency_ID}',
                Label: '{i18n>CurrencyId}',
                Value: ToCurrency_ID,
            },
            // {
            //     $Type: 'UI.DataField',
            //     //Label: '{i18n>ToCategory_ID}',
            //     Label: '{i18n>ToCategoryId}',
            //     Value: ToCategory_ID,
            // },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Category}',
                Value: Category,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>ToDimensionUnit_ID}',
                Value: ToDimensionUnit_ID,
            },
            {
                Label : '{i18n>Rating}',
                $Type : 'UI.DataFieldForAnnotation',
                Target: '@UI.DataPoint#AverageRating'

            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>StockAvailability}',
                Value: StockAvailability,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Rating}',
                Value: Rating
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Price}',
                Value: Price
            }
        ],
    },
    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Label: '{i18n>ImageUrl}',
            Value: ImageUrl,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>ProductName}',
            Value: ProductName,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Description}',
            Value: Description,
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Label : '{i18n>Supplier}',
            Target: 'Supplier/@Communication.Contact'

        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>ReleaseDate}',
            Value: ReleaseDate,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>DiscontinuedDate}',
            Value: DiscontinuedDate,
        },
        {
            Label      : '{i18n>StockAvailability}',
            Value      : StockAvailability,
            Criticality: StockAvailability
        },
        {
            // $Type: 'UI.DataField',
            // Label: 'Rating',
            // Value: Rating,
            Label : '{i18n>Rating}',
            $Type : 'UI.DataFieldForAnnotation',
            Target: '@UI.DataPoint#AverageRating'

        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Price}',
            Value: Price,
        }
    ],
    UI.SelectionFields           : [
        //ToCategory_ID, // Se anota en la entidad el sgte. campo
        CategoryId, 
        //ToCurrency_ID, // Se anota en la entidad el sgte. campo
        CurrencyId,
        StockAvailability
    ],
    Capabilities                 : {DeleteRestrictions: {
        $Type    : 'Capabilities.DeleteRestrictionsType',
        Deletable: false
    }, }
);

annotate service.Products with {
    //ToCategory_ID @title: '{i18n>CategoryId}';
    CategoryId @title: '{i18n>CategoryId}';
    //ToCurrency_ID @title: '{i18n>CurrencyId}';
    CurrencyId @title: '{i18n>CurrencyId}';
    StockAvailability @title: '{i18n>StockAvailability}';
}

annotate service.Products with {
    Supplier @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Supplier',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: Supplier_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Name',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Email',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Phone',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'Fax',
            },
        ],
    }
};

/**
 * Annotations for Categories
 */
annotate service.Products with {
    // Category
    ToCategory        @(Common: {
        Text     : {
            $value                : Category,
            ![@UI.TextArrangement]: #TextOnly,
        },
        ValueList: {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_Categories',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: ToCategory_ID,
                    ValueListProperty: 'Code'
                },
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: Category,
                    ValueListProperty: 'Text'
                }
            ]
        },
    });
    // Currency
    ToCurrency        @(Common: {
        ValueListWithFixedValues: false, // true: Tipo DropDownList
        ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'VH_Currencies',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: ToCurrency_ID,
                    ValueListProperty: 'Code'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Text'
                }
            ]
        },
    });
    // StockAvailability
    StockAvailability @(Common: {
        ValueListWithFixedValues: true,
        ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'StockAvailability',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: StockAvailability,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: StockAvailability,
                    ValueListProperty: 'Description'
                }
            ]
        },
    });
};

/**
 * Annotations for VH_Categories
 */
annotate service.VH_Categories with {
    Code @(
        UI    : {Hidden: true},
        Common: {Text: {
            $value                : Text,
            ![@UI.TextArrangement]: #TextOnly
        }}
    );
    Text @(UI: {HiddenFilter: true});
};

/**
 * Annotations for VH_Currencies
 */
annotate service.VH_Currencies with {
    Code @(UI: {HiddenFilter: true});
    Text @(UI: {HiddenFilter: true});
};

annotate service.Supplier with @(Communication: {Contact: {
    $Type: 'Communication.ContactType',
    fn   : Name,
    role : 'Supplier',
    photo: 'sap-icon://supplier',
    email: [{
        type   : #work,
        address: Email
    }],
    tel  : [
        {
            type: #work,
            uri : Phone
        },
        {
            type: #fax,
            uri : Fax
        }
    ]
}});

/**
 * Image Field
 */
annotate service.Products with {
    ImageUrl @(UI.IsImageURL: true)
};

/**
 * Data Point for Average Rating
 */
annotate service.Products with @(UI.DataPoint #AverageRating: {
    Value        : Rating,
    Title        : '{i18n>Rating}',
    TargetValue  : 5,
    Visualization: #Rating
});
