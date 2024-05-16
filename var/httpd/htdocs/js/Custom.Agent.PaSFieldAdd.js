$(document).ready(function () {	
	$( "#DynamicField_Answers" ).hide();
	$( "#LabelDynamicField_Answers" ).hide();
	$( "#DynamicField_Default" ).hide();
	$( "#LabelDynamicField_Default" ).hide();
	
	$("#DynamicField_QuestionType").change(function () {		
        var questionType   = $('#DynamicField_QuestionType').val();       
                if ('Dropdown' == questionType || 'Checkbox' == questionType || 'Radio Button' == questionType || 'Multiselect' == questionType) {                 	
                	$( "#DynamicField_Answers" ).show();
                	$( "#LabelDynamicField_Answers" ).show();
                    } else {
                    	$( "#DynamicField_Answers" ).hide();
                    	$( "#LabelDynamicField_Answers" ).hide();
                    }
                if( 'Alphanumeric' == questionType || 'Numeric' == questionType || 'Free Text' == questionType ){
                	$( "#DynamicField_DefaultText" ).show();
                	$( "#LabelDynamicField_DefaultText" ).show();
                	$( "#DynamicField_Default" ).hide();
                	$( "#LabelDynamicField_Default" ).hide();                	
                } else{
                	$( "#DynamicField_DefaultText" ).hide();
                	$( "#LabelDynamicField_DefaultText" ).hide();
                	$( "#DynamicField_Default" ).show();
                	$( "#LabelDynamicField_Default" ).show();
                } if( 'Numeric (Currency)' == questionType ){
                	$( "#DynamicField_DefaultText" ).show();
                	$( "#LabelDynamicField_DefaultText" ).show();
                	$( "#DynamicField_Default" ).hide();
                	$( "#LabelDynamicField_Default" ).hide(); 
                } 
            });
});