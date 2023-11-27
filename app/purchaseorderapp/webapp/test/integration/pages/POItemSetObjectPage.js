sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'vel.app.purchaseorderapp',
            componentId: 'POItemSetObjectPage',
            contextPath: '/POSet/Items'
        },
        CustomPageDefinitions
    );
});