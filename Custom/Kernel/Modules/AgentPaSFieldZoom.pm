# --
# Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::AgentPaSFieldZoom;


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

    # get needed objects
    my $ParamObject  = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $DynamicFieldObject        = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');
    

    # get params
    my $QuestionID = $ParamObject->GetParam( Param => "QuestionID" );
	my $PaSID = $ParamObject->GetParam( Param => 'PaSID' );

	
	# store needed parameters in %GetParam to make it reloadable
	my %GetParam;
	for my $ParamName (
		qw(PaSID)
		)
	{
		$GetParam{$ParamName} = $ParamObject->GetParam( Param => $ParamName );
	}
    # check needed stuff
    if ( !$QuestionID ) {
        return $LayoutObject->ErrorScreen(
            Message => 'No QuestionID is given!',
            Comment => 'Please contact the admin.',
        );
    }

    # get needed objects
    my $ProductObject = $Kernel::OM->Get('Kernel::System::Question');
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    # get config of frontend module
    $Self->{Config} = $ConfigObject->Get("Question::Frontend::AgentPaSFieldZoom");
    
    
    # get Product data
    my $Question = $ProductObject->QuestionGet(
        QuestionID => $QuestionID,
        UserID   => $Self->{UserID},
    );
    
    
    
    # check error
    if ( !$Question ) {
        return $LayoutObject->ErrorScreen(
            Message => "Product '$QuestionID' not found in database!",
            Comment => 'Please contact the admin.',
        );
    }
    # output header
    my $Output = $LayoutObject->Header(
         Value => 'Test Title',
    );
    $Output .= $LayoutObject->NavigationBar();

    # get log object
    my $LogObject = $Kernel::OM->Get('Kernel::System::Log');
    
    my $PaS = $Question->{PaSID};
	 # run Product menu modules    
    if ( ref $ConfigObject->Get('Question::Frontend::MenuModule') eq 'HASH' ) {

     # get items for menu
     my %Menus   = %{ $ConfigObject->Get('Question::Frontend::MenuModule') };
     my $Counter = 0;
   
     for my $Menu ( sort keys %Menus ) {

	 # redirect to AgentPaSZoom
	 $Menus{$Menu}->{Link} = "Action=AgentPaSZoom;PaSID=$PaS"
	 if ( $Menu eq '010-Back');
	  # redirect to AgentQuestionEdit
	 $Menus{$Menu}->{Link} = "Action=AgentPaSFieldEdit;QuestionID=$QuestionID;PaSID=$PaS"
	 if ( $Menu eq '020-Edit');
     $Menus{$Menu}->{Link} = "Action=AgentPaSFieldDelete;QuestionID=$QuestionID;PaSID=$PaS"
     if ( $Menu eq '030-Delete');
    
     # if ( $Menu eq '030-Delete');

	# load module
            if ( $Kernel::OM->Get('Kernel::System::Main')->Require( $Menus{$Menu}->{Module} ) ) {
                my $Object = $Menus{$Menu}->{Module}->new(
                    %{$Self},
                    QuestionID => $QuestionID,
                );

                # set classes                
                if ( $Menus{$Menu}->{Target} ) {

                    if ( $Menus{$Menu}->{Target} eq 'PopUp' ) {
                        $Menus{$Menu}->{MenuClass} = 'AsPopup';
                    }
                    elsif ( $Menus{$Menu}->{Target} eq 'Back' ) {
                        $Menus{$Menu}->{MenuClass} = 'HistoryBack';
                    }
                
                    elsif ( $Menus{$Menu}->{Target} eq 'ConfirmationDialog' ) {
                            $Menus{$Menu}->{Class} = 'AsConfirmationDialog';
                        }

                }
			
                # run module
                $Counter = $Object->Run(
                    %Param,
                    Question  => $Question,
                    Counter => $Counter,
                    Config  => $Menus{$Menu},
                    MenuID  => $Menu,
                );
            }
            else {
                return $LayoutObject->FatalError();
            }

	  
        }
        
       
    }
  
      # get user object
    my $UserObject = $Kernel::OM->Get('Kernel::System::User');

    # get agents preferences
    my %UserPreferences = $UserObject->GetPreferences(
        UserID => $Self->{UserID},
    );
 # get Product builder data
    my %ProductBuilderUser = $UserObject->GetUserData(
        UserID => $Question->{ChangeBy},
        Cached => 1,
    );
	
	# get create user data
    my %CreateUser = $UserObject->GetUserData(
        UserID => $Question->{CreatedBy},
        Cached => 1,
    );

	
	
    # get Product user data
    my %ProductUser = $UserObject->GetUserData(
        UserID => $Question->{ChangeBy},
        Cached => 1,
    );

    # all postfixes needed for user information
    my @Postfixes = qw(UserLogin UserFirstname UserLastname);

    # get user information for ProductBuilder, CreateBy, ProductBy
    for my $Postfix (@Postfixes) {
        $Question->{ 'ProductBuilder' . $Postfix } = $ProductBuilderUser{$Postfix};
        $Question->{ 'Create' . $Postfix }        = $CreateUser{$Postfix};
        $Question->{ 'Change' . $Postfix }        = $ProductUser{$Postfix};
    }

  
   # get link object
    my $LinkObject = $Kernel::OM->Get('Kernel::System::LinkObject');

    # get linked objects which are directly linked with this Product object
    my $LinkListWithData = $LinkObject->LinkListWithData(
        Object => 'Question',
        Key    => $QuestionID,
        State  => 'Valid',
        UserID => $Self->{UserID},
    );
	
	 # add combined linked objects from workorder to linked objects from Product object
    $LinkListWithData = {
        %{$LinkListWithData},
       
    };

    # get link table view mode
    my $LinkTableViewMode = $ConfigObject->Get('LinkObject::ViewMode');

    # create the link table
    my $LinkTableStrg = $LayoutObject->LinkObjectTableCreate(
        LinkListWithData => $LinkListWithData,
        ViewMode         => $LinkTableViewMode,
    );

    # output the link table
    if ($LinkTableStrg) {
        $LayoutObject->Block(
            Name => 'LinkTable' . $LinkTableViewMode,
            Data => {
                LinkTableStrg => $LinkTableStrg,
            },
        );
    }	
    # remember if user already closed message about links in iframes
    if ( !defined $Self->{DoNotShowBrowserLinkMessage} ) {
        if ( $UserPreferences{UserAgentDoNotShowBrowserLinkMessage} ) {
            $Self->{DoNotShowBrowserLinkMessage} = 1;
        }
        else {
            $Self->{DoNotShowBrowserLinkMessage} = 0;
        }
    }

    # show message about links in iframes, if user didn't close it already
    if ( !$Self->{DoNotShowBrowserLinkMessage} ) {
        $LayoutObject->Block(
            Name => 'BrowserLinkMessage',
        );
    }

    # get security restriction setting for iframes
    # security="restricted" may break SSO - disable this feature if requested
    my $MSSecurityRestricted;
    if ( $ConfigObject->Get('DisableMSIFrameSecurityRestricted') ) {
        $MSSecurityRestricted = '';
    }
    else {
        $MSSecurityRestricted = 'security="restricted"';
    }


    

    # get the dynamic fields for this screen
    my $DynamicField = $DynamicFieldObject->DynamicFieldListGet(
	Valid      => 1,
	ObjectType  => [ 'Question' ],
	FieldFilter => $ConfigObject->Get("Question::Frontend::$Self->{Action}")->{DynamicField} || {},
    );


    # cycle trough the activated Dynamic Fields
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( @{$DynamicField} ) {
     #   next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

        my $Value = $DynamicFieldBackendObject->ValueGet(
            DynamicFieldConfig => $DynamicFieldConfig,
            ObjectID           => $QuestionID,
        );

        # get print string for this dynamic field
        my $ValueStrg = $DynamicFieldBackendObject->DisplayValueRender(
            DynamicFieldConfig => $DynamicFieldConfig,
            Value              => $Value,
            ValueMaxChars      => 100,
            LayoutObject       => $LayoutObject,
        );

        # for empty values
        if ( !$ValueStrg->{Value} ) {
            $ValueStrg->{Value} = '-';
        }

        my $Label = $DynamicFieldConfig->{Label};

        $LayoutObject->Block(
            Name => 'DynamicField',
            Data => {
                Label => $Label,
            },
        );

        if ( $ValueStrg->{Link} ) {

            # output link element
            $LayoutObject->Block(
                Name => 'DynamicFieldLink',
                Data => {
                    %{$Question},
                    Value                       => $ValueStrg->{Value},
                    Title                       => $ValueStrg->{Title},
                    Link                        => $ValueStrg->{Link},
                    $DynamicFieldConfig->{Name} => $ValueStrg->{Title}
                },
            );
        }
        else {

            # output non link element
            $LayoutObject->Block(
                Name => 'DynamicFieldPlain',
                Data => {
                    Value => $ValueStrg->{Value},
                    Title => $ValueStrg->{Title},
                },
            );
        }

        # example of dynamic fields order customization
        $LayoutObject->Block(
            Name => 'DynamicField' . $DynamicFieldConfig->{Name},
            Data => {
                Label => $Label,
                Value => $ValueStrg->{Value},
                Title => $ValueStrg->{Title},
            },
        );
    }
	

    # start template output
    $LayoutObject->Block(
        TemplateFile => 'AgentPaSFieldZoom',
         Name => 'Meta',
        Data         => {
            %{$Question},
        },
    );

  # output meta block
    $LayoutObject->Block(
        Name => 'Meta',
        Data => {
            %{$Question},
        },
    );
	 
	
     $Output .= $LayoutObject->Output(
        TemplateFile => 'AgentPaSFieldZoom',
        Data         => {
            %{$Question},
            $PaSID,
          
        },
    );
    # add footer
    $Output .= $LayoutObject->Footer();

    return $Output;
}

1;
