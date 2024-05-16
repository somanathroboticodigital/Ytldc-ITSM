# --
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::LinkObject::PaS;

use strict;
use warnings;

use Kernel::Output::HTML::Layout;

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Log',
    'Kernel::System::Priority',
    'Kernel::System::State',
    'Kernel::System::Type',
    'Kernel::System::Web::Request',
);

=head1 NAME

Kernel::Output::HTML::LinkObject::Products - layout backend module

=head1 SYNOPSIS

All layout functions of link object (Products).

=over 4

=cut

=item new()

create an object

    $BackendObject = Kernel::Output::HTML::LinkObject::Products->new(
        UserLanguage => 'en',
        UserID     => 1,
    );

=cut

sub new {
    my ( $Type, %Param ) = @_;
    
    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    # check needed objects
    for my $Needed (qw(UserLanguage UserID)) {
        $Self->{$Needed} = $Param{$Needed} || die "Got no $Needed!";
    }

    # We need our own LayoutObject instance to avoid block data collisions
    #   with the main page.
    $Self->{LayoutObject} = Kernel::Output::HTML::Layout->new( %{$Self} );

    # define needed variables
    $Self->{ObjectData} = {
        Object   => 'PaS',
        Realname => 'PaS',
    };

    return $Self;
}

=item TableCreateComplex()

return an array with the block data

Return

    %BlockData = (
        {
            Object  => 'Products',
            Blockname => 'Products',
            Headline  => [
                {
                    Content => 'Number#',
                    Width   => 130,
                },
                {
                    Content => 'Title',
                },
                {
                    Content => 'Created',
                    Width   => 110,
                },
            ],
            ItemList => [
                [
                    {
                        Type     => 'Link',
                        Key   => $ProductsID,
                        Content  => '123123123',
                        CssClass => 'StrikeThrough',
                    },
                    {
                        Type      => 'Text',
                        Content   => 'The title',
                        MaxLength => 50,
                    },
                    {
                        Type    => 'TimeLong',
                        Content => '2008-01-01 12:12:00',
                    },
                ],
                [
                    {
                        Type    => 'Link',
                        Key  => $ProductsID,
                        Content => '434234',
                    },
                    {
                        Type      => 'Text',
                        Content   => 'The title of Products 2',
                        MaxLength => 50,
                    },
                    {
                        Type    => 'TimeLong',
                        Content => '2008-01-01 12:12:00',
                    },
                ],
            ],
        },
    );

    @BlockData = $BackendObject->TableCreateComplex(
        ObjectLinkListWithData => $ObjectLinkListRef,
    );

=cut

sub TableCreateComplex {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{ObjectLinkListWithData} || ref $Param{ObjectLinkListWithData} ne 'HASH' ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need ObjectLinkListWithData!',
        );
        return;
    }

    # convert the list
    my %LinkList;
    for my $LinkType ( sort keys %{ $Param{ObjectLinkListWithData} } ) {

        # extract link type List
        my $LinkTypeList = $Param{ObjectLinkListWithData}->{$LinkType};

        for my $Direction ( sort keys %{$LinkTypeList} ) {

            # extract direction list
            my $DirectionList = $Param{ObjectLinkListWithData}->{$LinkType}->{$Direction};

            for my $PaSID ( sort keys %{$DirectionList} ) {

                $LinkList{$PaSID}->{Data} = $DirectionList->{$PaSID};
            }
        }
    }

    # create the item list
    my @ItemList;
    for my $PaSID (
        sort { $LinkList{$a}{Data}->{Age} <=> $LinkList{$b}{Data}->{Age} }
        keys %LinkList
        )
    {

        # extract Products data
        my $PaS = $LinkList{$PaSID}{Data};

        # set css
        my $CssClass;
        if ( $PaS->{StateType} eq 'merged' ) {
            $CssClass = 'StrikeThrough';
        }

        my @ItemColumns = (
            {
                Type    => 'Link',
                Key  => $PaSID,
                Content => $PaS->{PaSNumber},
                Link    => $Self->{LayoutObject}->{Baselink}
                    . 'Action=AgentPaSZoom;PaSID='
                    . $PaSID,
                Title   => "PaS# $PaS->{PaSNumber}",
                CssClass => $CssClass,
            },
            {
                Type      => 'Text',
                Content   => $PaS->{Title},
                MaxLength => $Kernel::OM->Get('Kernel::Config')->Get('PaS::SubjectSize') || 50,
            },
            {
                Type    => 'Text',
                Content => $PaS->{Queue},
            },
            {
                Type      => 'Text',
                Content   => $PaS->{State},
                Translate => 1,
            },
            {
                Type    => 'TimeLong',
                Content => $PaS->{Created},
            },
        );
        open(TT, '>', '/tmp/file1.log');
        use Data::Dumper;
        print TT Dumper('new place');
        close(TT); 
        push @ItemList, \@ItemColumns;
    }

    return if !@ItemList;

    # define the block data
    my $ProductsHook = $Kernel::OM->Get('Kernel::Config')->Get('PaS::Hook');
    my %Block     = (
        Object  => $Self->{ObjectData}->{Object},
        Blockname => $Self->{ObjectData}->{Realname},
        Headline  => [
            {
                Content => $PaSHook,
                Width   => 130,
            },
            {
                Content => 'Title',
            },
            {
                Content => 'Queue',
                Width   => 100,
            },
            {
                Content => 'State',
                Width   => 110,
            },
            {
                Content => 'Created',
                Width   => 130,
            },
        ],
        ItemList => \@ItemList,
    );

    return ( \%Block );
}

=item TableCreateSimple()

return a hash with the link output data

Return

    %LinkOutputData = (
        Normal::Source => {
            Products => [
                {
                    Type     => 'Link',
                    Content  => 'T:55555',
                    Title   => 'Products#555555: The Products title',
                    CssClass => 'StrikeThrough',
                },
                {
                    Type    => 'Link',
                    Content => 'T:22222',
                    Title   => 'Products#22222: Title of Products 22222',
                },
            ],
        },
        ParentChild::Target => {
            Products => [
                {
                    Type    => 'Link',
                    Content => 'T:77777',
                    Title   => 'Products#77777: Products title',
                },
            ],
        },
    );

    %LinkOutputData = $BackendObject->TableCreateSimple(
        ObjectLinkListWithData => $ObjectLinkListRef,
    );

=cut

sub TableCreateSimple {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{ObjectLinkListWithData} || ref $Param{ObjectLinkListWithData} ne 'HASH' ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need ObjectLinkListWithData!'
        );
        return;
    }

    my $PaSHook = $Kernel::OM->Get('Kernel::Config')->Get('PaS::Hook');
    my %LinkOutputData;
    for my $LinkType ( sort keys %{ $Param{ObjectLinkListWithData} } ) {

        # extract link type List
        my $LinkTypeList = $Param{ObjectLinkListWithData}->{$LinkType};

        for my $Direction ( sort keys %{$LinkTypeList} ) {

            # extract direction list
            my $DirectionList = $Param{ObjectLinkListWithData}->{$LinkType}->{$Direction};

            my @ItemList;
            for my $PaSID ( sort { $a <=> $b } keys %{$DirectionList} ) {

                # extract Products data
                my $PaS = $DirectionList->{$PaSID};

                # set css
                my $CssClass;
                if ( $PaS->{StateType} eq 'merged' ) {
                    $CssClass = 'StrikeThrough';
                }

                # define item data
                my %Item = (
                    Type    => 'Link',
                    Content => 'T:' . $PaS->{PaSNumber},
                    Title   => "$PaSHook$PaS->{PaSNumber}: $PaS->{Title}",
                    Link    => $Self->{LayoutObject}->{Baselink}
                        . 'Action=AgentPaSZoom;PaSID='
                        . $ProductsID,
                    CssClass => $CssClass,
                );

                push @ItemList, \%Item;
            }

            # add item list to link output data
            $LinkOutputData{ $LinkType . '::' . $Direction }->{PaS} = \@ItemList;
        }
    }

    return %LinkOutputData;
}

=item ContentStringCreate()

return a output string

    my $String = $LayoutObject->ContentStringCreate(
        ContentData => $HashRef,
    );

=cut

sub ContentStringCreate {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{ContentData} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need ContentData!'
        );
        return;
    }

    return;
}

=item SelectableObjectList()

return an array hash with selectable objects

Return

    @SelectableObjectList = (
        {
            Key   => 'Products',
            Value => 'Products',
        },
    );

    @SelectableObjectList = $BackendObject->SelectableObjectList(
        Selected => $Identifier,  # (optional)
    );

=cut

sub SelectableObjectList {
    my ( $Self, %Param ) = @_;

    my $Selected;
    if ( $Param{Selected} && $Param{Selected} eq $Self->{ObjectData}->{Object} ) {
        $Selected = 1;
    }

    # object select list
    my @ObjectSelectList = (
        {
            Key   => $Self->{ObjectData}->{Object},
            Value   => $Self->{ObjectData}->{Realname},
            Selected => $Selected,
        },
    );

    return @ObjectSelectList;
}

=item SearchOptionList()

return an array hash with search options

Return

    @SearchOptionList = (
        {
            Key    => 'ProductsNumber',
            Name      => 'Products#',
            InputStrg => $FormString,
            FormData  => '1234',
        },
        {
            Key    => 'Title',
            Name      => 'Title',
            InputStrg => $FormString,
            FormData  => 'BlaBla',
        },
    );

    @SearchOptionList = $BackendObject->SearchOptionList(
        SubObject => 'Bla',  # (optional)
    );

=cut

sub SearchOptionList {
    my ( $Self, %Param ) = @_;

    my $ParamHook = $Kernel::OM->Get('Kernel::Config')->Get('PaS::Hook') || 'PaS#';

    # search option list
    my @SearchOptionList = (
        {
            Key  => 'PaSNumber',
            Name => $ParamHook,
            Type => 'Text',
        },
        {
            Key  => 'Title',
            Name => 'Title',
            Type => 'Text',
        },
        {
            Key  => 'PaSFulltext',
            Name => 'Fulltext',
            Type => 'Text',
        },
    );

    if ( $Kernel::OM->Get('Kernel::Config')->Get('PaS::Type') ) {
        push @SearchOptionList,
            {
            Key  => 'TypeIDs',
            Name => 'Type',
            Type => 'List',
            };
    }

    # add formkey
    for my $Row (@SearchOptionList) {
        $Row->{FormKey} = 'SEARCH::' . $Row->{Key};
    }

    # add form data and input string
    ROW:
    for my $Row (@SearchOptionList) {

        # prepare text input fields
        if ( $Row->{Type} eq 'Text' ) {

            # get form data
            $Row->{FormData} = $Kernel::OM->Get('Kernel::System::Web::Request')->GetParam( Param => $Row->{FormKey} );

            # parse the input text block
            $Self->{LayoutObject}->Block(
                Name => 'InputText',
                Data => {
                    Key   => $Row->{FormKey},
                    Value => $Row->{FormData} || '',
                },
            );

            # add the input string
            $Row->{InputStrg} = $Self->{LayoutObject}->Output(
                TemplateFile => 'LinkObject',
            );

            next ROW;
        }

        # prepare list boxes
        if ( $Row->{Type} eq 'List' ) {

            # get form data
            my @FormData = $Kernel::OM->Get('Kernel::System::Web::Request')->GetArray( Param => $Row->{FormKey} );
            $Row->{FormData} = \@FormData;

            my %ListData;
            if ( $Row->{Key} eq 'StateIDs' ) {
                %ListData = $Kernel::OM->Get('Kernel::System::State')->StateList(
                    UserID => $Self->{UserID},
                );
            }
            elsif ( $Row->{Key} eq 'PriorityIDs' ) {
                %ListData = $Kernel::OM->Get('Kernel::System::Priority')->PriorityList(
                    UserID => $Self->{UserID},
                );
            }
            elsif ( $Row->{Key} eq 'TypeIDs' ) {
                %ListData = $Kernel::OM->Get('Kernel::System::Type')->TypeList(
                    UserID => $Self->{UserID},
                );
            }

            # add the input string
            $Row->{InputStrg} = $Self->{LayoutObject}->BuildSelection(
                Data       => \%ListData,
                Name       => $Row->{FormKey},
                SelectedID => $Row->{FormData},
                Size       => 3,
                Multiple   => 1,
                Class     => 'Modernize',
            );

            next ROW;
        }
    }

    return @SearchOptionList;
}

1;

=back

=head1 TERMS AND CONDITIONS

This software is part of the OTRS project (http://otrs.org/).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (AGPL). If you
did not receive this file, see L<http://www.gnu.org/licenses/agpl.txt>.

=cut
