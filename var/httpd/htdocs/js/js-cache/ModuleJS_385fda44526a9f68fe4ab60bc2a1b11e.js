"use strict";var Core=Core||{};Core.Customer=Core.Customer||{};Core.Customer.TicketList=(function(TargetNS){TargetNS.Init=function(){$('.oooTicketItemCat').each(function(){var Row1=$(this).children(".oooRow1").first();var Row2=$(this).children(".oooRow2").first();var Width1=0;var Width2=0;var MaxWidth=$(this).width();var Categories=$(this).children("p");for(var i=0;i<Categories.length;i++){var Category=$(Categories[i]);var Outer=Category.outerWidth(true);if(Width1<=Width2){if(Width1+Outer<MaxWidth){Category.appendTo(Row1);Width1+=Outer;}
else{Category.hide();}}
else{if(Width2+Outer<MaxWidth){Category.appendTo(Row2);Width2+=Outer;}
else{Category.hide();}}}});};Core.Init.RegisterNamespace(TargetNS,'APP_MODULE');return TargetNS;}(Core.Customer.TicketList||{}));

"use strict";var Core=Core||{};Core.Customer=Core.Customer||{};Core.Customer.Search=(function(TargetNS){TargetNS.Init=function(){$('#oooSearchBox').on('click',function(){$('#oooSearch').addClass('oooFull');$('#oooSearch').focus();if(Core.Config.Get('ESActive')==1&&Core.Config.Get('Action')!=='CustomerFAQExplorer'&&Core.Config.Get('Action')!=='CustomerFAQZoom'){Core.UI.Elasticsearch.InitSearchField($('#oooSearch'),"CustomerElasticsearchQuickResult");}
$('#oooSearch').on('blur',function(){setTimeout(function(){$('#oooSearch').removeClass('oooFull');$('#oooSearch').val('');},60);});});};Core.Init.RegisterNamespace(TargetNS,'APP_MODULE');return TargetNS;}(Core.Customer.Search||{}));

