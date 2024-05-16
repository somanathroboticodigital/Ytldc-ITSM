// --
// Core.Customer.StaffSearch.js - provides the special module functions for the customer search
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
 * @exports TargetNS as Core.Customer.VendorSearch
 * @description
 *      This namespace contains the special module functions for the vendor employee search.
 */
Core.Customer.VendorSearch = (function (TargetNS) {
    var BackupData = {
        RequesterInfo: '',
        CustomerEmail: '',
        CustomerKey: ''
    },

    // Needed for the change event of customer fields, if ActiveAutoComplete is false (disabled)
    CustomerFieldChangeRunCount = {};

	// Customer PAS Search
	TargetNS.VendorSearchPAS = function($Element,$vendorname) {
	    //console.log($vendorid);
        Core.UI.Autocomplete.Init($Element,function (Request,Response) {
	

			var URL = Core.Config.Get('Baselink'),
       	    Data = {
           		Action: 'AgentCustomerSearch',
				Subaction: 'VendorSearch',
           		Term: Request.term,
                VendorName: $vendorname,
                MaxResults: Core.UI.Autocomplete.GetConfig('MaxResultsDisplayed')
        	};
		
        	$Element.data('AutoCompleteXHR', Core.AJAX.FunctionCall(URL, Data, function (Result) {
		
				var Data = [];
            	$Element.removeData('AutoCompleteXHR');


     
		    	$.each(Result, function () {
            		// use this code to remove email ID
            		this.CustomerValue = this.CustomerValue.replace(/<.*?>/, '');
                    //console.log(Result);
           			Data.push({
         		    	   label: this.CustomerValue + " (" + this.CustomerKey + ")",
                       	   // customer list representation (see CustomerUserListFields from Defaults.pm)
                       	   value: this.CustomerValue,
                       	   // customer user id
                           key: this.CustomerKey,
						   // customer email 
						   email: this.CustomerEmail,
						   // department 
						   dept: this.Department,
                           //VendorName
                           //VendorName: this.VendorName,
                           // Emp id
                           //EmployeeNo:this.EmployeeNo,
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

			// Set email address 
			var CustomerEmail = UI.item.email;
			$('#Email-ID').val(CustomerEmail)
			
			// Set department 	
			var Dept = UI.item.dept;
			$('#Department').val(Dept)
				

			// set LocalCustomer to Yes
			$('#Islocal').val('Yes');

           //set VendorName
           //var VendorName = UI.item.VendorName;
           //$("[name='Vendor Name']").val(VendorName)

           // Set vendor email address 
			//$('#Vendor-Email-Address').val(CustomerEmail)
            //var EmployeeNo=UI.item.EmployeeNo;
            // Set Employee id 
			//$('#Employee-Number').val(EmployeeNo)
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
}(Core.Customer.StaffSearch || {}));

