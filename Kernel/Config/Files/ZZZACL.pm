# OTOBO config file (automatically generated)
# VERSION:1.1
package Kernel::Config::Files::ZZZACL;
use strict;
use warnings;
no warnings 'redefine'; ## no critic qw(TestingAndDebugging::ProhibitNoWarnings)
use utf8;
sub Load {
    my ($File, $Self) = @_;

# Created: 2024-04-25 15:03:01 (Datta)
# Changed: 2024-04-25 15:04:34 (Datta)
# Comment: Allowed Open state when Ticket is in Solved state
$Self->{TicketAcl}->{'Allowed Open state when Ticket is in Solved state'} = {
  'Possible' => {
    'Ticket' => {
      'State' => [
        'Open'
      ]
    }
  },
  'PossibleAdd' => {},
  'PossibleNot' => {},
  'Properties' => {
    'Frontend' => {
      'Action' => [
        'AgentTicketPending'
      ]
    },
    'Ticket' => {
      'State' => [
        'Solved'
      ]
    }
  },
  'PropertiesDatabase' => {},
  'StopAfterMatch' => 0
};

# Created: 2024-05-14 19:29:25 (testhemant)
# Changed: 2024-05-14 19:31:28 (testhemant)
$Self->{TicketAcl}->{'Cancelled while ticket state in Waiting for Approval and Reject'} = {
  'Possible' => {
    'Ticket' => {
      'State' => [
        'Cancelled'
      ]
    }
  },
  'PossibleAdd' => {},
  'PossibleNot' => {},
  'Properties' => {
    'Frontend' => {
      'Action' => [
        'AgentTicketClose'
      ]
    },
    'Ticket' => {
      'State' => [
        'Waiting for Approval',
        'Reject'
      ],
      'Type' => [
        'Service Request'
      ]
    }
  },
  'PropertiesDatabase' => {},
  'StopAfterMatch' => 0
};

# Created: 2024-04-22 20:57:04 (Suraj)
# Changed: 2024-04-22 20:58:19 (Suraj)
$Self->{TicketAcl}->{'Change type next status'} = {
  'Possible' => {
    'Ticket' => {
      'State' => [
        'Solved'
      ]
    }
  },
  'PossibleAdd' => {},
  'PossibleNot' => {},
  'Properties' => {
    'Frontend' => {
      'Action' => [
        'AgentTicketPending'
      ]
    },
    'Ticket' => {
      'State' => [
        'In-Progress'
      ],
      'Type' => [
        'Change Request'
      ]
    }
  },
  'PropertiesDatabase' => {},
  'StopAfterMatch' => 0
};

# Created: 2024-05-15 02:00:13 (testhemant)
# Changed: 2024-05-15 02:01:40 (testhemant)
# Comment: Fields on AgentTicketFreeText while ticket type Incident
$Self->{TicketAcl}->{'Fields on AgentTicketFreeText while ticket type Incident'} = {
  'Possible' => {
    'Ticket' => {
      'DynamicField_Location' => []
    }
  },
  'PossibleAdd' => {},
  'PossibleNot' => {},
  'Properties' => {
    'Frontend' => {
      'Action' => [
        'AgentTicketFreeText'
      ]
    },
    'Ticket' => {
      'Type' => [
        'Incident'
      ]
    }
  },
  'PropertiesDatabase' => {},
  'StopAfterMatch' => 0
};

# Created: 2024-05-14 19:34:11 (testhemant)
# Changed: 2024-05-14 19:35:01 (testhemant)
# Comment: Hide Close menu module when ticket is Reject
$Self->{TicketAcl}->{'Hide Close menu module when ticket is Reject'} = {
  'Possible' => {},
  'PossibleAdd' => {},
  'PossibleNot' => {
    'Action' => [
      'AgentTicketPending'
    ]
  },
  'Properties' => {
    'Ticket' => {
      'State' => [
        'Reject'
      ]
    }
  },
  'PropertiesDatabase' => {},
  'StopAfterMatch' => 0
};

# Created: 2024-04-22 16:09:11 (Datta)
# Changed: 2024-04-25 16:34:24 (Datta)
# Comment: Hide closed state in AgentTicketPending and AgentTicketClose
$Self->{TicketAcl}->{'Hide closed state in AgentTicketPending and AgentTicketClose'} = {
  'Possible' => {},
  'PossibleAdd' => {},
  'PossibleNot' => {
    'Ticket' => {
      'State' => [
        'Closed'
      ]
    }
  },
  'Properties' => {
    'Frontend' => {
      'Action' => [
        'AgentTicketPending',
        'AgentTicketClose'
      ]
    }
  },
  'PropertiesDatabase' => {},
  'StopAfterMatch' => 0
};

# Created: 2024-04-25 13:58:07 (Datta)
# Changed: 2024-04-25 14:04:12 (Datta)
# Comment: Hide menu buttons when state is Closed and Cancelled
$Self->{TicketAcl}->{'Hide menu buttons when state is Closed and Cancelled'} = {
  'Possible' => {},
  'PossibleAdd' => {},
  'PossibleNot' => {
    'Action' => [
      'AgentTicketLock',
      'AgentTicketFreeText',
      'AgentTicketClose',
      'AgentTicketPriority',
      'AgentTicketNote',
      'AgentTicketOwner',
      'AgentTicketCustomer',
      'AgentTicketPending',
      'AgentLinkObject',
      'AgentTicketMove',
      'AgentTicketCompose',
      'AgentTicketMerge'
    ]
  },
  'Properties' => {
    'Ticket' => {
      'State' => [
        'Closed',
        'Cancelled'
      ]
    }
  },
  'PropertiesDatabase' => {},
  'StopAfterMatch' => 0
};

# Created: 2024-04-25 14:50:35 (Datta)
# Changed: 2024-04-25 14:53:51 (Datta)
# Comment: Hide menu buttons when state is Solved
$Self->{TicketAcl}->{'Hide menu buttons when state is Solved'} = {
  'Possible' => {},
  'PossibleAdd' => {},
  'PossibleNot' => {
    'Action' => [
      'AgentTicketClose',
      'AgentTicketFreeText',
      'AgentTicketLock',
      'AgentTicketPriority',
      'AgentTicketOwner',
      'AgentTicketCustomer',
      'AgentLinkObject',
      'AgentTicketMerge',
      'AgentTicketMove',
      'AgentTicketNote'
    ]
  },
  'Properties' => {
    'Ticket' => {
      'State' => [
        'Solved'
      ]
    }
  },
  'PropertiesDatabase' => {},
  'StopAfterMatch' => 0
};

# Created: 2024-04-25 20:19:14 (Datta)
# Changed: 2024-04-25 20:20:47 (Datta)
# Comment: Hide menu module when ticket is New State
$Self->{TicketAcl}->{'Hide menu module when ticket is New State'} = {
  'Possible' => {},
  'PossibleAdd' => {},
  'PossibleNot' => {
    'Action' => [
      'AgentTicketClose'
    ]
  },
  'Properties' => {
    'Ticket' => {
      'State' => [
        'New'
      ]
    }
  },
  'PropertiesDatabase' => {},
  'StopAfterMatch' => 0
};

# Created: 2024-05-15 01:41:31 (testhemant)
# Changed: 2024-05-15 01:43:28 (testhemant)
# Comment: Incident Type in CustomerTicketMessage
$Self->{TicketAcl}->{'Incident Type in CustomerTicketMessage'} = {
  'Possible' => {
    'Ticket' => {
      'Type' => [
        'Incident'
      ]
    }
  },
  'PossibleAdd' => {},
  'PossibleNot' => {},
  'Properties' => {
    'Frontend' => {
      'Action' => [
        'CustomerTicketMessage'
      ]
    }
  },
  'PropertiesDatabase' => {},
  'StopAfterMatch' => 0
};

# Created: 2024-04-25 20:25:01 (Datta)
# Changed: 2024-04-25 20:26:23 (Datta)
# Comment: Open state in Customerticketzoom
$Self->{TicketAcl}->{'Open state in Customerticketzoom'} = {
  'Possible' => {
    'Ticket' => {
      'State' => [
        'Open'
      ]
    }
  },
  'PossibleAdd' => {},
  'PossibleNot' => {},
  'Properties' => {
    'Frontend' => {
      'Action' => [
        'CustomerTicketZoom'
      ]
    },
    'Ticket' => {
      'State' => [
        'Open'
      ]
    }
  },
  'PropertiesDatabase' => {},
  'StopAfterMatch' => 0
};

# Created: 2024-05-13 15:15:36 (Somanath.Taradale)
# Changed: 2024-05-13 17:15:47 (Somanath.Taradale)
# Comment: SRApproved - Next Status
$Self->{TicketAcl}->{'SR Approved - Next Status'} = {
  'Possible' => {
    'Ticket' => {
      'State' => [
        'In-Progress',
        'On-Hold',
        'Open',
        'Pending'
      ]
    }
  },
  'PossibleAdd' => {},
  'PossibleNot' => {},
  'Properties' => {
    'Frontend' => {
      'Action' => [
        'AgentTicketPending'
      ]
    }
  },
  'PropertiesDatabase' => {
    'Ticket' => {
      'DynamicField_Level1ApprovalStatus' => [
        'Approved'
      ],
      'State' => [
        'Approved'
      ],
      'Type' => [
        'Service Request'
      ]
    }
  },
  'StopAfterMatch' => 0
};

# Created: 2024-05-10 02:14:24 (Datta)
# Changed: 2024-05-14 19:49:51 (testhemant)
# Comment: Show Approve and Reject state in AgentTicketPending
$Self->{TicketAcl}->{'Show Approve and Reject state in AgentTicketPending'} = {
  'Possible' => {
    'Ticket' => {
      'State' => [
        'Approved',
        'Reject'
      ]
    }
  },
  'PossibleAdd' => {},
  'PossibleNot' => {},
  'Properties' => {
    'Frontend' => {
      'Action' => [
        'AgentTicketPending'
      ]
    }
  },
  'PropertiesDatabase' => {
    'Ticket' => {
      'State' => [
        'Waiting for Approval'
      ],
      'Type' => [
        'Service Request'
      ]
    }
  },
  'StopAfterMatch' => 0
};

# Created: 2024-04-25 15:09:05 (Datta)
# Changed: 2024-04-26 14:46:24 (Datta)
# Comment: Show Open State in Pending Screen when ticket is new state
$Self->{TicketAcl}->{'Show Open State in Pending Screen when ticket is new state'} = {
  'Possible' => {
    'Ticket' => {
      'State' => [
        'Open'
      ]
    }
  },
  'PossibleAdd' => {},
  'PossibleNot' => {},
  'Properties' => {
    'Frontend' => {
      'Action' => [
        'AgentTicketPending'
      ]
    },
    'Ticket' => {
      'State' => [
        'New'
      ]
    }
  },
  'PropertiesDatabase' => {},
  'StopAfterMatch' => 0
};

# Created: 2024-04-22 19:02:10 (Datta)
# Changed: 2024-04-22 19:05:10 (Datta)
# Comment: State Set to In-progress from CustomerTicketZoom
$Self->{TicketAcl}->{'State Set to In-progress from CustomerTicketZoom'} = {
  'Possible' => {
    'Ticket' => {
      'State' => [
        'In-Progress'
      ]
    }
  },
  'PossibleAdd' => {},
  'PossibleNot' => {},
  'Properties' => {
    'Frontend' => {
      'Action' => [
        'CustomerTicketZoom'
      ]
    },
    'Ticket' => {
      'State' => [
        'Pending',
        'Solved',
        'On-Hold'
      ]
    }
  },
  'PropertiesDatabase' => {},
  'StopAfterMatch' => 0
};

# Created: 2024-04-26 14:49:45 (Datta)
# Changed: 2024-04-26 14:55:32 (Datta)
# Comment: States for incident type in Pending screen
$Self->{TicketAcl}->{'States for incident type in Pending screen'} = {
  'Possible' => {
    'Ticket' => {
      'State' => [
        'Open',
        'In-Progress',
        'On-Hold',
        'Pending',
        'Solved',
        'Cancelled'
      ]
    }
  },
  'PossibleAdd' => {},
  'PossibleNot' => {},
  'Properties' => {
    'Frontend' => {
      'Action' => [
        'AgentTicketPending',
        'AgentTicketClose'
      ]
    },
    'Ticket' => {
      'Type' => [
        'Incident'
      ]
    }
  },
  'PropertiesDatabase' => {},
  'StopAfterMatch' => 0
};

# Created: 2024-04-22 19:04:00 (Suraj)
# Changed: 2024-04-22 19:05:37 (Suraj)
$Self->{TicketAcl}->{'Waiting for Approval Next status'} = {
  'Possible' => {
    'Ticket' => {
      'State' => [
        'Rejected',
        'Approved'
      ]
    }
  },
  'PossibleAdd' => {},
  'PossibleNot' => {},
  'Properties' => {
    'Frontend' => {
      'Action' => [
        'AgentTicketPending'
      ]
    },
    'Ticket' => {
      'State' => [
        'Waiting for Approval'
      ],
      'Type' => [
        'Change Request'
      ]
    }
  },
  'PropertiesDatabase' => {},
  'StopAfterMatch' => 0
};

# Created: 2024-05-14 19:26:00 (testhemant)
# Changed: 2024-05-14 19:26:00 (testhemant)
# Comment: only cancle styate
$Self->{TicketAcl}->{'only cancle styate'} = {
  'Possible' => {},
  'PossibleAdd' => {},
  'PossibleNot' => {},
  'Properties' => {},
  'PropertiesDatabase' => {},
  'StopAfterMatch' => 0
};



    return;
}
1;
