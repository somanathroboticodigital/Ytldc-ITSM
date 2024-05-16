
/**
 *Name: handleProblemRequestType
 *Function: Remove all option from the Ticket Type option/dropdown if Ticket is a Problem or a Request ticket
 *Changed by: Hash
 **/

$(document).ready(function () {  
    var pasSubcategory = ($("#DynamicField_PaSSubCategory").val());
    var PaSCategory = $('#DynamicField_PaSCategory').val();
    var PaSDescription = $( "#DynamicField_PaSDescription" ).val();
    
    if( PaSCategory.length ) {
        setTimeout( function() {
            $( '#DynamicField_PaSSubCategory option[value="' + pasSubcategory + '"]' ).attr( 'selected', 'selected' );
            $( '#DynamicField_PaSSubCategory_Search' ).focus();

            console.log( pasSubcategory );
            console.log( $( '#DynamicField_PaSSubCategory' ).val() );
        }, 700 );
    }  
        setTimeout( function() {
            $( '#DynamicField_PaSDescription option[value="' + PaSDescription + '"]' ).attr( 'selected', 'selected' );
            $( '#DynamicField_PaSDescription_Search' ).focus();

            console.log( PaSDescription );
            console.log( $( '#DynamicField_PaSDescription' ).val() );
        }, 700 ); 

        	var PaSCategory = $('#DynamicField_PaSCategory').val();
        	var PaSSubCategory = $('#DynamicField_PaSSubCategory').val();                     
            var PasTitle = $('#DynamicField_PasTitle').val();
             $("#PaSTitle").val(PasTitle);
            // if ('Hardware' == PaSCategory) {
            //     $('#DynamicField_PaSSubCategory option').remove();
            //     $('#DynamicField_PaSSubCategory').append($('<option>', {value:'', text:''}));
            //     $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Camera', text:'Camera'}));
            //     $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Handheld', text:'Handheld'}));
            //     $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Mobile Phone', text:'Mobile Phone'}));
            //     $('#DynamicField_PaSSubCategory').append($('<option>', {value:'PC', text:'PC'}));
            //     $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Peripheral', text:'Peripheral'}));
            //     $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Printer', text:'Printer'}));
            //     $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Server', text:'Server'}));
            //     $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Telephony', text:'Telephony'}));           
            // }else if ('Service' == PaSCategory) {
            //     $('#DynamicField_PaSSubCategory option').remove();
            //     $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Account', text:'Account'}));
            //     $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Catalogue', text:'Catalogue'}));
            //     $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Consultancy', text:'Consultancy'}));
            //     $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Installation', text:'Installation'}));
            //     $('#DynamicField_PaSSubCategory').append($('<option>', {value:'S&M', text:'S&M'}));
            //     $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Software Testing', text:'Software Testing'}));
            //     $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Training', text:'Training'}));
            //     $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Upgrade', text:'Upgrade'}));
            //     $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Workshop', text:'Workshop'})); 
            //     $('#DynamicField_PaSSubCategory').append($('<option>', {value:'ITRR', text:'ITRR'})); 
            // }else if('Software' == PaSCategory){
        	//  $('#DynamicField_PaSSubCategory option').remove();
            //  $('#DynamicField_PaSSubCategory').append($('<option>', {value:'License', text:'License'}));
            //  $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Module', text:'Module'}));
            // }else if('Telephony' == PaSCategory){
        	//  $('#DynamicField_PaSSubCategory option').remove();
            //  $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Accessory', text:'Accessory'}));
            //  $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Broadband', text:'Broadband'}));
            //  $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Fixed Line Telephony', text:'Fixed Line Telephony'}));
            //  $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Smart Phone', text:'Smart Phone'}));
            // }else if('New Starter' == PaSCategory){
        	//  $('#DynamicField_PaSSubCategory option').remove();
            //  $('#DynamicField_PaSSubCategory').append($('<option>', {value:'New Starter', text:'New Starter'}));
            //  $('#DynamicField_PaSSubCategory').append($('<option>', {value:'New Account Creation', text:'New Account Creation'}));             
            // }         
           
            	
    // $("#DynamicField_PaSCategory").change(function () {
    // 	var PaSCategory = $('#DynamicField_PaSCategory').val();    	
    // 	if ('Service' == PaSCategory) {
    //         $('#DynamicField_PaSSubCategory option').remove();
    //         $('#DynamicField_PaSSubCategory').append($('<option>', {value:'', text:''}));
    //         $('#DynamicField_PaSSubCategory').append($('<option>', {value:'', text:''}));
    //         $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Account', text:'Account'}));
    //         $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Catalogue', text:'Catalogue'}));
    //         $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Consultancy', text:'Consultancy'}));
    //         $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Installation', text:'Installation'}));
    //         $('#DynamicField_PaSSubCategory').append($('<option>', {value:'S&M', text:'S&M'}));
    //         $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Software Testing', text:'Software Testing'}));
    //         $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Training', text:'Training'}));
    //         $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Upgrade', text:'Upgrade'}));
    //         $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Workshop', text:'Workshop'})); 
    //         $('#DynamicField_PaSSubCategory').append($('<option>', {value:'ITRR', text:'ITRR'})); 
    //     }else if ('Hardware' == PaSCategory) {        	
    //          $('#DynamicField_PaSSubCategory option').remove();
    //          $('#DynamicField_PaSSubCategory').append($('<option>', {value:'', text:''}));
    //          $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Camera', text:'Camera'}));
    //          $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Handheld', text:'Handheld'}));
    //          $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Mobile Phone', text:'Mobile Phone'}));
    //          $('#DynamicField_PaSSubCategory').append($('<option>', {value:'PC', text:'PC'}));
    //          $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Peripheral', text:'Peripheral'}));
    //          $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Printer', text:'Printer'}));
    //          $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Server', text:'Server'}));
    //          $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Telephony', text:'Telephony'}));           
    //      }else if('Software' == PaSCategory){
    //     	 $('#DynamicField_PaSSubCategory option').remove();
    //     	 $('#DynamicField_PaSSubCategory').append($('<option>', {value:'', text:''}));
    //          $('#DynamicField_PaSSubCategory').append($('<option>', {value:'License', text:'License'}));
    //          $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Module', text:'Module'}));
    //      }else if('Telephony' == PaSCategory){
    //     	 $('#DynamicField_PaSSubCategory option').remove();
    //     	 $('#DynamicField_PaSSubCategory').append($('<option>', {value:'', text:''}));
    //          $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Accessory', text:'Accessory'}));
    //          $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Broadband', text:'Broadband'}));
    //          $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Fixed Line Telephony', text:'Fixed Line Telephony'}));
    //          $('#DynamicField_PaSSubCategory').append($('<option>', {value:'Smart Phone', text:'Smart Phone'}));
    //      }else if('New Starter' == PaSCategory){
    //     	 $('#DynamicField_PaSSubCategory option').remove();
    //     	 $('#DynamicField_PaSSubCategory').append($('<option>', {value:'', text:''}));
    //          $('#DynamicField_PaSSubCategory').append($('<option>', {value:'New Starter', text:'New Starter'}));
    //          $('#DynamicField_PaSSubCategory').append($('<option>', {value:'New Account Creation', text:'New Account Creation'}));              
    //      }
    // });
    $('#SubmitPaSAdd').click(function () {
        var PasTitle = $('#DynamicField_PasTitle').val();        
        $("#PaSTitle").val(PasTitle);
    });
});

