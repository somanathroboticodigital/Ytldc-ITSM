# --
# Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::LinkObject::PaS;

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::PaS',
    'Kernel::System::Log',
);

=head1 NAME

Kernel/System/LinkObject/Products.pm - LinkObject backend for Products

=over 4

=cut

=item new()

create an object

    use Kernel::System::ObjectManager;
    local $Kernel::OM = Kernel::System::ObjectManager->new();
    my $LinkObjectProductsObject = $Kernel::OM->Get('Kernel::System::LinkObject::Products');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

=item LinkListWithData()

fill up the link list with data

    $Success = $LinkObjectBackend->LinkListWithData(
        LinkList => $HashRef,
        UserID   => 1,
    );

=cut

sub LinkListWithData {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(LinkList UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # check link list
    if ( ref $Param{LinkList} ne 'HASH' ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'LinkList must be a hash reference!',
        );
        return;
    }

    for my $LinkType ( sort keys %{ $Param{LinkList} } ) {

        for my $Direction ( sort keys %{ $Param{LinkList}->{$LinkType} } ) {

            PaSID:
            for my $PaSID ( sort keys %{ $Param{LinkList}->{$LinkType}->{$Direction} } ) {

                # get Products data
                my $PaSData = $Kernel::OM->Get('Kernel::System::PaS')->PaSGet(
                    PaSID => $PaSID,
                    UserID   => $Param{UserID},
                );

                # remove id from hash if ProductsGet() returns no results
                if ( !$PaSData ) {
                    delete $Param{LinkList}->{$LinkType}->{$Direction}->{$PaSID};
                    next PaSID;
                }

                # add Products data
                $Param{LinkList}->{$LinkType}->{$Direction}->{$PaSID} = $PaSData;
            }
        }
    }

    return 1;
}

=item ObjectPermission()

checks read permission for a given object and UserID.

    $Permission = $LinkObject->ObjectPermission(
        Object  => 'Products',
        Key     => 123,
        UserID  => 1,
    );

=cut

sub ObjectPermission {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Object Key UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # get config of Products zoom frontend module
    $Self->{Config} = $Kernel::OM->Get('Kernel::Config')->Get('PaS::Frontend::AgentPaSZoom');

    # check permissions
#    my $Access = $Kernel::OM->Get('Kernel::System::Products')->Permission(
#        Type     => $Self->{Config}->{Permission},
#        ProductsID => $Param{Key},
#        UserID   => $Param{UserID},
#    );

    return 1;
}

=item ObjectDescriptionGet()

return a hash of object descriptions

Return
    %Description = (
        Normal => "Products# 2009102110001674",
        Long   => "Products# 2009102110001674: The Products Title",
    );

    %Description = $LinkObject->ObjectDescriptionGet(
        Key     => 123,
        UserID  => 1,
    );

=cut

sub ObjectDescriptionGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Object Key UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # create description
    my %Description = (
        Normal => 'PaS',
        Long   => 'PaS',
    );

    return %Description if $Param{Mode} && $Param{Mode} eq 'Temporary';

    # get Products data
    my $PaSData = $Kernel::OM->Get('Kernel::System::PaS')->PaSGet(
        PaSID => $Param{Key},
        UserID   => $Param{UserID},
    );

    return if !$PaSData;
    return if !%{$PaSData};

    # define description text
    my $PaSHook      = $Kernel::OM->Get('Kernel::Config')->Get('PaS::Hook');
    my $DescriptionText = "$PaSHook $PaSData->{PaSNumber}";

    # create description
    %Description = (
        Normal => $DescriptionText,
        Long   => "$DescriptionText: $PaSData->{PaSTitle}",
    );

    return %Description;
}

=item ObjectSearch()

return a hash list of the search results

Return
    $SearchList = {
        NOTLINKED => {
            Source => {
                12  => $DataOfItem12,
                212 => $DataOfItem212,
                332 => $DataOfItem332,
            },
        },
    };

    $SearchList = $LinkObjectBackend->ObjectSearch(
        SearchParams => $HashRef,    # (optional)
        UserID       => 1,
    );

=cut

sub ObjectSearch {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{UserID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need UserID!',
        );
        return;
    }

    # set default params
    $Param{SearchParams} ||= {};

    # add wildcards
    my %Search;
    for my $Element (qw(PaSNumber PaSTitle WorkOrderTitle)) {
        if ( $Param{SearchParams}->{$Element} ) {
            $Search{$Element} = '*' . $Param{SearchParams}->{$Element} . '*';
        }
    }

    # search the Productss
    # no need to use OrderBy here, because it is sorted in TableCreateComplex and TableCreateSimple
    my $PaSIDsRef = $Kernel::OM->Get('Kernel::System::PaS')->PaSSearch(
        %{ $Param{SearchParams} },
        %Search,
        UsingWildcards => 1,
        MirrorDB       => 1,

        # TODO:
        # use sysconfig option for 'limit' instead, decide wheater this option would be only
        # valid for linking Productss, or just use a global setting for all linking stuff
        Limit => 200,

        UserID => $Param{UserID},
    );

    my %SearchList;
    PaSID:
    for my $PaSID ( @{$PaSIDsRef} ) {

        # get Products data
        my $PaSData = $Kernel::OM->Get('Kernel::System::PaS')->PaSGet(
            PaSID => $PaSID,
            UserID   => $Param{UserID},
        );

        next PaSID if !$PaSData;

        # add Products data
        $SearchList{NOTLINKED}->{Source}->{$PaSID} = $PaSData;
        
    }

    return \%SearchList;
}

=item LinkAddPre()

link add pre event module

    $True = $LinkObject->LinkAddPre(
        Key          => 123,
        SourceObject => 'Products',
        SourceKey    => 321,
        Type         => 'Normal',
        State        => 'Valid',
        UserID       => 1,
    );

    or

    $True = $LinkObject->LinkAddPre(
        Key          => 123,
        TargetObject => 'Products',
        TargetKey    => 321,
        Type         => 'Normal',
        State        => 'Valid',
        UserID       => 1,
    );

=cut

sub LinkAddPre {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Key UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # do not trigger event for temporary links
    return 1 if $Param{State} eq 'Temporary';

    return 1;
}

=item LinkAddPost()

link add pre event module

    $True = $LinkObject->LinkAddPost(
        Key          => 123,
        SourceObject => 'Products',
        SourceKey    => 321,
        Type         => 'Normal',
        State        => 'Valid',
        UserID       => 1,
    );

    or

    $True = $LinkObject->LinkAddPost(
        Key          => 123,
        TargetObject => 'Products',
        TargetKey    => 321,
        Type         => 'Normal',
        State        => 'Valid',
        UserID       => 1,
    );

=cut

sub LinkAddPost {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Key Type State UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # do not trigger event for temporary links
    return 1 if $Param{State} eq 'Temporary';

    # get information about linked object
    my $ID     = $Param{TargetKey}    || $Param{SourceKey};
    my $Object = $Param{TargetObject} || $Param{SourceObject};

    # trigger ProductsLinkAddPost-Event
    $Kernel::OM->Get('Kernel::System::PaS')->EventHandler(
        Event => 'PaSLinkAddPost',
        Data  => {
            PaSID => $Param{Key},
            Object   => $Object,         # the other object of the link
            ID       => $ID,             # id of the other object
            Type     => $Param{Type},    # the link type
            %Param,
        },
        UserID => $Param{UserID},
    );

    return 1;
}

=item LinkDeletePre()

link delete pre event module

    $True = $LinkObject->LinkDeletePre(
        Key          => 123,
        SourceObject => 'Products',
        SourceKey    => 321,
        Type         => 'Normal',
        State        => 'Valid',
        UserID       => 1,
    );

    or

    $True = $LinkObject->LinkDeletePre(
        Key          => 123,
        TargetObject => 'Products',
        TargetKey    => 321,
        Type         => 'Normal',
        State        => 'Valid',
        UserID       => 1,
    );

=cut

sub LinkDeletePre {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Key Type State UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # do not trigger event for temporary links
    return 1 if $Param{State} eq 'Temporary';

    return 1;
}

=item LinkDeletePost()

link delete post event module

    $True = $LinkObject->LinkDeletePost(
        Key          => 123,
        SourceObject => 'Products',
        SourceKey    => 321,
        Type         => 'Normal',
        State        => 'Valid',
        UserID       => 1,
    );

    or

    $True = $LinkObject->LinkDeletePost(
        Key          => 123,
        TargetObject => 'Products',
        TargetKey    => 321,
        Type         => 'Normal',
        State        => 'Valid',
        UserID       => 1,
    );

=cut

sub LinkDeletePost {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(Key Type State UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # do not trigger event for temporary links
    return 1 if $Param{State} eq 'Temporary';

    # get information about linked object
    my $ID     = $Param{TargetKey}    || $Param{SourceKey};
    my $Object = $Param{TargetObject} || $Param{SourceObject};

    # trigger ProductsLinkDeletePost-Event
    $Kernel::OM->Get('Kernel::System::PaS')->EventHandler(
        Event => 'PaSLinkDeletePost',
        Data  => {
            PaSID => $Param{Key},
            Object   => $Object,         # the other object of the link
            ID       => $ID,             # id of the other object
            Type     => $Param{Type},    # the link type
            %Param,
        },
        UserID => $Param{UserID},
    );

    return 1;
}

1;

=back

=head1 TERMS AND CONDITIONS

This software is part of the OTRS project (http://otrs.org/).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (AGPL). If you
did not receive this file, see L<http://www.gnu.org/licenses/agpl.txt>.

=cut
