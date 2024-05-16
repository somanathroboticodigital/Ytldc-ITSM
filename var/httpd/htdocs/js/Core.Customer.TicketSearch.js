// --
// Core.Customer.TicketSearch.js - provides the special module functions for the customer search
// Copyright (C) 2001-2013 OTRS AG, http://otrs.org/
// --
// This software comes with ABSOLUTELY NO WARRANTY. For details, see
// the enclosed file COPYING for license information (AGPL). If you
// did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
// --

"use strict";

var Core = Core || {};
Core.Customer = Core.Customer || {};

/**
 * @namespace
 * @exports TargetNS as Core.Customer.TicketSearch
 * @description
 *      This namespace contains the special module functions for the customer search.
 */
Core.Customer.TicketSearch = (function (TargetNS) {
    var BackupData = {
        RequesterInfo: '',
        CustomerEmail: '',
        CustomerKey: ''
    },

    // Needed for the change event of customer fields, if ActiveAutoComplete is false (disabled)
    CustomerFieldChangeRunCount = {};

	// Customer PAS Search
	TargetNS.CustomerSearchPAS = function($Element) {
	    //console.log($vendorid);
        Core.UI.Autocomplete.Init($Element, function (Request, Response) {
	        

			var URL = Core.Config.Get('Baselink'),
       	    Data = {
           		Action: 'AgentCustomerSearch',
				Subaction: 'TicketSearch',
           		TicketNumber: Request.term,
                MaxResults: Core.UI.Autocomplete.GetConfig('MaxResultsDisplayed')
        	};
		
        	$Element.data('AutoCompleteXHR', Core.AJAX.FunctionCall(URL, Data, function (Result) {
		
				var Data = [];
            	$Element.removeData('AutoCompleteXHR');


     
		    	$.each(Result, function () {
            		// use this code to remove email ID
            		//this.CustomerValue = this.CustomerValue.replace(/<.*?>/, '');
                    //console.log(Result);
           			Data.push({
         		    	   label: this.CustomerValue + " (" + this.CustomerKey + ")",
                       	   // Ticket list representation (see CustomerUserListFields from Defaults.pm)
                       	   value: this.CustomerValue,
                       	   // Ticket id
                           key: this.CustomerKey,
						   
						  
            		});
        		});
       	    Response(Data);
	    	}));
		},function (Event, UI) {
			
			var CustomerKey = UI.item.key,
                CustomerValue = UI.item.value;



            // Store Name & SAPID
            var strNameKey = CustomerValue + '(' + CustomerKey + ')';
                strNameKey = strNameKey.replace(/\"/g, '');
      
            // set employee name
            //$('#'+$Element[0].id).val(strNameKey);
            CustomerValue = CustomerValue.replace(/\"/g, '');
            $('#'+$Element[0].id).val(CustomerValue);

		
        });
    }

	/**@function
     * @param {jQueryObject} $Element The jQuery object of the input field with autocomplete
     * @return nothing
     *      This function initializes the special module functions
     */
    TargetNS.Init = function ($Element) {


        if (isJQueryObject($Element)) {
            // Hide tooltip in autocomplete field, if user already typed something to prevent the autocomplete list
            // to be hidden under the tooltip. (Only needed for serverside errors)
            $Element.unbind('keyup.Validate').bind('keyup.Validate', function () {
               var Value = $Element.val();
               if ($Element.hasClass('ServerError') && Value.length) {
                   $('#OTRS_UI_Tooltips_ErrorTooltip').hide();
               }
            });

            Core.UI.Autocomplete.Init($Element, function (Request, Response) {
                var URL = Core.Config.Get('Baselink'),
                    Data = {
                        Action: 'AgentCustomerSearch',
                        Term: Request.term,
                        MaxResults: Core.UI.Autocomplete.GetConfig('MaxResultsDisplayed')
                    };
                $Element.data('AutoCompleteXHR', Core.AJAX.FunctionCall(URL, Data, function (Result) {
                    var Data = [];
                    $Element.removeData('AutoCompleteXHR');
                    $.each(Result, function () {
						// use this code to remove email ID 
						this.CustomerValue = this.CustomerValue.replace(/<.*?>/, '');
                        Data.push({
                            label: this.CustomerValue + " (" + this.CustomerKey + ")",
                            // customer list representation (see CustomerUserListFields from Defaults.pm)
                            value: this.CustomerValue,
                            // customer user id
                            key: this.CustomerKey
                        });
                    });
                    Response(Data);
                }));
            }, function (Event, UI) {
                var CustomerKey = UI.item.key,
                    CustomerValue = UI.item.value;

                BackupData.CustomerKey = CustomerKey;
                BackupData.CustomerEmail = CustomerValue;


				var NameEmail = UI.item.label;
				// Store Name & SAPID
				var NameEmail = CustomerValue + '(' + CustomerKey + ')';
				NameEmail = NameEmail.replace(/\"/g, '');
				//NameEmail = NameEmail.replace(/\s</g, '<');
				//NameEmail = NameEmail.replace(/\s\((.*?)\)/, '');
				//NameEmail = NameEmail.replace(/</g, '(');
                //NameEmail = NameEmail.replace(/>/g, ')');
				//$(Event.target).val(CustomerValue);
				//

				//alert(NameEmail)
				// set approver field
				//$('#Email-ID').val(NameEmail);
				

            }, 'CustomerSearch');

        }

        // On unload remove old selected data. If the page is reloaded (with F5) this data stays in the field and invokes an ajax request otherwise
        $(window).bind('unload', function () {
           $('#DynamicField_SRApprover').val('');
        });

        //CheckPhoneCustomerCountLimit();
    };


    return TargetNS;
}(Core.Customer.TicketSearch || {}));

