# --
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::AgentPaSPrint;

use strict;
use warnings;

use Kernel::System::VariableCheck qw(:all);
use Kernel::System::DynamicField;
use Kernel::System::DynamicField::Backend;
use Kernel::System::VariableCheck qw(:all);
our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
   

    my $Output;
    
	# get param object
	my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');

	# get needed PaSID
	my $PaSID = $ParamObject->GetParam( Param => 'PaSID' );
	
    # get params
    my %GetParam;
    $GetParam{PaSID} = $Kernel::OM->Get('Kernel::System::Web::Request')->GetParam( Param => 'PaSID' );
	
    # check needed stuff
    if ( !$GetParam{PaSID} ) {
        return $LayoutObject->ErrorScreen(
            Message => 'No PaSID is given!',
            Comment => 'Please contact the admin.',
        );
    }

	# get PaS object
	my $PaSObject = $Kernel::OM->Get('Kernel::System::PaS');
	
    # get PaS item data
    my %PaSData = $PaSObject->PaSGet(
        PaSID     => $PaSID,
         UserID     => $Self->{UserID},
    );
    
     my $PaSPrintData = $PaSObject->PaSGet(
        PaSID     => $PaSID,
         UserID     => $Self->{UserID},
    );
  
    if ( !%PaSData ) {
        return $LayoutObject->ErrorScreen();
    }

    # get link object
    my $LinkObject = $Kernel::OM->Get('Kernel::System::LinkObject');

    # get linked objects
    my $LinkListWithData = $LinkObject->LinkListWithData(
        Object => 'PaS',
        Key    => $GetParam{PaSID},
        State  => 'Valid',
        UserID => $Self->{UserID},
    );

    # get link type list
    my %LinkTypeList = $LinkObject->TypeList(
        UserID => $Self->{UserID},
    );

    # get the link data
    my %LinkData;
    if ( $LinkListWithData ) {
        %LinkData = $LayoutObject->LinkObjectTableCreate(
            LinkListWithData => $LinkListWithData,
            ViewMode         => 'SimpleRaw',
        );
    }

    # get config object
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    # prepare fields data
    FIELD:
    for my $Field (qw(Field1 Field2 Field3 Field4 Field5 Field6)) {
        next FIELD if !$PaSData{$Field};

        # no quoting if HTML view is enabled
        next FIELD if $ConfigObject->Get('PaS::HTML');

        # HTML quoting
        $PaSData{$Field} = $LayoutObject->Ascii2Html(
            NewLine        => 0,
            Text           => $PaSData{$Field},
            VMax           => 5000,
            HTMLResultMode => 1,
            LinkFeature    => 1,
        );
    }

    # get user object
    my $UserObject = $Kernel::OM->Get('Kernel::System::User');

    # get user info (CreatedBy)
    my %UserInfo = $UserObject->GetUserData(
        UserID => $Self->{UserID}
    );
    $Param{CreatedByLogin} = $UserInfo{UserLogin};

    # get user info (ChangedBy)
    %UserInfo = $UserObject->GetUserData(
        UserID => $Self->{UserID}
    );
    $Param{ChangedByLogin} = $UserInfo{UserLogin};

    # get PDF object
    my $PDFObject = $Kernel::OM->Get('Kernel::System::PDF');

    # generate PDF output
    my $PrintedBy = $LayoutObject->{LanguageObject}->Translate('printed by');
    my $Time      = $LayoutObject->{Time};
    my %Page;

    # get maximum number of pages
    $Page{MaxPages} = $ConfigObject->Get('PDF::MaxPages');
    if ( !$Page{MaxPages} || $Page{MaxPages} < 1 || $Page{MaxPages} > 1000 ) {
        $Page{MaxPages} = 100;
    }
    my $HeaderRight  = $ConfigObject->Get('PaS::Hook') . $PaSPrintData->{PaSNumber};
    my $HeadlineLeft = $HeaderRight;
    my $Title        = $HeaderRight;
     if ( $PaSPrintData->{DynamicField_PasTitle} ) {
        $HeadlineLeft = $PaSPrintData->{DynamicField_PasTitle};
        $Title .= ' / ' . $PaSPrintData->{DynamicField_PasTitle};
    }

    $Page{MarginTop}    = 30;
    $Page{MarginRight}  = 40;
    $Page{MarginBottom} = 40;
    $Page{MarginLeft}   = 40;
    $Page{HeaderRight}  = $HeaderRight;
    $Page{FooterLeft}   = '';
    $Page{PageText}     = $LayoutObject->{LanguageObject}->Translate('Page');
    $Page{PageCount}    = 1;

    # create new PDF document
    $PDFObject->DocumentNew(
        Title  => $ConfigObject->Get('PaS') . ': ' . $Title,
        Encode => $LayoutObject->{UserCharset},
    );

    # create first PDF page
    $PDFObject->PageNew(
        %Page,
        FooterRight => $Page{PageText} . ' ' . $Page{PageCount},
    );
    $Page{PageCount}++;

    $PDFObject->PositionSet(
        Move => 'relativ',
        Y    => -6,
    );

    # output title
    $PDFObject->Text(
        Text     =>  $PaSPrintData->{DynamicField_PasTitle},
        FontSize => 13,
    );

    $PDFObject->PositionSet(
        Move => 'relativ',
        Y    => -6,
    );

    # output "printed by"
    $PDFObject->Text(
        Text => $PrintedBy . ' '
            . $Self->{UserFirstname} . ' '
            . $Self->{UserLastname} . ' ('
            . $Self->{UserEmail} . ')'
            . ', ' . $Time,
        FontSize => 9,
    );

    $PDFObject->PositionSet(
        Move => 'relativ',
        Y    => -14,
    );

  

 # output PaS dynamic fields
    $Self->_PDFOutputPaSDynamicFields(
        PageData => \%Page,
        PaSData  => \%PaSData,
    );
    # get time object
    my $TimeObject = $Kernel::OM->Get('Kernel::System::Time');

    # return the PDF document
    my $Filename = 'PaS' . $GetParam{PaSID};
    my ( $s, $m, $h, $D, $M, $Y ) = $TimeObject->SystemTime2Date(
        SystemTime => $TimeObject->SystemTime(),
    );
    $M = sprintf( "%02d", $M );
    $D = sprintf( "%02d", $D );
    $h = sprintf( "%02d", $h );
    $m = sprintf( "%02d", $m );
    my $PDFString = $PDFObject->DocumentOutput();
    return $LayoutObject->Attachment(
        Filename    => $Filename . "_" . "$Y-$M-$D" . "_" . "$h-$m.pdf",
        ContentType => "application/pdf",
        Content     => $PDFString,
        Type        => 'inline',
    );

}

sub _PDFOutputPaSDynamicFields {
    my ( $Self, %Param ) = @_;
    my $DynamicFieldObject        = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');
     my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
    # check needed stuff
    for my $Needed (qw(PageData PaSData)) {
        if ( !defined( $Param{$Needed} ) ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!",
            );
            return;
        }
    }
    my $Output = 0;
    my %PaS    = %{ $Param{PaSData} };
    my %Page   = %{ $Param{PageData} };
    my %GetParam;
    $GetParam{PaSID} = $Kernel::OM->Get('Kernel::System::Web::Request')->GetParam( Param => 'PaSID' );
    
    
    my %TableParam;
    my $Row = 0;

    # get dynamic field config for frontend module
    my $DynamicFieldFilter = $Kernel::OM->Get('Kernel::Config')->Get("PaS::Frontend::AgentPaSPrint")->{DynamicField};

    # get the dynamic fields for PaS object
    my $DynamicField = $DynamicFieldObject->DynamicFieldListGet(
	Valid      => 1,
	ObjectType  => [ 'PaS' ],
	 FieldFilter => $DynamicFieldFilter || {},
    );
  

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # generate table
    # cycle trough the activated Dynamic Fields for PaS object
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( @{$DynamicField} ) {
   #     next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

        # get dynamic field backend object
        my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

        my $Value = $DynamicFieldBackendObject->ValueGet(
            DynamicFieldConfig => $DynamicFieldConfig,
            ObjectID           => $GetParam{PaSID},
        );

        next DYNAMICFIELD if !$Value;
        next DYNAMICFIELD if $Value eq "";

        # get print string for this dynamic field
        my $ValueStrg = $DynamicFieldBackendObject->DisplayValueRender(
            DynamicFieldConfig => $DynamicFieldConfig,
            Value              => $Value,
            HTMLOutput         => 0,
            LayoutObject       => $LayoutObject,
        );

        $TableParam{CellData}[$Row][0]{Content}
            = $LayoutObject->{LanguageObject}->Translate( $DynamicFieldConfig->{Label} )
            . ':';
        $TableParam{CellData}[$Row][0]{Font}    = 'ProportionalBold';
        $TableParam{CellData}[$Row][1]{Content} = $ValueStrg->{Value};

        $Row++;
        $Output = 1;
    }

    $TableParam{ColumnData}[0]{Width} = 80;
    $TableParam{ColumnData}[1]{Width} = 431;

    # get PDF object
    my $PDFObject = $Kernel::OM->Get('Kernel::System::PDF');

    # output PaS dynamic fields
    if ($Output) {

        # set new position
        $PDFObject->PositionSet(
            Move => 'relativ',
            Y    => -15,
        );

        # output headline
        $PDFObject->Text(
            Text     => $LayoutObject->{LanguageObject}->Translate('PaS Details'),
            Height   => 7,
            Type     => 'Cut',
            Font     => 'ProportionalBoldItalic',
            FontSize => 7,
            Color    => '#666666',
        );

        # set new position
        $PDFObject->PositionSet(
            Move => 'relativ',
            Y    => -4,
        );

        # table params
        $TableParam{Type}            = 'Cut';
        $TableParam{Border}          = 0;
        $TableParam{FontSize}        = 6;
        $TableParam{BackgroundColor} = '#DDDDDD';
        $TableParam{Padding}         = 1;
        $TableParam{PaddingTop}      = 3;
        $TableParam{PaddingBottom}   = 3;

        # output table
        PAGE:
        for ( $Page{PageCount} .. $Page{MaxPages} ) {

            # output table (or a fragment of it)
            %TableParam = $PDFObject->Table( %TableParam, );

            # stop output or output next page
            if ( $TableParam{State} ) {
                last PAGE;
            }
            else {
                $PDFObject->PageNew(
                    %Page,
                    FooterRight => $Page{PageText} . ' ' . $Page{PageCount},
                );
                $Page{PageCount}++;
            }
        }
    }
    return 1;
}


1;
