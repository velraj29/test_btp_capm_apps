sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'vel/app/purchaseorderapp/test/integration/FirstJourney',
		'vel/app/purchaseorderapp/test/integration/pages/POSetList',
		'vel/app/purchaseorderapp/test/integration/pages/POSetObjectPage',
		'vel/app/purchaseorderapp/test/integration/pages/POItemSetObjectPage'
    ],
    function(JourneyRunner, opaJourney, POSetList, POSetObjectPage, POItemSetObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('vel/app/purchaseorderapp') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePOSetList: POSetList,
					onThePOSetObjectPage: POSetObjectPage,
					onThePOItemSetObjectPage: POItemSetObjectPage
                }
            },
            opaJourney.run
        );
    }
);