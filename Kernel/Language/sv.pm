# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2004 Mats Eric Olausson <mats at synergy.se>
# Copyright (C) 2009 Mikael Mattsson" <Mikael.Mattsson at konsumvarmland.se>
# Copyright (C) 2013 Andreas Berger" <andreas.berger at hagfors.se>
# Copyright (C) 2019-2024 Rother OSS GmbH, https://otobo.de/
# --
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
# --

package Kernel::Language::sv;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # $$START$$
    # possible charsets
    $Self->{Charset} = ['utf-8', ];
    # date formats (%A=WeekDay;%B=LongMonth;%T=Time;%D=Day;%M=Month;%Y=Year;)
    $Self->{DateFormat}          = '%D/%M %Y %T';
    $Self->{DateFormatLong}      = '%A %D. %B %Y %T';
    $Self->{DateFormatShort}     = '%Y.%M.%D';
    $Self->{DateInputFormat}     = '%Y.%M.%D';
    $Self->{DateInputFormatLong} = '%Y.%M.%D - %T';
    $Self->{Completeness}        = 0.339622641509434;

    # csv separator
    $Self->{Separator}         = ';';

    $Self->{DecimalSeparator}  = ',';
    $Self->{ThousandSeparator} = '.';
    $Self->{Translation} = {

        # Template: AdminACL
        'ACL Management' => 'Hantera behörigheter',
        'Actions' => 'Åtgärder',
        'Create New ACL' => 'Skapa ny ACL-regel',
        'Deploy ACLs' => 'Driftsätt ACL-regler',
        'Export ACLs' => 'Exportera behörigheter',
        'Filter for ACLs' => 'Filtrera ACL-regler',
        'Just start typing to filter...' => 'Börja skriva för att filtrera...',
        'Configuration Import' => 'Import av konfiguration',
        'Here you can upload a configuration file to import ACLs to your system. The file needs to be in .yml format as exported by the ACL editor module.' =>
            'Importera konfigurationsfiler för ACL-regler. Filen ska vara i .yml-format (som när exporterad från ACL-redigeraren).',
        'This field is required.' => 'Detta fält är obligatoriskt',
        'Overwrite existing ACLs?' => 'Skirv över existerande behörigheter?',
        'Upload ACL configuration' => 'Importera ACL-konfiguration',
        'Import ACL configuration(s)' => 'Importera ACL-konfigurationer',
        'Description' => 'Beskrivning',
        'To create a new ACL you can either import ACLs which were exported from another system or create a complete new one.' =>
            'För att skapa en ACL-regel kan du antingen importera ACL-regler som exporterats från en annan OTOBO-installation eller skapa en ny.',
        'Changes to the ACLs here only affect the behavior of the system, if you deploy the ACL data afterwards. By deploying the ACL data, the newly made changes will be written to the configuration.' =>
            '',
        'ACLs' => 'ACL-regler',
        'Please note: This table represents the execution order of the ACLs. If you need to change the order in which ACLs are executed, please change the names of the affected ACLs.' =>
            '',
        'ACL name' => 'Namn på behörighet',
        'Comment' => 'Kommentar',
        'Validity' => 'Giltighet',
        'Export' => 'Exportera',
        'Copy' => 'Kopiera',
        'No data found.' => 'Ingen data hittades.',
        'No matches found.' => 'Inga träffar hittades.',

        # Template: AdminACLEdit
        'Edit ACL %s' => 'Redigera ACL-regel %s',
        'Edit ACL' => '',
        'Go to overview' => 'Gå till översikt',
        'Delete ACL' => 'Radera behörighet',
        'Delete Invalid ACL' => 'Radera ogiltig behörighet',
        'Match settings' => 'Matcha inställningar',
        'Set up matching criteria for this ACL. Use \'Properties\' to match the current screen or \'PropertiesDatabase\' to match attributes of the current ticket that are in the database.' =>
            '',
        'Change settings' => 'Ändra inställningar',
        'Set up what you want to change if the criteria match. Keep in mind that \'Possible\' is a white list, \'PossibleNot\' a black list.' =>
            '',
        'Check the official %sdocumentation%s.' => '',
        'Show or hide the content' => 'Visa eller dölj innehållet',
        'Edit ACL Information' => '',
        'Name' => 'Namn',
        'Stop after match' => 'Avsluta efter träff',
        'Edit ACL Structure' => '',
        'Save ACL' => '',
        'Save' => 'Spara',
        'or' => 'eller',
        'Save and finish' => 'Spara och slutför',
        'Cancel' => 'Avbryt',
        'Do you really want to delete this ACL?' => 'Vill du verkligen radera denna ACL-regel?',

        # Template: AdminACLNew
        'Create a new ACL by submitting the form data. After creating the ACL, you will be able to add configuration items in edit mode.' =>
            '',

        # Template: AdminAbout
        'About' => '',
        'Toggle this widget' => 'Ändra denna widget',
        'This language is not present or enabled on the system. This text could be deleted if it is not needed anymore.' =>
            '',
        'Remove Language' => '',
        'Text' => 'Text',
        'Message body' => 'Meddelandekropp',
        'This field is required and must have less than 4000 characters.' =>
            '',
        'Remove About Language' => '',
        'Add new language' => '',
        'Save Changes' => 'Spara ändringar',

        # Template: AdminAppointmentCalendarManage
        'Calendar Management' => 'Kalenderhantering',
        'Add Calendar' => 'Lägg till kalender',
        'Edit Calendar' => 'Redigera kalender',
        'Calendar Overview' => 'Kalenderöversikt',
        'Add new Calendar' => 'Lägg till kalender',
        'Import Appointments' => 'Importera kalenderhändelser',
        'Calendar Import' => 'Importera kalendrar ',
        'Here you can upload a configuration file to import a calendar to your system. The file needs to be in .yml format as exported by calendar management module.' =>
            '',
        'Overwrite existing entities' => '',
        'Upload calendar configuration' => 'Läs in kalenderkonfiguration',
        'Import Calendar' => 'Importera kalender',
        'Filter for Calendars' => '',
        'Filter for calendars' => 'Kalenderfilter',
        'Depending on the group field, the system will allow users the access to the calendar according to their permission level.' =>
            '',
        'Read only: users can see and export all appointments in the calendar.' =>
            '',
        'Move into: users can modify appointments in the calendar, but without changing the calendar selection.' =>
            '',
        'Create: users can create and delete appointments in the calendar.' =>
            '',
        'Read/write: users can manage the calendar itself.' => '',
        'Group' => 'Grupp',
        'Changed' => 'Ändrat',
        'Created' => 'Skapat',
        'Download' => 'Nerladdning',
        'URL' => 'URL',
        'Export calendar' => 'Exportera kalendern',
        'Download calendar' => 'Hämta kalendern',
        'Copy public calendar URL' => 'Kopiera kalenderns publika URL',
        'Calendar' => 'Kalender',
        'Calendar name' => 'Kalendernamn',
        'Calendar with same name already exists.' => '',
        'Color' => 'Färg',
        'Permission group' => '',
        'Ticket Appointments' => '',
        'Rule' => 'Regel',
        'Remove this entry' => 'Ta bort denna post',
        'Remove' => 'Ta bort',
        'Start date' => 'Startdatum',
        'End date' => 'Slutdatum',
        'Use options below to narrow down for which tickets appointments will be automatically created.' =>
            '',
        'Queues' => 'Köer',
        'Please select a valid queue.' => '',
        'Search attributes' => '',
        'Add entry' => 'Lägg till post',
        'Add' => 'Lägg till',
        'Define rules for creating automatic appointments in this calendar based on ticket data.' =>
            '',
        'Add Rule' => 'Lägg till regel',
        'Submit' => 'Spara',

        # Template: AdminAppointmentImport
        'Appointment Import' => 'Kalenderhändelseimport',
        'Go back' => 'Tillbaka till översikten',
        'Uploaded file must be in valid iCal format (.ics).' => 'Inlästa filer måste vara iCal-filer (.ics).',
        'If desired Calendar is not listed here, please make sure that you have at least \'create\' permissions.' =>
            '',
        'Upload' => 'Ladda upp',
        'Update existing appointments?' => 'Uppdatera nuvarande kalenderhändelser?',
        'All existing appointments in the calendar with same UniqueID will be overwritten.' =>
            'Alla nuvarande kalenderhändelser med samma ID skrivs över.',
        'Upload calendar' => 'Läs in en kalender',
        'Import appointments' => 'Importera kalenderhändelser',

        # Template: AdminAppointmentNotificationEvent
        'Appointment Notification Management' => 'Kalenderhändelsepåminnelsehantering',
        'Add Notification' => 'Lägg till Meddelande',
        'Edit Notification' => 'Redigera notifiering',
        'Export Notifications' => 'Exportmeddelanden',
        'Filter for Notifications' => '',
        'Filter for notifications' => '',
        'Here you can upload a configuration file to import appointment notifications to your system. The file needs to be in .yml format as exported by the appointment notification module.' =>
            'Du kan läsa in en konfigurationsfil med kalenderhändelsepåminnelser. Filen behöver vara på det  .yml-format som du får vid export från kalenderhändelsepåminnelse-vyn.',
        'Overwrite existing notifications?' => 'Skriv över existerande notifieringar?',
        'Upload Notification configuration' => '',
        'Import Notification configuration' => '',
        'List' => 'Lista',
        'Delete' => 'Radera',
        'Delete this notification' => 'Radera denna notifiering',
        'Show in agent preferences' => 'Visa i handläggarinställningar',
        'Agent preferences tooltip' => '',
        'This message will be shown on the agent preferences screen as a tooltip for this notification.' =>
            '',
        'Events' => 'Händelser',
        'Event' => 'Händelse',
        'Here you can choose which events will trigger this notification. An additional appointment filter can be applied below to only send for appointments with certain criteria.' =>
            'Bestäm vilka händelser som aktiverar denna påminnelsenotifiering. Ytterligare filter kan appliceras för att endast skicka påminnelser för kalenderhändelser som uppfyller filterkriterierna. ',
        'Appointment Filter' => 'Kalenderhändelsfilter',
        'Type' => 'Typ',
        'Title' => 'Titel',
        'Location' => 'Plats',
        'Team' => 'Grupp',
        'Resource' => 'Resurs',
        'Recipients' => 'Mottagare',
        'Send to' => 'Skicka till',
        'Send to these agents' => 'Skicka till följande handläggare',
        'Send to all group members (agents only)' => '',
        'Send to all role members' => 'Skicka till alla rollmedlemmar',
        'Send on out of office' => 'Skicka frånvaromeddelande',
        'Also send if the user is currently out of office.' => 'Skicka även om användaren inte är inne.',
        'Once per day' => 'En gång om dagen',
        'Notify user just once per day about a single appointment using a selected transport.' =>
            '',
        'Notification Methods' => 'Notifieringsmetoder',
        'These are the possible methods that can be used to send this notification to each of the recipients. Please select at least one method below.' =>
            'Dessa metoder finns för att skicka den här notifieringen till var och en av mottagarna. Välj minst en metod nedan.',
        'Enable this notification method' => 'Aktivera denna notifieringsmetod',
        'Transport' => '',
        'At least one method is needed per notification.' => 'Minst en metod krävs per notifiering.',
        'Active by default in agent preferences' => '',
        'This is the default value for assigned recipient agents who didn\'t make a choice for this notification in their preferences yet. If the box is enabled, the notification will be sent to such agents.' =>
            '',
        'This feature is currently not available.' => 'Den här funktionen är just nu inte tillgänglig.',
        'Upgrade to %s' => 'Uppgradera till %s',
        'Please activate this transport in order to use it.' => '',
        'No data found' => 'Inget data funnet.',
        'No notification method found.' => 'Ingen notifieringsmetod funnen.',
        'Notification Text' => 'Notifieringstext',
        'This language is not present or enabled on the system. This notification text could be deleted if it is not needed anymore.' =>
            'Det här språket finns ej, eller är ej aktiverat i systemet. Denna notifieringstext kan raderas om den inte behövs längre.',
        'Remove Notification Language' => 'Radera notifieringsspråk',
        'Subject' => 'Ämne',
        'Add new notification language' => 'Lägg till nytt notifieringsspråk',
        'Tag Reference' => '',
        'Notifications are sent to an agent.' => 'Påminnelser skickas till handläggare.',
        'You can use the following tags' => 'Du kan använda följande taggar',
        'To get the first 20 character of the appointment title.' => '',
        'To get the appointment attribute' => '',
        ' e. g.' => ' t.ex.',
        'To get the calendar attribute' => '',
        'Attributes of the recipient user for the notification' => '',
        'Config options' => 'Konfigurationsinställningar',
        'Example notification' => 'Exempelnotifiering',

        # Template: AdminAppointmentNotificationEventTransportEmailSettings
        'Additional recipient email addresses' => 'Ytterligare mottagaradresser',
        'This field must have less then 200 characters.' => '',
        'Article visible for customer' => '',
        'An article will be created if the notification is sent to the customer or an additional email address.' =>
            '',
        'Email template' => 'E-postmall',
        'Use this template to generate the complete email (only for HTML emails).' =>
            '',
        'Enable email security' => '',
        'Email security level' => '',
        'If signing key/certificate is missing' => '',
        'If encryption key/certificate is missing' => '',

        # Template: AdminAttachment
        'Attachment Management' => 'Hantering av bifogade dokument',
        'Add Attachment' => 'Lägg till bilaga',
        'Edit Attachment' => 'Redigera bilaga',
        'Filter for Attachments' => 'Filter för bilagor',
        'Filter for attachments' => '',
        'Filename' => 'Filnamn',
        'Download file' => 'Hämta fil',
        'Delete this attachment' => 'Radera bilaga',
        'Do you really want to delete this attachment?' => 'Vill du verkligen radera denna bilaga?',
        'Attachment' => 'Bifogat dokument',

        # Template: AdminAutoResponse
        'Auto Response Management' => 'Autosvar-hantering',
        'Add Auto Response' => 'Lägg till Autosvar',
        'Edit Auto Response' => 'Redigera autosvar',
        'Filter for Auto Responses' => '',
        'Filter for auto responses' => '',
        'Response' => 'Svar',
        'Auto response from' => 'Autosvar från',
        'Reference' => 'Referens',
        'To get the first 20 character of the subject.' => 'För att få dom första 20 tecknen i ärenderaden',
        'To get the first 5 lines of the email.' => 'För att få dom första fem raderna i mejlet',
        'To get the name of the ticket\'s customer user (if given).' => '',
        'To get the article attribute' => 'För att hämta artikelattribut',
        'Options of the current customer user data' => 'Inställningar för kundens användardata',
        'Ticket owner options' => 'Alternativ för ärendeägare',
        'Ticket responsible options' => 'Alternativ för ärendeansvarig',
        'Options of the current user who requested this action' => 'Alternativ för nuvarande användare som begärde denna åtgärd',
        'Options of the ticket data' => 'Alternativ för ärendedata',
        'Options of ticket dynamic fields internal key values' => '',
        'Options of ticket dynamic fields display values, useful for Dropdown and Multiselect fields' =>
            '',
        'Example response' => 'Exempelsvar',

        # Template: AdminCloudServiceSupportDataCollector
        'Cloud Service Management' => 'Molntjänsthantering',
        'Support Data Collector' => 'Supportdata-insamlaren',
        'Support data collector' => 'Supportdata-insamlaren',
        'Hint' => 'Tips',
        'Currently support data is only shown in this system.' => 'Supportdata finns för tillfället endast lokalt i din OTOBO-installation.',
        'It is sometimes recommended to send this data to the OTOBO team in order to get better support.' =>
            '',
        'Configuration' => 'Konfiguration',
        'Send support data' => 'Sänd supportdata',
        'This will allow the system to send additional support data information to the OTOBO team.' =>
            '',
        'Update' => 'Uppdatera',
        'System Registration' => 'Registrera OTOBO-installationen',
        'To enable data sending, please register your system with the OTOBO team or update your system registration information (make sure to activate the \'send support data\' option.)' =>
            '',
        'Register this System' => 'Registrera denna OTOBO-installation',
        'System Registration is disabled for your system. Please check your configuration.' =>
            'Registering är inaktiverad för OTOBO-installationen. Kontrollera konfigurationen.',

        # Template: AdminCloudServices
        'System registration is a service of OTOBO team, which provides a lot of advantages!' =>
            '',
        'Please note that the use of OTOBO cloud services requires the system to be registered.' =>
            'För att använda OTOBO-cloudtjänsterna behöver OTOBO-installationen registreras.',
        'Register this system' => 'Registrera denna OTOBO-installation',
        'Here you can configure available cloud services that communicate securely with %s.' =>
            '',
        'Available Cloud Services' => 'Tillgängliga molntjänster',

        # Template: AdminCommunicationLog
        'Communication Log' => '',
        'Time Range' => '',
        'Show only communication logs created in specific time range.' =>
            '',
        'Filter for Communications' => '',
        'Filter for communications' => '',
        'In this screen you can see an overview about incoming and outgoing communications.' =>
            '',
        'You can change the sort and order of the columns by clicking on the column header.' =>
            '',
        'If you click on the different entries, you will get redirected to a detailed screen about the message.' =>
            '',
        'Status for: %s' => '',
        'Failing accounts' => '',
        'Some account problems' => '',
        'No account problems' => '',
        'No account activity' => '',
        'Number of accounts with problems: %s' => '',
        'Number of accounts with warnings: %s' => '',
        'Failing communications' => '',
        'No communication problems' => '',
        'No communication logs' => '',
        'Number of reported problems: %s' => '',
        'Open communications' => '',
        'No active communications' => '',
        'Number of open communications: %s' => '',
        'Average processing time' => '',
        'List of communications (%s)' => '',
        'Settings' => 'Inställningar',
        'Entries per page' => '',
        'No communications found.' => '',
        '%s s' => '',

        # Template: AdminCommunicationLogAccounts
        'Account Status' => '',
        'Back to overview' => '',
        'Filter for Accounts' => '',
        'Filter for accounts' => '',
        'You can change the sort and order of those columns by clicking on the column header.' =>
            '',
        'Account status for: %s' => '',
        'Status' => 'Status',
        'Account' => '',
        'Edit' => 'Redigera',
        'No accounts found.' => '',
        'Communication Log Details (%s)' => '',
        'Direction' => 'Riktning',
        'Start Time' => 'Starttid',
        'End Time' => '',
        'No communication log entries found.' => '',

        # Template: AdminCommunicationLogCommunications
        'Duration' => '',

        # Template: AdminCommunicationLogObjectLog
        '#' => '',
        'Priority' => 'Prioritet',
        'Module' => 'Modul',
        'Information' => 'Information',
        'No log entries found.' => '',

        # Template: AdminCommunicationLogZoom
        'Detail view for %s communication started at %s' => '',
        'Filter for Log Entries' => '',
        'Filter for log entries' => '',
        'Show only entries with specific priority and higher:' => '',
        'Communication Log Overview (%s)' => '',
        'No communication objects found.' => '',
        'Communication Log Details' => '',
        'Please select an entry from the list.' => '',

        # Template: AdminContactWD
        'Contact with data management' => '',
        'Contact with data' => '',
        'Add contact with data' => '',
        'Edit contact with data' => '',
        'Back to search results' => 'Tillbaka till sökresultat',
        'Select' => 'Välj',
        'Search' => 'Sök',
        'Wildcards like \'*\' are allowed.' => 'Jokertecken som \'*\' är tillåtna.',
        'Please enter a search term to look for contacts with data.' => '',
        'Valid' => 'Giltigt',

        # Template: AdminCustomerAccept
        'Privacy Policy Management' => '',
        'Privacy Policy' => '',
        'Remove PrivacyPolicy Language' => '',

        # Template: AdminCustomerCompany
        'Customer Management' => 'Hantera kunder',
        'Add Customer' => 'Lägg till kund',
        'Edit Customer' => 'Redigera kund',
        'List (only %s shown - more available)' => 'Lista (bara %s visas - fler tillgängliga)',
        'total' => 'totalt',
        'Please enter a search term to look for customers.' => 'Skriv in sökord för att hitta kunder.',
        'Customer ID' => 'Kund-ID',
        'Please note' => '',
        'This customer backend is read only!' => '',

        # Template: AdminCustomerGroup
        'Manage Customer-Group Relations' => 'Hantera kopplingar mellan kunder och grupper',
        'Notice' => 'OBS',
        'This feature is disabled!' => 'Denna funktion är avaktiverad!',
        'Just use this feature if you want to define group permissions for customers.' =>
            'Använd endast denna funktion om du vill kunna ange grupprättigheter för kunder.',
        'Enable it here!' => 'Aktivera den här!',
        'Edit Customer Default Groups' => 'Redigera grupper för kunder',
        'These groups are automatically assigned to all customers.' => 'Dessa grupper kopplas automatiskt till alla kunder.',
        'You can manage these groups via the configuration setting "CustomerGroupCompanyAlwaysGroups".' =>
            '',
        'Filter for Groups' => 'Filtrera grupper',
        'Select the customer:group permissions.' => 'Välj behörighet för customer:group.',
        'If nothing is selected, then there are no permissions in this group (tickets will not be available for the customer).' =>
            '',
        'Search Results' => 'Sökresultat',
        'Customers' => 'Kunder',
        'Groups' => 'Grupper',
        'Change Group Relations for Customer' => 'Ändra grupprelationer för kunden',
        'Change Customer Relations for Group' => 'Ändra kundrelationer för gruppen',
        'Toggle %s Permission for all' => 'Växla %s Rättighet för alla',
        'Toggle %s permission for %s' => 'Växla %s rättigheter för %s',
        'Customer Default Groups:' => 'Standardgrupper för kund:',
        'No changes can be made to these groups.' => 'Inga ändringar kan göras för dessa grupper.',
        'ro' => 'läs',
        'Read only access to the ticket in this group/queue.' => 'Endast läsrättighet till ärenden i denna grupp/kö.',
        'rw' => 'skriv',
        'Full read and write access to the tickets in this group/queue.' =>
            'Fulla läs- och skrivrättigheter till ärenden i denna grupp/kö.',

        # Template: AdminCustomerUser
        'Customer User Management' => 'Hantera kundanvändare',
        'Add Customer User' => 'Lägg till kundanvändare',
        'Edit Customer User' => 'Redigera kundanvändare',
        'Customer user are needed to have a customer history and to login via customer panel.' =>
            'Kundanvändare krävs för kundhistorik och inloggning via kundsidan.',
        'List (%s total)' => 'Lista (%s totalt)',
        'Username' => 'Användarnamn',
        'Email' => 'E-post',
        'Last Login' => 'Senaste inloggning',
        'Login as' => 'Logga in som',
        'Switch to customer' => 'Växla till kund',
        'This customer backend is read only, but the customer user preferences can be changed!' =>
            '',
        'This field is required and needs to be a valid email address.' =>
            'Detta fält är obligatoriskt och måste vara en giltig e-postadress',
        'This email address is not allowed due to the system configuration.' =>
            'Denna e-postadress är ogiltig enligt systemetinställningarna.',
        'This email address failed MX check.' => 'Denna e-postadress klarade inte MX-kontroll.',
        'DNS problem, please check your configuration and the error log.' =>
            'DNS-problem. Se över inställningarna och felloggen.',
        'The syntax of this email address is incorrect.' => 'Formatet för denna e-postadress är felaktigt.',
        'This CustomerID is invalid.' => '',
        'Effective Permissions for Customer User' => '',
        'Group Permissions' => '',
        'This customer user has no group permissions.' => '',
        'Table above shows effective group permissions for the customer user. The matrix takes into account all inherited permissions (e.g. via customer groups). Note: The table does not consider changes made to this form without submitting it.' =>
            '',
        'Customer Access' => '',
        'Customer' => 'Kund',
        'This customer user has no customer access.' => '',
        'Table above shows granted customer access for the customer user by permission context. The matrix takes into account all inherited access (e.g. via customer groups). Note: The table does not consider changes made to this form without submitting it.' =>
            '',

        # Template: AdminCustomerUserCustomer
        'Manage Customer User-Customer Relations' => '',
        'Select the customer user:customer relations.' => '',
        'Customer Users' => 'Kundanvändare',
        'Change Customer Relations for Customer User' => '',
        'Change Customer User Relations for Customer' => '',
        'Toggle active state for all' => 'Växla aktivt tillstånd för alla',
        'Active' => 'Aktivera',
        'Toggle active state for %s' => 'Växla aktivt tillstånd för %s',

        # Template: AdminCustomerUserGroup
        'Manage Customer User-Group Relations' => '',
        'Just use this feature if you want to define group permissions for customer users.' =>
            '',
        'Edit Customer User Default Groups' => '',
        'These groups are automatically assigned to all customer users.' =>
            '',
        'You can manage these groups via the configuration setting "CustomerGroupAlwaysGroups".' =>
            'Du kan hantera dessa grupper via "CustomerGroupAlwaysGroups".',
        'Filter for groups' => '',
        'Select the customer user - group permissions.' => '',
        'If nothing is selected, then there are no permissions in this group (tickets will not be available for the customer user).' =>
            '',
        'Customer User Default Groups:' => '',

        # Template: AdminCustomerUserService
        'Manage Customer User-Service Relations' => '',
        'Edit default services' => 'Redigera standardtjänster',
        'Filter for Services' => 'Filter för Tjänster',
        'Filter for services' => '',
        'Services' => 'Tjänster',

        # Template: AdminDynamicField
        'Dynamic Fields Management' => 'Hantera dynamiska fält',
        'Add new field for object' => 'Lägg till fält för objekt',
        'Filter for Dynamic Fields' => '',
        'Filter for dynamic fields' => '',
        'New Dynamic Fields' => '',
        'Would you like to benefit from additional dynamic field types? You have full access to the following field types:' =>
            '',
        'Database' => 'Databas',
        'Use external databases as configurable data sources for this dynamic field.' =>
            '',
        'Web service' => '',
        'External web services can be configured as data sources for this dynamic field.' =>
            '',
        'This feature allows to add (multiple) contacts with data to tickets.' =>
            '',
        'To add a new field, select the field type from one of the object\'s list, the object defines the boundary of the field and it can\'t be changed after the field creation.' =>
            '',
        'Dynamic Fields List' => 'Lista över dynamiska fält.',
        'Dynamic fields per page' => 'Dynamiska fält per sida',
        'Label' => 'Etikett',
        'Order' => 'Sortering',
        'Object' => 'Objekt',
        'Delete this field' => 'Radera detta fält',

        # Template: AdminDynamicFieldAdvanced
        'Import / Export' => '',
        'Here you can upload a configuration file to import dynamic fields to your system. The file needs to be in .yml format as exported by dynamic field management module.' =>
            '',
        'DynamicFields Import' => '',
        'DynamicFields Export' => '',
        'Dynamic Fields Screens' => '',
        'Here you can manage the dynamic fields in the respective screens.' =>
            '',

        # Template: AdminDynamicFieldCheckbox
        'Dynamic Fields' => 'Dynamiska fält',
        'Go back to overview' => 'Tillbaka till översikten',
        'General' => 'Generellt',
        'This field is required, and the value should be alphabetic and numeric characters only.' =>
            'Detta fält är obligatoriskt och får enbart innehålla siffror och bokstäver.',
        'Must be unique and only accept alphabetic and numeric characters.' =>
            'Måste vara unikt och endast innehålla siffror och bokstäver.',
        'Changing this value will require manual changes in the system.' =>
            'Om du ändrar denna inställning krävs även manuella ändringar i systemet.',
        'This is the name to be shown on the screens where the field is active.' =>
            'Detta är namnet som visas i vyer där fältet är aktivt.',
        'Field order' => 'Fältordning',
        'This field is required and must be numeric.' => 'Detta fält är obilgatoriskt och måste innehålla siffror.',
        'This is the order in which this field will be shown on the screens where is active.' =>
            '',
        'Tooltip message:' => '',
        'This is the tooltip message shown inside the customer interface.' =>
            '',
        'Is not possible to invalidate this entry, all config settings have to be changed beforehand.' =>
            '',
        'Field type' => 'Fälttyp',
        'Object type' => 'Objekttyp',
        'Internal field' => 'Internt fält',
        'This field is protected and can\'t be deleted.' => 'Detta fält är skyddat och kan ej raderas.',
        'This dynamic field is used in the following config settings:' =>
            '',
        'Field Settings' => 'Fältinställningar',
        'Default value' => 'Standardvärde',
        'This is the default value for this field.' => 'Detta är standardvärdet för det här fältet.',

        # Template: AdminDynamicFieldContactWD
        'Add or edit contacts' => '',
        'To add contacts to this field please fill out all the needed information and save it.' =>
            '',
        'Click on the field name from the overview to edit it and find the corresponding action in the sidebar or from the \'Tickets\' menu.' =>
            '',
        'Name Field' => '',
        'ValidID Field' => '',
        'Other Fields' => '',
        'Key' => 'Nyckel',
        'Value' => 'Innehåll',
        'Remove value' => 'Ta bort värde',
        'Add Field' => '',
        'Add value' => 'Lägg till värde',
        'These are the possible data attributes for contacts.' => '',
        'Mandatory fields' => '',
        'Comma separated list of mandatory keys (optional). Keys \'Name\' and \'ValidID\' are always mandatory and doesn\'t have to be listed here.' =>
            '',
        'Sorted fields' => '',
        'Comma separated list of keys in sort order (optional). Keys listed here come first, all remaining fields afterwards and sorted alphabetically.' =>
            '',
        'Searchable fields' => '',
        'Comma separated list of searchable keys (optional). Key \'Name\' is always searchable and doesn\'t have to be listed here.' =>
            '',
        'Translatable values' => 'Översättningsbara värden',
        'If you activate this option the values will be translated to the user defined language.' =>
            'Om du aktiverar detta val kommer värdena översättas till användarens språk.',
        'Note' => 'Notering',
        'You need to add the translations manually into the language translation files.' =>
            'Du behöver lägga till översättningarna manuellt i språköversättningsfilerna.',

        # Template: AdminDynamicFieldDB
        'Possible values' => 'Möjliga värden',
        'Datatype' => '',
        'Filter' => 'Filter',
        'Searchfield' => '',
        'Listfield' => '',
        'Show link' => 'Visa länk',
        'Here you can specify an optional HTTP link for the field value in Overviews and Zoom screens.' =>
            '',
        'Example' => 'Exempel',
        'You can reference the field with its own field name. You can also refer to other fields, e.g. with \'DynamicField_OtherFieldName\'.' =>
            '',
        'Link for preview' => 'Länk för förhandsgranskning',
        'If filled in, this URL will be used for a preview which is shown when this link is hovered in ticket zoom. Please note that for this to work, the regular URL field above needs to be filled in, too.' =>
            '',
        'SID' => '',
        'Driver' => '',
        'Server' => '',
        'Port' => 'Port',
        'Table / View' => '',
        'User' => 'Användare',
        'Password' => 'Lösenord',
        'Identifier' => 'Identifierare',
        'Must be unique column from the table entered in Table/View.' => '',
        'Multiselect' => '',
        'CacheTTL' => '',
        'Searchprefix' => '',
        'Searchsuffix' => '',
        'Result Limit' => '',
        'Case Sensitive' => '',

        # Template: AdminDynamicFieldDateTime
        'Default date difference' => '',
        'This field must be numeric.' => 'Detta fält måste vara numeriskt.',
        'The difference from NOW (in seconds) to calculate the field default value (e.g. 3600 or -60).' =>
            '',
        'Define years period' => 'Ange en tidsperiod',
        'Activate this feature to define a fixed range of years (in the future and in the past) to be displayed on the year part of the field.' =>
            '',
        'Years in the past' => 'Antal år bakåt',
        'Years in the past to display (default: 5 years).' => 'Antal år bakåt att visa (skönsvärde: 5 år).',
        'Years in the future' => 'Antal år framåt',
        'Years in the future to display (default: 5 years).' => 'Antal år framåt att visa (skönsvärde: 5 år).',
        'If special characters (&, @, :, /, etc.) should not be encoded, use \'url\' instead of \'uri\' filter.' =>
            '',
        'Restrict entering of dates' => 'Begränsa datuminmatning',
        'Here you can restrict the entering of dates of tickets.' => 'Här kan du begränsa inmatningen av datum för ärenden.',

        # Template: AdminDynamicFieldDropdown
        'Add Value' => 'Lägg till värde',
        'Add empty value' => 'Lägg till tomt värde',
        'Activate this option to create an empty selectable value.' => 'Aktivera detta val för att skapa ett tomt valbart värde.',
        'Tree View' => 'Träd-vy',
        'Activate this option to display values as a tree.' => 'Aktivera detta val för att visa värden som ett träd.',

        # Template: AdminDynamicFieldImportExport
        '%s - %s' => '',
        'Select the items you want to ' => '',
        'Select the desired elements and confirm the import with \'import\'.' =>
            '',
        'Here you can export a configuration file of dynamic fields and dynamic field screens to import these on another system. The configuration file is exported in yml format.' =>
            '',
        'The following dynamic fields can not be imported because of an invalid backend.' =>
            '',
        'Toggle all available elements' => '',
        'Fields' => 'Fält',
        'Screens' => '',

        # Template: AdminDynamicFieldScreen
        'Management of Dynamic Fields <-> Screens' => '',
        'Overview' => 'Översikt',
        'Default Columns Screens' => '',
        'Add DynamicField' => '',
        'You can assign elements to this Screen/Field by dragging the elements with the mouse from the left list to the right list.' =>
            '',
        'Ordering the elements within the list is also possible by drag \'n\' drop.' =>
            '',
        'Filter available elements' => '',
        'selected to available elements' => '',
        'Available Elements' => '',
        'Filter disabled elements' => '',
        'selected to disabled elements' => '',
        'Toggle all disabled elements' => '',
        'Disabled Elements' => '',
        'Filter assigned elements' => '',
        'selected to assigned elements' => '',
        'Toggle all assigned elements' => '',
        'Assigned Elements' => '',
        'Filter assigned required elements' => '',
        'selected to assigned required elements' => '',
        'Toggle all assigned required elements' => '',
        'Assigned Required Elements' => '',
        'Reset' => 'Nollställ',

        # Template: AdminDynamicFieldText
        'Number of rows' => 'Antal rader',
        'Specify the height (in lines) for this field in the edit mode.' =>
            'Ange höjden (i rader) för detta fält i redigeringsläge.',
        'Number of cols' => 'Antal kolumner',
        'Specify the width (in characters) for this field in the edit mode.' =>
            'Ange bredden (i antal tecken) för detta fält i redigeringsläge.',
        'Check RegEx' => 'Kontrollera reguljärt uttryck',
        'Here you can specify a regular expression to check the value. The regex will be executed with the modifiers xms.' =>
            '',
        'RegEx' => 'Reguljärt uttryck',
        'Invalid RegEx' => 'Ogiltigt reguljärt uttryck',
        'Error Message' => 'Felmeddelande',
        'Add RegEx' => 'Lägg till reguljärt uttryck',

        # Template: AdminDynamicFieldTitle
        'Template' => 'Mall',
        'Style' => '',
        'bold' => '',
        'italic' => '',
        'underline' => '',
        'Font style of the label.' => '',
        'Size' => 'Storlek',
        'Font size of the label.' => '',
        'Color in hex.' => '',

        # Template: AdminDynamicFieldWebService
        'This field is required' => 'Det här fältet måste fyllas i',
        'The web service to be executed for possible values.' => '',
        'Invoker' => '',
        'The invoker to be used to perform requests (invoker needs to be of type \'Generic::PassThrough\').' =>
            '',
        'Activate this option to allow multiselect on results.' => '',
        'Cache TTL' => '',
        'Cache time to live (in minutes), to save the retrieved possible values.' =>
            '',
        'Here you can specify an optional HTTP link for the field value in Overviews and Zoom screens. Optional HTTP link works only for single-select fields.' =>
            '',

        # Template: AdminEmail
        'Admin Message' => '',
        'With this module, administrators can send messages to agents, group or role members.' =>
            'Med denna modul kan administratörer skicka meddelanden till handläggare och medlemmar i grupper och roller.',
        'Create Administrative Message' => '',
        'Your message was sent to' => 'Ditt meddelande skickades till',
        'From' => 'Från',
        'Send message to users' => 'Skicka meddelande till användare',
        'Send message to group members' => 'Skicka meddelande till gruppmedlemmar',
        'Group members need to have permission' => 'Gruppmedlemmar behöver tillåtelse',
        'Send message to role members' => 'Skicka meddelande till rollmedlemmar',
        'Also send to customers in groups' => 'Skicka också till kunder i grupperna',
        'Body' => 'Meddelandetext',
        'Send' => 'Skicka',

        # Template: AdminGenericAgent
        'Generic Agent Job Management' => '',
        'Edit Job' => '',
        'Add Job' => '',
        'Run Job' => '',
        'Filter for Jobs' => '',
        'Filter for jobs' => '',
        'Last run' => 'Senaste körning',
        'Run Now!' => 'Kör nu!',
        'Delete this task' => 'Radera denna uppgift',
        'Run this task' => 'Kör uppgiften',
        'Job Settings' => 'Jobbinställningar',
        'Job name' => 'Namn på jobb',
        'The name you entered already exists.' => 'Namnet du angav finns redan.',
        'Automatic Execution (Multiple Tickets)' => '',
        'Execution Schedule' => 'Exekveringsschema',
        'Schedule minutes' => 'Schemalagda minuter',
        'Schedule hours' => 'Schemalagda timmar',
        'Schedule days' => 'Schemalagda dagar',
        'Automatic execution values are in the system timezone.' => '',
        'Currently this generic agent job will not run automatically.' =>
            'För närvarande kommer detta jobb inte köras automatiskt.',
        'To enable automatic execution select at least one value from minutes, hours and days!' =>
            'För att aktivera automatisk körning måste du minst välja ett värde från minuter, timmar och dagar!',
        'Event Based Execution (Single Ticket)' => '',
        'Event Triggers' => 'Händelsetrigger',
        'List of all configured events' => 'Lista över alla konfigurerade händelser',
        'Delete this event' => 'Radera denna händelse',
        'Additionally or alternatively to a periodic execution, you can define ticket events that will trigger this job.' =>
            '',
        'If a ticket event is fired, the ticket filter will be applied to check if the ticket matches. Only then the job is run on that ticket.' =>
            '',
        'Do you really want to delete this event trigger?' => 'Vill du verkligen radera denna händelsetrigger?',
        'Add Event Trigger' => 'Lägg till händelsetrigger',
        'To add a new event select the event object and event name' => '',
        'Select Tickets' => 'Välj ärenden',
        '(e. g. 10*5155 or 105658*)' => 't.ex. 10*5144 eller 105658*',
        '(e. g. 234321)' => 't.ex. 163736',
        'Customer user ID' => '',
        '(e. g. U5150)' => '(t.ex. INGJAN)',
        'Fulltext-search in article (e. g. "Mar*in" or "Baue*").' => 'Fulltextsökning i artikel (t ex "Pet*er" eller "Johan*on")',
        'To' => 'Till',
        'Cc' => 'Kopia',
        'Service' => 'Tjänst',
        'Service Level Agreement' => 'Servicenivåavtal',
        'Queue' => 'Kö',
        'State' => 'Status',
        'Agent' => 'Handläggare',
        'Owner' => 'Ansvarig handläggare',
        'Responsible' => 'Ansvarig',
        'Ticket lock' => 'Ärendelås',
        'Dynamic fields' => '',
        'Add dynamic field' => '',
        'Create times' => 'Skapat-tider',
        'No create time settings.' => 'Inga inställningar för skapattider.',
        'Ticket created' => 'Ärende skapat',
        'Ticket created between' => 'Ärendet skapat mellan',
        'and' => 'och',
        'Last changed times' => 'Senast ändrade-tider',
        'No last changed time settings.' => 'Inga inställningar för senaste ändrings-tider. ',
        'Ticket last changed' => 'Ärende senast ändrat',
        'Ticket last changed between' => 'Ärende senast ändrat mellan',
        'Change times' => 'Ändrade-tider',
        'No change time settings.' => 'Inga Ändringstider',
        'Ticket changed' => 'Ärende ändrat',
        'Ticket changed between' => 'Ärende ändrat mellan',
        'Last close times' => '',
        'No last close time settings.' => '',
        'Ticket last close' => '',
        'Ticket last close between' => '',
        'Close times' => 'Stängd-tider',
        'No close time settings.' => 'Inga Stängt-tider',
        'Ticket closed' => 'Ärende stängt',
        'Ticket closed between' => 'Ärende stängt mellan',
        'Pending times' => 'Väntande-tider',
        'No pending time settings.' => 'Inga Avvaktar-tider',
        'Ticket pending time reached' => 'Ärendets väntetid nådd',
        'Ticket pending time reached between' => 'Ärende väntetid nådd mellan',
        'Escalation times' => 'Eskalerings-tider',
        'No escalation time settings.' => 'Ingen eskaleringstid är inställd.',
        'Ticket escalation time reached' => 'Eskaleringstiden för ärendet är nådd',
        'Ticket escalation time reached between' => 'Eskaleringstid för ärendet nådd mellan',
        'Escalation - first response time' => 'Eskalering - första responstid',
        'Ticket first response time reached' => 'Ärende första responstid nådd',
        'Ticket first response time reached between' => 'Ärende första responstid nådd mellan',
        'Escalation - update time' => 'Eskalering - uppdateringstid',
        'Ticket update time reached' => 'Ärende uppdateringstid nådd',
        'Ticket update time reached between' => 'Ärende uppdaterings tid nådd mellan',
        'Escalation - solution time' => 'Eskalering - lösningstid',
        'Ticket solution time reached' => 'Ärende lösningstid nådd',
        'Ticket solution time reached between' => 'Ärende lösningstid nådd mellan',
        'Archive search option' => '',
        'Update/Add Ticket Attributes' => 'Uppdatera / Ändra ärendeattribut',
        'Set new service' => 'Ange ny tjänst',
        'Set new Service Level Agreement' => 'Ange nytt servicenivåavtal',
        'Set new priority' => 'Ange ny prioritet',
        'Set new queue' => 'Ange ny kö',
        'Set new state' => 'Ange nytt tillstånd',
        'Pending date' => 'Väntande datum',
        'Set new agent' => 'Ange ny handläggare',
        'new owner' => 'ny ansvarig handläggare',
        'new responsible' => 'ny ansvarig',
        'Set new ticket lock' => 'Ange nytt ärendelås',
        'New customer user ID' => '',
        'New customer ID' => 'Nytt kund-ID',
        'New title' => 'Ny rubrik',
        'New type' => 'Ny typ',
        'Archive selected tickets' => 'Arkivera markerade ärenden',
        'Add Note' => 'Lägg till anteckning',
        'Visible for customer' => '',
        'Time units' => 'Tidsenheter',
        'Execute Ticket Commands' => '',
        'Send agent/customer notifications on changes' => 'Meddela handläggare/kund när ändringar sker',
        'CMD' => 'CMD',
        'This command will be executed. ARG[0] will be the ticket number. ARG[1] the ticket id.' =>
            'Detta kommando kommer utföras. ARG[0] blir dess ärendenummer. ARG[1] dess ärende-id.',
        'Delete tickets' => 'Radera ärenden',
        'Warning: All affected tickets will be removed from the database and cannot be restored!' =>
            'Varning: Alla påverkade ärenden kommer raderas från databasen och kan inte återställas!',
        'Execute Custom Module' => '',
        'Param %s key' => 'Parameter %s nyckel',
        'Param %s value' => 'Parameter %s värde',
        'Results' => 'Resultat',
        '%s Tickets affected! What do you want to do?' => '%s Påverkade ärenden! Vad vill du göra?',
        'Warning: You used the DELETE option. All deleted tickets will be lost!' =>
            'Varning: Du använde RADERA valet. Alla raderade ärenden kommer vara borta!',
        'Warning: There are %s tickets affected but only %s may be modified during one job execution!' =>
            'Varning: %s ärenden kommer påverkas, men endast %s kan bli ändrade under en körning!',
        'Affected Tickets' => 'Påverkade ärenden',
        'Age' => 'Ålder',

        # Template: AdminGenericInterfaceDebugger
        'GenericInterface Web Service Management' => '',
        'Web Service Management' => '',
        'Debugger' => 'Debugger',
        'Go back to web service' => 'Tillbaka till webbtjänsten',
        'Clear' => 'Rensa',
        'Do you really want to clear the debug log of this web service?' =>
            'Vill du verkligen rensa debugloggen för denna webbtjänst?',
        'Request List' => 'Requester',
        'Time' => 'Tid',
        'Communication ID' => '',
        'Remote IP' => 'Fjärr-IP',
        'Loading' => 'Laddar',
        'Select a single request to see its details.' => 'Välj en request för att se detaljerna.',
        'Filter by type' => 'Filtrera på typ',
        'Filter from' => 'Filtrera på från',
        'Filter to' => 'Filtrera på till',
        'Filter by remote IP' => 'Filtrera på fjärr-IP',
        'Limit' => 'Gräns',
        'Refresh' => 'Uppdatera',

        # Template: AdminGenericInterfaceErrorHandlingDefault
        'Add ErrorHandling' => '',
        'Edit ErrorHandling' => '',
        'Do you really want to delete this error handling module?' => '',
        'All configuration data will be lost.' => '',
        'General options' => '',
        'The name can be used to distinguish different error handling configurations.' =>
            '',
        'Please provide a unique name for this web service.' => '',
        'Error handling module backend' => '',
        'This OTOBO error handling backend module will be called internally to process the error handling mechanism.' =>
            '',
        'Processing options' => '',
        'Configure filters to control error handling module execution.' =>
            '',
        'Only requests matching all configured filters (if any) will trigger module execution.' =>
            '',
        'Operation filter' => '',
        'Only execute error handling module for selected operations.' => '',
        'Note: Operation is undetermined for errors occuring while receiving incoming request data. Filters involving this error stage should not use operation filter.' =>
            '',
        'Invoker filter' => '',
        'Only execute error handling module for selected invokers.' => '',
        'Error message content filter' => '',
        'Enter a regular expression to restrict which error messages should cause error handling module execution.' =>
            '',
        'Error message subject and data (as seen in the debugger error entry) will considered for a match.' =>
            '',
        'Example: Enter \'^.*401 Unauthorized.*\$\' to handle only authentication related errors.' =>
            '',
        'Error stage filter' => '',
        'Only execute error handling module on errors that occur during specific processing stages.' =>
            '',
        'Example: Handle only errors where mapping for outgoing data could not be applied.' =>
            '',
        'Error code' => '',
        'An error identifier for this error handling module.' => '',
        'This identifier will be available in XSLT-Mapping and shown in debugger output.' =>
            '',
        'Error message' => '',
        'An error explanation for this error handling module.' => '',
        'This message will be available in XSLT-Mapping and shown in debugger output.' =>
            '',
        'Define if processing should be stopped after module was executed, skipping all remaining modules or only those of the same backend.' =>
            '',
        'Default behavior is to resume, processing the next module.' => '',

        # Template: AdminGenericInterfaceErrorHandlingRequestRetry
        'This module allows to configure scheduled retries for failed requests.' =>
            '',
        'Default behavior of GenericInterface web services is to send each request exactly once and not to reschedule after errors.' =>
            '',
        'If more than one module capable of scheduling a retry is executed for an individual request, the module executed last is authoritative and determines if a retry is scheduled.' =>
            '',
        'Request retry options' => '',
        'Retry options are applied when requests cause error handling module execution (based on processing options).' =>
            '',
        'Schedule retry' => '',
        'Should requests causing an error be triggered again at a later time?' =>
            '',
        'Initial retry interval' => '',
        'Interval after which to trigger the first retry.' => '',
        'Note: This and all further retry intervals are based on the error handling module execution time for the initial request.' =>
            '',
        'Factor for further retries' => '',
        'If a request returns an error even after a first retry, define if subsequent retries are triggered using the same interval or in increasing intervals.' =>
            '',
        'Example: If a request is initially triggered at 10:00 with initial interval at \'1 minute\' and retry factor at \'2\', retries would be triggered at 10:01 (1 minute), 10:03 (2*1=2 minutes), 10:07 (2*2=4 minutes), 10:15 (2*4=8 minutes), ...' =>
            '',
        'Maximum retry interval' => '',
        'If a retry interval factor of \'1.5\' or \'2\' is selected, undesirably long intervals can be prevented by defining the largest interval allowed.' =>
            '',
        'Intervals calculated to exceed the maximum retry interval will then automatically be shortened accordingly.' =>
            '',
        'Example: If a request is initially triggered at 10:00 with initial interval at \'1 minute\', retry factor at \'2\' and maximum interval at \'5 minutes\', retries would be triggered at 10:01 (1 minute), 10:03 (2 minutes), 10:07 (4 minutes), 10:12 (8=>5 minutes), 10:17, ...' =>
            '',
        'Maximum retry count' => '',
        'Maximum number of retries before a failing request is discarded, not counting the initial request.' =>
            '',
        'Example: If a request is initially triggered at 10:00 with initial interval at \'1 minute\', retry factor at \'2\' and maximum retry count at \'2\', retries would be triggered at 10:01 and 10:02 only.' =>
            '',
        'Note: Maximum retry count might not be reached if a maximum retry period is configured as well and reached earlier.' =>
            '',
        'This field must be empty or contain a positive number.' => '',
        'Maximum retry period' => '',
        'Maximum period of time for retries of failing requests before they are discarded (based on the error handling module execution time for the initial request).' =>
            '',
        'Retries that would normally be triggered after maximum period is elapsed (according to retry interval calculation) will automatically be triggered at maximum period exactly.' =>
            '',
        'Example: If a request is initially triggered at 10:00 with initial interval at \'1 minute\', retry factor at \'2\' and maximum retry period at \'30 minutes\', retries would be triggered at 10:01, 10:03, 10:07, 10:15 and finally at 10:31=>10:30.' =>
            '',
        'Note: Maximum retry period might not be reached if a maximum retry count is configured as well and reached earlier.' =>
            '',

        # Template: AdminGenericInterfaceInvokerDefault
        'Add Invoker' => '',
        'Edit Invoker' => '',
        'Do you really want to delete this invoker?' => '',
        'Invoker Details' => '',
        'The name is typically used to call up an operation of a remote web service.' =>
            '',
        'Invoker backend' => '',
        'This OTOBO invoker backend module will be called to prepare the data to be sent to the remote system, and to process its response data.' =>
            '',
        'Mapping for outgoing request data' => '',
        'Configure' => 'Konfigurera',
        'The data from the invoker of OTOBO will be processed by this mapping, to transform it to the kind of data the remote system expects.' =>
            '',
        'Mapping for incoming response data' => '',
        'The response data will be processed by this mapping, to transform it to the kind of data the invoker of OTOBO expects.' =>
            '',
        'Asynchronous' => 'Asynkron',
        'Condition' => 'Villkor',
        'Edit this event' => '',
        'This invoker will be triggered by the configured events.' => '',
        'Add Event' => 'Lägg till Händelse',
        'To add a new event select the event object and event name and click on the "+" button' =>
            '',
        'Asynchronous event triggers are handled by the OTOBO Scheduler Daemon in background (recommended).' =>
            '',
        'Synchronous event triggers would be processed directly during the web request.' =>
            '',

        # Template: AdminGenericInterfaceInvokerEvent
        'GenericInterface Invoker Event Settings for Web Service %s' => '',
        'Go back to' => 'Tillbaka till',
        'Delete all conditions' => '',
        'Do you really want to delete all the conditions for this event?' =>
            '',
        'General Settings' => '',
        'Event type' => '',
        'Conditions' => 'Villkor',
        'Conditions can only operate on non-empty fields.' => '',
        'Type of Linking between Conditions' => '',
        'Remove this Condition' => '',
        'Type of Linking' => '',
        'Add a new Field' => '',
        'Remove this Field' => '',
        'And can\'t be repeated on the same condition.' => '',
        'Add New Condition' => '',

        # Template: AdminGenericInterfaceInvokerTicket
        'General invoker data' => '',
        'Settings for outgoing request data' => '',
        'Ticket fields' => 'Ärendefält',
        'Only the selected ticket fields will be considered for the request data.' =>
            '',
        'Article fields' => '',
        'Only the selected article fields will be considered for the request data.' =>
            '',
        'Ticket dynamic fields' => '',
        'Only the selected ticket dynamic fields will be considered for the request data.' =>
            '',
        'Article dynamic fields' => '',
        'Only the selected article dynamic fields will be considered for the request data.' =>
            '',
        'Number of articles' => '',
        'The outgoing request data will only contain the configured number of articles. If left empty, only 1 article will be sent.' =>
            '',
        'Communication channels' => '',
        'The outgoing request data will only consider articles of the selected communication channels. If left empty, articles created by all communication channels will be used.' =>
            '',
        'Customer visibility' => '',
        'The outgoing request data will only consider articles created with the selected customer visibility.' =>
            '',
        'Sender Types' => '',
        'The outgoing request data will only consider articles created by the selected sender types. If left empty, articles created by all sender types will be used.' =>
            '',
        'Mapping' => '',
        'Settings for incoming response data' => '',
        'Remote TicketID dynamic field' => '',
        'The selected ticket dynamic field is being used to store the remote TicketID.' =>
            '',
        'If left empty, the remote TicketID will not be stored, unless you define a system configuration value for this web service.' =>
            '',
        'The selected field is already in use by the Ticket dynamic fields option.' =>
            '',
        'Only the selected ticket dynamic fields are being considered for processing the incoming response data. If left empty, no dynamic field will be processed.' =>
            '',
        'Event data' => '',

        # Template: AdminGenericInterfaceMappingSimple
        'Mapping Simple' => '',
        'Default rule for unmapped keys' => '',
        'This rule will apply for all keys with no mapping rule.' => '',
        'Default rule for unmapped values' => '',
        'This rule will apply for all values with no mapping rule.' => '',
        'New key map' => '',
        'Add key mapping' => '',
        'Mapping for Key ' => '',
        'Remove key mapping' => '',
        'Key mapping' => '',
        'Map key' => '',
        'matching the' => '',
        'to new key' => '',
        'Value mapping' => '',
        'Map value' => 'Mappa värde',
        'to new value' => 'till nytt värde',
        'Remove value mapping' => '',
        'New value map' => '',
        'Add value mapping' => '',
        'Do you really want to delete this key mapping?' => '',

        # Template: AdminGenericInterfaceMappingXSLT
        'General Shortcuts' => '',
        'MacOS Shortcuts' => '',
        'Comment code' => '',
        'Uncomment code' => '',
        'Auto format code' => '',
        'Expand/Collapse code block' => '',
        'Find' => '',
        'Find next' => '',
        'Find previous' => '',
        'Find and replace' => '',
        'Find and replace all' => '',
        'XSLT Mapping' => '',
        'XSLT stylesheet' => '',
        'The entered data is not a valid XSLT style sheet.' => '',
        'Here you can add or modify your XSLT mapping code.' => '',
        'The editing field allows you to use different functions like automatic formatting, window resize as well as tag- and bracket-completion.' =>
            '',
        'Data includes' => '',
        'Select one or more sets of data that were created at earlier request/response stages to be included in mappable data.' =>
            '',
        'These sets will appear in the data structure at \'/DataInclude/<DataSetName>\' (see debugger output of actual requests for details).' =>
            '',
        'Data key regex filters (before mapping)' => '',
        'Data key regex filters (after mapping)' => '',
        'Regular expressions' => '',
        'Replace' => '',
        'Remove regex' => '',
        'Add regex' => '',
        'These filters can be used to transform keys using regular expressions.' =>
            '',
        'The data structure will be traversed recursively and all configured regexes will be applied to all keys.' =>
            '',
        'Use cases are e.g. removing key prefixes that are undesired or correcting keys that are invalid as XML element names.' =>
            '',
        'Example 1: Search = \'^jira:\' / Replace = \'\' turns \'jira:element\' into \'element\'.' =>
            '',
        'Example 2: Search = \'^\' / Replace = \'_\' turns \'16x16\' into \'_16x16\'.' =>
            '',
        'Example 3: Search = \'^(?<number>\d+) (?<text>.+?)\$\' / Replace = \'_\$+{text}_\$+{number}\' turns \'16 elementname\' into \'_elementname_16\'.' =>
            '',
        'For information about regular expressions in Perl please see here:' =>
            '',
        'Perl regular expressions tutorial' => '',
        'If modifiers are desired they have to be specified within the regexes themselves.' =>
            '',
        'Regular expressions defined here will be applied before the XSLT mapping.' =>
            '',
        'Regular expressions defined here will be applied after the XSLT mapping.' =>
            '',

        # Template: AdminGenericInterfaceOperationDefault
        'Add Operation' => '',
        'Edit Operation' => '',
        'Do you really want to delete this operation?' => '',
        'Operation Details' => '',
        'The name is typically used to call up this web service operation from a remote system.' =>
            '',
        'Operation backend' => '',
        'This OTOBO operation backend module will be called internally to process the request, generating data for the response.' =>
            '',
        'Mapping for incoming request data' => '',
        'The request data will be processed by this mapping, to transform it to the kind of data OTOBO expects.' =>
            '',
        'Mapping for outgoing response data' => '',
        'The response data will be processed by this mapping, to transform it to the kind of data the remote system expects.' =>
            '',
        'Include Ticket Data' => '',
        'Include ticket data in response.' => '',

        # Template: AdminGenericInterfaceTransportHTTPREST
        'Network Transport' => '',
        'Properties' => 'Egenskaper',
        'Route mapping for Operation' => '',
        'Define the route that should get mapped to this operation. Variables marked by a \':\' will get mapped to the entered name and passed along with the others to the mapping. (e.g. /Ticket/:TicketID).' =>
            '',
        'Valid request methods for Operation' => '',
        'Limit this Operation to specific request methods. If no method is selected all requests will be accepted.' =>
            '',
        'Maximum message length' => 'Maximal meddelandelängd',
        'This field should be an integer number.' => 'Detta fält bör vara ett heltalsvärde (integer).',
        'Here you can specify the maximum size (in bytes) of REST messages that OTOBO will process.' =>
            '',
        'Send Keep-Alive' => 'Skicka keep-alive',
        'This configuration defines if incoming connections should get closed or kept alive.' =>
            '',
        'Additional response headers' => '',
        'Add response header' => '',
        'Endpoint' => '',
        'URI to indicate specific location for accessing a web service.' =>
            '',
        'e.g. https://www.otobo.de:10745/api/v1.0 (without trailing backslash)' =>
            '',
        'Timeout' => '',
        'Timeout value for requests.' => '',
        'Authentication' => 'Autentisering',
        'An optional authentication mechanism to access the remote system.' =>
            '',
        'BasicAuth User' => '',
        'The user name to be used to access the remote system.' => '',
        'BasicAuth Password' => '',
        'The password for the privileged user.' => 'Lösenordet för admin-användaren.',
        'Use Proxy Options' => '',
        'Show or hide Proxy options to connect to the remote system.' => '',
        'Proxy Server' => 'Proxy-server',
        'URI of a proxy server to be used (if needed).' => 'URI för proxy-server som ska användas (om det behövs).',
        'e.g. http://proxy_hostname:8080' => 't.ex. http://proxy_hostname:8080',
        'Proxy User' => 'Proxy-användare',
        'The user name to be used to access the proxy server.' => 'Användarnamnet som ska användas för åtkomst till proxyservern.',
        'Proxy Password' => 'Proxy-lösenordet',
        'The password for the proxy user.' => 'Lösenordet för proxy-användaren.',
        'Skip Proxy' => '',
        'Skip proxy servers that might be configured globally?' => '',
        'Use SSL Options' => 'Använd SSL',
        'Show or hide SSL options to connect to the remote system.' => 'Visa eller dölj SSL-inställningarna.',
        'Client Certificate' => '',
        'The full path and name of the SSL client certificate file (must be in PEM, DER or PKCS#12 format).' =>
            '',
        'e.g. /opt/otobo/var/certificates/SOAP/certificate.pem' => '',
        'Client Certificate Key' => '',
        'The full path and name of the SSL client certificate key file (if not already included in certificate file).' =>
            '',
        'e.g. /opt/otobo/var/certificates/SOAP/key.pem' => '',
        'Client Certificate Key Password' => '',
        'The password to open the SSL certificate if the key is encrypted.' =>
            '',
        'Certification Authority (CA) Certificate' => '',
        'The full path and name of the certification authority certificate file that validates SSL certificate.' =>
            '',
        'e.g. /opt/otobo/var/certificates/SOAP/CA/ca.pem' => '',
        'Certification Authority (CA) Directory' => '',
        'The full path of the certification authority directory where the CA certificates are stored in the file system.' =>
            '',
        'e.g. /opt/otobo/var/certificates/SOAP/CA' => '',
        'SSL hostname verification.' => '',
        'Abort the request if the hostname cannot be verified. Disable with caution! Skipping verification is a security risk! Mainly for testing purposes in case of self-signed SSL certificates, or if you know what you are doing.' =>
            '',
        'Controller mapping for Invoker' => '',
        'The controller that the invoker should send requests to. Variables marked by a \':\' will get replaced by the data value and passed along with the request. (e.g. /Ticket/:TicketID?UserLogin=:UserLogin&Password=:Password).' =>
            '',
        'Valid request command for Invoker' => '',
        'A specific HTTP command to use for the requests with this Invoker (optional).' =>
            '',
        'Default command' => 'Standardkommando',
        'The default HTTP command to use for the requests.' => '',
        'Additional request headers (all invokers)' => '',
        'Additional request headers (invoker specific)' => '',
        'Remove all headers for this invoker' => '',
        'Headers for invoker' => '',
        'Additional response headers (all operations)' => '',
        'Additional response headers (operation specific)' => '',
        'Remove all headers for this operation' => '',
        'Headers for operation' => '',
        'Common headers' => '',
        'Header Name' => '',
        'Remove header' => '',
        'Add header' => '',

        # Template: AdminGenericInterfaceTransportHTTPSOAP
        'e.g. https://local.otobo.de:8000/Webservice/Example' => '',
        'Set SOAPAction' => '',
        'Set to "Yes" in order to send a filled SOAPAction header.' => '',
        'Set to "No" in order to send an empty SOAPAction header.' => '',
        'Set to "Yes" in order to check the received SOAPAction header (if not empty).' =>
            '',
        'Set to "No" in order to ignore the received SOAPAction header.' =>
            '',
        'SOAPAction scheme' => '',
        'Select how SOAPAction should be constructed.' => '',
        'Some web services require a specific construction.' => '',
        'Some web services send a specific construction.' => '',
        'SOAPAction separator' => '',
        'Character to use as separator between name space and SOAP operation.' =>
            '',
        'Usually .Net web services use "/" as separator.' => '',
        'SOAPAction free text' => '',
        'Text to be used to as SOAPAction.' => '',
        'Namespace' => 'Namnrymd',
        'URI to give SOAP methods a context, reducing ambiguities.' => '',
        'e.g. urn:otobo-com:soap:functions or http://www.otobo.de/GenericInterface/actions' =>
            '',
        'Request name scheme' => '',
        'Select how SOAP request function wrapper should be constructed.' =>
            '',
        '\'FunctionName\' is used as example for actual invoker/operation name.' =>
            '',
        '\'FreeText\' is used as example for actual configured value.' =>
            '',
        'Request name free text' => '',
        'Text to be used to as function wrapper name suffix or replacement.' =>
            '',
        'Please consider XML element naming restrictions (e.g. don\'t use \'<\' and \'&\').' =>
            '',
        'Response name scheme' => '',
        'Select how SOAP response function wrapper should be constructed.' =>
            '',
        'Response name free text' => '',
        'Here you can specify the maximum size (in bytes) of SOAP messages that OTOBO will process.' =>
            '',
        'Encoding' => 'Kodning',
        'The character encoding for the SOAP message contents.' => 'Teckenkodningen för SOAP-meddelandeinnehållet.',
        'e.g. utf-8, latin1, iso-8859-1, cp1250, Etc.' => '',
        'Sort options' => 'Sorteringsalternativ',
        'Add new first level element' => '',
        'Element' => '',
        'Outbound sort order for xml fields (structure starting below function name wrapper) - see documentation for SOAP transport.' =>
            '',

        # Template: AdminGenericInterfaceWebservice
        'Add Web Service' => '',
        'Edit Web Service' => '',
        'Clone Web Service' => '',
        'The name must be unique.' => 'Namnet måste vara unikt.',
        'Clone' => 'Klona',
        'Export Web Service' => '',
        'Import web service' => 'Importera webbtjänst',
        'Configuration File' => 'Konfigurationsfil',
        'The file must be a valid web service configuration YAML file.' =>
            'Filen måste vara en giltig webbtjänstkonfiguration (YAML).',
        'Here you can specify a name for the webservice. If this field is empty, the name of the configuration file is used as name.' =>
            '',
        'Import' => 'Importera',
        'Configuration History' => '',
        'Delete web service' => 'Radera webbtjänst',
        'Do you really want to delete this web service?' => 'Vill du verkligen radera denna webbtjänst?',
        'Ready2Adopt Web Services' => '',
        'Here you can activate Ready2Adopt web services showcasing our best practices.' =>
            '',
        'Import Ready2Adopt web service' => '',
        'After you save the configuration you will be redirected again to the edit screen.' =>
            '',
        'If you want to return to overview please click the "Go to overview" button.' =>
            '',
        'Remote system' => 'Fjärrsystem',
        'Provider transport' => '',
        'Requester transport' => '',
        'Debug threshold' => '',
        'In provider mode, OTOBO offers web services which are used by remote systems.' =>
            '',
        'In requester mode, OTOBO uses web services of remote systems.' =>
            '',
        'Network transport' => 'Nätverkstransport',
        'Error Handling Modules' => '',
        'Error handling modules are used to react in case of errors during the communication. Those modules are executed in a specific order, which can be changed by drag and drop.' =>
            '',
        'Backend' => '',
        'Add error handling module' => '',
        'Operations are individual system functions which remote systems can request.' =>
            '',
        'Invokers prepare data for a request to a remote web service, and process its response data.' =>
            '',
        'Controller' => '',
        'Inbound mapping' => '',
        'Outbound mapping' => '',
        'Delete this action' => '',
        'At least one %s has a controller that is either not active or not present, please check the controller registration or delete the %s' =>
            '',

        # Template: AdminGenericInterfaceWebserviceHistory
        'History' => 'Historik',
        'Go back to Web Service' => 'Tillbaka till webbtjänsten',
        'Here you can view older versions of the current web service\'s configuration, export or even restore them.' =>
            '',
        'Configuration History List' => '',
        'Version' => 'Version',
        'Create time' => '',
        'Select a single configuration version to see its details.' => '',
        'Export web service configuration' => '',
        'Restore web service configuration' => '',
        'Do you really want to restore this version of the web service configuration?' =>
            '',
        'Your current web service configuration will be overwritten.' => '',

        # Template: AdminGroup
        'Group Management' => 'grupphantering',
        'Add Group' => 'Lägg till grupp',
        'Edit Group' => 'Ändra grupp',
        'The admin group is to get in the admin area and the stats group to get stats area.' =>
            '\'admin\'-gruppen ger tillgång till Admin-arean, \'stats\'-gruppen till Rapporter-arean.',
        'Create new groups to handle access permissions for different groups of agent (e. g. purchasing department, support department, sales department, ...). ' =>
            '',
        'It\'s useful for ASP solutions. ' => '',

        # Template: AdminLog
        'System Log' => 'Systemlogg',
        'Here you will find log information about your system.' => 'Här finner du logg-information om ditt system.',
        'Hide this message' => 'Göm detta meddelande',
        'Recent Log Entries' => '',
        'Facility' => 'Funktion',
        'Message' => 'Meddelande',

        # Template: AdminMailAccount
        'Mail Account Management' => 'E-postkontohantering',
        'Add Mail Account' => 'Lägg till e-postkonto',
        'Edit Mail Account for host' => '',
        'and user account' => '',
        'Filter for Mail Accounts' => '',
        'Filter for mail accounts' => '',
        'All incoming emails with one account will be dispatched in the selected queue.' =>
            '',
        'If your account is marked as trusted, the X-OTOBO headers already existing at arrival time (for priority etc.) will be kept and used, for example in PostMaster filters.' =>
            '',
        'Outgoing email can be configured via the Sendmail* settings in %s.' =>
            '',
        'System Configuration' => '',
        'Host' => 'Värd',
        'Delete account' => 'Radera konto',
        'Fetch mail' => 'Hämta e-post',
        'Do you really want to delete this mail account?' => '',
        'Example: mail.example.com' => 'T.ex. mail.example.com',
        'IMAP Folder' => 'IMAP-katalog',
        'Only modify this if you need to fetch mail from a different folder than INBOX.' =>
            'Ändra bara om du vill hämta e-post från en annan katalog än inkorgen.',
        'Trusted' => 'Betrodd',
        'Dispatching' => 'Fördelning',
        'Edit Mail Account' => 'Redigera e-postkonto',

        # Template: AdminNavigationBar
        'Administration Overview' => '',
        'Filter for Items' => '',
        'Favorites' => '',
        'You can add favorites by moving your cursor over items on the right side and clicking the star icon.' =>
            '',
        'Links' => '',
        'View the admin manual' => '',
        'No Matches' => '',
        'Sorry, your search didn\'t match any items.' => '',
        'Set as favorite' => '',

        # Template: AdminNotificationEvent
        'Ticket Notification Management' => 'Hantering av ärendemeddelanden',
        'Here you can upload a configuration file to import Ticket Notifications to your system. The file needs to be in .yml format as exported by the Ticket Notification module.' =>
            '',
        'Here you can choose which events will trigger this notification. An additional ticket filter can be applied below to only send for ticket with certain criteria.' =>
            '',
        'Ticket Filter' => 'Ärendefilter',
        'Lock' => 'Lås',
        'SLA' => 'SLA',
        'Customer User ID' => '',
        'Article Filter' => 'Artikelfilter',
        'Only for ArticleCreate and ArticleSend event' => 'Enbart för ArticleCreate och ArticleSend event',
        'Article sender type' => '',
        'If ArticleCreate or ArticleSend is used as a trigger event, you need to specify an article filter as well. Please select at least one of the article filter fields.' =>
            '',
        'Communication channel' => '',
        'Include attachments to notification' => 'Bifoga bilaga med notifieringen',
        'Notify user just once per day about a single ticket using a selected transport.' =>
            '',
        'Notifications are sent to an agent or a customer.' => 'Notifieringar skickas till handläggare eller kunder.',
        'To get the first 20 character of the subject (of the latest agent article).' =>
            'För att få de första 20 tecknen i ärenderaden (på senaste handläggarartikeln).',
        'To get the first 5 lines of the body (of the latest agent article).' =>
            'För att få de första fem raderna i kroppen (på senaste handläggarartikeln).',
        'To get the first 20 character of the subject (of the latest customer article).' =>
            'För att då de första 20 tecknen i ärenderaden (på senaste kundartikeln).',
        'To get the first 5 lines of the body (of the latest customer article).' =>
            'För att få de fem första raderna i kroppen (på senaste kundartikeln).',
        'Attributes of the current customer user data' => 'Egenskaper för kundens användardata',
        'Attributes of the current ticket owner user data' => '',
        'Attributes of the current ticket responsible user data' => '',
        'Attributes of the current agent user who requested this action' =>
            '',
        'Attributes of the ticket data' => '',
        'Ticket dynamic fields internal key values' => '',
        'Ticket dynamic fields display values, useful for Dropdown and Multiselect fields' =>
            '',

        # Template: AdminNotificationEventTransportEmailSettings
        'Use comma or semicolon to separate email addresses.' => '',
        'You can use OTOBO-tags like <OTOBO_TICKET_DynamicField_...> to insert values from the current ticket.' =>
            '',

        # Template: AdminPGP
        'PGP Management' => 'PGP-hantering',
        'Add PGP Key' => 'Lägg till PGP-nyckel',
        'PGP support is disabled' => 'PGP-stöd är inaktiverat',
        'To be able to use PGP in OTOBO, you have to enable it first.' =>
            'För att använda PGP i OTOBO, måste du aktivera det först.',
        'Enable PGP support' => 'Aktivera PGP-stöd',
        'Faulty PGP configuration' => 'Felaktig PGP-konfiguration',
        'PGP support is enabled, but the relevant configuration contains errors. Please check the configuration using the button below.' =>
            'PGP-stöd är aktiverat, men den tillhörande konfigurationen innehåller fel. Vänligen kontrollera konfigurationen genom att använda knappen nedan.',
        'Configure it here!' => 'Konfigurera den här!',
        'Check PGP configuration' => 'Kontrollera PGP-konfiguration',
        'In this way you can directly edit the keyring configured in SysConfig.' =>
            'På det här sättet kan du direkt redigera nyckelringen som är inställd i SysConfig.',
        'Introduction to PGP' => 'Introduktion till PGP',
        'Bit' => 'Bit',
        'Fingerprint' => 'Fingeravtryck',
        'Expires' => 'Upphör',
        'Delete this key' => 'Radera denna nyckel',
        'PGP key' => 'PGP-nyckel',

        # Template: AdminPackageManager
        'Package Manager' => 'Pakethanterare',
        'Uninstall Package' => '',
        'Uninstall package' => 'Avinstallera paket',
        'Do you really want to uninstall this package?' => 'Vill du verkligen avinstallera detta paket?',
        'Reinstall package' => 'Installera om paket',
        'Do you really want to reinstall this package? Any manual changes will be lost.' =>
            'Vill du verkligen ominstallera det här paketet? Eventuella manuella ändringar kommer försvinna.',
        'Go to updating instructions' => '',
        'Go to the OTOBO customer portal' => '',
        'package information' => '',
        'Package installation requires a patch level update of OTOBO.' =>
            '',
        'Package update requires a patch level update of OTOBO.' => '',
        'Please note that your installed OTOBO version is %s.' => '',
        'To install this package, you need to update OTOBO to version %s or newer.' =>
            '',
        'This package can only be installed on OTOBO version %s or older.' =>
            '',
        'This package can only be installed on OTOBO version %s or newer.' =>
            '',
        'Why should I keep OTOBO up to date?' => '',
        'You will receive updates about relevant security issues.' => '',
        'You will receive updates for all other relevant OTOBO issues.' =>
            '',
        'How can I do a patch level update if I don’t have a contract?' =>
            '',
        'Please find all relevant information within the updating instructions at %s.' =>
            '',
        'In case you would have further questions we would be glad to answer them.' =>
            '',
        'Please visit our customer portal and file a request.' => '',
        'Install Package' => 'Installera paket',
        'Update Package' => '',
        'Continue' => 'Fortsätt',
        'Please make sure your database accepts packages over %s MB in size (it currently only accepts packages up to %s MB). Please adapt the max_allowed_packet setting of your database in order to avoid errors.' =>
            '',
        'Install' => 'Installera',
        'Update repository information' => 'Uppdatera information om repo',
        'Cloud services are currently disabled.' => 'Molntjänster är fört tillfället inaktiverade.',
        'OTOBO Verify can not continue!' => '',
        'Enable cloud services' => 'Aktivera molntjänster',
        'Update all installed packages' => '',
        'Online Repository' => 'Online-repo',
        'Vendor' => 'Leverantör',
        'Action' => 'Åtgärd',
        'Module documentation' => 'Moduldokumentation',
        'Local Repository' => 'Local Repository',
        'This package is verified by OTOBOverify (tm)' => 'Det här paketet är verifierat av OTOBOverify (tm)',
        'Uninstall' => 'Avinstallera',
        'Package not correctly deployed! Please reinstall the package.' =>
            'Paketet inte korrekt installerat! Försök installera det igen.',
        'Reinstall' => 'Ominstallera',
        'Features for %s customers only' => 'Egenskaper endast för %s-kunder ',
        'With %s, you can benefit from the following optional features. Please make contact with %s if you need more information.' =>
            '',
        'Package Information' => '',
        'Download package' => 'Ladda ner paket',
        'Rebuild package' => 'Bygg om paket',
        'Metadata' => 'Metadata',
        'Change Log' => 'Ändringslogg',
        'Date' => 'Datum',
        'List of Files' => 'Fillista',
        'Permission' => 'Rättighet',
        'Download file from package!' => 'Ladda ner fil från paket!',
        'Required' => 'Krävs',
        'Primary Key' => '',
        'Auto Increment' => '',
        'SQL' => 'SQL',
        'File Differences for File %s' => '',
        'File differences for file %s' => 'Filskillnader för fil %s',

        # Template: AdminPerformanceLog
        'Performance Log' => 'Prestandalogg',
        'Range' => 'Intervall',
        'last' => 'sista',
        'This feature is enabled!' => 'Denna funktion är aktiverad!',
        'Just use this feature if you want to log each request.' => 'Använd endast denna funktion om du vill logga varje request.',
        'Activating this feature might affect your system performance!' =>
            'Att aktivera denna funktion kan påverka din systemprestanda!',
        'Disable it here!' => 'Avaktivera det här!',
        'Logfile too large!' => 'Loggfilen är för stor!',
        'The logfile is too large, you need to reset it' => 'Loggfilen är för stor, du behöver återställa den',
        'Interface' => 'Interface',
        'Requests' => 'Requests',
        'Min Response' => 'Min respons',
        'Max Response' => 'Max respons',
        'Average Response' => 'Medel respons',
        'Period' => 'Period',
        'minutes' => 'minuter',
        'Min' => 'Min',
        'Max' => 'Max',
        'Average' => 'Medel',

        # Template: AdminPostMasterFilter
        'PostMaster Filter Management' => 'PostMaster Filter',
        'Add PostMaster Filter' => 'Lägg till PostMaster-filter',
        'Edit PostMaster Filter' => 'Ändra PostMaster-Filter',
        'Filter for PostMaster Filters' => '',
        'Filter for PostMaster filters' => '',
        'To dispatch or filter incoming emails based on email headers. Matching using Regular Expressions is also possible.' =>
            '',
        'If you want to match only the email address, use EMAILADDRESS:info@example.com in From, To or Cc.' =>
            'Om du bara vill hantera e-postadressen, använd EMAILADDRESS:info@example.com i Från, Till eller CC.',
        'If you use Regular Expressions, you also can use the matched value in () as [***] in the \'Set\' action.' =>
            '',
        'You can also use named captures %s and use the names in the \'Set\' action %s (e.g. Regexp: %s, Set action: %s). A matched EMAILADDRESS has the name \'%s\'.' =>
            '',
        'Delete this filter' => 'Radera detta filter',
        'Do you really want to delete this postmaster filter?' => '',
        'A postmaster filter with this name already exists!' => '',
        'Filter Condition' => 'Filter-villkor',
        'AND Condition' => 'OCH-villkor',
        'Search header field' => '',
        'for value' => '',
        'The field needs to be a valid regular expression or a literal word.' =>
            '',
        'Negate' => 'Negera',
        'Set Email Headers' => 'Sätt e-posthuvud',
        'Set email header' => 'Sätt e-posthvuud',
        'with value' => '',
        'The field needs to be a literal word.' => '',
        'Header' => 'Huvud',

        # Template: AdminPriority
        'Priority Management' => 'Hantera prioriteter',
        'Add Priority' => 'Lägg till Prioritet',
        'Edit Priority' => 'Redigera prioritet',
        'Filter for Priorities' => '',
        'Filter for priorities' => '',
        'This priority is present in a SysConfig setting, confirmation for updating settings to point to the new priority is needed!' =>
            '',
        'This priority is used in the following config settings:' => '',

        # Template: AdminProcessManagement
        'Process Management' => '',
        'Filter for Processes' => '',
        'Filter for processes' => '',
        'Create New Process' => '',
        'Deploy All Processes' => '',
        'Here you can upload a configuration file to import a process to your system. The file needs to be in .yml format as exported by process management module.' =>
            '',
        'Upload process configuration' => '',
        'Import process configuration' => '',
        'Ready2Adopt Processes' => '',
        'Here you can activate Ready2Adopt processes showcasing our best practices. Please note that some additional configuration may be required.' =>
            '',
        'Import Ready2Adopt process' => '',
        'To create a new Process you can either import a Process that was exported from another system or create a complete new one.' =>
            '',
        'Changes to the Processes here only affect the behavior of the system, if you synchronize the Process data. By synchronizing the Processes, the newly made changes will be written to the Configuration.' =>
            '',
        'Processes' => 'Processer',
        'Process name' => 'Processnamn',
        'Print' => 'Skriv ut',
        'Export Process Configuration' => 'Exportera processkonfiguration',
        'Copy Process' => 'Kopiera process',

        # Template: AdminProcessManagementActivity
        'Cancel & close' => 'Avbryt & stäng',
        'Go Back' => 'Tillbaka',
        'Please note, that changing this activity will affect the following processes' =>
            '',
        'Activity' => 'Aktivitet',
        'Activity Name' => 'Aktivitetsnamn',
        'Activity Dialogs' => 'Aktivitetsdialoger',
        'You can assign Activity Dialogs to this Activity by dragging the elements with the mouse from the left list to the right list.' =>
            'Du kan koppla aktivitetsdialoger till denna aktivitet genom att flytta dem från den vänstra listan till den högra',
        'Filter available Activity Dialogs' => '',
        'Available Activity Dialogs' => 'Tillgängliga aktivitetsdialoger',
        'Name: %s, EntityID: %s' => 'Namn: %s, EntityID: %s',
        'Create New Activity Dialog' => 'Skapa ny ativitetsdialog',
        'Assigned Activity Dialogs' => '',

        # Template: AdminProcessManagementActivityDialog
        'Please note that changing this activity dialog will affect the following activities' =>
            '',
        'Please note that customer users will not be able to see or use the following fields: Owner, Responsible, Lock, PendingTime and CustomerID.' =>
            '',
        'The Queue field can only be used by customers when creating a new ticket.' =>
            '',
        'Activity Dialog' => 'Aktivitetsdialog',
        'Activity dialog Name' => '',
        'Available in' => 'Tillgänglig om',
        'Description (short)' => 'Beskrivning (kort)',
        'Description (long)' => 'Beskrivning (lång)',
        'The selected permission does not exist.' => '',
        'Required Lock' => '',
        'The selected required lock does not exist.' => '',
        'Submit Advice Text' => '',
        'Submit Button Text' => '',
        'You can assign Fields to this Activity Dialog by dragging the elements with the mouse from the left list to the right list.' =>
            '',
        'Filter available fields' => '',
        'Available Fields' => 'Tillgängliga fält',
        'Assigned Fields' => 'Tilldelade fält',
        'Communication Channel' => '',
        'Is visible for customer' => '',
        'Display' => '',

        # Template: AdminProcessManagementPath
        'Path' => 'Sökväg',
        'Edit this transition' => '',
        'Transition Actions' => '',
        'You can assign Transition Actions to this Transition by dragging the elements with the mouse from the left list to the right list.' =>
            '',
        'Filter available Transition Actions' => '',
        'Available Transition Actions' => '',
        'Create New Transition Action' => '',
        'Assigned Transition Actions' => '',

        # Template: AdminProcessManagementProcessAccordion
        'Activities' => 'Aktiviteter',
        'Filter Activities...' => '',
        'Create New Activity' => '',
        'Filter Activity Dialogs...' => '',
        'Transitions' => '',
        'Filter Transitions...' => '',
        'Create New Transition' => '',
        'Filter Transition Actions...' => '',

        # Template: AdminProcessManagementProcessEdit
        'Edit Process' => '',
        'Print process information' => '',
        'Delete Process' => '',
        'Delete Inactive Process' => '',
        'Available Process Elements' => '',
        'The Elements listed above in this sidebar can be moved to the canvas area on the right by using drag\'n\'drop.' =>
            '',
        'You can place Activities on the canvas area to assign this Activity to the Process.' =>
            '',
        'To assign an Activity Dialog to an Activity drop the Activity Dialog element from this sidebar over the Activity placed in the canvas area.' =>
            '',
        'You can start a connection between two Activities by dropping the Transition element over the Start Activity of the connection. After that you can move the loose end of the arrow to the End Activity.' =>
            '',
        'Actions can be assigned to a Transition by dropping the Action Element onto the label of a Transition.' =>
            '',
        'Edit Process Information' => '',
        'Process Name' => '',
        'The selected state does not exist.' => '',
        'Add and Edit Activities, Activity Dialogs and Transitions' => '',
        'Show EntityIDs' => '',
        'Extend the width of the Canvas' => '',
        'Extend the height of the Canvas' => '',
        'Remove the Activity from this Process' => '',
        'Edit this Activity' => '',
        'Save Activities, Activity Dialogs and Transitions' => '',
        'Do you really want to delete this Process?' => '',
        'Do you really want to delete this Activity?' => '',
        'Do you really want to delete this Activity Dialog?' => '',
        'Do you really want to delete this Transition?' => '',
        'Do you really want to delete this Transition Action?' => '',
        'Do you really want to remove this activity from the canvas? This can only be undone by leaving this screen without saving.' =>
            '',
        'Do you really want to remove this transition from the canvas? This can only be undone by leaving this screen without saving.' =>
            '',

        # Template: AdminProcessManagementProcessNew
        'In this screen, you can create a new process. In order to make the new process available to users, please make sure to set its state to \'Active\' and synchronize after completing your work.' =>
            '',

        # Template: AdminProcessManagementProcessPrint
        'cancel & close' => '',
        'Start Activity' => 'Påbörja aktivitet',
        'Contains %s dialog(s)' => 'Innehåller %s dialoger',
        'Assigned dialogs' => 'Tilldelade dialoger',
        'Activities are not being used in this process.' => 'Aktiviteter används inte i processen.',
        'Assigned fields' => '',
        'Activity dialogs are not being used in this process.' => '',
        'Condition linking' => 'Länkning av villkor',
        'Transitions are not being used in this process.' => 'Övergångar används inte i processen.',
        'Module name' => 'Modulnamn',
        'Transition actions are not being used in this process.' => '',

        # Template: AdminProcessManagementTransition
        'Please note that changing this transition will affect the following processes' =>
            '',
        'Transition' => 'Övergång',
        'Transition Name' => 'Namnet på övergången',

        # Template: AdminProcessManagementTransitionAction
        'Please note that changing this transition action will affect the following processes' =>
            '',
        'Transition Action' => '',
        'Transition Action Name' => '',
        'Transition Action Module' => '',
        'Config Parameters' => '',
        'Add a new Parameter' => '',
        'Remove this Parameter' => '',

        # Template: AdminQueue
        'Queue Management' => '',
        'Add Queue' => 'Skapa kö',
        'Edit Queue' => 'Editera kö',
        'Filter for Queues' => '',
        'Filter for queues' => '',
        'A queue with this name already exists!' => '',
        'This queue is present in a SysConfig setting, confirmation for updating settings to point to the new queue is needed!' =>
            '',
        'Sub-queue of' => 'Underkö till',
        'Unlock timeout' => 'Tidsintervall för borttagning av lås',
        '0 = no unlock' => '0 = ingen upplåsning',
        'hours' => 'timmar',
        'Only business hours are counted.' => 'Endast kontorstid räknas.',
        'If an agent locks a ticket and does not close it before the unlock timeout has passed, the ticket will unlock and will become available for other agents.' =>
            '',
        'Notify by' => 'Meddela via',
        '0 = no escalation' => '0 = ingen upptrappning',
        'If there is not added a customer contact, either email-external or phone, to a new ticket before the time defined here expires, the ticket is escalated.' =>
            '',
        'If there is an article added, such as a follow-up via email or the customer portal, the escalation update time is reset. If there is no customer contact, either email-external or phone, added to a ticket before the time defined here expires, the ticket is escalated.' =>
            '',
        'If the ticket is not set to closed before the time defined here expires, the ticket is escalated.' =>
            '',
        'Follow up Option' => 'Korrespondens på låst ärende',
        'Specifies if follow up to closed tickets would re-open the ticket, be rejected or lead to a new ticket.' =>
            'Anger om uppföljningar till stängda ärenden åter-öppnar ärendet, blir avvisat eller skapar ett nytt ärende.',
        'Ticket lock after a follow up' => 'Ärendet låses efter uppföljningsmail',
        'If a ticket is closed and the customer sends a follow up the ticket will be locked to the old owner.' =>
            '',
        'System address' => 'Systemadress',
        'Will be the sender address of this queue for email answers.' => 'Avsändaradress för email i denna Kö.',
        'Default sign key' => '',
        'To use a sign key, PGP keys or S/MIME certificates need to be added with identifiers for selected queue system address.' =>
            '',
        'Salutation' => 'Hälsningsfras',
        'The salutation for email answers.' => 'Hälsningsfras för email-svar.',
        'Signature' => 'Signatur',
        'The signature for email answers.' => 'Signatur för email-svar.',
        'This queue is used in the following config settings:' => '',

        # Template: AdminQueueAutoResponse
        'Manage Queue-Auto Response Relations' => 'Hantera kö-autosvar-relationer',
        'Change Auto Response Relations for Queue' => 'Ändra autosvar-relationer för kön',
        'This filter allow you to show queues without auto responses' => '',
        'Queues without Auto Responses' => '',
        'This filter allow you to show all queues' => '',
        'Show All Queues' => '',
        'Auto Responses' => 'AutoSvar',

        # Template: AdminQueueTemplates
        'Manage Template-Queue Relations' => 'Hantera mall-kö-relationer',
        'Filter for Templates' => 'Filter för mallar',
        'Filter for templates' => '',
        'Templates' => 'Mallar',

        # Template: AdminRegistration
        'System Registration Management' => 'Registrering av OTOBO-installationen',
        'Edit System Registration' => '',
        'System Registration Overview' => '',
        'Register System' => '',
        'Validate OTOBO-ID' => '',
        'Deregister System' => 'Avregistrera OTOBO-installationen',
        'Edit details' => '',
        'Show transmitted data' => 'Visa överförda data',
        'Deregister system' => 'Avregistrera OTOBO-installationen',
        'Overview of registered systems' => 'Översikt över registrerade OTOBO-installationer',
        'This system is registered with OTOBO Team.' => '',
        'System type' => 'Systemtyp',
        'Unique ID' => 'Unikt ID',
        'Last communication with registration server' => 'Senaste kontakt med reistreringsservern',
        'System Registration not Possible' => '',
        'Please note that you can\'t register your system if OTOBO Daemon is not running correctly!' =>
            'Systemregisteringen kräver att OTOBO-demonen körs.',
        'Instructions' => 'Instruktioner',
        'System Deregistration not Possible' => '',
        'OTOBO-ID Login' => 'OTOBO-ID-inloggning',
        'System registration is a service of OTOBO Team, which provides a lot of advantages!' =>
            '',
        'Read more' => 'Läs mer',
        'You need to log in with your OTOBO-ID to register your system.' =>
            'Logga in med ditt OTOBO-ID för att registrera OTOBO-installationen.',
        'Your OTOBO-ID is the email address you used to sign up on the OTOBO.com webpage.' =>
            'Ditt OTOBO-ID är den e-postadress du använde för att registrera dig på OTOBO.com.',
        'Data Protection' => 'Dataskydd för personuppgifter',
        'What are the advantages of system registration?' => 'Vilka är fördelarna med att registrera OTOBO-installationen?',
        'You will receive updates about relevant security releases.' => '',
        'With your system registration we can improve our services for you, because we have all relevant information available.' =>
            'Genom att registrera OTOBO-installationen kan informationen du tillhandahåller hjälpa Rother OSS GmbH att förbättra tjänsterna.',
        'This is only the beginning!' => '',
        'We will inform you about our new services and offerings soon.' =>
            '',
        'Can I use OTOBO without being registered?' => 'Kan jag använda OTOBO utan att vara registrerad?',
        'System registration is optional.' => 'Registrering av OTOBO-installationen är inte obligatorisk.',
        'You can download and use OTOBO without being registered.' => 'Du kan hämta och använda OTOBO utan registrering av installationen.',
        'Is it possible to deregister?' => 'Kan man avregistrera en OTOBO-installation?',
        'You can deregister at any time.' => 'Du kan avregistrera en OTOBO-installation när som helst.',
        'Which data is transfered when registering?' => 'Vilka uppgifter skickas vid registrering av OTOBO-installationen?',
        'A registered system sends the following data to OTOBO Team:' => '',
        'Fully Qualified Domain Name (FQDN), OTOBO version, Database, Operating System and Perl version.' =>
            'Domännamnet (FQDN), OTOBO-version, databastyp, samt OS- och Perl-version.',
        'Why do I have to provide a description for my system?' => 'Varför ska jag ge en systembeskrivning?',
        'The description of the system is optional.' => 'Systembeskrivningen är inte obligatorisk.',
        'The description and system type you specify help you to identify and manage the details of your registered systems.' =>
            'Systembeskrivningen och -typen gör det lättare att hålla reda på uppgifterna om dina registrerade OTOBO-installationer.',
        'How often does my OTOBO system send updates?' => 'Hur ofta skickar OTOBO-installationen uppdateringar?',
        'Your system will send updates to the registration server at regular intervals.' =>
            'Din OTOBO-installation skickar regelbundet uppdateringar till registreringsservern.',
        'Typically this would be around once every three days.' => 'Vanligtvis sker det var tredje dag.',
        'If you deregister your system, you will lose these benefits:' =>
            'Om du avregistrerar OTOBO-installationen avstår du från följande:',
        'You need to log in with your OTOBO-ID to deregister your system.' =>
            'Du behöver logga in med ditt OTOBO-ID för att avregistrera OTOBO-installationen.',
        'OTOBO-ID' => 'OTOBO-ID',
        'You don\'t have an OTOBO-ID yet?' => 'Saknar du OTOBO-ID?',
        'Sign up now' => 'Registrera dig nu',
        'Forgot your password?' => 'Glömt ditt lösenord?',
        'Retrieve a new one' => 'Generera ett nytt lösenord',
        'Next' => 'Nästa',
        'This data will be frequently transferred to OTOBO Team when you register this system.' =>
            '',
        'Attribute' => 'Attribut',
        'FQDN' => 'FQDN',
        'OTOBO Version' => 'OTOBO-version',
        'Operating System' => 'Operativsystem',
        'Perl Version' => 'Perl-version',
        'Optional description of this system.' => 'Valfritt: beskrivning av systemet.',
        'This will allow the system to send additional support data information to OTOBO Team.' =>
            '',
        'Register' => 'Registrera',
        'Continuing with this step will deregister the system from OTOBO Team.' =>
            '',
        'Deregister' => 'Avregistrera',
        'You can modify registration settings here.' => '',
        'Overview of Transmitted Data' => '',
        'There is no data regularly sent from your system to %s.' => 'Inga data skickas regelbundet från OTOBO-installationen till %s.',
        'The following data is sent at minimum every 3 days from your system to %s.' =>
            'Följande supportdata om OTOBO-installationen skickas var tredje dag till %s.',
        'The data will be transferred in JSON format via a secure https connection.' =>
            '',
        'System Registration Data' => 'Systemregistreringsdata',
        'Support Data' => 'Supportdata',

        # Template: AdminRole
        'Role Management' => 'Roller',
        'Add Role' => 'Lägg till Roll',
        'Edit Role' => '',
        'Filter for Roles' => '',
        'Filter for roles' => '',
        'Create a role and put groups in it. Then add the role to the users.' =>
            'Skapa en roll och lägg grupper i den. Lägg sedan till rollen till användare.',
        'There are no roles defined. Please use the \'Add\' button to create a new role.' =>
            '',

        # Template: AdminRoleGroup
        'Manage Role-Group Relations' => 'Hantera roll-grupp-relationer',
        'Roles' => 'Roller',
        'Select the role:group permissions.' => '',
        'If nothing is selected, then there are no permissions in this group (tickets will not be available for the role).' =>
            '',
        'Toggle %s permission for all' => '',
        'move_into' => 'Flytta till',
        'Permissions to move tickets into this group/queue.' => 'Rätt att flytta ärenden i denna grupp/Kö.',
        'create' => 'Skapa',
        'Permissions to create tickets in this group/queue.' => 'Rätt att skapa ärenden i denna grupp/Kö.',
        'note' => 'notera',
        'Permissions to add notes to tickets in this group/queue.' => 'Rätt att skapa anteckningar på ärenden i den här gruppen/kön.',
        'owner' => 'ansvarig handläggare',
        'Permissions to change the owner of tickets in this group/queue.' =>
            '',
        'priority' => 'prioritet',
        'Permissions to change the ticket priority in this group/queue.' =>
            'Rätt att ändra ärendeprioritet i denna grupp/Kö.',

        # Template: AdminRoleUser
        'Manage Agent-Role Relations' => 'Hantera handläggare-roll-relationer',
        'Add Agent' => 'Lägg till handläggare',
        'Filter for Agents' => 'Filter för handläggare',
        'Filter for agents' => '',
        'Agents' => 'Handläggare',
        'Manage Role-Agent Relations' => 'Hantera roll-handläggar-relationer',

        # Template: AdminSLA
        'SLA Management' => 'SLA',
        'Edit SLA' => 'Redigera SLA',
        'Add SLA' => 'Lägg till SLA',
        'Filter for SLAs' => '',
        'Please write only numbers!' => 'Skriv bara siffror!',

        # Template: AdminSMIME
        'S/MIME Management' => 'S/MIME',
        'Add Certificate' => 'Lägg till Certifikat',
        'Add Private Key' => 'Lägg till Privat Nyckel',
        'SMIME support is disabled' => '',
        'To be able to use SMIME in OTOBO, you have to enable it first.' =>
            '',
        'Enable SMIME support' => '',
        'Faulty SMIME configuration' => '',
        'SMIME support is enabled, but the relevant configuration contains errors. Please check the configuration using the button below.' =>
            '',
        'Check SMIME configuration' => '',
        'Filter for Certificates' => '',
        'Filter for certificates' => 'Filter för certifikat',
        'To show certificate details click on a certificate icon.' => 'Klicka på certifikatsikonen för detaljer om certifikatet.',
        'To manage private certificate relations click on a private key icon.' =>
            'Klicka på privata nyckeln-ikonen för att hantera relationer för privata certifikat.',
        'Here you can add relations to your private certificate, these will be embedded to the S/MIME signature every time you use this certificate to sign an email.' =>
            'Lägg till relationer för ditt privata certifikat. De bäddas då in i S/MIME-signaturen för de e-brev du signerat med certifikatet.',
        'See also' => 'Se även',
        'In this way you can directly edit the certification and private keys in file system.' =>
            'På det här sättet kan du redigera certifikat och nycklar på filsystemet.',
        'Hash' => 'checksumma',
        'Create' => 'Skapa',
        'Handle related certificates' => 'Hantera relaterade certifikat',
        'Read certificate' => 'Öppna certifikatet',
        'Delete this certificate' => 'Ta bort certifikatet',
        'File' => 'Fil',
        'Secret' => 'Hemlighet',
        'Related Certificates for' => 'Relaterade certifikat för',
        'Delete this relation' => 'Ta bort relationen',
        'Available Certificates' => 'Tillgängliga certifikat',
        'Filter for S/MIME certs' => 'Filter för S/MIME-certifikat',
        'Relate this certificate' => 'Ange relation för certifikatet',

        # Template: AdminSMIMECertRead
        'S/MIME Certificate' => 'S/MIME-certifikat',
        'Certificate Details' => '',
        'Close this dialog' => 'Stäng dialog',

        # Template: AdminSalutation
        'Salutation Management' => 'Hantering av Hälsningsfraser',
        'Add Salutation' => 'Lägg till Hälsningsfras',
        'Edit Salutation' => 'Redigera hälsningsfras',
        'Filter for Salutations' => '',
        'Filter for salutations' => '',
        'e. g.' => 't.ex.',
        'Example salutation' => 'Exempel på hälsningsfras',

        # Template: AdminSecureMode
        'Secure Mode Needs to be Enabled!' => '',
        'Secure mode will (normally) be set after the initial installation is completed.' =>
            'Säkert läge använda (normalt) efter iledande installation är slutförd.',
        'If secure mode is not activated, activate it via SysConfig because your application is already running.' =>
            'Programmet körs redan. Om säkert läge inte är aktiverat gör du det via SysConfig i Administrations-vyn.',

        # Template: AdminSelectBox
        'SQL Box' => 'SQL-frågefönster',
        'Filter for Results' => '',
        'Filter for results' => '',
        'Here you can enter SQL to send it directly to the application database. It is not possible to change the content of the tables, only select queries are allowed.' =>
            'Här skriver du in SQL-uttrycket för att exekvera det mot databasen. Du kan endast skicka \'select\'-uttryck. Att utföra ändringar är inte möjligt.',
        'Here you can enter SQL to send it directly to the application database.' =>
            'Här skriver du in SQL-uttrycket för att exekvera det mot databasen.',
        'Options' => 'Tillval',
        'Only select queries are allowed.' => 'Endast \'select\'-frågor tillåts.',
        'The syntax of your SQL query has a mistake. Please check it.' =>
            'SQL-uttrycket är felaktigt. Kontrollera syntaxen och försök igen. ',
        'There is at least one parameter missing for the binding. Please check it.' =>
            'Åtminstone en variabelbindning saknas. Kontrollera och försök igen.',
        'Result format' => 'Resultatformat',
        'Run Query' => 'Utför frågan',
        '%s Results' => '',
        'Query is executed.' => 'Frågan är utförd.',

        # Template: AdminService
        'Service Management' => 'Tjänster',
        'Add Service' => 'Lägg till tjänst',
        'Edit Service' => 'Redigera tjänst',
        'Service name maximum length is 200 characters (with Sub-service).' =>
            '',
        'Sub-service of' => 'Undertjänst till',

        # Template: AdminSession
        'Session Management' => 'Sessionshantering',
        'Detail Session View for %s (%s)' => '',
        'All sessions' => 'Alla sessioner',
        'Agent sessions' => 'Handläggarsessioner',
        'Customer sessions' => 'Kundsessioner',
        'Unique agents' => 'Faktiska handläggare',
        'Unique customers' => 'Faktiska kunder',
        'Kill all sessions' => 'Terminera alla sessioner',
        'Kill this session' => 'Avsluta sessionen',
        'Filter for Sessions' => '',
        'Filter for sessions' => '',
        'Session' => 'Session',
        'Kill' => 'Avsluta',
        'Detail View for SessionID: %s - %s' => '',

        # Template: AdminSignature
        'Signature Management' => 'Signaturer',
        'Add Signature' => 'Lägg till signatur',
        'Edit Signature' => 'Redigera signatur',
        'Filter for Signatures' => '',
        'Filter for signatures' => '',
        'Example signature' => 'Exempelsignatur',

        # Template: AdminState
        'State Management' => 'Status',
        'Add State' => 'Lägg till Status',
        'Edit State' => 'Redigera status',
        'Filter for States' => '',
        'Filter for states' => '',
        'Attention' => 'OBS',
        'Please also update the states in SysConfig where needed.' => '',
        'This state is present in a SysConfig setting, confirmation for updating settings to point to the new type is needed!' =>
            '',
        'State type' => 'Statustyp',
        'It\'s not possible to invalidate this entry because there is no other merge states in system!' =>
            '',
        'This state is used in the following config settings:' => '',

        # Template: AdminSupportDataCollector
        'Sending support data to OTOBO Team is not possible!' => '',
        'Enable Cloud Services' => '',
        'This data is sent to OTOBO Team on a regular basis. To stop sending this data please update your system registration.' =>
            '',
        'You can manually trigger the Support Data sending by pressing this button:' =>
            '',
        'Send Update' => 'Skicka uppdatering',
        'Currently this data is only shown in this system.' => 'Supportdata finns för tillfället endast lokalt i din OTOBO-installation.',
        'It is highly recommended to send this data to OTOBO Team in order to get better support.' =>
            '',
        'To enable data sending, please register your system with OTOBO Team or update your system registration information (make sure to activate the \'send support data\' option.)' =>
            '',
        'A support bundle (including: system registration information, support data, a list of installed packages and all locally modified source code files) can be generated by pressing this button:' =>
            '',
        'Generate Support Bundle' => 'Skapa supportpaket',
        'The Support Bundle has been Generated' => '',
        'Please choose one of the following options.' => 'Välj ett av följande alternativ:',
        'Send by Email' => 'Skicka som e-post',
        'The support bundle is too large to send it by email, this option has been disabled.' =>
            '',
        'The email address for this user is invalid, this option has been disabled.' =>
            'Alternativet är inte tillgängligt då e-postadressen för användaren är ogiltig.',
        'Sending' => 'Skickar',
        'The support bundle will be sent to OTOBO Team via email automatically.' =>
            '',
        'Download File' => 'Hämta bilaga',
        'A file containing the support bundle will be downloaded to the local system. Please save the file and send it to the OTOBO Team, using an alternate method.' =>
            '',
        'Error: Support data could not be collected (%s).' => '',
        'Details' => '',

        # Template: AdminSystemAddress
        'System Email Addresses Management' => 'Hantera systemets e-postadresser',
        'Add System Email Address' => 'Lägg till en system-epostadress',
        'Edit System Email Address' => 'Ändra en system-e-postadress',
        'Add System Address' => '',
        'Filter for System Addresses' => '',
        'Filter for system addresses' => '',
        'All incoming email with this address in To or Cc will be dispatched to the selected queue.' =>
            '',
        'Email address' => 'E-postadress',
        'Display name' => '',
        'This email address is already used as system email address.' => '',
        'The display name and email address will be shown on mail you send.' =>
            '',
        'This system address cannot be set to invalid.' => '',
        'This system address cannot be set to invalid, because it is used in one or more queue(s) or auto response(s).' =>
            '',

        # Template: AdminSystemConfiguration
        'online administrator documentation' => '',
        'System configuration' => '',
        'Navigate through the available settings by using the tree in the navigation box on the left side.' =>
            '',
        'Find certain settings by using the search field below or from search icon from the top navigation.' =>
            '',
        'Find out how to use the system configuration by reading the %s.' =>
            '',
        'Search in all settings...' => '',
        'There are currently no settings available. Please make sure to run \'otobo.Console.pl Maint::Config::Rebuild\' before using the software.' =>
            '',

        # Template: AdminSystemConfigurationDeployment
        'Changes Deployment' => '',
        'Help' => '',
        'This is an overview of all settings which will be part of the deployment if you start it now. You can compare each setting to its former state by clicking the icon on the top right.' =>
            '',
        'To exclude certain settings from a deployment, click the checkbox on the header bar of a setting.' =>
            '',
        'By default, you will only deploy settings which you changed on your own. If you\'d like to deploy settings changed by other users, too, please click the link on top of the screen to enter the advanced deployment mode.' =>
            '',
        'A deployment has just been restored, which means that all affected setting have been reverted to the state from the selected deployment.' =>
            '',
        'Please review the changed settings and deploy afterwards.' => '',
        'An empty list of changes means that there are no differences between the restored and the current state of the affected settings.' =>
            '',
        'Changes Overview' => '',
        'There are %s changed settings which will be deployed in this run.' =>
            '',
        'Switch to basic mode to deploy settings only changed by you.' =>
            '',
        'You have %s changed settings which will be deployed in this run.' =>
            '',
        'Switch to advanced mode to deploy settings changed by other users, too.' =>
            '',
        'There are no settings to be deployed.' => '',
        'Switch to advanced mode to see deployable settings changed by other users.' =>
            '',
        'Deploy selected changes' => '',

        # Template: AdminSystemConfigurationDeploymentHistory
        'Deployment History' => '',
        'Filter for Deployments' => '',
        'Recent Deployments' => '',
        'Restore' => '',
        'View Details' => '',
        'Restore this deployment.' => '',
        'Export this deployment.' => '',

        # Template: AdminSystemConfigurationDeploymentHistoryDetails
        'Deployment Details' => '',
        'by' => 'av',
        'No settings have been deployed in this run.' => '',

        # Template: AdminSystemConfigurationGroup
        'This group doesn\'t contain any settings. Please try navigating to one of its sub groups.' =>
            '',

        # Template: AdminSystemConfigurationImportExport
        'Import & Export' => '',
        'Upload a file to be imported to your system (.yml format as exported from the System Configuration module).' =>
            '',
        'Upload system configuration' => '',
        'Import system configuration' => '',
        'Download current configuration settings of your system in a .yml file.' =>
            '',
        'Include user settings' => '',
        'Export current configuration' => '',

        # Template: AdminSystemConfigurationSearch
        'Search for' => '',
        'Search for category' => '',
        'Settings I\'m currently editing' => '',
        'Your search for "%s" in category "%s" did not return any results.' =>
            '',
        'Your search for "%s" in category "%s" returned one result.' => '',
        'Your search for "%s" in category "%s" returned %s results.' => '',
        'You\'re currently not editing any settings.' => '',
        'You\'re currently editing %s setting(s).' => '',

        # Template: AdminSystemConfigurationSearchDialog
        'Category' => 'Kategori',
        'Run search' => 'Kör sökning',

        # Template: AdminSystemConfigurationSettingHistoryDetails
        'Change History' => '',
        'Change History of %s' => '',
        'No modified values for this setting, the default value is used.' =>
            '',

        # Template: AdminSystemConfigurationUserModifiedDetails
        'Review users setting value' => '',
        'Users Value' => '',
        'For' => '',
        'Delete all user values.' => '',
        'No user value for this setting.' => '',

        # Template: AdminSystemConfigurationView
        'View a custom List of Settings' => '',
        'View single Setting: %s' => '',
        'Go back to Deployment Details' => '',

        # Template: AdminSystemMaintenance
        'System Maintenance Management' => 'Hantera systemunderhåll',
        'Schedule New System Maintenance' => 'Schemalägg nytt systemunderhåll',
        'Filter for System Maintenances' => '',
        'Filter for system maintenances' => 'Filter för systemunderhåll',
        'Schedule a system maintenance period for announcing the Agents and Customers the system is down for a time period.' =>
            '',
        'Some time before this system maintenance starts the users will receive a notification on each screen announcing about this fact.' =>
            '',
        'Stop date' => 'Slutdatum',
        'Delete System Maintenance' => 'Ta bort ett systemunderhåll',

        # Template: AdminSystemMaintenanceEdit
        'Edit System Maintenance' => '',
        'Edit System Maintenance Information' => '',
        'Date invalid!' => 'Ogiltigt datum!',
        'Login message' => 'Inloggningsmeddelande',
        'This field must have less then 250 characters.' => '',
        'Show login message' => 'Visa inloggningsmeddelande',
        'Notify message' => 'Meddelande',
        'Manage Sessions' => 'Hantera sessioner',
        'All Sessions' => 'Alla sessioner',
        'Agent Sessions' => 'Handläggarsessioner',
        'Customer Sessions' => 'Kundsessioner',
        'Kill all Sessions, except for your own' => 'Avsluta alla sessioner utom den egna',

        # Template: AdminTemplate
        'Template Management' => '',
        'Add Template' => 'Lägg till mall',
        'Edit Template' => 'Redigera mall',
        'A template is a default text which helps your agents to write faster tickets, answers or forwards.' =>
            'En mall är en standardtext som hjälper dina handläggare att skriva ärenden, svar eller vidarebefordran snabbare.',
        'Don\'t forget to add new templates to queues.' => 'Glöm inte att lägga till nya mallar till köer.',
        'Attachments' => 'Bifogade dokument',
        'Delete this entry' => 'Radera denna post',
        'Do you really want to delete this template?' => 'Vill du verkligen radera den här mallen?',
        'A standard template with this name already exists!' => 'En standardmall med det här namnet existerar redan!',
        'To get the first 20 characters of the subject of the current/latest agent article (current for Answer and Forward, latest for Note template type). This tag is not supported for other template types.' =>
            '',
        'To get the first 5 lines of the body of the current/latest agent article (current for Answer and Forward, latest for Note template type). This tag is not supported for other template types.' =>
            '',
        'To get the first 20 characters of the subject of the current/latest article (current for Answer and Forward, latest for Note template type). This tag is not supported for other template types.' =>
            '',
        'To get the first 5 lines of the body of the current/latest article (current for Answer and Forward, latest for Note template type). This tag is not supported for other template types.' =>
            '',
        'Create type templates only supports this smart tags' => '',
        'Example template' => 'Exempelmall',
        'The current ticket state is' => 'Nuvarande ärendestatus',
        'Your email address is' => 'Din e-postadress',

        # Template: AdminTemplateAttachment
        'Manage Template-Attachment Relations' => '',
        'Toggle active for all' => '',
        'Link %s to selected %s' => '',

        # Template: AdminType
        'Type Management' => 'Ärendetyp',
        'Add Type' => 'Lägg till Typ',
        'Edit Type' => 'Redigera typ',
        'Filter for Types' => '',
        'Filter for types' => '',
        'A type with this name already exists!' => '',
        'This type is present in a SysConfig setting, confirmation for updating settings to point to the new type is needed!' =>
            '',
        'This type is used in the following config settings:' => '',

        # Template: AdminUser
        'Agent Management' => 'Handläggare',
        'Edit Agent' => 'Redigera handläggare',
        'Edit personal preferences for this agent' => '',
        'Agents will be needed to handle tickets.' => 'Handläggare hanterar ärenden.',
        'Don\'t forget to add a new agent to groups and/or roles!' => 'Lägg även till nya handläggare till grupper och/eller roller!',
        'Please enter a search term to look for agents.' => 'Skriv in sökord för att hitta handläggare',
        'Last login' => 'Senaste inloggning',
        'Switch to agent' => 'Växla till handläggare',
        'Title or salutation' => '',
        'Firstname' => 'Förnamn',
        'Lastname' => 'Efternamn',
        'A user with this username already exists!' => '',
        'Will be auto-generated if left empty.' => '',
        'Mobile' => 'Mobil',
        'Effective Permissions for Agent' => '',
        'This agent has no group permissions.' => '',
        'Table above shows effective group permissions for the agent. The matrix takes into account all inherited permissions (e.g. via roles).' =>
            '',

        # Template: AdminUserGroup
        'Manage Agent-Group Relations' => 'Hantera handläggare-grupp-relationer ',

        # Template: AgentAppointmentAgendaOverview
        'Agenda Overview' => 'Dagordningsvy',
        'Manage Calendars' => 'Hantera kalendrar',
        'Add Appointment' => 'Lägg till händelse',
        'Today' => 'Idag',
        'All-day' => 'Heldagshändelse',
        'Repeat' => 'Upprepa',
        'Notification' => 'Notifiering',
        'Yes' => 'Ja',
        'No' => 'Nej',
        'No calendars found. Please add a calendar first by using Manage Calendars page.' =>
            'Hittar ingen kalender. Lägg till en kalender under Hantera kalendrar.',

        # Template: AgentAppointmentCalendarOverview
        'Add new Appointment' => 'Lägg till ny kalenderhändelse',
        'Calendars' => 'Kalendrar',

        # Template: AgentAppointmentEdit
        'Basic information' => '',
        'Date/Time' => 'Datum/tid',
        'Invalid date!' => 'Ogiltigt datum!',
        'Please set this to value before End date.' => '',
        'Please set this to value after Start date.' => '',
        'This an occurrence of a repeating appointment.' => '',
        'Click here to see the parent appointment.' => '',
        'Click here to edit the parent appointment.' => '',
        'Frequency' => '',
        'Every' => '',
        'day(s)' => 'dag(ar)',
        'week(s)' => 'veck(or)',
        'month(s)' => 'månad(er)',
        'year(s)' => 'år',
        'On' => 'På',
        'Monday' => 'Måndag',
        'Mon' => 'mån',
        'Tuesday' => 'Tisdag',
        'Tue' => 'tis',
        'Wednesday' => 'Onsdag',
        'Wed' => 'ons',
        'Thursday' => 'Torsdag',
        'Thu' => 'tor',
        'Friday' => 'Fredag',
        'Fri' => 'fre',
        'Saturday' => 'Lördag',
        'Sat' => 'lör',
        'Sunday' => 'Söndag',
        'Sun' => 'sön',
        'January' => 'Januari',
        'Jan' => 'jan',
        'February' => 'Februari',
        'Feb' => 'feb',
        'March' => 'Mars',
        'Mar' => 'mar',
        'April' => 'April',
        'Apr' => 'apr',
        'May_long' => 'Maj',
        'May' => 'maj',
        'June' => 'Juni',
        'Jun' => 'jun',
        'July' => 'Juli',
        'Jul' => 'jul',
        'August' => 'Augusti',
        'Aug' => 'aug',
        'September' => 'September',
        'Sep' => 'sep',
        'October' => 'Oktober',
        'Oct' => 'okt',
        'November' => 'November',
        'Nov' => 'nov',
        'December' => 'December',
        'Dec' => 'dec',
        'Relative point of time' => '',
        'Link' => 'Länk',
        'Remove entry' => 'Radera post',

        # Template: AgentCustomerInformationCenter
        'Customer Information Center' => 'Kundinformationscenter',

        # Template: AgentCustomerInformationCenterSearch
        'Customer User' => 'Kundanvändare',

        # Template: AgentCustomerTableView
        'Note: Customer is invalid!' => 'OBS: Kunden är ogiltig!',
        'Start chat' => 'Starta chatt',
        'Video call' => '',
        'Audio call' => '',

        # Template: AgentCustomerUserAddressBook
        'Customer User Address Book' => '',
        'Search for recipients and add the results as \'%s\'.' => '',
        'Search template' => 'Sökmall',
        'Create Template' => 'Skapa mall',
        'Create New' => 'Skapa ny',
        'Save changes in template' => 'Spara ändringar i mall',
        'Filters in use' => 'Använda filter',
        'Additional filters' => 'Ytterligare filter',
        'Add another attribute' => 'Lägg till ett annat attribut',
        'The attributes with the identifier \'(Customer)\' are from the customer company.' =>
            '',
        '(e. g. Term* or *Term*)' => '',

        # Template: AgentCustomerUserAddressBookOverview
        'Select all' => 'Välj alla',
        'The customer user is already selected in the ticket mask.' => '',
        'Select this customer user' => '',
        'Add selected customer user to' => '',

        # Template: AgentCustomerUserAddressBookOverviewNavBar
        'Change search options' => 'Ändra sökinställningar',

        # Template: AgentCustomerUserInformationCenter
        'Customer User Information Center' => '',

        # Template: AgentDaemonInfo
        'The OTOBO Daemon is a daemon process that performs asynchronous tasks, e.g. ticket escalation triggering, email sending, etc.' =>
            '',
        'A running OTOBO Daemon is mandatory for correct system operation.' =>
            'OTOBO-demonen behöver köras för att systemet ska fungera som det ska.',
        'Starting the OTOBO Daemon' => 'Startar OTOBO-demonen',
        'Make sure that the file \'%s\' exists (without .dist extension). This cron job will check every 5 minutes if the OTOBO Daemon is running and start it if needed.' =>
            '',
        'Execute \'%s start\' to make sure the cron jobs of the \'otobo\' user are active.' =>
            '',
        'After 5 minutes, check that the OTOBO Daemon is running in the system (\'bin/otobo.Daemon.pl status\').' =>
            'Kontroller om fem minuter att OTOBO-demonen körs (\'bin/otobo.Daemon.pl status\').',

        # Template: AgentDashboard
        'Dashboard' => 'Översikt',

        # Template: AgentDashboardAppointmentCalendar
        'New Appointment' => 'Ny kalenderhändelse',
        'Tomorrow' => 'Imorgon',
        'Soon' => 'Snart',
        '5 days' => '5 dagar',
        'Start' => 'Start',
        'none' => 'inga',

        # Template: AgentDashboardCalendarOverview
        'in' => 'i',

        # Template: AgentDashboardCommon
        'Save settings' => 'Spara inställningar',
        'Close this widget' => '',
        'more' => 'mer',
        'Available Columns' => 'Tillgängliga kolumner',
        'Visible Columns (order by drag & drop)' => 'Synliga kolumner (sortera med dra & släpp)',

        # Template: AgentDashboardCustomerIDList
        'Change Customer Relations' => '',
        'Open' => 'Öppna',
        'Closed' => 'Stängda',
        '%s open ticket(s) of %s' => '%s öppna ärenden av %s',
        '%s closed ticket(s) of %s' => '%s stängda ärenden av %s',
        'Edit customer ID' => '',

        # Template: AgentDashboardCustomerIDStatus
        'Escalated tickets' => 'Eskalerade ärenden',
        'Open tickets' => 'Öppna ärenden',
        'Closed tickets' => 'Stängda ärenden',
        'All tickets' => 'Alla ärenden',
        'Archived tickets' => 'Arkiverade ärenden',

        # Template: AgentDashboardCustomerUserInformation
        'Note: Customer User is invalid!' => '',

        # Template: AgentDashboardCustomerUserList
        'Customer user information' => '',
        'Phone ticket' => 'Telefonärende',
        'Email ticket' => 'Epost-ärende',
        'New phone ticket from %s' => 'Nytt telefonärende från %s',
        'New email ticket to %s' => 'Nytt e-postärende från %s',

        # Template: AgentDashboardMyLastChangedTickets
        'No tickets found.' => '',

        # Template: AgentDashboardProductNotify
        '%s %s is available!' => '%s %s är tillgänlig!',
        'Please update now.' => 'Vänligen uppdatera nu.',
        'Release Note' => 'Släppanteckning',
        'Level' => 'Nivå',

        # Template: AgentDashboardRSSOverview
        'Posted %s ago.' => 'Postad för %s sedan.',

        # Template: AgentDashboardStats
        'The configuration for this statistic widget contains errors, please review your settings.' =>
            '',
        'Download as SVG file' => 'Hämta som SVG',
        'Download as PNG file' => 'Hämta som PNG',
        'Download as CSV file' => 'Hämta som CSV',
        'Download as Excel file' => 'Hämta som Excel-arbetsbok',
        'Download as PDF file' => 'Hämta som PDF',
        'Please select a valid graph output format in the configuration of this widget.' =>
            '',
        'The content of this statistic is being prepared for you, please be patient.' =>
            'Denna information förbereds just nu. Vänligen vänta lite...',
        'This statistic can currently not be used because its configuration needs to be corrected by the statistics administrator.' =>
            '',

        # Template: AgentDashboardTicketGeneric
        'Assigned to customer user' => '',
        'Accessible for customer user' => '',
        'My locked tickets' => 'Mina låsta ärenden',
        'My watched tickets' => 'Mina bevakade ärenden',
        'My responsibilities' => 'Mina uppdrag',
        'Tickets in My Queues' => 'Ärenden i Mina Köer',
        'Tickets in My Services' => 'Ärenden i Mina Tjänster',
        'Service Time' => 'Tjänsttid',

        # Template: AgentDashboardTicketQueueOverview
        'Total' => '',

        # Template: AgentDashboardUserOnline
        'out of office' => 'frånvarande',

        # Template: AgentDashboardUserOutOfOffice
        'until' => 'till',

        # Template: AgentDynamicFieldDBDetailedSearch
        'Back' => 'Tillbaka',
        'Detailed search' => '',
        'Add an additional attribute' => '',

        # Template: AgentDynamicFieldDBDetails
        'Details view' => '',

        # Template: AgentElasticsearchQuickResult
        'Tickets' => 'Ärenden',
        'ConfigItems' => '',

        # Template: AgentInfo
        'To accept some news, a license or some changes.' => '',
        'Yes, accepted.' => '',

        # Template: AgentLinkObject
        'Manage links for %s' => '',
        'Create new links' => '',
        'Manage existing links' => '',
        'Link with' => '',
        'Start search' => '',
        'There are currently no links. Please click \'Create new Links\' on the top to link this item to other objects.' =>
            '',

        # Template: AgentPassword
        'Password Policy' => '',
        'Your current password is older than %s days. You need to set a new one.' =>
            '',
        'Change password' => 'Byt lösenord',
        'Current password' => 'Nuvarande lösenord',
        'New password' => 'Nytt lösenord',
        'Repeat new password' => '',
        'Password needs to be renewed every %s days.' => '',
        'Password history is active, you can\'t use a password which was used the last %s times.' =>
            '',
        'Password length must be at least %s characters.' => '',
        'Password requires at least two lower- and two uppercase characters.' =>
            '',
        'Password requires at least two characters.' => '',
        'Password requires at least one digit.' => '',
        'Change config options' => '',
        'Admin permissions are required!' => '',

        # Template: AgentPreferences
        'Edit your preferences' => 'Ändra dina inställningar',
        'Personal Preferences' => '',
        'Preferences' => 'Inställningar',
        'Please note: you\'re currently editing the preferences of %s.' =>
            '',
        'Go back to editing this agent' => '',
        'Set up your personal preferences. Save each setting by clicking the checkmark on the right.' =>
            '',
        'You can use the navigation tree below to only show settings from certain groups.' =>
            '',
        'Dynamic Actions' => '',
        'Filter settings...' => '',
        'Filter for settings' => '',
        'Save all settings' => '',
        'Avatars have been disabled by the system administrator. You\'ll see your initials instead.' =>
            '',
        'You can change your avatar image by registering with your email address %s at %s. Please note that it can take some time until your new avatar becomes available because of caching.' =>
            '',
        'End' => 'Slut',
        'This setting can currently not be saved.' => '',
        'This setting can currently not be saved' => '',
        'Save this setting' => '',
        'Did you know? You can help translating OTOBO at %s.' => 'Visste du att du kan hjälpa till att översätta OTOBO på %s.',

        # Template: SettingsList
        'Reset to default' => '',

        # Template: AgentPreferencesOverview
        'Choose from the groups on the right to find the settings you\'d wish to change.' =>
            '',
        'Did you know?' => '',
        'You can change your avatar by registering with your email address %s on %s' =>
            '',

        # Template: AgentSplitSelection
        'Target' => '',
        'Process' => 'Process',
        'Split' => 'Dela',

        # Template: AgentStatisticsAdd
        'Statistics Management' => '',
        'Add Statistics' => '',
        'Read more about statistics in OTOBO' => '',
        'Dynamic Matrix' => '',
        'Each cell contains a singular data point.' => '',
        'Dynamic List' => '',
        'Each row contains data of one entity.' => '',
        'Static' => '',
        'Non-configurable complex statistics.' => '',
        'General Specification' => 'Generell specifikation',
        'Create Statistic' => 'Skapa rapport',

        # Template: AgentStatisticsEdit
        'Edit Statistics' => '',
        'Run now' => 'Kör nu',
        'Statistics Preview' => 'Förhandsvisa rapport',
        'Save Statistic' => '',

        # Template: AgentStatisticsImport
        'Import Statistics' => '',
        'Import Statistics Configuration' => '',

        # Template: AgentStatisticsOverview
        'Statistics' => 'Rapporter',
        'Run' => 'Utför',
        'Edit statistic "%s".' => 'Redigera rapporten "%s".',
        'Export statistic "%s"' => 'Exportera rapporten "%s"',
        'Export statistic %s' => 'Exportera rapporterna %s',
        'Delete statistic "%s"' => 'Ta bort rapporten "%s"',
        'Delete statistic %s' => 'Ta bort rapporterna %s',

        # Template: AgentStatisticsReportsAdd
        'Report Management' => '',
        'Add Report' => '',

        # Template: AgentStatisticsReportsEdit
        'Edit Report' => '',
        'Here you can combine several statistics to a report which you can generate as a PDF manually or automatically at configured times.' =>
            '',
        'Please note that you can only select charts as statistics output format if you configured one of the renderer binaries on your system.' =>
            '',
        'Configure PhantomJS' => '',
        'Configure GoogleChrome' => '',
        'General settings' => '',
        'Automatic generation settings' => '',
        'Automatic generation times (cron)' => '',
        'Specify when the report should be automatically generated in cron format, e. g. "10 1 * * *" for every day at 1:10 am.' =>
            '',
        'Times are in the system timezone.' => '',
        'Last automatic generation time' => '',
        'Next planned automatic generation time' => '',
        'Automatic generation language' => '',
        'The language to be used when the report is automatically generated.' =>
            '',
        'Email subject' => '',
        'Specify the subject for the automatically generated email.' => '',
        'Email body' => '',
        'Specify the text for the automatically generated email.' => '',
        'Email recipients' => '',
        'Specify recipient email addresses (comma separated).' => '',
        'Output settings' => '',
        'Headline' => '',
        'Caption for preamble' => '',
        'Preamble' => '',
        'Caption for epilogue' => '',
        'Epilogue' => '',
        'Add statistic to report' => '',

        # Template: AgentStatisticsReportsOverview
        'Statistics Reports' => '',
        'Edit statistics report "%s".' => '',
        'Delete statistics report "%s"' => '',

        # Template: AgentStatisticsReportsView
        'View Report' => '',
        'This statistics report contains configuration errors and can currently not be used.' =>
            '',

        # Template: AgentStatisticsView
        'Statistics Overview' => '',
        'View Statistics' => '',
        'Statistics Information' => '',
        'Created by' => 'Skapat av',
        'Changed by' => 'Ändrat av',
        'Sum rows' => 'Summera rader',
        'Sum columns' => 'Summera kolumner',
        'Show as dashboard widget' => 'Visa som översiktsvy',
        'Cache' => 'Cache',
        'This statistic contains configuration errors and can currently not be used.' =>
            'Rapporten kan inte användas då den innehåller konfigurationsfel.',

        # Template: AgentTicketActionCommon
        'Change Free Text of %s%s%s' => '',
        'Change Owner of %s%s%s' => '',
        'Close %s%s%s' => '',
        'Add Note to %s%s%s' => '',
        'Set Pending Time for %s%s%s' => '',
        'Change Priority of %s%s%s' => '',
        'Change Responsible of %s%s%s' => '',
        'The ticket has been locked' => 'Ärendet är låst',
        'Undo & close' => 'Ångra & stäng',
        'Ticket Settings' => 'Ärenden',
        'Queue invalid.' => '',
        'Service invalid.' => 'Ogiltig tjänst.',
        'SLA invalid.' => '',
        'New Owner' => 'Ny ansvarig handläggare',
        'Please set a new owner!' => 'Ange en ny ansvarig handläggare!',
        'Owner invalid.' => '',
        'New Responsible' => 'Ny ansvarig',
        'Please set a new responsible!' => '',
        'Responsible invalid.' => '',
        'Next state' => 'Nästa tillstånd',
        'State invalid.' => '',
        'For all pending* states.' => 'För alla väntetillstånd.',
        'Add Article' => 'Lägg till artikel',
        'Create an Article' => 'Skapa en artikel',
        'Inform agents' => 'Meddela handläggare',
        'Inform involved agents' => 'Meddela inblandade handläggare',
        'Here you can select additional agents which should receive a notification regarding the new article.' =>
            'Välj vilka andra handläggare som ska få notifiering om den här nya artikeln.',
        'Text will also be received by' => '',
        'Text Template' => 'Textmall',
        'Setting a template will overwrite any text or attachment.' => 'Att applicera mallen kommer att ta bort både text och bilagor. ',
        'Invalid time!' => 'Ogiltig tid!',

        # Template: AgentTicketBounce
        'Bounce %s%s%s' => '',
        'Bounce to' => 'Skicka över till',
        'You need a email address.' => 'Du behöver en e-postadress.',
        'Need a valid email address or don\'t use a local email address.' =>
            'Ange en giltig e-postadress eller undvik att ange en lokal e-postadress.',
        'Next ticket state' => 'Nästa ärendestatus',
        'Inform sender' => 'Informera avsändare',
        'Send mail' => 'Skicka e-post!',

        # Template: AgentTicketBulk
        'Ticket Bulk Action' => 'Ärendemassförändring',
        'Send Email' => 'Skicka e-post',
        'Merge' => 'Sammanfoga',
        'Merge to' => 'Slå samman med',
        'Invalid ticket identifier!' => 'Ogiltigt ärende-ID!',
        'Merge to oldest' => 'Slå samman till äldsta',
        'Link together' => 'Länka',
        'Link to parent' => 'Länk till förälder',
        'Unlock tickets' => 'Lås upp ärenden',
        'Execute Bulk Action' => '',

        # Template: AgentTicketCompose
        'Compose Answer for %s%s%s' => '',
        'This address is registered as system address and cannot be used: %s' =>
            'Den här e-postadressen är registrerad som en systemadress och kan därför inte användas: %s',
        'Please include at least one recipient' => 'Vänligen ange minst en mottagare',
        'Select one or more recipients from the customer user address book.' =>
            '',
        'Customer user address book' => '',
        'Remove Ticket Customer' => 'Ta bort ärendets kund',
        'Move to Cc' => '',
        'Move to Bcc' => '',
        'Please remove this entry and enter a new one with the correct value.' =>
            'Ta bort eller korrigera det ogiltiga värdet.',
        'This address already exists on the address list.' => 'Adressen är redan mottagarlistan.',
        'Remove Cc' => 'Ta bort Cc',
        'Move to To' => '',
        'Bcc' => 'Dold kopia',
        'Remove Bcc' => 'Ta bort Bcc',
        'Date Invalid!' => 'Ogiltigt datum!',

        # Template: AgentTicketCustomer
        'Change Customer of %s%s%s' => '',
        'Customer Information' => 'Kundinformation',
        'Customer user' => 'Kundanvändare',

        # Template: AgentTicketEmail
        'Create New Email Ticket' => 'Skapa nytt e-postärende',
        'Example Template' => 'Exempelmall',
        'To customer user' => 'Till kundanvändare',
        'Please include at least one customer user for the ticket.' => 'Vänligen ange minst en kundanvändare för ärendet.',
        'Select this customer as the main customer.' => 'Sätt den här användaren som den primära användaren',
        'Remove Ticket Customer User' => 'Ta bort ärendets kundanvändare',
        'From queue' => 'Från kö',
        'Get all' => 'Hämta alla',

        # Template: AgentTicketEmailOutbound
        'Outbound Email for %s%s%s' => '',

        # Template: AgentTicketEmailResend
        'Resend Email for %s%s%s' => '',

        # Template: AgentTicketEscalation
        'Ticket %s: first response time is over (%s/%s)!' => 'Ärende %s: första åtgärdstid har passerats (%s/%s)!',
        'Ticket %s: first response time will be over in %s/%s!' => 'Ärende %s: första åtgärdstid har passerats om %s/%s!',
        'Ticket %s: update time is over (%s/%s)!' => '',
        'Ticket %s: update time will be over in %s/%s!' => 'Ärende %s: uppdateringstid har passerats om %s/%s!',
        'Ticket %s: solution time is over (%s/%s)!' => 'Ärende %s: lösningstid har passerats (%s/%s)!',
        'Ticket %s: solution time will be over in %s/%s!' => 'Ärende %s: lösningstid har passerats om %s/%s!',

        # Template: AgentTicketForward
        'Forward %s%s%s' => '',

        # Template: AgentTicketHistory
        'History of %s%s%s' => '',
        'Filter for history items' => '',
        'Expand/collapse all' => '',
        'CreateTime' => 'CreateTime',
        'Article' => 'Artikel',

        # Template: AgentTicketMerge
        'Merge %s%s%s' => '',
        'Merge Settings' => 'Sammanfoga-inställningar',
        'You need to use a ticket number!' => 'Du måste ange ett ärendenummer!',
        'A valid ticket number is required.' => 'Att giltigt ärendenummer krävs.',
        'Try typing part of the ticket number or title in order to search by it.' =>
            '',
        'Limit the search to tickets with same Customer ID (%s).' => '',
        'Inform Sender' => '',
        'Need a valid email address.' => 'Behöver en giltig e-postadress.',

        # Template: AgentTicketMove
        'Move %s%s%s' => '',
        'New Queue' => 'Ny Kö',
        'Move' => 'Flytta',

        # Template: AgentTicketOverviewMedium
        'No ticket data found.' => 'Ingen ärendeinformation hittad.',
        'Open / Close ticket action menu' => 'Öppna/stängda ärenden-menyn',
        'Select this ticket' => 'Välj detta ärende',
        'Sender' => 'Avsändare',
        'First Response Time' => 'Första Responstid',
        'Update Time' => 'Uppdateringstid',
        'Solution Time' => 'Lösningstid',
        'Move ticket to a different queue' => 'Flytta ärende till en annan kö',
        'Change queue' => 'Ändra kö',

        # Template: AgentTicketOverviewNavBar
        'Remove active filters for this screen.' => 'Ta bort aktiva filter för denna vy.',
        'Tickets per page' => 'Ärenden per sida',

        # Template: AgentTicketOverviewPreview
        'Missing channel' => '',

        # Template: AgentTicketOverviewSmall
        'Reset overview' => 'Återställ översikt',
        'Column Filters Form' => '',

        # Template: AgentTicketPhone
        'Split Into New Phone Ticket' => 'Gör nytt telefonärende från detta',
        'Save Chat Into New Phone Ticket' => 'Spara chat till ett nytt telefonärende',
        'Create New Phone Ticket' => 'Skapa nytt telefonärende',
        'Please include at least one customer for the ticket.' => 'Vänligen ange minst en kund för ärendet.',
        'To queue' => 'Till kö',
        'Chat protocol' => 'Chattprotokoll',
        'The chat will be appended as a separate article.' => 'Chatten läggs till som en egen artikel i ärendet.',

        # Template: AgentTicketPhoneCommon
        'Phone Call for %s%s%s' => '',

        # Template: AgentTicketPlain
        'View Email Plain Text for %s%s%s' => '',
        'Plain' => 'Enkel',
        'Download this email' => 'Hämta e-brevet',

        # Template: AgentTicketProcess
        'Create New Process Ticket' => 'Skapa nytt processärende',

        # Template: AgentTicketProcessSmall
        'Enroll Ticket into a Process' => '',

        # Template: AgentTicketSearch
        'Profile link' => '',
        'Output' => 'Resultatbild',
        'Fulltext' => 'Fritext',
        'Customer ID (complex search)' => '',
        '(e. g. 234*)' => '',
        'Customer ID (exact match)' => '',
        'Assigned to Customer User Login (complex search)' => '',
        '(e. g. U51*)' => '',
        'Assigned to Customer User Login (exact match)' => '',
        'Accessible to Customer User Login (exact match)' => '',
        'Created in Queue' => 'Skapad i Kö',
        'Lock state' => '',
        'Watcher' => 'Bevakare',
        'Article Create Time (before/after)' => 'Tid när artikel skapades (före/efter)',
        'Article Create Time (between)' => 'Tid när artikel skapades (mellan)',
        'Please set this to value before end date.' => '',
        'Please set this to value after start date.' => '',
        'Ticket Create Time (before/after)' => 'Tid när ärende skapades (före/efter)',
        'Ticket Create Time (between)' => 'Tid när ärendet skapades (mellan)',
        'Ticket Change Time (before/after)' => 'Tid när ärende ändrades (före/efter)',
        'Ticket Change Time (between)' => 'Tid när ärendet ändrades (mellan)',
        'Ticket Last Change Time (before/after)' => 'Tid när ärende senast ändrades (före/efter)',
        'Ticket Last Change Time (between)' => 'Tid när ärendet senast ändrades (mellan)',
        'Ticket Pending Until Time (before/after)' => '',
        'Ticket Pending Until Time (between)' => '',
        'Ticket Close Time (before/after)' => 'Tid när ärende stängdes (före/efter)',
        'Ticket Close Time (between)' => 'Tid när ärendet stängdes (mellan)',
        'Ticket Escalation Time (before/after)' => 'Tid när ärende eskalerades (före/efter)',
        'Ticket Escalation Time (between)' => 'Tid när ärendet eskalerades (fmellan)',
        'Archive Search' => 'Arkivsökning',

        # Template: AgentTicketZoom
        'Sender Type' => 'Avsändartyp',
        'Save filter settings as default' => 'Spara filterinställningar som standard',
        'Event Type' => 'Händelsetyp',
        'Save as default' => '',
        'Drafts' => '',
        'Change Queue' => 'Ändra kö',
        'There are no dialogs available at this point in the process.' =>
            '',
        'This item has no articles yet.' => '',
        'Ticket Timeline View' => 'Tidslinjevy för ärende',
        'Article Overview - %s Article(s)' => '',
        'Page %s' => '',
        'Add Filter' => 'Lägg till filter',
        'Set' => 'Använd',
        'Reset Filter' => 'Återställ filter',
        'No.' => 'Nr.',
        'Unread articles' => 'Olästa artiklar',
        'Via' => '',
        'Important' => 'Viktigt',
        'Unread Article!' => 'Oläst artikel!',
        'Incoming message' => 'Inkommande meddelande',
        'Outgoing message' => 'Utgående meddelande',
        'Internal message' => 'Internt meddelande',
        'Sending of this message has failed.' => '',
        'Resize' => '',
        'Mark this article as read' => 'Märk artikeln som läst',
        'Show Full Text' => 'Visa hela texten',
        'Full Article Text' => 'Hela artikeltexten',
        'No more events found. Please try changing the filter settings.' =>
            '',

        # Template: Chat
        '#%s' => '',
        'via %s' => '',
        'by %s' => '',
        'Toggle article details' => '',

        # Template: MIMEBase
        'This message is being processed. Already tried to send %s time(s). Next try will be %s.' =>
            '',
        'To open links in the following article, you might need to press Ctrl or Cmd or Shift key while clicking the link (depending on your browser and OS).' =>
            'För att öppna länkar i följande artikel behöver du kanske hålla ner Ctrl, Cmd eller Shift medan du klickar på länken (beroende på vilken webbläsare eller operativsystem du har).',
        'Close this message' => 'Stäng meddelandet',
        'Image' => '',
        'PDF' => 'PDF',
        'Unknown' => 'Okänd',
        'View' => 'Bild',

        # Template: LinkTable
        'Linked Objects' => 'Länkade objekt',

        # Template: TicketInformation
        'Archive' => 'Arkiv',
        'This ticket is archived.' => 'Ärendet är arkiverat.',
        'Note: Type is invalid!' => 'OBS: typen är ogiltig!',
        'Pending till' => 'Väntande tills',
        'Locked' => 'Låst',
        '%s Ticket(s)' => '',
        'Accounted time' => 'Redovisad tid',

        # Template: Invalid
        'Preview of this article is not possible because %s channel is missing in the system.' =>
            '',
        'Please re-install %s package in order to display this article.' =>
            '',

        # Template: AttachmentBlocker
        'To protect your privacy, remote content was blocked.' => '',
        'Load blocked content.' => 'Visa blockerat innehåll.',

        # Template: Breadcrumb
        'Home' => '',
        'Back to admin overview' => '',

        # Template: CloudServicesDisabled
        'This Feature Requires Cloud Services' => '',
        'You can' => 'Du kan',
        'go back to the previous page' => 'Tillbaka till föregående sida',

        # Template: CustomerAccept
        'Click to accept' => '',

        # Template: TicketCustomerIDSelection
        'The customer ID is not changeable, no other customer ID can be assigned to this ticket.' =>
            '',
        'First select a customer user, then you can select a customer ID to assign to this ticket.' =>
            '',
        'Select a customer ID to assign to this ticket.' => '',
        'From all Customer IDs' => '',
        'From assigned Customer IDs' => '',

        # Template: CustomerDashboard
        'Ticket Search' => '',
        'New Ticket' => 'Nytt ärende',

        # Template: CustomerError
        'An Error Occurred' => '',
        'Error Details' => 'Detaljer om felet',
        'Traceback' => 'Återspårning',

        # Template: CustomerFooterJS
        '%s detected possible network issues. You could either try reloading this page manually or wait until your browser has re-established the connection on its own.' =>
            '',
        'The connection has been re-established after a temporary connection loss. Due to this, elements on this page could have stopped to work correctly. In order to be able to use all elements correctly again, it is strongly recommended to reload this page.' =>
            '',

        # Template: CustomerLogin
        'JavaScript Not Available' => 'Javaskript är avstängt',
        'In order to experience this software, you\'ll need to enable JavaScript in your browser.' =>
            '',
        'Browser Warning' => 'Browservarning',
        'The browser you are using is too old.' => 'Din webbläsare är för gammal.',
        'This software runs with a huge lists of browsers, please upgrade to one of these.' =>
            '',
        'Please see the documentation or ask your admin for further information.' =>
            'Läs dokumentationen eller kontakta en administratör för mer information.',
        'The browser you are using doesn\'t support css-grid. It\'s likely too old.' =>
            '',
        'Internet Explorer is functional, but not all features are fully supported. Please consider updating to a modern browser.' =>
            '',
        'One moment please, you are being redirected...' => 'Vänta, du blir omdirigerad ...',
        'Login' => 'Inloggning',
        'Your user name' => 'Ditt användarnamn',
        'User name' => 'Användarnamn',
        'Your password' => 'Ditt lösenord',
        'Forgot password?' => 'Glömt lösenordet?',
        'Your 2 Factor Token' => '',
        '2 Factor Token' => '',
        'Log In' => 'Logga in',
        'Request Account' => '',
        'Request New Password' => 'Be om nytt lösenord',
        'Your User Name' => 'Ditt användarnamn',
        'A new password will be sent to your email address.' => 'Ett nytt lösenord kommer skickas till din e-postadress.',
        'Create Account' => 'Skapa konto',
        'Please fill out this form to receive login credentials.' => 'Fyll i detta formulär för att få dina inloggningsuppgifter.',
        'How we should address you' => '',
        'Your First Name' => 'Ditt förnamn',
        'Your Last Name' => 'Ditt efternamn',
        'Your email address (this will become your username)' => 'Din e-postadress (som blir ditt användarnamn)',

        # Template: CustomerNavigationBar
        'Logout' => 'Logga ut',

        # Template: CustomerPassword
        'Change Password' => '',
        'Password needs to contain at least 3 of the character classes: lower char, upper char, digit, special character.' =>
            '',

        # Template: CustomerTicketList
        'Welcome!' => 'Välkommen!',
        'You have no tickets yet. Please click here, to create a new one.' =>
            '',
        'Nothing to show.' => '',
        'Click here for an unfiltered list of all your tickets.' => '',

        # Template: CustomerTicketMessage
        'Issue a new Ticket' => '',
        'Service level agreement' => 'SLA',

        # Template: CustomerTicketOverview
        'Your Tickets' => '',
        'Page' => 'Sida',
        'Sort' => '',

        # Template: CustomerTicketSearch
        'Profile' => 'Profil',
        'e. g. 10*5155 or 105658*' => '',
        'CustomerID' => 'Kund-ID',
        'Fulltext Search in Tickets (e. g. "John*n" or "Will*")' => '',
        'Types' => 'Typer',
        'Time Restrictions' => '',
        'No time settings' => 'Inga tidsinställningar',
        'All' => 'Alla',
        'Specific date' => 'Specifikt datum',
        'Only tickets created' => 'Bara ärenden skapade',
        'Date range' => 'Datumintervall',
        'Only tickets created between' => 'Bara ärenden skapade mellan',
        'Ticket Archive System' => '',
        'Save Search as Template?' => '',
        'Save as Template?' => 'Spara som mall?',
        'Save as Template' => 'Spara som mall',
        'Template Name' => 'Mallnamn',
        'Pick a profile name' => 'Välj ett profilnamn',
        'Output to' => 'Utdata till',

        # Template: CustomerTicketSearchResultShort
        'of' => 'av',
        'Search Results for' => 'Sökresultat för',
        'Remove this Search Term.' => 'Ta bort sökterm',

        # Template: CustomerTicketZoom
        'Reply' => 'Svara',
        'Discard' => '',
        'Ticket Information' => 'Ärende-information',
        'Categories' => '',
        'Further actions' => '',

        # Template: Chat
        'Expand article' => '',

        # Template: MIMEBase
        'Article Information' => '',

        # Template: CustomerWarning
        'Warning' => 'Varning',

        # Template: TileNewTicket
        'Issue%sa ticket' => '',

        # Template: DashboardEventsTicketCalendar
        'Event Information' => 'Händelseinformation',

        # Template: Error
        'Send a bugreport' => 'Skicka en buggrapport',
        'Expand' => 'Expandera',

        # Template: Footer
        'Powered by %s' => '',

        # Template: AttachmentList
        'Click to delete this attachment.' => '',

        # Template: DraftButtons
        'Update draft' => '',
        'Save as new draft' => '',

        # Template: DraftNotifications
        'You have loaded the draft "%s".' => '',
        'You have loaded the draft "%s". You last changed it %s.' => '',
        'You have loaded the draft "%s". It was last changed %s by %s.' =>
            '',
        'Please note that this draft is outdated because the ticket was modified since this draft was created.' =>
            '',

        # Template: Header
        'Edit personal preferences' => 'Ändra personliga inställningar',
        'Personal preferences' => '',
        'You are logged in as' => 'Du är inloggad som',

        # Template: Installer
        'JavaScript not available' => 'Javascript är avstängt',
        'Step %s' => 'Steg %s',
        'License' => 'Licens',
        'Database Settings' => 'Databasinställningar',
        'General Specifications and Mail Settings' => 'E-postinställningar och andra inställningar',
        'Finish' => 'Slut',
        'Welcome to %s' => 'Välkommen till %s',
        'Germany' => '',
        'Phone' => 'Telefon',
        'Web site' => 'Webbplats',

        # Template: InstallerConfigureMail
        'Configure Outbound Mail' => 'Konfigurera utgående e-post',
        'Outbound mail type' => 'Typ',
        'Select outbound mail type.' => 'Välj typ för utgående e-post.',
        'Outbound mail port' => 'Port för utgående e-post',
        'Select outbound mail port.' => 'Välj port för utgående e-post.',
        'SMTP host' => 'SMTP-värd',
        'SMTP host.' => 'SMTP-värd.',
        'SMTP authentication' => 'SMTP-autentisering',
        'Does your SMTP host need authentication?' => 'Behöver din SMTP-värd autentisering?',
        'SMTP auth user' => 'SMTP-autentiseringsanvändare',
        'Username for SMTP auth.' => 'Användarnamn för SMTP-autentisering.',
        'SMTP auth password' => 'SMTP-autentiseringslösenord',
        'Password for SMTP auth.' => 'Lösenord för SMTP-autentisering.',
        'Configure Inbound Mail' => 'Konfigurera inkommande e-post ',
        'Inbound mail type' => 'Typ',
        'Select inbound mail type.' => 'Välj typ för inkommande e-post.',
        'Inbound mail host' => 'Värd för inkommande e-post ',
        'Inbound mail host.' => 'Inkommande e-postvärd.',
        'Inbound mail user' => 'Användare',
        'User for inbound mail.' => 'Användare för inkommande e-post.',
        'Inbound mail password' => 'Lösenord',
        'Password for inbound mail.' => 'Lösenord för inkommande e-post.',
        'Result of mail configuration check' => 'Resultat av e-postkonfigurationskontrollen',
        'Check mail configuration' => 'Kontrollera e-postkonfigurationen',
        'Skip this step' => 'Hoppa över detta steg',

        # Template: InstallerDBResult
        'Done' => 'Klar',
        'Error' => 'Fel',
        'Database setup successful!' => 'Databasinstallationen lyckades!',

        # Template: InstallerDBStart
        'Install Type' => 'Installationstyp',
        'Create a new database for OTOBO' => 'Skapa en ny databas för OTOBO-installationen',
        'Use an existing database for OTOBO' => 'Använd en existerande databas för OTOBO-installationen',

        # Template: InstallerDBmssql
        'If you have set a root password for your database, it must be entered here. If not, leave this field empty.' =>
            'Om du har angett ett rootlösenord för din databas måste du ange det här. Lämna fältet blankt annars.',
        'Database name' => 'Databasnamn',
        'Check database settings' => 'Kontrollera databasinställningarna',
        'Result of database check' => 'Resultat av databaskontrollen',
        'Database check successful.' => 'Databaskontrollen lyckades.',
        'Database User' => 'Databasanvändare',
        'New' => 'Nytt',
        'A new database user with limited permissions will be created for this OTOBO system.' =>
            'En ny databasanvändare med begränsade rättigheter kommer att skapas för OTOBO-installationen.',
        'Generated password' => 'Skapat lösenord',
        'Repeat Password' => 'Upprepa lösenordet',
        'Passwords do not match' => 'Lösenorden stämmer inte överens',

        # Template: InstallerFinish
        'Start page' => 'Startsida',
        'Your OTOBO Team' => 'Ditt OTOBO-Team',

        # Template: InstallerLicense
        'Don\'t accept license' => 'Acceptera inte licens',
        'Accept license and continue' => 'Acceptera licens och fortsätt',

        # Template: InstallerSystem
        'SystemID' => 'System-ID',
        'The identifier of the system. Each ticket number and each HTTP session ID contain this number.' =>
            'System-ID:t. Varje ärende och HTTP-sessions-ID innehåller det.',
        'HTTP Type' => '',
        'Set the request scheme used for cookies and various links. For production purposes always use https.' =>
            '',
        'System FQDN' => ' OTOBO-installationens värdnamn (FQDN)',
        'Fully qualified domain name of your system.' => 'Fullständigt värdnamn (FQDN) för ditt system.',
        'AdminEmail' => 'Admin-email',
        'Email address of the system administrator.' => 'Systemadministratörens e-postadress.',
        'Organization' => 'Organisation',
        'Log' => 'Logg',
        'LogModule' => 'LoggningsModul',
        'Log backend to use.' => '',
        'LogFile' => '',
        'Webfrontend' => 'Webb-gränssnitt',
        'Default language' => 'Standardspråk',
        'Default language.' => 'Standardspråk.',
        'CheckMXRecord' => 'KontrolleraMXFält',
        'Email addresses that are manually entered are checked against the MX records found in DNS. Don\'t use this option if your DNS is slow or does not resolve public addresses.' =>
            '',
        'Elasticsearch' => '',
        'Initialize Elasticsearch' => '',
        'Elasticsearch server was found, and it has been activated automatically for OTOBO.' =>
            '',
        'Seemingly either no clean Elasticsearch server is running, or it is not using the standard configuration. To activate Elasticsearch manually, please edit the web service in the admin interface if necessary, activate \'Elasticsearch::Active\' and \'Frontend::ToolBarModule###250-Ticket::ElasticsearchFulltext\' in the SysConfig and run the otobo.Console command \'Maint::Elasticsearch::Migration\'.' =>
            '',

        # Template: LinkObject
        'Delete link' => '',
        'Delete Link' => '',
        'Object#' => 'Objekt-#',
        'Add links' => 'Lägg till länkar',
        'Delete links' => 'Ta bort länkar',

        # Template: Login
        'Lost your password?' => 'Glömt lösenordet?',
        'Back to login' => 'Tillbaka till inloggningen',

        # Template: MetaFloater
        'Scale preview content' => '',
        'Open URL in new tab' => '',
        'Close preview' => '',
        'A preview of this website can\'t be provided because it didn\'t allow to be embedded.' =>
            '',

        # Template: Copy
        'Start migration' => '',
        'Result of data migration' => '',
        'Last successful task:' => '',
        'Migration will restart from the last successfully finished task. Please do a complete rerun if you changed your system in the meantime.' =>
            '',
        'Clean up and finish' => '',

        # Template: Finish
        'The migration is complete, thank you for trying out OTOBO - we hope you will like it.' =>
            '',
        'To be able to use OTOBO you have to enter the following line in your command line (Terminal/Shell) as root.' =>
            'För att kunna använda OTOBO, måste följende rad skrivas på kommandoraden som root.',
        'Restart your webserver' => 'Starta om din webbserver',
        'After doing so your OTOBO is up and running.' => 'Efter detta är OTOBO igång.',

        # Template: Intro
        'This migration script will lead you step by step through the process of migrating your ticket system from OTRS or ((OTRS)) Community Edition version 6 to OTOBO 10.' =>
            '',
        'There is no danger whatsoever for your original system: nothing is changed there.' =>
            '',
        'Instructions and details on migration prerequisites can be found in the migration manual. We strongly recommend reading it before starting migration.' =>
            '',
        'In case you have to suspend migration, you can resume it anytime at the same point as long as the cache has not been deleted.' =>
            '',
        'All entered passwords are cached until the migration is finished.' =>
            '',
        ' Anyone with access to this page, or read permission for the OTOBO Home Directory will be able to read them. If you abort the migration, you are given the option to clear the cache by visiting this page again.' =>
            '',
        'If you need support, just ask our experts – either at' => '',
        'OTOBO forum' => '',
        'or directly via mail to' => '',
        'Cached data found' => '',
        'You will continue where you aborted the migration last time. If you do not want this, please discard your previous progress.' =>
            '',
        'An error occured.' => '',
        'Discard previous progress' => '',
        'Insecure HTTP connection' => '',
        'You are using the migration script via http. This is highly insecure as various passwords are required during the process, and will be transferred unencrypted. Anyone between you and the OTOBO server will be able to read them! Please consider setting up https instead.' =>
            '',
        'Continue anyways :(' => '',
        ' Continue anyways :(' => '',

        # Template: OTRSDBSettings
        'DSN' => '',
        'Skip DB migration' => '',
        'Expert option! Only works if the migration has already been done by hand.' =>
            '',
        'Skipped.' => '',

        # Template: OTRSFileSettings
        'OTRS server' => '',
        'SSH User' => '',
        'OTRS home directory' => '',
        'Check settings' => '',
        'Result of settings check' => '',
        'Settings check successful.' => '',

        # Template: PreChecks
        'Execute migration pre-checks' => '',

        # Template: MobileNotAvailableWidget
        'Feature not Available' => '',
        'Sorry, but this feature of OTOBO is currently not available for mobile devices. If you\'d like to use it, you can either switch to desktop mode or use your regular desktop device.' =>
            'Funktionen är inte tillgänglig i dynamiskt läge för mobila enheter. För att använda den ändå växlar du till skrivbordsläge eller använder en apparat med större skärm.',

        # Template: Motd
        'Message of the Day' => 'Dagens ord',
        'This is the message of the day. You can edit this in %s.' => '',

        # Template: NoPermission
        'Insufficient Rights' => '',
        'Back to the previous page' => '',

        # Template: Alert
        'Alert' => '',
        'Powered by' => 'Drivs av',

        # Template: Pagination
        'Show first page' => 'Visa första sidan',
        'Show previous pages' => 'Visa föregående sidor',
        'Show page %s' => 'Visa sida %s',
        'Show next pages' => 'Visa nästkommande sidor',
        'Show last page' => 'Visa sista sidan',

        # Template: PictureUpload
        'Need FormID!' => 'Formulär-ID saknas!',
        'No file found!' => '',
        'The file is not an image that can be shown inline!' => '',

        # Template: PreferencesNotificationEvent
        'No user configurable notifications found.' => '',
        'Receive messages for notification \'%s\' by transport method \'%s\'.' =>
            '',

        # Template: ActivityDialogHeader
        'Process Information' => '',
        'Dialog' => 'Dialog',

        # Template: Article
        'Inform Agent' => 'Meddela handläggare',

        # Template: PublicDefault
        'Welcome' => 'Välkommen',
        'This is the default public interface of OTOBO! There was no action parameter given.' =>
            '',
        'You could install a custom public module (via the package manager), for example the FAQ module, which has a public interface.' =>
            '',

        # Template: GeneralSpecificationsWidget
        'Permissions' => 'Behörigheter',
        'You can select one or more groups to define access for different agents.' =>
            '',
        'Result formats' => 'Resultatformat',
        'Time Zone' => 'Tidszon',
        'The selected time periods in the statistic are time zone neutral.' =>
            '',
        'Create summation row' => '',
        'Generate an additional row containing sums for all data rows.' =>
            '',
        'Create summation column' => '',
        'Generate an additional column containing sums for all data columns.' =>
            '',
        'Cache results' => '',
        'Stores statistics result data in a cache to be used in subsequent views with the same configuration (requires at least one selected time field).' =>
            '',
        'Provide the statistic as a widget that agents can activate in their dashboard.' =>
            'Tillhandahåll statistik som en panel som handläggare kan aktivera i sin översikt.',
        'Please note that enabling the dashboard widget will activate caching for this statistic in the dashboard.' =>
            '',
        'If set to invalid end users can not generate the stat.' => 'Om ogiltig så kan inte användaren generera rapporten.',

        # Template: PreviewWidget
        'There are problems in the configuration of this statistic:' => '',
        'You may now configure the X-axis of your statistic.' => '',
        'This statistic does not provide preview data.' => 'Rapporten innehåller inga förgranskningsdata.',
        'Preview format' => '',
        'Please note that the preview uses random data and does not consider data filters.' =>
            '',
        'Configure X-Axis' => '',
        'X-axis' => 'X-axel',
        'Configure Y-Axis' => '',
        'Y-axis' => 'Y-axel',
        'Configure Filter' => '',

        # Template: RestrictionsWidget
        'Please select only one element or turn off the button \'Fixed\'.' =>
            'Välj endast ett värde, eller slå av knappen \'Fast\'.',
        'Absolute period' => '',
        'Between %s and %s' => '',
        'Relative period' => '',
        'The past complete %s and the current+upcoming complete %s %s' =>
            '',
        'Do not allow changes to this element when the statistic is generated.' =>
            '',

        # Template: StatsParamsWidget
        'Format' => '',
        'Exchange Axis' => 'Växla axlar',
        'Configurable Params of Static Stat' => '',
        'No element selected.' => '',
        'Scale' => 'Skala om',
        'show more' => 'visa mer',
        'show less' => '',

        # Template: D3
        'Download SVG' => 'Hämta som SVG',
        'Download PNG' => 'Hämta som PNG',

        # Template: XAxisWidget
        'The selected time period defines the default time frame for this statistic to collect data from.' =>
            '',
        'Defines the time unit that will be used to split the selected time period into reporting data points.' =>
            '',

        # Template: YAxisWidget
        'Please remember that the scale for the Y-axis has to be larger than the scale for the X-axis (e.g. X-axis => Month, Y-Axis => Year).' =>
            '',

        # Template: StatsWidget
        'Remove statistic' => '',
        'If you don\'t specify a title here, the title of the statistic will be used.' =>
            '',
        'Preface' => '',
        'Postface' => '',

        # Template: SettingHistoryListCompare
        'On ' => '',
        'Reset to this value' => '',

        # Template: SettingsList
        'This setting is disabled.' => '',
        'This setting is fixed but not deployed yet!' => '',
        'This setting is currently being overridden in %s and can\'t thus be changed here!' =>
            '',
        'Changing this setting is only available in a higher config level!' =>
            '',
        '%s (%s) is currently working on this setting.' => '',
        'Toggle advanced options for this setting' => '',
        'Disable this setting, so it is no longer effective' => '',
        'Disable' => '',
        'Enable this setting, so it becomes effective' => '',
        'Enable' => '',
        'Reset this setting to its default state' => '',
        'Reset setting' => '',
        'Allow users to adapt this setting from within their personal preferences' =>
            '',
        'Allow users to update' => '',
        'Do not longer allow users to adapt this setting from within their personal preferences' =>
            '',
        'Forbid users to update' => '',
        'Show user specific changes for this setting' => '',
        'Show user settings' => '',
        'Copy a direct link to this setting to your clipboard' => '',
        'Copy direct link' => '',
        'Remove this setting from your favorites setting' => '',
        'Remove from favourites' => '',
        'Add this setting to your favorites' => '',
        'Add to favourites' => '',
        'Cancel editing this setting' => '',
        'Save changes on this setting' => '',
        'Edit this setting' => '',
        'Enable this setting' => '',
        'This group doesn\'t contain any settings. Please try navigating to one of its sub groups or another group.' =>
            '',

        # Template: SettingsListCompare
        'Now' => '',
        'User modification' => '',
        'enabled' => '',
        'disabled' => '',
        'Setting state' => '',

        # Template: Actions
        'Edit search' => '',
        'Go back to admin: ' => '',
        'Deployment' => '',
        'My favourite settings' => '',
        'Invalid settings' => '',

        # Template: DynamicActions
        'Filter visible settings...' => '',
        'Enable edit mode for all settings' => '',
        'Save all edited settings' => '',
        'Cancel editing for all settings' => '',
        'All actions from this widget apply to the visible settings on the right only.' =>
            '',

        # Template: Help
        'Currently edited by me.' => '',
        'Modified but not yet deployed.' => '',
        'Currently edited by another user.' => '',
        'Different from its default value.' => '',
        'Save current setting.' => '',
        'Cancel editing current setting.' => '',

        # Template: Navigation
        'Navigation' => '',

        # Template: UsersSettingListCompare
        'Delete user\'s value.' => '',

        # Template: Test
        'OTOBO Test Page' => 'OTOBO Test-sida',
        'Unlock' => 'Lås upp',
        'Welcome %s %s' => 'Välkommen %s %s',
        'Counter' => 'Räknare',

        # Template: Warning
        'Go back to the previous page' => 'Tillbaka till föregående sida',

        # JS Template: CalendarSettingsDialog
        'Show' => 'Visa',

        # JS Template: FormDraftAddDialog
        'Draft title' => '',

        # JS Template: ArticleViewSettingsDialog
        'Article display' => '',

        # JS Template: FormDraftDeleteDialog
        'Do you really want to delete "%s"?' => '',
        'Confirm' => 'Bekräfta',

        # JS Template: WidgetLoading
        'Loading, please wait...' => '',

        # JS Template: ToggleMoreLessCustomer
        'Show all' => '',
        'Show less' => '',

        # JS Template: UploadContainer
        'Click to select a file for upload.' => '',
        'Click to select or drop files here.' => '',
        'Click to select files or just drop them here.' => '',
        'Click to select a file or just drop it here.' => '',
        'Uploading...' => '',

        # JS Template: MigrationState
        'Time needed' => '',

        # JS Template: PackageResolve
        'Package' => '',
        'Uninstall from OTOBO' => '',
        'Ignore' => '',
        'Migrate' => '',

        # JS Template: InformationDialog
        'Process state' => '',
        'Running' => '',
        'Finished' => 'Klar',
        'No package information available.' => '',

        # JS Template: AddButton
        'Add new entry' => 'Lägg till ny post',

        # JS Template: AddHashKey
        'Add key' => '',

        # JS Template: DialogDeployment
        'Deployment comment...' => '',
        'This field can have no more than 250 characters.' => '',
        'Deploying, please wait...' => '',
        'Preparing to deploy, please wait...' => '',
        'Deploy now' => '',
        'Try again' => '',

        # JS Template: DialogReset
        'Reset options' => '',
        'Reset setting on global level.' => '',
        'Reset globally' => '',
        'Remove all user changes.' => '',
        'Reset locally' => '',
        'user(s) have modified this setting.' => '',
        'Do you really want to reset this setting to it\'s default value?' =>
            '',

        # JS Template: HelpDialog
        'You can use the category selection to limit the navigation tree below to entries from the selected category. As soon as you select the category, the tree will be re-built.' =>
            '',

        # Perl Module: Kernel/Config/Defaults.pm
        'Database Backend' => '',
        'CustomerIDs' => 'Kund-ID:n',
        'Fax' => 'Fax',
        'Street' => 'Gata',
        'Zip' => 'Postnr',
        'City' => 'Stad',
        'Country' => 'Land',
        'Mr.' => 'Herr',
        'Mrs.' => 'Fru',
        'Address' => 'Adress',
        'View system log messages.' => 'Visa systemlogg-meddelanden.',
        'Edit the system configuration settings.' => 'Redigera systemkonfiguration.',
        'Update and extend your system with software packages.' => 'Utöka OTOBO-installationen med ytterligare programpaket.',

        # Perl Module: Kernel/Modules/AdminACL.pm
        'ACL information from database is not in sync with the system configuration, please deploy all ACLs.' =>
            'ACL-informationen från databasen är inte i synk med den i systemkonfigurationen. Driftsätt alla ACL-regler.',
        'ACLs could not be Imported due to a unknown error, please check OTOBO logs for more information' =>
            '',
        'The following ACLs have been added successfully: %s' => '',
        'The following ACLs have been updated successfully: %s' => '',
        'There where errors adding/updating the following ACLs: %s. Please check the log file for more information.' =>
            '',
        'There was an error creating the ACL' => '',
        'Need ACLID!' => '',
        'Could not get data for ACLID %s' => '',
        'There was an error updating the ACL' => '',
        'There was an error setting the entity sync status.' => '',
        'There was an error synchronizing the ACLs.' => '',
        'ACL %s could not be deleted' => '',
        'There was an error getting data for ACL with ID %s' => '',
        '%s (copy) %s' => '',
        'Please note that ACL restrictions will be ignored for the Superuser account (UserID 1).' =>
            '',
        'Exact match' => '',
        'Negated exact match' => '',
        'Regular expression' => '',
        'Regular expression (ignore case)' => '',
        'Negated regular expression' => '',
        'Negated regular expression (ignore case)' => '',

        # Perl Module: Kernel/Modules/AdminAbout.pm
        'Could not update About message!' => '',
        'About message updated!' => '',

        # Perl Module: Kernel/Modules/AdminAppointmentCalendarManage.pm
        'System was unable to create Calendar!' => 'Kunde inte skapa kalendern!',
        'Please contact the administrator.' => 'Kontakta administratören.',
        'No CalendarID!' => 'Kalender-ID saknas!',
        'You have no access to this calendar!' => 'Du har ingen åtkomst till kalendern!',
        'Error updating the calendar!' => 'Kunde inte uppdatera kalendern!',
        'Couldn\'t read calendar configuration file.' => 'Kalenderkonfigurationsfilen kunde inte läsas.',
        'Please make sure your file is valid.' => '',
        'Could not import the calendar!' => 'Kunde inte importera kalendern!',
        'Calendar imported!' => 'Kalender importerad!',
        'Need CalendarID!' => 'Kalender-ID krävs!',
        'Could not retrieve data for given CalendarID' => 'Inga data hittades för kalender-ID:t',
        'Successfully imported %s appointment(s) to calendar %s.' => 'Lyckades importera %s kalenderhändelse(r) till kalender %s.',
        '+5 minutes' => '+5 minuter',
        '+15 minutes' => '+15 minuter',
        '+30 minutes' => '+30 minuter',
        '+1 hour' => '+1 timme',

        # Perl Module: Kernel/Modules/AdminAppointmentImport.pm
        'No permissions' => 'Rättigheter saknas',
        'System was unable to import file!' => 'Kunde inte importera filen!',
        'Please check the log for more information.' => '',

        # Perl Module: Kernel/Modules/AdminAppointmentNotificationEvent.pm
        'Notification name already exists!' => 'Påminnelsenamnet finns redan!',
        'Notification added!' => '',
        'There was an error getting data for Notification with ID:%s!' =>
            '',
        'Unknown Notification %s!' => '',
        '%s (copy)' => '',
        'There was an error creating the Notification' => '',
        'Notifications could not be Imported due to a unknown error, please check OTOBO logs for more information' =>
            '',
        'The following Notifications have been added successfully: %s' =>
            '',
        'The following Notifications have been updated successfully: %s' =>
            '',
        'There where errors adding/updating the following Notifications: %s. Please check the log file for more information.' =>
            '',
        'Notification updated!' => '',
        'Agent (resources), who are selected within the appointment' => '',
        'All agents with (at least) read permission for the appointment (calendar)' =>
            'Alla handläggare med (åtminstone) läsrättigheter för kalenderhändelsen (kalendern)',
        'All agents with write permission for the appointment (calendar)' =>
            'Alla handläggare med skrivrättigheter för kalenderhändelsen (kalendern)',

        # Perl Module: Kernel/Modules/AdminAttachment.pm
        'Attachment added!' => 'Bilaga tillagd!',

        # Perl Module: Kernel/Modules/AdminAutoResponse.pm
        'Auto Response added!' => '',

        # Perl Module: Kernel/Modules/AdminCommunicationLog.pm
        'Invalid CommunicationID!' => '',
        'All communications' => '',
        'Last 1 hour' => '',
        'Last 3 hours' => '',
        'Last 6 hours' => '',
        'Last 12 hours' => '',
        'Last 24 hours' => '',
        'Last week' => '',
        'Last month' => '',
        'Invalid StartTime: %s!' => '',
        'Successful' => '',
        'Processing' => '',
        'Failed' => 'Misslyckad',
        'Invalid Filter: %s!' => '',
        'Less than a second' => '',
        'sorted descending' => '',
        'sorted ascending' => '',
        'Trace' => '',
        'Debug' => '',
        'Info' => 'Info',
        'Warn' => '',
        'days' => 'dagar',
        'day' => 'dag',
        'hour' => 'timme',
        'minute' => 'minut',
        'seconds' => 'sekunder',
        'second' => 'sekund',

        # Perl Module: Kernel/Modules/AdminContactWD.pm
        'No contact is given!' => '',
        'No data found for given contact in given source!' => '',
        'Contact updated!' => '',
        'No field data found!' => '',
        'Contact created!' => '',
        'Error creating contact!' => '',
        'No sources found, at least one "Contact with data" dynamic field must be added to the system!' =>
            '',
        'No data found for given source!' => '',

        # Perl Module: Kernel/Modules/AdminCustomerAccept.pm
        'Could not update Privacy Policy!' => '',
        'Privacy Policy updated!' => '',

        # Perl Module: Kernel/Modules/AdminCustomerCompany.pm
        'Customer company updated!' => 'Kundorganisation uppdaterad!',
        'Dynamic field %s not found!' => '',
        'Unable to set value for dynamic field %s!' => '',
        'Customer Company %s already exists!' => '',
        'Customer company added!' => 'Kundorganisation tillagd!',

        # Perl Module: Kernel/Modules/AdminCustomerGroup.pm
        'No configuration for \'CustomerGroupPermissionContext\' found!' =>
            '',
        'Please check system configuration.' => '',
        'Invalid permission context configuration:' => '',

        # Perl Module: Kernel/Modules/AdminCustomerUser.pm
        'Customer updated!' => 'Kunden uppdaterad!',
        'New phone ticket' => 'Nytt telefonärende',
        'New email ticket' => 'Nytt e-postärende',
        'Customer %s added' => 'Kund %s lades till',
        'Customer user updated!' => '',
        'Same Customer' => '',
        'Direct' => '',
        'Indirect' => '',

        # Perl Module: Kernel/Modules/AdminCustomerUserGroup.pm
        'Change Customer User Relations for Group' => '',
        'Change Group Relations for Customer User' => '',

        # Perl Module: Kernel/Modules/AdminCustomerUserService.pm
        'Allocate Customer Users to Service' => '',
        'Allocate Services to Customer User' => '',

        # Perl Module: Kernel/Modules/AdminDynamicField.pm
        'Fields configuration is not valid' => '',
        'Objects configuration is not valid' => '',
        'Could not reset Dynamic Field order properly, please check the error log for more details.' =>
            '',

        # Perl Module: Kernel/Modules/AdminDynamicFieldCheckbox.pm
        'Undefined subaction.' => '',
        'Need %s' => '',
        'Add %s field' => '',
        'The field does not contain only ASCII letters and numbers.' => '',
        'There is another field with the same name.' => '',
        'The field must be numeric.' => '',
        'Need ValidID' => '',
        'Could not create the new field' => '',
        'Need ID' => '',
        'Could not get data for dynamic field %s' => '',
        'Change %s field' => '',
        'The name for this field should not change.' => '',
        'Could not update the field %s' => '',
        'Currently' => '',
        'Unchecked' => '',
        'Checked' => '',

        # Perl Module: Kernel/Modules/AdminDynamicFieldContactWD.pm
        'This field key is duplicated.' => '',

        # Perl Module: Kernel/Modules/AdminDynamicFieldDB.pm
        'This field value is duplicated.' => '',

        # Perl Module: Kernel/Modules/AdminDynamicFieldDateTime.pm
        'Prevent entry of dates in the future' => '',
        'Prevent entry of dates in the past' => '',

        # Perl Module: Kernel/Modules/AdminDynamicFieldDropdown.pm
        'Syntax is incorrect. Please provide a parent element name in front of the double colon.' =>
            '',
        'An element is used as parent element, but not included itself. Please include it.' =>
            '',

        # Perl Module: Kernel/Modules/AdminDynamicFieldScreen.pm
        'Settings were saved.' => '',
        'System was not able to save the setting!' => '',
        'Setting is locked by another user!' => '',
        'System was not able to reset the setting!' => '',
        'Settings were reset.' => '',

        # Perl Module: Kernel/Modules/AdminEmail.pm
        'Select at least one recipient.' => '',

        # Perl Module: Kernel/Modules/AdminGenericAgent.pm
        'minute(s)' => 'minut(er)',
        'hour(s)' => 'timm(ar)',
        'Time unit' => 'Tidsenhet',
        'within the last ...' => 'inom de senaste ...',
        'within the next ...' => 'inom de nästa ...',
        'more than ... ago' => 'mer än ... sedan',
        'Unarchived tickets' => 'Oarkiverade ärenden',
        'archive tickets' => '',
        'restore tickets from archive' => '',
        'Need Profile!' => '',
        'Got no values to check.' => '',
        'Please remove the following words because they cannot be used for the ticket selection:' =>
            '',

        # Perl Module: Kernel/Modules/AdminGenericInterfaceDebugger.pm
        'Need WebserviceID!' => '',
        'Could not get data for WebserviceID %s' => '',
        'ascending' => 'stigande',
        'descending' => 'fallande',

        # Perl Module: Kernel/Modules/AdminGenericInterfaceErrorHandlingDefault.pm
        'Need communication type!' => '',
        'Communication type needs to be \'Requester\' or \'Provider\'!' =>
            '',
        'Invalid Subaction!' => '',
        'Need ErrorHandlingType!' => '',
        'ErrorHandlingType %s is not registered' => '',
        'Could not update web service' => '',
        'Need ErrorHandling' => '',
        'Could not determine config for error handler %s' => '',
        'Invoker processing outgoing request data' => '',
        'Mapping outgoing request data' => '',
        'Transport processing request into response' => '',
        'Mapping incoming response data' => '',
        'Invoker processing incoming response data' => '',
        'Transport receiving incoming request data' => '',
        'Mapping incoming request data' => '',
        'Operation processing incoming request data' => '',
        'Mapping outgoing response data' => '',
        'Transport sending outgoing response data' => '',
        'skip same backend modules only' => '',
        'skip all modules' => '',
        'Operation deleted' => '',
        'Invoker deleted' => '',

        # Perl Module: Kernel/Modules/AdminGenericInterfaceErrorHandlingRequestRetry.pm
        '0 seconds' => '',
        '15 seconds' => '',
        '30 seconds' => '',
        '45 seconds' => '',
        '1 minute' => '',
        '2 minutes' => '',
        '3 minutes' => '',
        '4 minutes' => '',
        '5 minutes' => '',
        '10 minutes' => '10 minuter',
        '15 minutes' => '15 minuter',
        '30 minutes' => '',
        '1 hour' => '',
        '2 hours' => '',
        '3 hours' => '',
        '4 hours' => '',
        '5 hours' => '',
        '6 hours' => '',
        '12 hours' => '',
        '18 hours' => '',
        '1 day' => '',
        '2 days' => '',
        '3 days' => '',
        '4 days' => '',
        '6 days' => '',
        '1 week' => '',

        # Perl Module: Kernel/Modules/AdminGenericInterfaceInvokerDefault.pm
        'Could not determine config for invoker %s' => '',
        'InvokerType %s is not registered' => '',
        'MappingType %s is not registered' => '',

        # Perl Module: Kernel/Modules/AdminGenericInterfaceInvokerEvent.pm
        'Need Invoker!' => '',
        'Need Event!' => '',
        'Could not get registered modules for Invoker' => '',
        'Could not get backend for Invoker %s' => '',
        'The event %s is not valid.' => '',
        'Could not update configuration data for WebserviceID %s' => '',
        'This sub-action is not valid' => '',
        'xor' => '',
        'String' => '',
        'Regexp' => '',
        'Validation Module' => '',

        # Perl Module: Kernel/Modules/AdminGenericInterfaceInvokerTicket.pm
        'Invisible only' => '',
        'Visible only' => '',
        'Visible and invisible' => '',

        # Perl Module: Kernel/Modules/AdminGenericInterfaceMappingSimple.pm
        'Simple Mapping for Outgoing Data' => '',
        'Simple Mapping for Incoming Data' => '',
        'Could not get registered configuration for action type %s' => '',
        'Could not get backend for %s %s' => '',
        'Keep (leave unchanged)' => '',
        'Ignore (drop key/value pair)' => '',
        'Map to (use provided value as default)' => '',
        'Exact value(s)' => '',
        'Ignore (drop Value/value pair)' => '',

        # Perl Module: Kernel/Modules/AdminGenericInterfaceMappingXSLT.pm
        'XSLT Mapping for Outgoing Data' => '',
        'XSLT Mapping for Incoming Data' => '',
        'Could not find required library %s' => '',
        'Outgoing request data before processing (RequesterRequestInput)' =>
            '',
        'Outgoing request data before mapping (RequesterRequestPrepareOutput)' =>
            '',
        'Outgoing request data after mapping (RequesterRequestMapOutput)' =>
            '',
        'Incoming response data before mapping (RequesterResponseInput)' =>
            '',
        'Outgoing error handler data after error handling (RequesterErrorHandlingOutput)' =>
            '',
        'Incoming request data before mapping (ProviderRequestInput)' => '',
        'Incoming request data after mapping (ProviderRequestMapOutput)' =>
            '',
        'Outgoing response data before mapping (ProviderResponseInput)' =>
            '',
        'Outgoing error handler data after error handling (ProviderErrorHandlingOutput)' =>
            '',

        # Perl Module: Kernel/Modules/AdminGenericInterfaceOperationDefault.pm
        'Could not determine config for operation %s' => '',
        'OperationType %s is not registered' => '',

        # Perl Module: Kernel/Modules/AdminGenericInterfaceTransportHTTPREST.pm
        'Need valid Subaction!' => '',
        'This field should be an integer.' => '',
        'File or Directory not found.' => '',

        # Perl Module: Kernel/Modules/AdminGenericInterfaceWebservice.pm
        'There is another web service with the same name.' => '',
        'There was an error updating the web service.' => '',
        'There was an error creating the web service.' => '',
        'Web service "%s" created!' => '',
        'Need Name!' => '',
        'Need ExampleWebService!' => '',
        'Could not load %s.' => '',
        'Could not read %s!' => '',
        'Need a file to import!' => '',
        'The imported file has not valid YAML content! Please check OTOBO log for details' =>
            '',
        'Web service "%s" deleted!' => '',
        'OTOBO as provider' => 'OTOBO-installationen svarar på request (tillhandahållare)',
        'Operations' => '',
        'OTOBO as requester' => 'OTOBO-installationen skickar request',
        'Invokers' => '',

        # Perl Module: Kernel/Modules/AdminGenericInterfaceWebserviceHistory.pm
        'Got no WebserviceHistoryID!' => '',
        'Could not get history data for WebserviceHistoryID %s' => '',

        # Perl Module: Kernel/Modules/AdminGroup.pm
        'Group updated!' => 'Grupp uppdaterad!',

        # Perl Module: Kernel/Modules/AdminMailAccount.pm
        'Mail account added!' => 'E-postkonto tillagt!',
        'Email account fetch already fetched by another process. Please try again later!' =>
            '',
        'Dispatching by email To: field.' => 'Skickar iväg enligt e-postmeddelandets till-fält.',
        'Dispatching by selected Queue.' => 'Skickar iväg enligt vald kö.',

        # Perl Module: Kernel/Modules/AdminNotificationEvent.pm
        'Agent who created the ticket' => '',
        'Agent who owns the ticket' => 'Handläggaren som äger ärendet',
        'Agent who is responsible for the ticket' => 'Handläggaren som är ansvarig för ärendet',
        'All agents watching the ticket' => 'Alla handläggare som bevakar ärendet',
        'All agents with write permission for the ticket' => 'Alla handläggare med skrivrättigheter i ärendet',
        'All agents subscribed to the ticket\'s queue' => '',
        'All agents subscribed to the ticket\'s service' => '',
        'All agents subscribed to both the ticket\'s queue and service' =>
            '',
        'Customer user of the ticket' => '',
        'All recipients of the first article' => '',
        'All recipients of the last article' => '',
        'Invisible to customer' => '',
        'Visible to customer' => '',

        # Perl Module: Kernel/Modules/AdminPGP.pm
        'PGP environment is not working. Please check log for more info!' =>
            '',
        'Need param Key to delete!' => '',
        'Key %s deleted!' => '',
        'Need param Key to download!' => '',

        # Perl Module: Kernel/Modules/AdminPackageManager.pm
        'No such package!' => '',
        'No such file %s in package!' => '',
        'No such file %s in local file system!' => '',
        'Can\'t read %s!' => '',
        'File is OK' => '',
        'Package has locally modified files.' => '',
        'Package not verified by the OTOBO Team!' => '',
        'Not Started' => '',
        'Updated' => '',
        'Already up-to-date' => '',
        'Installed' => '',
        'Not correctly deployed' => '',
        'Package updated correctly' => '',
        'Package was already updated' => '',
        'Dependency installed correctly' => '',
        'The package needs to be reinstalled' => '',
        'The package contains cyclic dependencies' => '',
        'Not found in on-line repositories' => '',
        'Required version is higher than available' => '',
        'Dependencies fail to upgrade or install' => '',
        'Package could not be installed' => '',
        'Package could not be upgraded' => '',
        'Repository List' => '',
        'No packages found in selected repository. Please check log for more info!' =>
            '',
        'Package not verified due a communication issue with verification server!' =>
            '',
        'Can\'t connect to OTOBO Feature Add-on list server!' => '',
        'Can\'t get OTOBO Feature Add-on list from server!' => '',
        'Can\'t get OTOBO Feature Add-on from server!' => '',

        # Perl Module: Kernel/Modules/AdminPostMasterFilter.pm
        'No such filter: %s' => '',

        # Perl Module: Kernel/Modules/AdminPriority.pm
        'Priority added!' => 'Prioritet tillagd!',

        # Perl Module: Kernel/Modules/AdminProcessManagement.pm
        'Process Management information from database is not in sync with the system configuration, please synchronize all processes.' =>
            'Processhanteringsinformationen från databasen är inte i synk med den i systemkonfigurationen. Synkronisera alla processer.',
        'Need ExampleProcesses!' => '',
        'Need ProcessID!' => '',
        'Yes (mandatory)' => '',
        'Unknown Process %s!' => '',
        'There was an error generating a new EntityID for this Process' =>
            '',
        'The StateEntityID for state Inactive does not exists' => '',
        'There was an error creating the Process' => '',
        'There was an error setting the entity sync status for Process entity: %s' =>
            '',
        'Could not get data for ProcessID %s' => '',
        'There was an error updating the Process' => '',
        'Process: %s could not be deleted' => '',
        'There was an error synchronizing the processes.' => '',
        'The %s:%s is still in use' => '',
        'The %s:%s has a different EntityID' => '',
        'Could not delete %s:%s' => '',
        'There was an error setting the entity sync status for %s entity: %s' =>
            '',
        'Could not get %s' => '',
        'Need %s!' => '',
        'Process: %s is not Inactive' => '',

        # Perl Module: Kernel/Modules/AdminProcessManagementActivity.pm
        'There was an error generating a new EntityID for this Activity' =>
            '',
        'There was an error creating the Activity' => '',
        'There was an error setting the entity sync status for Activity entity: %s' =>
            '',
        'Need ActivityID!' => '',
        'Could not get data for ActivityID %s' => '',
        'There was an error updating the Activity' => '',
        'Missing Parameter: Need Activity and ActivityDialog!' => '',
        'Activity not found!' => '',
        'ActivityDialog not found!' => '',
        'ActivityDialog already assigned to Activity. You cannot add an ActivityDialog twice!' =>
            '',
        'Error while saving the Activity to the database!' => '',
        'This subaction is not valid' => '',
        'Edit Activity "%s"' => '',

        # Perl Module: Kernel/Modules/AdminProcessManagementActivityDialog.pm
        'There was an error generating a new EntityID for this ActivityDialog' =>
            '',
        'There was an error creating the ActivityDialog' => '',
        'There was an error setting the entity sync status for ActivityDialog entity: %s' =>
            '',
        'Need ActivityDialogID!' => '',
        'Could not get data for ActivityDialogID %s' => '',
        'There was an error updating the ActivityDialog' => '',
        'Edit Activity Dialog "%s"' => '',
        'Agent Interface' => '',
        'Customer Interface' => '',
        'Agent and Customer Interface' => '',
        'Do not show Field' => '',
        'Show Field' => '',
        'Show Field As Mandatory' => '',

        # Perl Module: Kernel/Modules/AdminProcessManagementPath.pm
        'Edit Path' => '',

        # Perl Module: Kernel/Modules/AdminProcessManagementTransition.pm
        'There was an error generating a new EntityID for this Transition' =>
            '',
        'There was an error creating the Transition' => '',
        'There was an error setting the entity sync status for Transition entity: %s' =>
            '',
        'Need TransitionID!' => '',
        'Could not get data for TransitionID %s' => '',
        'There was an error updating the Transition' => '',
        'Edit Transition "%s"' => '',
        'Transition validation module' => '',

        # Perl Module: Kernel/Modules/AdminProcessManagementTransitionAction.pm
        'At least one valid config parameter is required.' => '',
        'There was an error generating a new EntityID for this TransitionAction' =>
            '',
        'There was an error creating the TransitionAction' => '',
        'There was an error setting the entity sync status for TransitionAction entity: %s' =>
            '',
        'Need TransitionActionID!' => '',
        'Could not get data for TransitionActionID %s' => '',
        'There was an error updating the TransitionAction' => '',
        'Edit Transition Action "%s"' => '',
        'Error: Not all keys seem to have values or vice versa.' => '',

        # Perl Module: Kernel/Modules/AdminQueue.pm
        'Queue updated!' => 'Kö uppdaterad!',
        'Don\'t use :: in queue name!' => '',
        'Click back and change it!' => '',
        '-none-' => '-inga-',

        # Perl Module: Kernel/Modules/AdminQueueAutoResponse.pm
        'Queues ( without auto responses )' => '',

        # Perl Module: Kernel/Modules/AdminQueueTemplates.pm
        'Change Queue Relations for Template' => 'Ändra körelationer för mallen',
        'Change Template Relations for Queue' => 'Ändra mallrelationer för kön',

        # Perl Module: Kernel/Modules/AdminRegistration.pm
        'Production' => 'Produktion',
        'Test' => '',
        'Training' => 'Träning',
        'Development' => '',

        # Perl Module: Kernel/Modules/AdminRole.pm
        'Role updated!' => 'Roll uppdaterad!',
        'Role added!' => 'Roll tillagd!',

        # Perl Module: Kernel/Modules/AdminRoleGroup.pm
        'Change Group Relations for Role' => 'Ändra grupprelationer för rollen',
        'Change Role Relations for Group' => 'Ändra rollrelationer för gruppen',

        # Perl Module: Kernel/Modules/AdminRoleUser.pm
        'Role' => '',
        'Change Role Relations for Agent' => 'Ändra rollrelationer för handläggaren',
        'Change Agent Relations for Role' => 'Ändra handläggarrelationer för rollen',

        # Perl Module: Kernel/Modules/AdminSLA.pm
        'Please activate %s first!' => 'Vänligen aktivera %s först!',

        # Perl Module: Kernel/Modules/AdminSMIME.pm
        'S/MIME environment is not working. Please check log for more info!' =>
            '',
        'Need param Filename to delete!' => '',
        'Need param Filename to download!' => '',
        'Needed CertFingerprint and CAFingerprint!' => '',
        'CAFingerprint must be different than CertFingerprint' => '',
        'Relation exists!' => '',
        'Relation added!' => '',
        'Impossible to add relation!' => '',
        'Relation doesn\'t exists' => '',
        'Relation deleted!' => '',
        'Impossible to delete relation!' => '',
        'Certificate %s could not be read!' => '',
        'Needed Fingerprint' => '',
        'Handle Private Certificate Relations' => '',

        # Perl Module: Kernel/Modules/AdminSalutation.pm
        'Salutation added!' => '',

        # Perl Module: Kernel/Modules/AdminSignature.pm
        'Signature updated!' => 'Signatur uppdaterad!',
        'Signature added!' => 'Signatur tillagd!',

        # Perl Module: Kernel/Modules/AdminState.pm
        'State added!' => 'Status tillagd!',

        # Perl Module: Kernel/Modules/AdminSupportDataCollector.pm
        'File %s could not be read!' => '',

        # Perl Module: Kernel/Modules/AdminSystemAddress.pm
        'System e-mail address added!' => 'E-post för system tillagd!',

        # Perl Module: Kernel/Modules/AdminSystemConfiguration.pm
        'Invalid Settings' => '',
        'There are no invalid settings active at this time.' => '',
        'You currently don\'t have any favourite settings.' => '',
        'The following settings could not be found: %s' => '',
        'Import not allowed!' => '',
        'System Configuration could not be imported due to an unknown error, please check OTOBO logs for more information.' =>
            '',
        'Category Search' => '',

        # Perl Module: Kernel/Modules/AdminSystemConfigurationDeployment.pm
        'Some imported settings are not present in the current state of the configuration or it was not possible to update them. Please check the OTOBO log for more information.' =>
            '',

        # Perl Module: Kernel/Modules/AdminSystemConfigurationDeploymentHistory.pm
        'This deployment does not contain changes in the setting values!' =>
            '',
        'No DeploymentID received!' => '',

        # Perl Module: Kernel/Modules/AdminSystemConfigurationGroup.pm
        'System was unable to update setting!' => '',
        'You need to enable the setting before locking!' => '',
        'You can\'t work on this setting because %s (%s) is currently working on it.' =>
            '',
        'Missing setting name!' => '',
        'Missing ResetOptions!' => '',
        'System was not able to lock the setting!' => '',
        'Missing setting name.' => '',
        'Setting not found.' => '',
        'Missing Settings!' => '',

        # Perl Module: Kernel/Modules/AdminSystemConfigurationSettingHistory.pm
        'No setting name received!' => '',
        'Modified Version' => '',
        'Reset To Default' => '',
        'Default Version' => '',
        'No setting name or modified version id received!' => '',
        'Was not possible to revert the historical value!' => '',

        # Perl Module: Kernel/Modules/AdminSystemConfigurationUser.pm
        'Missing setting name or modified id!' => '',
        'System was not able to delete the user setting values!' => '',

        # Perl Module: Kernel/Modules/AdminSystemMaintenance.pm
        'Start date shouldn\'t be defined after Stop date!' => 'Startdatumet borde inte definieras efter Slutdatumet!',
        'There was an error creating the System Maintenance' => '',
        'Need SystemMaintenanceID!' => '',
        'Could not get data for SystemMaintenanceID %s' => '',
        'System Maintenance was added successfully!' => '',
        'System Maintenance was updated successfully!' => '',
        'Session has been killed!' => '',
        'All sessions have been killed, except for your own.' => '',
        'There was an error updating the System Maintenance' => '',
        'Was not possible to delete the SystemMaintenance entry: %s!' => '',

        # Perl Module: Kernel/Modules/AdminTemplate.pm
        'Template updated!' => '',
        'Template added!' => '',

        # Perl Module: Kernel/Modules/AdminTemplateAttachment.pm
        'Change Attachment Relations for Template' => 'Ändra bilagerelationer för mallen',
        'Change Template Relations for Attachment' => 'Ändra mallrelationer för bilagan',

        # Perl Module: Kernel/Modules/AdminType.pm
        'Need Type!' => '',
        'Type added!' => 'Typ tillagd!',

        # Perl Module: Kernel/Modules/AdminUser.pm
        'Agent updated!' => 'Handläggare uppdaterad!',

        # Perl Module: Kernel/Modules/AdminUserGroup.pm
        'Change Group Relations for Agent' => 'Ändra grupprelationer för handläggaren',
        'Change Agent Relations for Group' => 'Ändra handläggarrelationer för gruppen',

        # Perl Module: Kernel/Modules/AgentAppointmentAgendaOverview.pm
        'Month' => 'Månad',
        'Week' => 'Vecka',
        'Day' => 'Dag',

        # Perl Module: Kernel/Modules/AgentAppointmentCalendarOverview.pm
        'All appointments' => 'Alla kalenderhändelser',
        'Appointments assigned to me' => 'Mina kalenderhändelser',
        'Showing only appointments assigned to you! Change settings' => '',

        # Perl Module: Kernel/Modules/AgentAppointmentEdit.pm
        'Appointment not found!' => '',
        'Never' => 'Aldrig',
        'Every Day' => 'Varje dag',
        'Every Week' => 'Varje vecka',
        'Every Month' => 'Varje månad',
        'Every Year' => 'Varje år',
        'Custom' => 'Anpassat',
        'Daily' => 'Daglig',
        'Weekly' => 'Veckovis',
        'Monthly' => 'Månadsvis',
        'Yearly' => 'Årlig',
        'every' => 'varje',
        'for %s time(s)' => '%s gång(er)',
        'until ...' => 'tills ...',
        'for ... time(s)' => '... gång(er)',
        'until %s' => 'tills %s',
        'No notification' => 'Ingen påminnelse',
        '%s minute(s) before' => '%s minut(er) innan',
        '%s hour(s) before' => '%s timme/timmar innan',
        '%s day(s) before' => '%s dag(ar) innan',
        '%s week before' => '%s vecka/veckor innan',
        'before the appointment starts' => 'innan händelsen',
        'after the appointment has been started' => 'efter händelsen börjat',
        'before the appointment ends' => 'innan händelsen slutar',
        'after the appointment has been ended' => 'efter händelsen har slutat',
        'No permission!' => 'Saknar rättigheter!',
        'Cannot delete ticket appointment!' => 'Kunde inte ta bort kalenderhändelsen!',
        'No permissions!' => 'Rättigheter saknas!',

        # Perl Module: Kernel/Modules/AgentAppointmentList.pm
        '+%s more' => '',

        # Perl Module: Kernel/Modules/AgentCustomerSearch.pm
        'Customer History' => 'Kundhistorik',

        # Perl Module: Kernel/Modules/AgentCustomerUserAddressBook.pm
        'No RecipientField is given!' => '',

        # Perl Module: Kernel/Modules/AgentDashboardCommon.pm
        'No such config for %s' => '',
        'Statistic' => 'Rapport',
        'No preferences for %s!' => '',
        'Can\'t get element data of %s!' => '',
        'Can\'t get filter content data of %s!' => '',
        'Customer Name' => '',
        'Customer User Name' => '',

        # Perl Module: Kernel/Modules/AgentLinkObject.pm
        'Need SourceObject and SourceKey!' => '',
        'You need ro permission!' => '',
        'Can not delete link with %s!' => '',
        '%s Link(s) deleted successfully.' => '',
        'Can not create link with %s! Object already linked as %s.' => '',
        'Can not create link with %s!' => 'Kunde inte länka till %s!',
        '%s links added successfully.' => '',
        'The object %s cannot link with other object!' => '',

        # Perl Module: Kernel/Modules/AgentPreferences.pm
        'Param Group is required!' => '',
        'This feature is not available.' => '',
        'Updated user preferences' => '',
        'System was unable to deploy your changes.' => '',
        'Setting not found!' => '',
        'System was unable to reset the setting!' => '',

        # Perl Module: Kernel/Modules/AgentSplitSelection.pm
        'Process ticket' => 'Behandla ärende.',

        # Perl Module: Kernel/Modules/AgentStatistics.pm
        'Parameter %s is missing.' => '',
        'Invalid Subaction.' => '',
        'Statistic could not be imported.' => 'Rapporten kunde inte importeras.',
        'Please upload a valid statistic file.' => 'Rapportfilens innehåll är inte välformat. Åtgärda och försök igen.',
        'Export: Need StatID!' => '',
        'Delete: Get no StatID!' => '',
        'Need StatID!' => '',
        'Could not load stat.' => '',
        'Add New Statistic' => 'Lägg till ny rapport',
        'Could not create statistic.' => '',
        'Run: Get no %s!' => '',

        # Perl Module: Kernel/Modules/AgentStatisticsReports.pm
        'Got no %s!' => '',
        'Add New Statistics Report' => '',
        'This name is already in use, please choose a different one.' => '',
        'Could not create report.' => '',
        'Need StatsReportID!' => '',
        'Edit Statistics Report' => '',
        'Could not find report.' => '',
        'Please provide a valid cron entry.' => '',
        'Could not update report.' => '',
        'View Statistics Report' => '',
        'Delete: Got no StatsReportID!' => '',

        # Perl Module: Kernel/Modules/AgentTicketActionCommon.pm
        'No TicketID is given!' => 'Inget ÄrendeID är angivet!',
        'You need %s permissions!' => '',
        'Loading draft failed!' => '',
        'Sorry, you need to be the ticket owner to perform this action.' =>
            'Åtgärden kan endast utföras av ansvarig handläggare för ärendet.',
        'Please change the owner first.' => 'Byt ansvarig handläggare först.',
        'FormDraft functionality disabled!' => '',
        'Draft name is required!' => '',
        'FormDraft name %s is already in use!' => '',
        'Could not perform validation on field %s!' => '',
        'No subject' => 'Inget ämne',
        'Could not delete draft!' => '',
        'Previous Owner' => 'Tidigare ansvarig handläggare',
        'wrote' => 'skrev',
        'Message from' => 'Meddelande från',
        'End message' => 'Meddelandeslut',

        # Perl Module: Kernel/Modules/AgentTicketBounce.pm
        '%s is needed!' => '',
        'Plain article not found for article %s!' => '',
        'Article does not belong to ticket %s!' => '',
        'Can\'t bounce email!' => '',
        'Can\'t send email!' => '',
        'Wrong Subaction!' => '',

        # Perl Module: Kernel/Modules/AgentTicketBulk.pm
        'Can\'t lock Tickets, no TicketIDs are given!' => '',
        'Ticket (%s) is not unlocked!' => '',
        'The following tickets were ignored because they are locked by another agent or you don\'t have write access to tickets: %s.' =>
            '',
        'The following ticket was ignored because it is locked by another agent or you don\'t have write access to ticket: %s.' =>
            '',
        'You need to select at least one ticket.' => '',
        'Bulk feature is not enabled!' => '',
        'No selectable TicketID is given!' => '',
        'You either selected no ticket or only tickets which are locked by other agents.' =>
            '',
        'The following tickets were ignored because they are locked by another agent or you don\'t have write access to these tickets: %s.' =>
            '',
        'The following tickets were locked: %s.' => '',

        # Perl Module: Kernel/Modules/AgentTicketCompose.pm
        'Article subject will be empty if the subject contains only the ticket hook!' =>
            '',
        'Address %s replaced with registered customer address.' => 'Adress %s utbytt mot registrerad kunds adress.',
        'Customer user automatically added in Cc.' => 'Kundanvändare automatiskt tillagd till Cc.',

        # Perl Module: Kernel/Modules/AgentTicketEmail.pm
        'Ticket "%s" created!' => 'Ärende "%s" skapat!',
        'No Subaction!' => '',

        # Perl Module: Kernel/Modules/AgentTicketEmailOutbound.pm
        'Got no TicketID!' => '',
        'System Error!' => '',

        # Perl Module: Kernel/Modules/AgentTicketEmailResend.pm
        'No ArticleID is given!' => '',

        # Perl Module: Kernel/Modules/AgentTicketEscalationView.pm
        'Next week' => 'Nästa vecka',
        'Ticket Escalation View' => 'Ärendeeskaleringsvy',

        # Perl Module: Kernel/Modules/AgentTicketForward.pm
        'Article %s could not be found!' => '',
        'Forwarded message from' => 'Vidarebefodrat meddelande från',
        'End forwarded message' => 'Slut på vidarebefordrat meddelande',

        # Perl Module: Kernel/Modules/AgentTicketHistory.pm
        'Can\'t show history, no TicketID is given!' => '',

        # Perl Module: Kernel/Modules/AgentTicketLock.pm
        'Can\'t lock Ticket, no TicketID is given!' => '',
        'Sorry, the current owner is %s!' => '',
        'Please become the owner first.' => '',
        'Ticket (ID=%s) is locked by %s!' => '',
        'Change the owner!' => '',

        # Perl Module: Kernel/Modules/AgentTicketLockedView.pm
        'New Article' => 'Ny artikel',
        'Pending' => 'Väntande',
        'Reminder Reached' => 'Påminnelse finns',
        'My Locked Tickets' => 'Mina låsta ärenden',

        # Perl Module: Kernel/Modules/AgentTicketMerge.pm
        'Can\'t merge ticket with itself!' => 'Det går inte att slå samman ett ärende med sig själv!',

        # Perl Module: Kernel/Modules/AgentTicketMove.pm
        'You need move permissions!' => '',

        # Perl Module: Kernel/Modules/AgentTicketPhone.pm
        'Chat is not active.' => '',
        'No permission.' => '',
        '%s has left the chat.' => '%s har lämnat chatten.',
        'This chat has been closed and will be removed in %s hours.' => 'Chatten har stängts och tas bort om %s timmar.',

        # Perl Module: Kernel/Modules/AgentTicketPhoneCommon.pm
        'Ticket locked.' => 'Ärende låst.',

        # Perl Module: Kernel/Modules/AgentTicketPlain.pm
        'No ArticleID!' => '',
        'This is not an email article.' => '',
        'Can\'t read plain article! Maybe there is no plain email in backend! Read backend message.' =>
            '',

        # Perl Module: Kernel/Modules/AgentTicketPrint.pm
        'Need TicketID!' => 'Behöver ÄrendeID!',

        # Perl Module: Kernel/Modules/AgentTicketProcess.pm
        'Couldn\'t get ActivityDialogEntityID "%s"!' => '',
        'No Process configured!' => '',
        'The selected process is invalid!' => 'Den valda processen är ogiltig!',
        'Process %s is invalid!' => '',
        'Subaction is invalid!' => '',
        'Parameter %s is missing in %s.' => '',
        'No ActivityDialog configured for %s in _RenderAjax!' => '',
        'Got no Start ActivityEntityID or Start ActivityDialogEntityID for Process: %s in _GetParam!' =>
            '',
        'Couldn\'t get Ticket for TicketID: %s in _GetParam!' => '',
        'Couldn\'t determine ActivityEntityID. DynamicField or Config isn\'t set properly!' =>
            '',
        'Process::Default%s Config Value missing!' => '',
        'Got no ProcessEntityID or TicketID and ActivityDialogEntityID!' =>
            '',
        'Can\'t get StartActivityDialog and StartActivityDialog for the ProcessEntityID "%s"!' =>
            '',
        'Can\'t get Ticket "%s"!' => '',
        'Can\'t get ProcessEntityID or ActivityEntityID for Ticket "%s"!' =>
            '',
        'Can\'t get Activity configuration for ActivityEntityID "%s"!' =>
            '',
        'Can\'t get ActivityDialog configuration for ActivityDialogEntityID "%s"!' =>
            '',
        'Can\'t get data for Field "%s" of ActivityDialog "%s"!' => '',
        'PendingTime can just be used if State or StateID is configured for the same ActivityDialog. ActivityDialog: %s!' =>
            '',
        'Pending Date' => 'Väntar till',
        'for pending* states' => 'för väntetillstånd',
        'ActivityDialogEntityID missing!' => '',
        'Couldn\'t get Config for ActivityDialogEntityID "%s"!' => '',
        'Couldn\'t use CustomerID as an invisible field.' => '',
        'Missing ProcessEntityID, check your ActivityDialogHeader.tt!' =>
            '',
        'No StartActivityDialog or StartActivityDialog for Process "%s" configured!' =>
            '',
        'Couldn\'t create ticket for Process with ProcessEntityID "%s"!' =>
            '',
        'Couldn\'t set ProcessEntityID "%s" on TicketID "%s"!' => '',
        'Couldn\'t set ActivityEntityID "%s" on TicketID "%s"!' => '',
        'Could not store ActivityDialog, invalid TicketID: %s!' => '',
        'Invalid TicketID: %s!' => '',
        'Missing ActivityEntityID in Ticket %s!' => '',
        'This step does not belong anymore to the current activity in process for ticket \'%s%s%s\'! Another user changed this ticket in the meantime. Please close this window and reload the ticket.' =>
            '',
        'Missing ProcessEntityID in Ticket %s!' => '',
        'Could not set DynamicField value for %s of Ticket with ID "%s" in ActivityDialog "%s"!' =>
            '',
        'Could not set PendingTime for Ticket with ID "%s" in ActivityDialog "%s"!' =>
            '',
        'Wrong ActivityDialog Field config: %s can\'t be Display => 1 / Show field (Please change its configuration to be Display => 0 / Do not show field or Display => 2 / Show field as mandatory)!' =>
            '',
        'Could not set %s for Ticket with ID "%s" in ActivityDialog "%s"!' =>
            '',
        'Default Config for Process::Default%s missing!' => '',
        'Default Config for Process::Default%s invalid!' => '',

        # Perl Module: Kernel/Modules/AgentTicketQueue.pm
        'Available tickets' => 'Tillgängliga ärenden',
        'including subqueues' => 'underköer inkluderat',
        'excluding subqueues' => 'underköer exkluderat',
        'QueueView' => 'Köer',

        # Perl Module: Kernel/Modules/AgentTicketResponsibleView.pm
        'My Responsible Tickets' => 'Mina ärenden',

        # Perl Module: Kernel/Modules/AgentTicketSearch.pm
        'last-search' => 'senaste sökningen',
        'Untitled' => '',
        'Ticket Number' => 'Ärendenummer',
        'Ticket' => 'Ärende',
        'printed by' => 'utskrivet av',
        'CustomerID (complex search)' => '',
        'CustomerID (exact match)' => '',
        'Invalid Users' => 'Ogiltiga användare',
        'Normal' => 'Normal',
        'CSV' => 'CSV',
        'Excel' => '',
        'in more than ...' => 'i mer än ...',

        # Perl Module: Kernel/Modules/AgentTicketService.pm
        'Feature not enabled!' => '',
        'Service View' => 'Service-vy',

        # Perl Module: Kernel/Modules/AgentTicketStatusView.pm
        'Status View' => 'Statusvy',

        # Perl Module: Kernel/Modules/AgentTicketWatchView.pm
        'My Watched Tickets' => 'Mina bevakade ärenden',

        # Perl Module: Kernel/Modules/AgentTicketWatcher.pm
        'Feature is not active' => '',

        # Perl Module: Kernel/Modules/AgentTicketZoom.pm
        'Link Deleted' => 'Länken borttagen',
        'Ticket Locked' => '',
        'Pending Time Set' => '',
        'Dynamic Field Updated' => 'Uppdaterade det dynamiska fältet',
        'Outgoing Email (internal)' => '',
        'Ticket Created' => '',
        'Type Updated' => 'Typ uppdaterades',
        'Escalation Update Time In Effect' => '',
        'Escalation Update Time Stopped' => '',
        'Escalation First Response Time Stopped' => '',
        'Customer Updated' => 'Kunden uppdaterades',
        'Internal Chat' => 'Intern chatt',
        'Automatic Follow-Up Sent' => 'Automatisk uppföljning skickad',
        'Note Added' => 'Anteckningen lades till',
        'Note Added (Customer)' => 'Anteckningen lades till (Kund)',
        'SMS Added' => '',
        'SMS Added (Customer)' => '',
        'State Updated' => 'Uppdaterade status',
        'Outgoing Answer' => '',
        'Service Updated' => 'Tjänsten uppdaterades',
        'Link Added' => 'Länken lades till',
        'Incoming Customer Email' => 'Inkommande e-post från kunder',
        'Incoming Web Request' => 'Inkommande webbförfrågning',
        'Priority Updated' => 'Prioriteten uppdaterades',
        'Ticket Unlocked' => '',
        'Outgoing Email' => 'Utgående e-post',
        'Title Updated' => 'Titeln uppdaterades',
        'Ticket Merged' => '',
        'Outgoing Phone Call' => 'Utgående telefonsamtal',
        'Forwarded Message' => '',
        'Removed User Subscription' => '',
        'Time Accounted' => '',
        'Incoming Phone Call' => 'Inkommande telefonsamtal',
        'System Request.' => '',
        'Incoming Follow-Up' => 'Inkommande uppföljning',
        'Automatic Reply Sent' => 'Automatiskt svar skickat',
        'Automatic Reject Sent' => '',
        'Escalation Solution Time In Effect' => '',
        'Escalation Solution Time Stopped' => '',
        'Escalation Response Time In Effect' => '',
        'Escalation Response Time Stopped' => '',
        'SLA Updated' => 'SLA uppdaterades',
        'External Chat' => 'Extern chatt',
        'Queue Changed' => '',
        'Notification Was Sent' => '',
        'This ticket does not exist, or you don\'t have permissions to access it in its current state.' =>
            '',
        'Missing FormDraftID!' => '',
        'Can\'t get for ArticleID %s!' => '',
        'Article filter settings were saved.' => '',
        'Event type filter settings were saved.' => '',
        'Need ArticleID!' => '',
        'Invalid ArticleID!' => '',
        'Forward article via mail' => 'Vidarebefordra artikeln via e-post',
        'Forward' => 'Vidarebefordra',
        'Fields with no group' => 'Fält utan grupper',
        'Article could not be opened! Perhaps it is on another article page?' =>
            '',
        'Show one article' => 'Visa en artikel',
        'Show all articles' => 'Visa alla artiklar',
        'Show Ticket Timeline View' => 'Visa ärendet i tidslinjevy',

        # Perl Module: Kernel/Modules/AjaxAttachment.pm
        'Got no FormID.' => '',
        'Error: the file could not be deleted properly. Please contact your administrator (missing FileID).' =>
            '',

        # Perl Module: Kernel/Modules/CustomerDashboardCommon.pm
        'Registration for tile %s of CustomerDashboard is invalid! Either Module or Template needed.' =>
            '',
        'Registration for tile %s of CustomerDashboard is invalid! Order needs to be a unique number.' =>
            '',

        # Perl Module: Kernel/Modules/CustomerGenericContent.pm
        'Need Key!' => '',
        'Invalid Key!' => '',
        'Failed to load Content!' => '',
        'Destination unknown.' => '',

        # Perl Module: Kernel/Modules/CustomerTicketArticleContent.pm
        'ArticleID is needed!' => '',
        'No TicketID for ArticleID (%s)!' => '',
        'HTML body attachment is missing!' => '',

        # Perl Module: Kernel/Modules/CustomerTicketAttachment.pm
        'FileID and ArticleID are needed!' => '',
        'No such attachment (%s)!' => '',

        # Perl Module: Kernel/Modules/CustomerTicketMessage.pm
        'Check SysConfig setting for %s::QueueDefault.' => '',
        'Check SysConfig setting for %s::TicketTypeDefault.' => '',
        'You don\'t have sufficient permissions for ticket creation in default queue.' =>
            '',

        # Perl Module: Kernel/Modules/CustomerTicketOverview.pm
        'Need CustomerID!' => '',
        'My Tickets' => 'Mina ärenden',
        'Company Tickets' => 'Organisationens ärenden',
        'Untitled!' => '',

        # Perl Module: Kernel/Modules/CustomerTicketSearch.pm
        'Customer Realname' => 'Kundens riktiga namn',
        'Created within the last' => 'Skapad senaste',
        'Created more than ... ago' => 'Skapades för mer än ... sedan',
        'Please remove the following words because they cannot be used for the search:' =>
            '',

        # Perl Module: Kernel/Modules/CustomerTicketZoom.pm
        'Could not load process module.' => '',
        'Can\'t reopen ticket, not possible in this queue!' => '',
        'Create a new ticket!' => '',

        # Perl Module: Kernel/Modules/Installer.pm
        'SecureMode active!' => '',
        'If you want to re-run the Installer, disable the SecureMode in the SysConfig.' =>
            '',
        'Directory "%s" doesn\'t exist!' => '',
        'Configure "Home" in Kernel/Config.pm first!' => '',
        'File "%s/Kernel/Config.pm" not found!' => '',
        'Directory "%s" not found!' => '',
        'Install OTOBO' => 'Installera OTOBO',
        'Intro' => 'Intro',
        'Kernel/Config.pm isn\'t writable!' => '',
        'If you want to use the installer, set the Kernel/Config.pm writable for the webserver user!' =>
            '',
        'Database Selection' => 'Databasval',
        'Unknown Check!' => '',
        'The check "%s" doesn\'t exist!' => '',
        'Enter the password for the database user.' => 'Ange lösenord för databasanvändaren.',
        'Configure MySQL' => '',
        'Database %s' => '',
        'Enter the password for the administrative database user.' => 'Ange lösenord för administrativ databasanvändare.',
        'Configure PostgreSQL' => '',
        'Configure Oracle' => '',
        'Unknown database type "%s".' => '',
        'Please go back.' => '',
        'Create Database' => 'Skapa databas',
        'Install OTOBO - Error' => '',
        'File "%s/%s.xml" not found!' => '',
        'Contact your Admin!' => '',
        'Execution of SQL statement failed: ' => '',
        'https' => '',
        'http' => '',
        'System Settings' => 'Inställningar för OTOBO-installationen',
        'Syslog' => '',
        'Configure Mail' => 'Konfigurera mail',
        'Mail Configuration' => 'Mailkonfiguration',
        'Unknown Subaction %s!' => '',
        'Can\'t connect to database, Perl module DBD::%s not installed!' =>
            '',
        'Can\'t connect to database, read comment!' => '',
        'Database already contains data - it should be empty!' => 'Databasen innehåller redan information - den bör vara tom!',
        'Error: Please make sure your database accepts packages over %s MB in size (it currently only accepts packages up to %s MB). Please adapt the max_allowed_packet setting of your database in order to avoid errors.' =>
            '',
        'Error: Please set the value for innodb_log_file_size on your database to at least %s MB (current: %s MB, recommended: %s MB). For more information, please have a look at %s.' =>
            '',

        # Perl Module: Kernel/Modules/MigrateFromOTRS.pm
        'If you want to re-run the MigrateFromOTRS Tool, disable the SecureMode in the SysConfig.' =>
            '',
        'OTRS to OTOBO migration' => '',

        # Perl Module: Kernel/Modules/PublicCalendar.pm
        'No %s!' => 'Inga %s!',
        'No such user!' => 'Okänd användare!',
        'Invalid calendar!' => 'Ogiltig kalender!',
        'Invalid URL!' => 'Ogiltig URL!',
        'There was an error exporting the calendar!' => 'Kalendern kunde inte exporteras!',

        # Perl Module: Kernel/Modules/PublicRepository.pm
        'Need config Package::RepositoryAccessRegExp' => '',
        'Authentication failed from %s!' => '',

        # Perl Module: Kernel/Output/HTML/Article/Chat.pm
        'Chat' => 'Chat',

        # Perl Module: Kernel/Output/HTML/ArticleAction/AgentTicketBounce.pm
        'Bounce Article to a different mail address' => 'Studsa artikel till en annan e-postadress',
        'Bounce' => 'Studsa',

        # Perl Module: Kernel/Output/HTML/ArticleAction/AgentTicketCompose.pm
        'Reply All' => 'Svara alla',

        # Perl Module: Kernel/Output/HTML/ArticleAction/AgentTicketEmailResend.pm
        'Resend this article' => '',
        'Resend' => '',

        # Perl Module: Kernel/Output/HTML/ArticleAction/AgentTicketMessageLog.pm
        'View message log details for this article' => '',
        'Message Log' => '',

        # Perl Module: Kernel/Output/HTML/ArticleAction/AgentTicketNote.pm
        'Reply to note' => 'Svara på anteckning',

        # Perl Module: Kernel/Output/HTML/ArticleAction/AgentTicketPhone.pm
        'Split this article' => 'Dela den här artikeln',

        # Perl Module: Kernel/Output/HTML/ArticleAction/AgentTicketPlain.pm
        'View the source for this Article' => '',
        'Plain Format' => 'Enkelt format',

        # Perl Module: Kernel/Output/HTML/ArticleAction/AgentTicketPrint.pm
        'Print this article' => 'Skriv ut den här artikeln',

        # Perl Module: Kernel/Output/HTML/ArticleAction/GetHelpLink.pm
        'Contact us at hello@otobo.de' => '',
        'Get Help' => '',

        # Perl Module: Kernel/Output/HTML/ArticleAction/MarkAsImportant.pm
        'Mark' => 'Markera',
        'Unmark' => 'Avmarkera',

        # Perl Module: Kernel/Output/HTML/ArticleAction/ReinstallPackageLink.pm
        'Re-install Package' => '',
        'Re-install' => '',

        # Perl Module: Kernel/Output/HTML/ArticleCheck/PGP.pm
        'Crypted' => 'Krypterat',
        'Sent message encrypted to recipient!' => '',
        'Signed' => 'Signatur',
        '"PGP SIGNED MESSAGE" header found, but invalid!' => '',

        # Perl Module: Kernel/Output/HTML/ArticleCheck/SMIME.pm
        'Internal error during verification!' => '',
        'Impossible to decrypt: private key not found!' => '',
        'Impossible to decrypt: private key for email was not found!' => '',
        'Successful decryption' => '',

        # Perl Module: Kernel/Output/HTML/ArticleCompose/Crypt.pm
        'There are no encryption keys available for the addresses: \'%s\'. ' =>
            '',
        'There are no selected encryption keys for the addresses: \'%s\'. ' =>
            '',
        'Cannot use expired encryption keys for the addresses: \'%s\'. ' =>
            '',
        'Cannot use revoked encryption keys for the addresses: \'%s\'. ' =>
            '',
        'Encrypt' => '',
        'Keys/certificates will only be shown for recipients with more than one key/certificate. The first found key/certificate will be pre-selected. Please make sure to select the correct one.' =>
            '',

        # Perl Module: Kernel/Output/HTML/ArticleCompose/Security.pm
        'Email security' => '',
        'PGP sign' => '',
        'PGP sign and encrypt' => '',
        'PGP encrypt' => '',
        'SMIME sign' => '',
        'SMIME sign and encrypt' => '',
        'SMIME encrypt' => '',

        # Perl Module: Kernel/Output/HTML/ArticleCompose/Sign.pm
        'Cannot use expired signing key: \'%s\'. ' => '',
        'Cannot use revoked signing key: \'%s\'. ' => '',
        'There are no signing keys available for the addresses \'%s\'.' =>
            '',
        'There are no selected signing keys for the addresses \'%s\'.' =>
            '',
        'Sign' => 'Signerat',
        'Keys/certificates will only be shown for a sender with more than one key/certificate. The first found key/certificate will be pre-selected. Please make sure to select the correct one.' =>
            '',

        # Perl Module: Kernel/Output/HTML/Dashboard/AppointmentCalendar.pm
        'Shown' => 'Visade',
        'Refresh (minutes)' => 'Förnya (minuter)',
        'off' => 'av',

        # Perl Module: Kernel/Output/HTML/Dashboard/CustomerIDList.pm
        'Shown customer ids' => '',

        # Perl Module: Kernel/Output/HTML/Dashboard/CustomerUserList.pm
        'Shown customer users' => 'Visa kundanvändare.',
        'Offline' => '',
        'User is currently offline.' => '',
        'User is currently active.' => '',
        'Away' => '',
        'User was inactive for a while.' => '',

        # Perl Module: Kernel/Output/HTML/Dashboard/EventsTicketCalendar.pm
        'The start time of a ticket has been set after the end time!' => 'Startdatumet på ett ärende sker efter slutdatumet!',

        # Perl Module: Kernel/Output/HTML/Dashboard/MyLastChangedTickets.pm
        'Shown Tickets' => 'Visade Ärenden',

        # Perl Module: Kernel/Output/HTML/Dashboard/News.pm
        'Can\'t connect to OTOBO News server!' => '',
        'Can\'t get OTOBO News from server!' => '',

        # Perl Module: Kernel/Output/HTML/Dashboard/ProductNotify.pm
        'Can\'t connect to Product News server!' => '',
        'Can\'t get Product News from server!' => '',

        # Perl Module: Kernel/Output/HTML/Dashboard/RSS.pm
        'Can\'t connect to %s!' => '',

        # Perl Module: Kernel/Output/HTML/Dashboard/TicketGeneric.pm
        'Shown Columns' => 'Visade kolumner',
        'filter not active' => '',
        'filter active' => '',
        'This ticket has no title or subject' => 'Detta ärende har ingen rubrik eller ämne',

        # Perl Module: Kernel/Output/HTML/Dashboard/TicketStatsGeneric.pm
        '7 Day Stats' => '7-dagarsstatistik',

        # Perl Module: Kernel/Output/HTML/Dashboard/UserOnline.pm
        'User set their status to unavailable.' => '',
        'Unavailable' => '',

        # Perl Module: Kernel/Output/HTML/Layout.pm
        'Standard' => 'Standard',
        'The following tickets are not updated: %s.' => '',
        'h' => 'h',
        'm' => 'm',
        'd' => 'd',
        'This ticket does not exist, or you don\'t have permissions to access it in its current state. You can take one of the following actions:' =>
            '',
        'This is a' => 'Detta är en',
        'email' => 'e-post',
        'click here' => 'klicka här',
        'to open it in a new window.' => 'för att öppna i ett nytt fönster',
        'Year' => 'År',
        'Hours' => 'Timmar',
        'Minutes' => 'Minuter',
        'Check to activate this date' => 'Kryssa i för att aktivera detta datum',
        '%s TB' => '',
        '%s GB' => '',
        '%s MB' => '',
        '%s KB' => '',
        '%s B' => '',
        'No Permission!' => 'Ej Behörig!',
        'No Permission' => '',
        'Show Tree Selection' => 'Visa trädval',
        'Split Quote' => '',
        'Remove Quote' => '',

        # Perl Module: Kernel/Output/HTML/Layout/LinkObject.pm
        'Linked as' => 'Länkad som',
        'Search Result' => '',
        'Linked' => 'Länkat',
        'Bulk' => 'Bulk',

        # Perl Module: Kernel/Output/HTML/Layout/Ticket.pm
        'Lite' => 'Enkel',
        'Unread article(s) available' => 'Olästa artiklar tillgängliga',

        # Perl Module: Kernel/Output/HTML/LinkObject/Appointment.pm
        'Appointment' => 'Kalenderhändelse',

        # Perl Module: Kernel/Output/HTML/LinkObject/Ticket.pm
        'Archive search' => '',

        # Perl Module: Kernel/Output/HTML/Notification/AgentOnline.pm
        'Online Agent: %s' => 'Handläggare online: %s',

        # Perl Module: Kernel/Output/HTML/Notification/AgentTicketEscalation.pm
        'There are more escalated tickets!' => 'Det finns fler eskalerade ärenden!',

        # Perl Module: Kernel/Output/HTML/Notification/AgentTimeZoneCheck.pm
        'Please select a time zone in your preferences and confirm it by clicking the save button.' =>
            '',

        # Perl Module: Kernel/Output/HTML/Notification/CustomerOnline.pm
        'Online Customer: %s' => 'Kund online: %s',

        # Perl Module: Kernel/Output/HTML/Notification/CustomerSystemMaintenanceCheck.pm
        'System maintenance is active!' => '',
        'A system maintenance period will start at: %s and is expected to stop at: %s' =>
            '',

        # Perl Module: Kernel/Output/HTML/Notification/DaemonCheck.pm
        'OTOBO Daemon is not running.' => 'OTOBO-demonen körs inte.',

        # Perl Module: Kernel/Output/HTML/Notification/OutofOfficeCheck.pm
        'You have Out of Office enabled, would you like to disable it?' =>
            'Du har aktivierat automatiskt svar vid frånvaro. Vill du stänga av det?',

        # Perl Module: Kernel/Output/HTML/Notification/SystemConfigurationInvalidCheck.pm
        'You have %s invalid setting(s) deployed. Click here to show invalid settings.' =>
            '',

        # Perl Module: Kernel/Output/HTML/Notification/SystemConfigurationIsDirtyCheck.pm
        'You have undeployed settings, would you like to deploy them?' =>
            '',

        # Perl Module: Kernel/Output/HTML/Notification/SystemConfigurationOutOfSyncCheck.pm
        'The configuration is being updated, please be patient...' => '',
        'There is an error updating the system configuration!' => '',

        # Perl Module: Kernel/Output/HTML/Notification/UIDCheck.pm
        'Don\'t use the Superuser account to work with %s! Create new Agents and work with these accounts instead.' =>
            '',

        # Perl Module: Kernel/Output/HTML/Preferences/AppointmentNotificationEvent.pm
        'Please make sure you\'ve chosen at least one transport method for mandatory notifications.' =>
            '',
        'Preferences updated successfully!' => 'Inställningar lagrade!',

        # Perl Module: Kernel/Output/HTML/Preferences/Language.pm
        '(in process)' => '(under behandling)',

        # Perl Module: Kernel/Output/HTML/Preferences/OutOfOffice.pm
        'Please specify an end date that is after the start date.' => 'Sluttiden behöver vara efter starttiden.',

        # Perl Module: Kernel/Output/HTML/Preferences/Password.pm
        'Verify password' => 'Bekräfta lösenordet',
        'The current password is not correct. Please try again!' => 'Lösenordet stämmer inte. Försök igen!',
        'Please supply your new password!' => 'Ange ett nytt lösenord!',
        'Can\'t update password, the new password and the repeated password do not match.' =>
            '',
        'This password is forbidden by the current system configuration. Please contact the administrator if you have additional questions.' =>
            '',
        'Can\'t update password, it must be at least %s characters long!' =>
            'Kan inte uppdatera lösenordet. Det måste vara minst %s tecken!',
        'Can\'t update password, it must contain at least 2 lowercase and 2 uppercase letter characters!' =>
            '',
        'Can\'t update password, it must contain at least 1 digit!' => 'Kan inte uppdatera lösenordet. Det måste innehålla minst en siffra!',
        'Can\'t update password, it must contain at least 2 letter characters!' =>
            '',
        'Can\'t update password, it must contain at least 3 of 4 (lower char, upper char, digit, special character)!' =>
            '',

        # Perl Module: Kernel/Output/HTML/Preferences/TimeZone.pm
        'Time zone updated successfully!' => '',

        # Perl Module: Kernel/Output/HTML/Statistics/View.pm
        'invalid' => 'ogiltig',
        'valid' => 'giltig',
        'No (not supported)' => 'Nej (stöds ej)',
        'No past complete or the current+upcoming complete relative time value selected.' =>
            '',
        'The selected time period is larger than the allowed time period.' =>
            '',
        'No time scale value available for the current selected time scale value on the X axis.' =>
            '',
        'The selected date is not valid.' => 'Det valda datumet är inte giltigt.',
        'The selected end time is before the start time.' => 'Vald sluttid är före starttiden!',
        'There is something wrong with your time selection.' => '',
        'Please select only one element or allow modification at stat generation time.' =>
            '',
        'Please select at least one value of this field or allow modification at stat generation time.' =>
            '',
        'Please select one element for the X-axis.' => '',
        'You can only use one time element for the Y axis.' => '',
        'You can only use one or two elements for the Y axis.' => '',
        'Please select at least one value of this field.' => '',
        'Please provide a value or allow modification at stat generation time.' =>
            '',
        'Please select a time scale.' => '',
        'Your reporting time interval is too small, please use a larger time scale.' =>
            '',
        'second(s)' => 'sekund(er)',
        'quarter(s)' => 'kvartal',
        'half-year(s)' => 'halvår',
        'Please remove the following words because they cannot be used for the ticket restrictions: %s.' =>
            '',

        # Perl Module: Kernel/Output/HTML/SysConfig.pm
        'Cancel editing and unlock this setting' => '',
        'Reset this setting to its default value.' => '',
        'Unable to load %s!' => '',
        'Content' => 'Innehåll',

        # Perl Module: Kernel/Output/HTML/TicketMenu/Lock.pm
        'Unlock to give it back to the queue' => 'Lås upp för att lägga tillbaka i kön',
        'Lock it to work on it' => 'Lås det för att jobba med det',

        # Perl Module: Kernel/Output/HTML/TicketMenu/TicketWatcher.pm
        'Unwatch' => 'Ta bort bevakning',
        'Remove from list of watched tickets' => 'Ta bort från lista av bevakade ärenden.',
        'Watch' => 'Bevaka',
        'Add to list of watched tickets' => 'Lägg till i listan av bevakade ärenden',

        # Perl Module: Kernel/Output/HTML/TicketOverviewMenu/Sort.pm
        'Order by' => 'Sortera efter',

        # Perl Module: Kernel/Output/HTML/ToolBar/TicketLocked.pm
        'Locked Tickets New' => 'Nya låsta ärenden',
        'Locked Tickets Reminder Reached' => 'Låsta ärenden där påminnelse har nåtts',
        'Locked Tickets Total' => 'Totalt antal låsta ärenden',

        # Perl Module: Kernel/Output/HTML/ToolBar/TicketResponsible.pm
        'Responsible Tickets New' => 'Mina ärenden nya',
        'Responsible Tickets Reminder Reached' => 'Påminnelse för mina ärenden nådd',
        'Responsible Tickets Total' => 'Mina ärenden totalt',

        # Perl Module: Kernel/Output/HTML/ToolBar/TicketWatcher.pm
        'Watched Tickets New' => 'Nya bevakande ärenden',
        'Watched Tickets Reminder Reached' => 'Påminnelse för bevakat ärende nådd',
        'Watched Tickets Total' => 'Totalt antal bevakade ärenden',

        # Perl Module: Kernel/Output/PDF/StatisticsReports.pm
        '%s Report' => '',
        'Error: this graph could not be generated: %s.' => '',
        'Table of Contents' => '',

        # Perl Module: Kernel/Output/PDF/Ticket.pm
        'Ticket Dynamic Fields' => 'Dynamiska fält för ärende',

        # Perl Module: Kernel/System/ACL/DB/ACL.pm
        'Couldn\'t read ACL configuration file. Please make sure the file is valid.' =>
            '',

        # Perl Module: Kernel/System/Auth.pm
        'It is currently not possible to login due to a scheduled system maintenance.' =>
            'Det är för tillfället inte möjligt att logga in på grund av systemunderhåll.',

        # Perl Module: Kernel/System/Auth/OpenIDConnect.pm
        'Authentication error. Please contact the administrator.' => '',
        'Authentication error.' => '',
        'Invalid response from the authentication server. Maybe the process took too long. Please retry once.' =>
            '',

        # Perl Module: Kernel/System/AuthSession.pm
        'Please note that the session limit is almost reached.' => '',
        'Session limit reached! Please try again later.' => 'För många samtidiga sessioner! Försök igen senare.',
        'Session per user limit reached!' => '',

        # Perl Module: Kernel/System/AuthSession/DB.pm
        'Session invalid. Please log in again.' => 'Ogiltig session. Vänligen logga in igen.',
        'Session has timed out. Please log in again.' => 'Sessionstiden har löpt ut.  Vänligen logga in igen.',

        # Perl Module: Kernel/System/Calendar/Event/Transport/Email.pm
        'PGP sign only' => '',
        'PGP encrypt only' => '',
        'SMIME sign only' => '',
        'SMIME encrypt only' => '',
        'PGP and SMIME not enabled.' => '',
        'Skip notification delivery' => '',
        'Send unsigned notification' => '',
        'Send unencrypted notification' => '',

        # Perl Module: Kernel/System/Console/Command/Dev/Tools/Config2Docbook.pm
        'Configuration Options Reference' => 'Referens för inställningar',
        'This setting can not be changed.' => '',
        'This setting is not active by default.' => '',
        'This setting can not be deactivated.' => '',
        'This setting is not visible.' => '',
        'This setting can be overridden in the user preferences.' => '',
        'This setting can be overridden in the user preferences, but is not active by default.' =>
            '',

        # Perl Module: Kernel/System/CustomerUser.pm
        'Customer user "%s" already exists.' => '',

        # Perl Module: Kernel/System/CustomerUser/DB.pm
        'This email address is already in use for another customer user.' =>
            '',

        # Perl Module: Kernel/System/DynamicField/Driver/BaseDateTime.pm
        'before/after' => 'före/efter',
        'between' => 'mellan',

        # Perl Module: Kernel/System/DynamicField/Driver/BaseText.pm
        'e.g. Text or Te*t' => '',

        # Perl Module: Kernel/System/DynamicField/Driver/Checkbox.pm
        'Ignore this field.' => '',

        # Perl Module: Kernel/System/DynamicField/Driver/TextArea.pm
        'This field is required or' => 'Detta fält är obligatoriskt eller',
        'The field content is too long!' => 'Fältinnehållet är för långt!',
        'Maximum size is %s characters.' => 'Maxlängd är %s tecken.',

        # Perl Module: Kernel/System/MigrateFromOTRS/CloneDB/Backend.pm
        'Sanity checks for database.' => '',

        # Perl Module: Kernel/System/MigrateFromOTRS/OTOBOACLDeploy.pm
        'Deploy the ACL configuration.' => '',
        'Deployment completed, perfect!' => '',

        # Perl Module: Kernel/System/MigrateFromOTRS/OTOBOAutoResponseTemplatesMigrate.pm
        'Migrate database table auto_responses.' => '',
        'Migration failed.' => '',
        'Migrate database table auto_response.' => '',
        'Migration completed, perfect!' => '',

        # Perl Module: Kernel/System/MigrateFromOTRS/OTOBOCacheCleanup.pm
        'OTOBO Cache cleanup.' => '',
        'Completed.' => '',

        # Perl Module: Kernel/System/MigrateFromOTRS/OTOBOCopyFilesFromOTRS.pm
        'Need OTRSData->%s!' => '',
        'Can\'t access OTRS Home: %s!' => '',
        'All needed files copied and migrated, perfect!' => '',

        # Perl Module: Kernel/System/MigrateFromOTRS/OTOBODatabaseMigrate.pm
        'Copy database.' => '',
        'Skipped...' => '',
        'System was unable to connect to OTRS database.' => '',
        'System was unable to complete data transfer.' => '',
        'Data transfer completed.' => '',

        # Perl Module: Kernel/System/MigrateFromOTRS/OTOBOFrameworkVersionCheck.pm
        'Check if OTOBO version is correct.' => '',
        'Check if OTOBO and OTRS connect is possible.' => '',
        'Can\'t open RELEASE file from OTRSHome: %s!' => '',
        'Check if OTOBO and OTRS version is correct.' => '',
        '%s does not exist!' => '',
        'No OTOBO system found!' => '',
        'You are trying to run this script on the wrong framework version %s!' =>
            '',
        'OTOBO Version is correct: %s.' => '',
        'Check if OTRS version is correct.' => '',
        'OTRS RELEASE file %s does not exist!' => '',
        'Can\'t read OTRS RELEASE file: %s' => '',
        'No OTRS system found!' => '',
        'Unknown PRODUCT found in OTRS RELASE file: %s. Expected values are %s.' =>
            '',
        'OTRS Version is correct: %s.' => '',

        # Perl Module: Kernel/System/MigrateFromOTRS/OTOBOItsmTablesMigrate.pm
        'Migrate ITSM database tables.' => '',
        'Nothing to do, as the the table \'%s\' does not exist.' => '',
        'UPDATE of the table \'%s\' failed.' => '',
        'Migration completed.' => '',

        # Perl Module: Kernel/System/MigrateFromOTRS/OTOBOMigrateConfigFromOTRS.pm
        'Migrate configuration settings.' => '',
        'An error occured during SysConfig data migration or no configuration exists.' =>
            '',
        'An error occured during SysConfig migration when writing XML to DB.' =>
            '',
        'SysConfig data migration completed.' => '',

        # Perl Module: Kernel/System/MigrateFromOTRS/OTOBOMigrateWebServiceConfiguration.pm
        'Migrate web service configuration.' => '',
        'Failed - see the log!' => '',

        # Perl Module: Kernel/System/MigrateFromOTRS/OTOBONotificationMigrate.pm
        'Migrate database table notification.' => '',

        # Perl Module: Kernel/System/MigrateFromOTRS/OTOBOOTRSConnectionCheck.pm
        'Can\'t open Kernel/Config.pm file from OTRSHome: %s!' => '',
        'Check if Kernel/Config.pm exists in OTOBO home.' => '',
        'Kernel/Config.pm exists in OTOBO home' => '',
        'Check if we are able to connect to OTRS Home.' => '',
        'Can\'t connect to OTRS file directory.' => '',
        'Connect to OTRS file directory is possible.' => '',

        # Perl Module: Kernel/System/MigrateFromOTRS/OTOBOOTRSDBCheck.pm
        'Try database connect and sanity checks.' => '',
        'Could not create database object.' => '',
        'Database connect and sanity checks completed.' => '',

        # Perl Module: Kernel/System/MigrateFromOTRS/OTOBOOTRSPackageCheck.pm
        'Check if all necessary packages are installed.' => '',
        'The following packages are only installed in OTRS:' => '',
        'Please install (or uninstall) the packages before migration. If a package doesn\'t exist for OTOBO so far, please contact the OTOBO Team at bugs\@otobo.org. We will find a solution.' =>
            '',
        'The same packages are installed on both systems, perfect!' => '',

        # Perl Module: Kernel/System/MigrateFromOTRS/OTOBOPackageSpecifics.pm
        'Package specific tasks' => '',
        'Done -' => '',
        'Failed at -' => '',

        # Perl Module: Kernel/System/MigrateFromOTRS/OTOBOPerlModulesCheck.pm
        'Check if all needed Perl modules have been installed.' => '',
        '%s script does not exist.' => '',
        'One or more required Perl modules are missing. Please install them as recommended, and run the migration script again.' =>
            '',
        'All required Perl modules have been installed, perfect!' => '',

        # Perl Module: Kernel/System/MigrateFromOTRS/OTOBOPostmasterFilterMigrate.pm
        'Migrate postmaster filter.' => '',

        # Perl Module: Kernel/System/MigrateFromOTRS/OTOBOProcessDeploy.pm
        'Deploy the process management configuration.' => '',

        # Perl Module: Kernel/System/MigrateFromOTRS/OTOBOResponseTemplatesMigrate.pm
        'Migrate database table response_template.' => '',

        # Perl Module: Kernel/System/MigrateFromOTRS/OTOBOSalutationsMigrate.pm
        'Migrate database table salutation.' => '',

        # Perl Module: Kernel/System/MigrateFromOTRS/OTOBOSignaturesMigrate.pm
        'Migrate database table signature.' => '',

        # Perl Module: Kernel/System/MigrateFromOTRS/OTOBOStatsMigrate.pm
        'Migrate statistics.' => '',

        # Perl Module: Kernel/System/NotificationEvent.pm
        'Couldn\'t read Notification configuration file. Please make sure the file is valid.' =>
            '',
        'Imported notification has body text with more than 4000 characters.' =>
            '',

        # Perl Module: Kernel/System/Package.pm
        'not installed' => '',
        'installed' => 'installerad',
        'Unable to parse repository index document.' => 'Kunde inte läsa indexdokument för repot.',
        'No packages for your framework version found in this repository, it only contains packages for other framework versions.' =>
            'Det finns inga paket tillgängliga i repositoriet för din ramverksversion. Det finns dock paket för andra versioner. ',
        'File is not installed!' => '',
        'File is different!' => '',
        'Can\'t read file!' => '',
        '<p>Additional packages can enhance OTOBO with plenty of useful features. Ensure, however, that the origin of this package is trustworthy, as it can modify OTOBO in any possible way.</p>' =>
            '',
        'Package not verified by the OTOBO community!' => '',
        '<p>The installation of packages which are not verified is disabled. You can activate the installation of not verified packages via the "Package::AllowNotVerifiedPackages" system configuration setting.</p>' =>
            '',
        'Verification not possible (e.g. no internet connection)!' => '',

        # Perl Module: Kernel/System/ProcessManagement/DB/Process.pm
        'The process "%s" and all of its data has been imported successfully.' =>
            '',

        # Perl Module: Kernel/System/ProcessManagement/DB/Process/State.pm
        'Inactive' => 'Inaktiv',
        'FadeAway' => '',

        # Perl Module: Kernel/System/Registration.pm
        'Can\'t contact registration server. Please try again later.' => 'Kan inte ansluta till registreringsservern. Försök senare.',
        'No content received from registration server. Please try again later.' =>
            'Inget innehåll togs emot från registreringsservern. Försök senare.',
        'Can\'t get Token from sever' => '',
        'Username and password do not match. Please try again.' => 'Användarnamn och lösenord är fel. Försök igen senare.',
        'Problems processing server result. Please try again later.' => 'Problem med att hantera serverns svar. Försök senare.',

        # Perl Module: Kernel/System/Stats.pm
        'Sum' => 'Summa',
        'week' => 'vecka',
        'quarter' => 'kvartal',
        'half-year' => 'halvår',

        # Perl Module: Kernel/System/Stats/Dynamic/Ticket.pm
        'State Type' => '',
        'Created Priority' => 'Skapad Prioritet',
        'Created State' => 'Skapad Status',
        'Create Time' => 'Skapad Tid',
        'Pending until time' => '',
        'Close Time' => 'StängTid',
        'Escalation' => 'Eskalering',
        'Escalation - First Response Time' => '',
        'Escalation - Update Time' => '',
        'Escalation - Solution Time' => '',
        'Agent/Owner' => 'Ansvarig handläggare',
        'Created by Agent/Owner' => 'Skapad av handläggare/ansvarig',
        'Assigned to Customer User Login' => '',

        # Perl Module: Kernel/System/Stats/Dynamic/TicketAccountedTime.pm
        'Evaluation by' => 'Utvärdering av',
        'Ticket/Article Accounted Time' => 'Ärende/Artikel Redovisad Tid',
        'Ticket Create Time' => 'Ärende Skapad Tid',
        'Ticket Close Time' => 'Ärende Stängt Tid',
        'Accounted time by Agent' => 'Redovisad tid per handläggare',
        'Total Time' => 'Total Tid',
        'Ticket Average' => 'Ärende Medel',
        'Ticket Min Time' => 'Ärende Min Tid',
        'Ticket Max Time' => 'Ärende Max Tid',
        'Number of Tickets' => 'Antal ärenden',
        'Article Average' => 'Artikel Medel',
        'Article Min Time' => 'Artikel Min Tid',
        'Article Max Time' => 'Artikel Max tid',
        'Number of Articles' => 'Antal Artiklar',

        # Perl Module: Kernel/System/Stats/Dynamic/TicketList.pm
        'unlimited' => '',
        'Attributes to be printed' => 'Attribut som skall skrivas ut',
        'Sort sequence' => 'Sorteringssekvens',
        'State Historic' => 'Tidigare tillstånd',
        'State Type Historic' => 'Tidigare tillståndstyper',
        'Historic Time Range' => '',
        'Number' => 'Nummer',
        'Last Changed' => '',

        # Perl Module: Kernel/System/Stats/Dynamic/TicketSolutionResponseTime.pm
        'Solution Average' => '',
        'Solution Min Time' => '',
        'Solution Max Time' => '',
        'Solution Average (affected by escalation configuration)' => '',
        'Solution Min Time (affected by escalation configuration)' => '',
        'Solution Max Time (affected by escalation configuration)' => '',
        'Solution Working Time Average (affected by escalation configuration)' =>
            '',
        'Solution Min Working Time (affected by escalation configuration)' =>
            '',
        'Solution Max Working Time (affected by escalation configuration)' =>
            '',
        'First Response Average (affected by escalation configuration)' =>
            '',
        'First Response Min Time (affected by escalation configuration)' =>
            '',
        'First Response Max Time (affected by escalation configuration)' =>
            '',
        'First Response Working Time Average (affected by escalation configuration)' =>
            '',
        'First Response Min Working Time (affected by escalation configuration)' =>
            '',
        'First Response Max Working Time (affected by escalation configuration)' =>
            '',
        'Number of Tickets (affected by escalation configuration)' => '',

        # Perl Module: Kernel/System/Stats/Static/OpenTicketCountPerDayPeriod.pm
        'Days' => 'Dagar',
        'Queues / Tickets' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/OutdatedTables.pm
        'Outdated Tables' => '',
        'Outdated tables were found in the database. These can be removed if empty.' =>
            '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/TablePresence.pm
        'Table Presence' => '',
        'Internal Error: Could not open file.' => 'Internt fel: Kunde inte öppna fil.',
        'Table Check' => '',
        'Internal Error: Could not read file.' => 'Internt fel: Kunde inte läsa fil.',
        'Tables found which are not present in the database.' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/mssql/Size.pm
        'Database Size' => 'Databasstorlek',
        'Could not determine database size.' => 'Kunde inte beräkna databasstorlek.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/mssql/Version.pm
        'Database Version' => 'Databasversion',
        'Could not determine database version.' => 'Kunde inte avgöra databasversion.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/mysql/Charset.pm
        'Client Connection Charset' => '',
        'Setting character_set_client needs to be utf8.' => '',
        'Server Database Charset' => '',
        'Please convert your database to the character set \'utf8mb4\'.' =>
            '',
        'Table Charset' => '',
        'There were tables found which do not have \'utf8mb4\' as charset.' =>
            '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/mysql/InnoDBLogFileSize.pm
        'InnoDB Log File Size' => '',
        'The setting innodb_log_file_size must be at least 256 MB.' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/mysql/InvalidDefaultValues.pm
        'Invalid Default Values' => '',
        'Tables with invalid default values were found. In order to fix it automatically, please run: bin/otobo.Console.pl Maint::Database::Check --repair' =>
            '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/mysql/MaxAllowedPacket.pm
        'Maximum Query Size' => '',
        'The setting \'max_allowed_packet\' must be 64 MB or higher.' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/mysql/Performance.pm
        'Query Cache Size' => '',
        'The setting \'query_cache_size\' should be used (higher than 10 MB but not more than 512 MB).' =>
            '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/mysql/StorageEngine.pm
        'Default Storage Engine' => '',
        'Table Storage Engine' => '',
        'Tables with a different storage engine than the default engine were found.' =>
            '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/mysql/Version.pm
        'MySQL 5.x or higher is required.' => 'MySQL 5.x eller senare krävs.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/oracle/NLS.pm
        'NLS_LANG Setting' => '',
        'NLS_LANG must be set to al32utf8 (e.g. GERMAN_GERMANY.AL32UTF8).' =>
            '',
        'NLS_DATE_FORMAT Setting' => '',
        'NLS_DATE_FORMAT must be set to \'YYYY-MM-DD HH24:MI:SS\'.' => '',
        'NLS_DATE_FORMAT Setting SQL Check' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/oracle/PrimaryKeySequencesAndTriggers.pm
        'Primary Key Sequences and Triggers' => '',
        'The following sequences and/or triggers with possible wrong names have been found. Please rename them manually.' =>
            '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/postgresql/Charset.pm
        'Setting client_encoding needs to be UNICODE or UTF8.' => '',
        'Setting server_encoding needs to be UNICODE or UTF8.' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/postgresql/DateStyle.pm
        'Date Format' => 'Datumformat',
        'Setting DateStyle needs to be ISO.' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/postgresql/PrimaryKeySequences.pm
        'Primary Key Sequences' => '',
        'The following sequences with possible wrong names have been found. Please rename them manually.' =>
            '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/postgresql/Version.pm
        'PostgreSQL 9.2 or higher is required.' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OS/Certificates.pm
        'Certificate check' => '',
        'Found obsolete cryptographic function.' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OS/DiskPartitionOTOBO.pm
        'OTOBO Disk Partition' => 'OTOBO diskpartition',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OS/DiskSpacePartitions.pm
        'Disk Partitions Usage' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OS/Distribution.pm
        'Distribution' => 'Distribution',
        'Could not determine distribution.' => 'Kunde inte bestämma distribution.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OS/KernelVersion.pm
        'Kernel Version' => 'Kernelversion',
        'Could not determine kernel version.' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OS/Load.pm
        'System Load' => 'Systembelastning',
        'The system load should be at maximum the number of CPUs the system has (e.g. a load of 8 or less on a system with 8 CPUs is OK).' =>
            'Systembelastningen ska högst vara samma siffra som antalet CPU:er i systemet, d v s ett system med åtta CPU:er ska högst ha en belastning på åtta för att vara OK.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OS/PerlModules.pm
        'Perl Modules' => 'Perlmoduler',
        'Not all required Perl modules are correctly installed.' => 'Alla nödvändiga Perl-moduler är inte korrekt installerade.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OS/PerlModulesAudit.pm
        'Perl Modules Audit' => '',
        'CPAN::Audit reported that one or more installed Perl modules have known vulnerabilities. Please note that there might be false positives for distributions patching Perl modules without changing their version number.' =>
            '',
        'CPAN::Audit did not report any known vulnerabilities in the installed Perl modules.' =>
            '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OS/Swap.pm
        'Free Swap Space (%)' => '',
        'No swap enabled.' => '',
        'Used Swap Space (MB)' => 'Använt växlingsutrymme (MB)',
        'There should be more than 60% free swap space.' => '',
        'There should be no more than 200 MB swap space used.' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/ArticleSearchIndexStatus.pm
        'OTOBO' => 'OTOBO',
        'Article Search Index Status' => '',
        'Indexed Articles' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/ArticlesPerCommunicationChannel.pm
        'Articles Per Communication Channel' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/CommunicationLog.pm
        'Incoming communications' => '',
        'Outgoing communications' => '',
        'Failed communications' => '',
        'Average processing time of communications (s)' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/CommunicationLogAccountStatus.pm
        'Communication Log Account Status (last 24 hours)' => '',
        'No connections found.' => '',
        'ok' => '',
        'permanent connection errors' => '',
        'intermittent connection errors' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/ConfigSettings.pm
        'Config Settings' => '',
        'Could not determine value.' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/DaemonRunning.pm
        'Daemon' => '',
        'Daemon is running.' => '',
        'Daemon is not running.' => 'OTOBO-demonen körs inte.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/DatabaseRecords.pm
        'Database Records' => '',
        'Ticket History Entries' => '',
        'Articles' => 'Artiklar',
        'Attachments (DB, Without HTML)' => 'Bilagor (DB, utan HTML)',
        'Customers With At Least One Ticket' => 'Kunder med minst ett ärende',
        'Dynamic Field Values' => 'Dynamiska fältvärden',
        'Invalid Dynamic Fields' => '',
        'Invalid Dynamic Field Values' => '',
        'GenericInterface Webservices' => '',
        'Process Tickets' => '',
        'Months Between First And Last Ticket' => 'Antal månader mellan första och sista ärende',
        'Tickets Per Month (avg)' => 'Ärenden per månad (genomsnitt)',
        'Open Tickets' => 'Öppna ärenden',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/DefaultUser.pm
        'Default Admin Password' => 'Defaultlösenord för admin',
        'Security risk: the agent account root@localhost still has the default password. Please change it or invalidate the account.' =>
            '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/EmailQueue.pm
        'Email Sending Queue' => '',
        'Emails queued for sending' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/FQDN.pm
        'FQDN (domain name)' => '',
        'Please configure your FQDN setting.' => 'Ställ in  FQDN.',
        'Domain Name' => 'Domännamn',
        'Your FQDN setting is invalid.' => 'Inställningen för FQDN är fel.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/FileSystemWritable.pm
        'File System Writable' => 'Är filsystemet skrivbart',
        'The file system on your OTOBO partition is not writable.' => 'Filsystemet på din OTOBO-partition är inte skrivbart.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/LegacyConfigBackups.pm
        'Legacy Configuration Backups' => '',
        'No legacy configuration backup files found.' => '',
        'Legacy configuration backup files found in Kernel/Config/Backups folder, but they might still be required by some packages.' =>
            '',
        'Legacy configuration backup files are no longer needed for the installed packages, please remove them from Kernel/Config/Backups folder.' =>
            '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/PackageDeployment.pm
        'Package Installation Status' => 'Paketinstallationsstatus',
        'Some packages have locally modified files.' => '',
        'Some packages are not correctly installed.' => '',
        'Package Verification Status' => '',
        'Some packages are not verified by the OTOBO Team.' => '',
        'Package Framework Version Status' => '',
        'Some packages are not allowed for the current framework version.' =>
            '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/PackageList.pm
        'Package List' => 'Paketlista',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/SessionConfigSettings.pm
        'Session Config Settings' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/SpoolMails.pm
        'Spooled Emails' => '',
        'There are emails in var/spool that OTOBO could not process.' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/SystemID.pm
        'Your SystemID setting is invalid, it should only contain digits.' =>
            'OTOBO-installationens system-ID är ogiltigt. Det ska enbart bestå av siffror.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/Ticket/DefaultType.pm
        'Default Ticket Type' => '',
        'The configured default ticket type is invalid or missing. Please change the setting Ticket::Type::Default and select a valid ticket type.' =>
            '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/Ticket/IndexModule.pm
        'Ticket Index Module' => '',
        'You have more than 60,000 tickets and should use the StaticDB backend. See admin manual (Performance Tuning) for more information.' =>
            'Du har mer än 60,000 ärenden och bör använda StaticDB. Se administratörs manualen (Prestandajustering) för mer information.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/Ticket/InvalidUsersWithLockedTickets.pm
        'Invalid Users with Locked Tickets' => '',
        'There are invalid users with locked tickets.' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/Ticket/OpenTickets.pm
        'You should not have more than 8,000 open tickets in your system.' =>
            'Du br inte ha fler än 8000 öppna ärenden i systemet.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/Ticket/SearchIndexModule.pm
        'Ticket Search Index Module' => '',
        'The indexing process forces the storage of the original article text in the article search index, without executing filters or applying stop word lists. This will increase the size of the search index and thus may slow down fulltext searches.' =>
            '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/Ticket/StaticDBOrphanedRecords.pm
        'Orphaned Records In ticket_lock_index Table' => '',
        'Table ticket_lock_index contains orphaned records. Please run bin/otobo.Console.pl "Maint::Ticket::QueueIndexCleanup" to clean the StaticDB index.' =>
            '',
        'Orphaned Records In ticket_index Table' => '',
        'Table ticket_index contains orphaned records. Please run bin/otobo.Console.pl "Maint::Ticket::QueueIndexCleanup" to clean the StaticDB index.' =>
            '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/TimeSettings.pm
        'Time Settings' => '',
        'Server time zone' => '',
        'OTOBO time zone' => '',
        'OTOBO time zone is not set.' => '',
        'User default time zone' => '',
        'User default time zone is not set.' => '',
        'Calendar time zone is not set.' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/UI/AgentSkinUsage.pm
        'UI - Agent Skin Usage' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/UI/AgentThemeUsage.pm
        'UI - Agent Theme Usage' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTOBO/UI/SpecialStats.pm
        'UI - Special Statistics' => '',
        'Agents using custom main menu ordering' => '',
        'Agents using favourites for the admin overview' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Webserver/Apache/LoadedModules.pm
        'Webserver' => 'Webbserver',
        'Loaded Apache Modules' => 'Laddade Apache-moduler',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Webserver/Apache/MPMModel.pm
        'MPM model' => '',
        'OTOBO requires apache to be run with the \'prefork\' MPM model.' =>
            '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Webserver/Apache/Performance.pm
        'CGI Accelerator Usage' => '',
        'You should use FastCGI or mod_perl to increase your performance.' =>
            '',
        'mod_deflate Usage' => '',
        'Please install mod_deflate to improve GUI speed.' => '',
        'mod_filter Usage' => '',
        'Please install mod_filter if mod_deflate is used.' => '',
        'mod_headers Usage' => '',
        'Please install mod_headers to improve GUI speed.' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Webserver/EnvironmentVariables.pm
        'Environment Variables' => 'Miljövariabler',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Webserver/InternalWebRequest.pm
        'Support Data Collection' => '',
        'Support data could not be collected from the web server.' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Webserver/Plack/PSGIEnv.pm
        'PSGI Environment' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Webserver/Plack/RunsUnderPSGI.pm
        'Runs under PSGI' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Webserver/Version.pm
        'Webserver Version' => 'Webbserver, version',
        'Could not determine webserver version.' => 'Kunde inte avgöra webbserverns version.',

        # Perl Module: Kernel/System/SupportDataCollector/PluginAsynchronous/OTOBO/ConcurrentUsers.pm
        'Concurrent Users Details' => '',
        'Concurrent Users' => 'Samtidiga användare',

        # Perl Module: Kernel/System/SupportDataCollector/PluginBase.pm
        'OK' => 'OK',
        'Problem' => 'Problem',

        # Perl Module: Kernel/System/SysConfig.pm
        'Setting %s does not exists!' => '',
        'Setting %s is not locked to this user!' => '',
        'Setting value is not valid!' => '',
        'Could not add modified setting!' => '',
        'Could not update modified setting!' => '',
        'Setting could not be unlocked!' => '',
        'Missing key %s!' => '',
        'Invalid setting: %s' => '',
        'Could not combine settings values into a perl hash.' => '',
        'Can not lock the deployment for UserID \'%s\'!' => '',
        'All Settings' => '',

        # Perl Module: Kernel/System/SysConfig/BaseValueType.pm
        'Default' => '',
        'Value is not correct! Please, consider updating this field.' => '',
        'Value doesn\'t satisfy regex (%s).' => '',

        # Perl Module: Kernel/System/SysConfig/ValueType/Checkbox.pm
        'Enabled' => 'Aktiverad',
        'Disabled' => 'Inaktiverad',

        # Perl Module: Kernel/System/SysConfig/ValueType/Date.pm
        'System was not able to calculate user Date in OTOBOTimeZone!' =>
            '',

        # Perl Module: Kernel/System/SysConfig/ValueType/DateTime.pm
        'System was not able to calculate user DateTime in OTOBOTimeZone!' =>
            '',

        # Perl Module: Kernel/System/SysConfig/ValueType/FrontendNavigation.pm
        'Value is not correct! Please, consider updating this module.' =>
            '',

        # Perl Module: Kernel/System/SysConfig/ValueType/VacationDays.pm
        'Value is not correct! Please, consider updating this setting.' =>
            '',

        # Perl Module: Kernel/System/Ticket.pm
        'Reset of unlock time.' => '',

        # Perl Module: Kernel/System/Ticket/Article/Backend/Chat.pm
        'Chat Participant' => '',
        'Chat Message Text' => '',

        # Perl Module: Kernel/System/Web/InterfaceAgent.pm
        'Too many failed login attempts, please retry in %s s.' => '',
        'Login failed! Your user name or password was entered incorrectly.' =>
            'Inloggning misslyckades! Felaktigt användarnamn eller lösenord.',
        'Authentication succeeded, but no user data record is found in the database. Please contact the administrator.' =>
            '',
        'Can`t remove SessionID.' => '',
        'Logout successful.' => '',
        'Feature not active!' => 'Funktion inte aktiverad!',
        'Sent password reset instructions. Please check your email.' => 'Skickade instruktioner för att återställa lösenord. Titta i din inkorg för mer information.',
        'Invalid Token!' => 'Ogiltig inmatning!',
        'Sent new password to %s. Please check your email.' => 'Skickade nytt lösenord till %s. Titta i din inkorg för mer information.',
        'Error: invalid session.' => '',
        'No Permission to use this frontend module!' => '',

        # Perl Module: Kernel/System/Web/InterfaceCustomer.pm
        'Authentication succeeded, but no customer record is found in the customer backend. Please contact the administrator.' =>
            '',
        'Reset password unsuccessful. Please contact the administrator.' =>
            '',
        'This e-mail address already exists. Please log in or reset your password.' =>
            'Den här e-postadressen finns redan. Vänligen logga in eller återställ ditt lösenord.',
        'This email address is not allowed to register. Please contact support staff.' =>
            'Denna e-post adress är inte tillåten att registrera. Vänligen kontakta support personal.',
        'Added via Customer Panel (%s)' => '',
        'Customer user can\'t be added!' => '',
        'Can\'t send account info!' => '',
        'New account created. Sent login information to %s. Please check your email.' =>
            'Nytt konto skapat. Skickade inloggningsuppgifter till %s. Titta i din inkorg.',

        # Perl Module: Kernel/System/Web/InterfaceInstaller.pm
        'If you want to re-run installer.pl, then disable the SecureMode in the SysConfig.' =>
            '',
        'Action "%s" not found!' => '',

        # Perl Module: Kernel/System/Web/InterfaceMigrateFromOTRS.pm
        'If you want to re-run migration.pl, then disable the SecureMode in the SysConfig.' =>
            '',

        # Perl Module: Kernel/System/Web/InterfacePublic.pm
        'Could not connect to the database.' => '',

        # Database XML / SOPM Definition: scripts/database/otobo-initial_insert.xml
        'invalid-temporarily' => '* ogiltig-tillfälligt',
        'Group for default access.' => '',
        'Group of all administrators.' => '',
        'Group for statistics access.' => '',
        'new' => 'ny',
        'All new state types (default: viewable).' => '',
        'open' => 'öppet',
        'All open state types (default: viewable).' => '',
        'closed' => 'stängt',
        'All closed state types (default: not viewable).' => '',
        'pending reminder' => 'väntar på påminnelse',
        'All \'pending reminder\' state types (default: viewable).' => '',
        'pending auto' => 'väntar på auto',
        'All \'pending auto *\' state types (default: viewable).' => '',
        'removed' => 'borttagen',
        'All \'removed\' state types (default: not viewable).' => '',
        'merged' => 'sammanfogat',
        'State type for merged tickets (default: not viewable).' => '',
        'New ticket created by customer.' => 'Nytt ärende skapat av kunden.',
        'closed successful' => 'Löst och stängt',
        'Ticket is closed successful.' => 'Ärendet stängdes utan problem.',
        'closed unsuccessful' => 'Olöst men stängt',
        'Ticket is closed unsuccessful.' => 'Ärendet kunde inte stängas.',
        'Open tickets.' => 'Öppna ärenden.',
        'Customer removed ticket.' => 'Ärendet borttaget av kunden.',
        'Ticket is pending for agent reminder.' => 'Ärendet väntar på handläggarpåminnelse.',
        'pending auto close+' => 'väntar på att stängas (löst)',
        'Ticket is pending for automatic close.' => 'Ärendet väntar på att stängas.',
        'pending auto close-' => 'väntar på att stängas (olöst)',
        'State for merged tickets.' => 'Tillstånd för sammanslaget ärende.',
        'system standard salutation (en)' => 'Installationens standardhälsningsfras (en)',
        'Standard Salutation.' => 'Skönshälsningsfras.',
        'system standard signature (en)' => 'Installationens standardsignatur (en)',
        'Standard Signature.' => 'Skönssignatur.',
        'Standard Address.' => 'Standardadress.',
        'possible' => 'möjlig',
        'Follow-ups for closed tickets are possible. Ticket will be reopened.' =>
            'Uppföljning på låst ärende möjlig. Ärendet öppnas igen.',
        'reject' => 'Avvisas',
        'Follow-ups for closed tickets are not possible. No new ticket will be created.' =>
            '',
        'new ticket' => 'nytt ärende',
        'Follow-ups for closed tickets are not possible. A new ticket will be created.' =>
            '',
        'Postmaster queue.' => '',
        'All default incoming tickets.' => '',
        'All junk tickets.' => 'Alla skräpärenden.',
        'All misc tickets.' => 'Alla övriga ärenden.',
        'auto reply' => 'auto svara',
        'Automatic reply which will be sent out after a new ticket has been created.' =>
            '',
        'auto reject' => 'auto avvisa',
        'Automatic reject which will be sent out after a follow-up has been rejected (in case queue follow-up option is "reject").' =>
            '',
        'auto follow up' => 'auto följ upp',
        'Automatic confirmation which is sent out after a follow-up has been received for a ticket (in case queue follow-up option is "possible").' =>
            '',
        'auto reply/new ticket' => 'auto svara/nytt ärende',
        'Automatic response which will be sent out after a follow-up has been rejected and a new ticket has been created (in case queue follow-up option is "new ticket").' =>
            '',
        'auto remove' => 'auto ta bort',
        'Auto remove will be sent out after a customer removed the request.' =>
            'Automatisk borttagning skickas ut när kunden tagit bort förfrågan.',
        'default reply (after new ticket has been created)' => 'Standardsvar när nytt ärende skapats',
        'default reject (after follow-up and rejected of a closed ticket)' =>
            '',
        'default follow-up (after a ticket follow-up has been added)' => '',
        'default reject/new ticket created (after closed follow-up with new ticket creation)' =>
            '',
        'Unclassified' => 'Oklassificerad',
        '1 very low' => '1 mycket låg',
        '2 low' => '2 låg',
        '3 normal' => '3 medium',
        '4 high' => '4 hög',
        '5 very high' => '5 mycket hög',
        'unlock' => 'upplåst',
        'lock' => 'låst',
        'tmp_lock' => '',
        'agent' => 'handläggare',
        'system' => 'system',
        'customer' => 'kund',
        'Ticket create notification' => 'Nytt ärende-notifiering',
        'You will receive a notification each time a new ticket is created in one of your "My Queues" or "My Services".' =>
            '',
        'Ticket follow-up notification (unlocked)' => 'Ärendeuppföljnings-notifiering (olåst)',
        'You will receive a notification if a customer sends a follow-up to an unlocked ticket which is in your "My Queues" or "My Services".' =>
            '',
        'Ticket follow-up notification (locked)' => 'Ärendeuppföljnings-notifiering (låst)',
        'You will receive a notification if a customer sends a follow-up to a locked ticket of which you are the ticket owner or responsible.' =>
            '',
        'Ticket lock timeout notification' => 'Meddela mig då tiden gått ut för ett ärende-lås',
        'You will receive a notification as soon as a ticket owned by you is automatically unlocked.' =>
            '',
        'Ticket owner update notification' => 'Ärendeägarbytes-notifiering',
        'Ticket responsible update notification' => 'Ärendeägarbytes-notifiering',
        'Ticket new note notification' => 'Ärendeantecknings-notifiering',
        'Ticket queue update notification' => 'Ärendeköförändrings-notifiering',
        'You will receive a notification if a ticket is moved into one of your "My Queues".' =>
            '',
        'Ticket pending reminder notification (locked)' => '',
        'Ticket pending reminder notification (unlocked)' => 'Notifiering om väntande-påminnelse för ärende (olåst)',
        'Ticket escalation notification' => 'Eskalerat ärende-notifiering',
        'Ticket escalation warning notification' => 'Eskalerat ärende-varningsnotifiering',
        'Ticket service update notification' => 'Ärendetjänstförändrings-notifiering',
        'You will receive a notification if a ticket\'s service is changed to one of your "My Services".' =>
            '',
        'Appointment reminder notification' => 'Kalenderhändelsepåminnelse',
        'You will receive a notification each time a reminder time is reached for one of your appointments.' =>
            'Du får en notifiering för varje påminnelsetid för dina kalenderhändelser. ',
        'Ticket email delivery failure notification' => '',

        # JS File: Core.AJAX
        'Error during AJAX communication. Status: %s, Error: %s' => '',
        'This window must be called from compose window.' => '',

        # JS File: Core.Agent.Admin.ACL
        'Add all' => 'Lägg till alla',
        'An item with this name is already present.' => 'En sak med det här namnet finns redan.',
        'This item still contains sub items. Are you sure you want to remove this item including its sub items?' =>
            '',

        # JS File: Core.Agent.Admin.About
        'Do you really want to delete this language?' => '',

        # JS File: Core.Agent.Admin.AppointmentCalendar.Manage
        'More' => 'Mer',
        'Less' => 'Mindre',
        'Press Ctrl+C (Cmd+C) to copy to clipboard' => '',

        # JS File: Core.Agent.Admin.Attachment
        'Delete this Attachment' => '',
        'Deleting attachment...' => '',
        'There was an error deleting the attachment. Please check the logs for more information.' =>
            '',
        'Attachment was deleted successfully.' => '',

        # JS File: Core.Agent.Admin.DynamicField
        'Do you really want to delete this dynamic field? ALL associated data will be LOST!' =>
            'Vill du verkligen radera detta dynamiska fält? Alla data inmatade via fältet kommer att försvinna!',
        'Delete field' => 'Radera fält',
        'Deleting the field and its data. This may take a while...' => '',

        # JS File: Core.Agent.Admin.GenericAgent
        'Remove this dynamic field' => '',
        'Remove selection' => 'Ta bort urval',
        'Do you really want to delete this generic agent job?' => '',
        'Delete this Event Trigger' => 'Radera denna händesletrigger',
        'Duplicate event.' => 'Duplicera händelse.',
        'This event is already attached to the job, Please use a different one.' =>
            'Denna händelse är redan knuten till jobbet, vänligen använd en annan.',

        # JS File: Core.Agent.Admin.GenericInterfaceDebugger
        'An error occurred during communication.' => 'Ett fel uppstod under pågående kommunikation.',
        'Request Details' => 'Requestdetaljer',
        'Request Details for Communication ID' => '',
        'Show or hide the content.' => 'Visa eller dölj innehållet',
        'Clear debug log' => 'Rensa avlusningsloggen',

        # JS File: Core.Agent.Admin.GenericInterfaceErrorHandling
        'Delete error handling module' => '',

        # JS File: Core.Agent.Admin.GenericInterfaceInvoker
        'It is not possible to add a new event trigger because the event is not set.' =>
            '',
        'Delete this Invoker' => '',

        # JS File: Core.Agent.Admin.GenericInterfaceInvokerEvent
        'Sorry, the only existing condition can\'t be removed.' => '',
        'Sorry, the only existing field can\'t be removed.' => '',
        'Delete conditions' => '',

        # JS File: Core.Agent.Admin.GenericInterfaceMapping
        'Mapping for Key %s' => '',
        'Mapping for Key' => '',
        'Delete this Key Mapping' => '',

        # JS File: Core.Agent.Admin.GenericInterfaceOperation
        'Delete this Operation' => '',

        # JS File: Core.Agent.Admin.GenericInterfaceWebservice
        'Clone web service' => 'Klona webbtjänst',
        'Delete operation' => 'Radera åtgärd',
        'Delete invoker' => '',

        # JS File: Core.Agent.Admin.Group
        'WARNING: When you change the name of the group \'admin\', before making the appropriate changes in the SysConfig, you will be locked out of the administrations panel! If this happens, please rename the group back to admin per SQL statement.' =>
            'VARNING: När du ändrar namnet på gruppen \'admin\', innan du gör lämpliga ändringar i SysConfig, kommer du låsas ut ur administrationspanelen! Om detta inträffar, döp om grubben tillbaka till admin via SQL. ',

        # JS File: Core.Agent.Admin.MailAccount
        'Delete this Mail Account' => '',
        'Deleting the mail account and its data. This may take a while...' =>
            '',

        # JS File: Core.Agent.Admin.NotificationEvent
        'Do you really want to delete this notification language?' => 'Vill du verkligen radera detta notifieringsspråk?',
        'Do you really want to delete this notification?' => '',

        # JS File: Core.Agent.Admin.PGP
        'Do you really want to delete this key?' => '',

        # JS File: Core.Agent.Admin.PackageManager
        'There is a package upgrade process running, click here to see status information about the upgrade progress.' =>
            '',
        'A package upgrade was recently finished. Click here to see the results.' =>
            '',
        'No response from get package upgrade result.' => '',
        'Update all packages' => '',
        'Dismiss' => 'Avfärda',
        'Update All Packages' => '',
        'No response from package upgrade all.' => '',
        'Currently not possible' => '',
        'This is currently disabled because of an ongoing package upgrade.' =>
            '',
        'This option is currently disabled because the OTOBO Daemon is not running.' =>
            '',
        'Are you sure you want to update all installed packages?' => '',
        'No response from get package upgrade run status.' => '',

        # JS File: Core.Agent.Admin.PostMasterFilter
        'Delete this PostMasterFilter' => '',
        'Deleting the postmaster filter and its data. This may take a while...' =>
            '',

        # JS File: Core.Agent.Admin.ProcessManagement.Canvas
        'Remove Entity from canvas' => '',
        'No TransitionActions assigned.' => '',
        'No dialogs assigned yet. Just pick an activity dialog from the list on the left and drag it here.' =>
            '',
        'This Activity cannot be deleted because it is the Start Activity.' =>
            '',
        'Remove the Transition from this Process' => '',

        # JS File: Core.Agent.Admin.ProcessManagement
        'As soon as you use this button or link, you will leave this screen and its current state will be saved automatically. Do you want to continue?' =>
            '',
        'Delete Entity' => '',
        'This Activity is already used in the Process. You cannot add it twice!' =>
            '',
        'Error during AJAX communication' => '',
        'An unconnected transition is already placed on the canvas. Please connect this transition first before placing another transition.' =>
            '',
        'This Transition is already used for this Activity. You cannot use it twice!' =>
            '',
        'This TransitionAction is already used in this Path. You cannot use it twice!' =>
            '',
        'Hide EntityIDs' => '',
        'Edit Field Details' => '',
        'Customer interface does not support articles not visible for customers.' =>
            '',
        'Sorry, the only existing parameter can\'t be removed.' => '',

        # JS File: Core.Agent.Admin.SMIME
        'Do you really want to delete this certificate?' => '',

        # JS File: Core.Agent.Admin.SupportDataCollector
        'Sending Update...' => 'Skickar uppdatering ...',
        'Support Data information was successfully sent.' => 'Supportdata skickades utan problem.',
        'Was not possible to send Support Data information.' => 'Supportdata kunde inte skickas.',
        'Update Result' => 'Uppdateringsresultat',
        'Generating...' => 'Skapar...',
        'It was not possible to generate the Support Bundle.' => 'Det gick inte att skapa supportpaketet.',
        'Generate Result' => 'Skapa resultat',
        'Support Bundle' => 'Supportpaket',
        'The mail could not be sent' => 'E-post kunde inte skickas',

        # JS File: Core.Agent.Admin.SysConfig.Entity
        'It is not possible to set this entry to invalid. All affected configuration settings have to be changed beforehand.' =>
            '',
        'Cannot proceed' => '',
        'Update manually' => '',
        'You can either have the affected settings updated automatically to reflect the changes you just made or do it on your own by pressing \'update manually\'.' =>
            '',
        'Save and update automatically' => '',
        'Don\'t save, update manually' => '',
        'The item you\'re currently viewing is part of a not-yet-deployed configuration setting, which makes it impossible to edit it in its current state. Please wait until the setting has been deployed. If you\'re unsure what to do next, please contact your system administrator.' =>
            '',

        # JS File: Core.Agent.Admin.SystemConfiguration
        'Loading...' => 'Laddar...',
        'Search the System Configuration' => '',
        'Please enter at least one search word to find anything.' => '',
        'Unfortunately deploying is currently not possible, maybe because another agent is already deploying. Please try again later.' =>
            '',
        'Deploy' => '',
        'The deployment is already running.' => '',
        'Deployment successful. You\'re being redirected...' => '',
        'There was an error. Please save all settings you are editing and check the logs for more information.' =>
            '',
        'Reset option is required!' => '',
        'By restoring this deployment all settings will be reverted to the value they had at the time of the deployment. Do you really want to continue?' =>
            '',
        'Keys with values can\'t be renamed. Please remove this key/value pair instead and re-add it afterwards.' =>
            '',
        'Unlock setting.' => '',

        # JS File: Core.Agent.Admin.SystemConfigurationUser
        'Are you sure you want to remove all user values?' => '',

        # JS File: Core.Agent.Admin.SystemMaintenance
        'Do you really want to delete this scheduled system maintenance?' =>
            'Vill du verkligen ta bort systemunderhållet?',

        # JS File: Core.Agent.Admin.Template
        'Delete this Template' => '',
        'Deleting the template and its data. This may take a while...' =>
            '',

        # JS File: Core.Agent.AppointmentCalendar
        'Jump' => 'Hoppa',
        'Timeline Month' => 'Månadsvy',
        'Timeline Week' => 'Veckovy',
        'Timeline Day' => 'Dagsvy',
        'Previous' => '',
        'Resources' => 'Resurser',
        'Su' => 'Sö',
        'Mo' => 'Må',
        'Tu' => 'Ti',
        'We' => 'On',
        'Th' => 'To',
        'Fr' => 'Fr',
        'Sa' => 'Lö',
        'This is a repeating appointment' => 'Upprepad kalenderhändelse',
        'Would you like to edit just this occurrence or all occurrences?' =>
            '',
        'All occurrences' => 'Alla förekomster',
        'Just this occurrence' => 'Endast denna händelse',
        'Too many active calendars' => 'För många aktiva kalendrar',
        'Please either turn some off first or increase the limit in configuration.' =>
            '',
        'Restore default settings' => '',
        'Are you sure you want to delete this appointment? This operation cannot be undone.' =>
            '',

        # JS File: Core.Agent.CustomerSearch
        'First select a customer user, then select a customer ID to assign to this ticket.' =>
            '',
        'Duplicated entry' => '',
        'It is going to be deleted from the field, please try again.' => 'Den tas bort som mottagare. Försök igen.',

        # JS File: Core.Agent.CustomerUserAddressBook
        'Please enter at least one search value or * to find anything.' =>
            'Skriv minst ett sökord eller * för alla.',

        # JS File: Core.Agent.Daemon
        'Information about the OTOBO Daemon' => 'Information om OTOBO-demonen',

        # JS File: Core.Agent.Dashboard
        'Please check the fields marked as red for valid inputs.' => '',
        'month' => 'månad',
        'Remove active filters for this widget.' => 'Ta bort aktiva filter för denna widget.',

        # JS File: Core.Agent.DynamicFieldDBSearch
        'This dynamic field database value is already selected.' => '',

        # JS File: Core.Agent.LinkObject.SearchForm
        'Please wait...' => '',
        'Searching for linkable objects. This may take a while...' => '',

        # JS File: Core.Agent.LinkObject
        'Do you really want to delete this link?' => '',

        # JS File: Core.Agent.Login
        'Are you using a browser plugin like AdBlock or AdBlockPlus? This can cause several issues and we highly recommend you to add an exception for this domain.' =>
            '',
        'Do not show this warning again.' => '',

        # JS File: Core.Agent.Preferences
        'Sorry, but you can\'t disable all methods for notifications marked as mandatory.' =>
            '',
        'Sorry, but you can\'t disable all methods for this notification.' =>
            '',
        'Please note that at least one of the settings you have changed requires a page reload. Click here to reload the current screen.' =>
            '',
        'An unknown error occurred. Please contact the administrator.' =>
            '',

        # JS File: Core.Agent.Responsive
        'Switch to desktop mode' => 'Byt till skrivbordsläge',

        # JS File: Core.Agent.Search
        'Please remove the following words from your search as they cannot be searched for:' =>
            '',

        # JS File: Core.Agent.SharedSecretGenerator
        'Generate' => '',

        # JS File: Core.Agent.SortedTree
        'This element has children elements and can currently not be removed.' =>
            '',

        # JS File: Core.Agent.Statistics
        'Do you really want to delete this statistic?' => 'Vill du verkligen ta bort rapporten?',

        # JS File: Core.Agent.StatisticsReports
        'Do you really want to delete this report?' => '',

        # JS File: Core.Agent.TicketAction
        'Select a customer ID to assign to this ticket' => '',
        'Do you really want to continue?' => 'Vill du verkligen fortsätta?',

        # JS File: Core.Agent.TicketBulk
        ' ...and %s more' => '',
        ' ...show less' => '',

        # JS File: Core.Agent.TicketFormDraft
        'Add new draft' => '',
        'Delete draft' => '',
        'There are no more drafts available.' => '',
        'It was not possible to delete this draft.' => '',

        # JS File: Core.Agent.TicketZoom
        'Article filter' => 'Artikelfilter',
        'Apply' => 'Verkställ',
        'Event Type Filter' => 'Filter för händelsetyp',

        # JS File: Core.Agent
        'Slide the navigation bar' => '',
        'Please turn off Compatibility Mode in Internet Explorer!' => '',

        # JS File: Core.App.Responsive
        'Switch to mobile mode' => 'Byt till dynamiskt mobilläge',

        # JS File: Core.App
        'Error: Browser Check failed!' => '',
        'Reload page' => '',
        'Reload page (%ss)' => '',

        # JS File: Core.Debug
        'Namespace %s could not be initialized, because %s could not be found.' =>
            '',

        # JS File: Core.Exception
        'An error occurred! Please check the browser error log for more details!' =>
            '',

        # JS File: Core.Form.Validate
        'One or more errors occurred!' => 'Ett eller fler fel inträffade!',

        # JS File: Core.Installer
        'Mail check successful.' => 'Kontrollen av e-postinställningarna lyckades.',
        'Error in the mail settings. Please correct and try again.' => 'Inställningarna för e-post stämmer inte. Ändra och försök igen.',

        # JS File: Core.SystemConfiguration
        'Open this node in a new window' => '',
        'Please add values for all keys before saving the setting.' => '',
        'The key must not be empty.' => '',
        'A key with this name (\'%s\') already exists.' => '',
        'Do you really want to revert this setting to its historical value?' =>
            '',

        # JS File: Core.UI.Datepicker
        'Open date selection' => '',
        'Invalid date (need a future date)!' => 'Datumet behöver vara i framtiden!',
        'Invalid date (need a past date)!' => 'Datumet behöver vara passerat!',

        # JS File: Core.UI.InputFields
        'Not available' => 'Inte tillgänglig',
        'and %s more...' => 'och %s ytterligare ...',
        'Show current selection' => '',
        'Current selection' => '',
        'Clear all' => 'Rensa alla',
        'Filters' => 'Filter',
        'Clear search' => 'Rensa sökning',

        # JS File: Core.UI.Popup
        'If you now leave this page, all open popup windows will be closed, too!' =>
            '',
        'A popup of this screen is already open. Do you want to close it and load this one instead?' =>
            '',
        'Could not open popup window. Please disable any popup blockers for this application.' =>
            'Kund einte öppnapopupfönster. Avaktivera popupblockerare för denna applikation.',

        # JS File: Core.UI.Table.Sort
        'Ascending sort applied, ' => '',
        'Descending sort applied, ' => '',
        'No sort applied, ' => '',
        'sorting is disabled' => '',
        'activate to apply an ascending sort' => '',
        'activate to apply a descending sort' => '',
        'activate to remove the sort' => '',

        # JS File: Core.UI.Table
        'Remove the filter' => '',

        # JS File: Core.UI.TreeSelection
        'There are currently no elements available to select from.' => 'Det finns inga poster att välja just nu.',

        # JS File: Core.UI
        'Please only select one file for upload.' => '',
        'Sorry, you can only upload one file here.' => '',
        'Sorry, you can only upload %s files.' => '',
        'Please only select at most %s files for upload.' => '',
        'The following files are not allowed to be uploaded: %s' => '',
        'The following files exceed the maximum allowed size per file of %s and were not uploaded: %s' =>
            '',
        'The following files were already uploaded and have not been uploaded again: %s' =>
            '',
        'No space left for the following files: %s' => '',
        'Available space %s of %s.' => '',
        'Upload information' => '',
        'An unknown error occurred when deleting the attachment. Please try again. If the error persists, please contact your system administrator.' =>
            '',

        # JS File: Core.Language.UnitTest
        'yes' => 'ja',
        'no' => 'inga',
        'This is %s' => '',
        'Complex %s with %s arguments' => '',

        # JS File: OTOBOLineChart
        'No Data Available.' => '',

        # JS File: OTOBOMultiBarChart
        'Grouped' => 'Grupperade',
        'Stacked' => 'Staplade',

        # JS File: OTOBOStackedAreaChart
        'Stream' => 'Stream',
        'Expanded' => 'Expanderade',

        # SysConfig
        '
            Show optional parameters in parameter list, too. If disabled, the optional parameters are only shown
            in an extra table
        ' => '',
        '
Dear Customer,

Unfortunately we could not detect a valid ticket number
in your subject, so this email can\'t be processed.

Please create a new ticket via the customer panel.

Thanks for your help!

 Your Helpdesk Team
' => '',
        ' (work units)' => '(tidsenheter, decimalt)',
        ' 2 minutes' => ' 2 minuter',
        ' 5 minutes' => ' 5 minuter',
        ' 7 minutes' => ' 7 minuter',
        '"Slim" skin which tries to save screen space for power users.' =>
            '',
        '%s' => '%s',
        '(UserLogin) Firstname Lastname' => '(Användarlogin) Förnamn efternamn',
        '(UserLogin) Lastname Firstname' => '(Användarlogin) Efternamn förnamn',
        '(UserLogin) Lastname, Firstname' => '(Användarlogin) Efternamn, förnamn',
        '*** out of office until %s (%s d left) ***' => '',
        '0 - Disabled' => '',
        '1 - Available' => '',
        '1 - Enabled' => '',
        '10 Minutes' => '',
        '100 (Expert)' => '',
        '15 Minutes' => '',
        '2 - Enabled and required' => '',
        '2 - Enabled and shown by default' => '',
        '2 - Enabled by default' => '',
        '2 Minutes' => '',
        '200 (Advanced)' => '',
        '30 Minutes' => '',
        '300 (Beginner)' => '',
        '5 Minutes' => '',
        'A TicketWatcher Module.' => '',
        'A Website' => 'Webbplatsen',
        'A list of dynamic fields that are merged into the main ticket during a merge operation. Only dynamic fields that are empty in the main ticket will be set.' =>
            '',
        'A picture' => 'En bild',
        'ACL module that allows closing parent tickets only if all its children are already closed ("State" shows which states are not available for the parent ticket until all child tickets are closed).' =>
            '',
        'Access Control Lists (ACL)' => 'Åtkomstkontroll (ACL)',
        'AccountedTime' => 'Redovisad tid',
        'Activate Elasticsearch.' => '',
        'Activate the customer frontend.' => '',
        'Activate the public frontend.' => '',
        'Activates Rendering of DynamicFields outside of the DynamicField block.' =>
            '',
        'Activates a blinking mechanism of the queue that contains the oldest ticket.' =>
            '',
        'Activates lost password feature for agents, in the agent interface.' =>
            'Aktivera glömt lösenord-funktionen för handläggare i handläggargränssnittet.',
        'Activates lost password feature for customers.' => 'Aktiverar glömt lösenord-funktionen för kunder.',
        'Activates support for customer and customer user groups.' => '',
        'Activates the article filter in the zoom view to specify which articles should be shown.' =>
            '',
        'Activates the available themes on the system. Value 1 means active, 0 means inactive.' =>
            'Aktiverar tillgängliga teman. 1 betyder aktivt, 0 betyder inaktivt. ',
        'Activates the ticket archive system search in the customer interface.' =>
            'Aktiverar sökfunktionen för arkivet i kundgränssnittet.',
        'Activates the ticket archive system to have a faster system by moving some tickets out of the daily scope. To search for these tickets, the archive flag has to be enabled in the ticket search.' =>
            '',
        'Activates time accounting.' => 'Aktivera tidsredovisningsmodulen.',
        'ActivityID' => 'Aktivitets-ID',
        'Add a note to this ticket' => 'Lägg till en anteckning till ärendet',
        'Add an inbound phone call to this ticket' => 'Lägg till ett inkommande telefonsamtal till ärendet',
        'Add an outbound phone call to this ticket' => 'Lägg till ett utgående telefonsamtal till ärendet',
        'Added %s time unit(s), for a total of %s time unit(s).' => '',
        'Added email. %s' => 'Added email. %s',
        'Added follow-up to ticket [%s]. %s' => '',
        'Added link to ticket "%s".' => 'Added link to ticket "%s".',
        'Added note (%s).' => '',
        'Added phone call from customer.' => '',
        'Added phone call to customer.' => '',
        'Added subscription for user "%s".' => 'Added subscription for user "%s".',
        'Added system request (%s).' => '',
        'Added web request from customer.' => '',
        'Adds a suffix with the actual year and month to the OTOBO log file. A logfile for every month will be created.' =>
            '',
        'Adds customers email addresses to recipients in the ticket compose screen of the agent interface. The customers email address won\'t be added if the article type is email-internal.' =>
            '',
        'Adds the one time vacation days for the indicated calendar.' => '',
        'Adds the one time vacation days.' => '',
        'Adds the permanent vacation days for the indicated calendar.' =>
            '',
        'Adds the permanent vacation days.' => '',
        'Admin' => 'Administration',
        'Admin Area.' => '',
        'Admin Contact With Data' => '',
        'Admin Notification' => 'Admin-meddelanden',
        'Admin area navigation for the agent interface.' => '',
        'Admin contact with data.' => '',
        'Admin modules overview.' => '',
        'Admin.' => 'Admin.',
        'Administration' => 'Administration',
        'Agent Contact With Data Search' => '',
        'Agent Customer Search' => '',
        'Agent Customer Search.' => '',
        'Agent Dynamic Field Database Detailed Search' => '',
        'Agent Dynamic Field Database Details' => '',
        'Agent Dynamic Field Database Search' => '',
        'Agent Name' => '',
        'Agent Name + FromSeparator + System Address Display Name' => '',
        'Agent Preferences.' => '',
        'Agent Statistics.' => '',
        'Agent User Search' => '',
        'Agent User Search.' => '',
        'Agent contact with data search.' => '',
        'Agent dynamic field database detailed search.' => '',
        'Agent dynamic field database details.' => '',
        'Agent dynamic field database search.' => '',
        'Agent frontend module registration (disable \'Edit contacts with data\' link if if there is no source field configured).' =>
            '',
        'Agent interface article notification module to check PGP.' => '',
        'Agent interface article notification module to check S/MIME.' =>
            '',
        'Agent interface module to access CIC search via nav bar. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2".' =>
            '',
        'Agent interface module to access fulltext search via nav bar. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2".' =>
            '',
        'Agent interface module to access search profiles via nav bar. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2".' =>
            '',
        'Agent interface module to check incoming emails in the Ticket-Zoom-View if the S/MIME-key is available and true.' =>
            '',
        'Agent interface notification module to see the number of locked tickets. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2".' =>
            '',
        'Agent interface notification module to see the number of tickets an agent is responsible for. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2".' =>
            '',
        'Agent interface notification module to see the number of tickets in My Services. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2".' =>
            '',
        'Agent interface notification module to see the number of watched tickets. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2".' =>
            '',
        'AgentTicketZoom widget that displays Contact with data dynamic field in the side bar.' =>
            '',
        'AgentTicketZoom widget that displays a table of objects linked to the ticket.' =>
            '',
        'AgentTicketZoom widget that displays customer information for the ticket in the side bar.' =>
            '',
        'AgentTicketZoom widget that displays ticket data in the side bar.' =>
            '',
        'Agents ↔ Groups' => '',
        'Agents ↔ Roles' => '',
        'All CustomerIDs of a customer user.' => '',
        'All closed tickets.' => '',
        'All customer users of a CustomerID' => 'Alla kundanvändare för kund-ID:t',
        'All escalated tickets' => 'Alla eskalerade ärenden',
        'All new tickets, these tickets have not been worked on yet' => 'Alla nya ärenden, dessa ärenden har inte arbetas med än',
        'All open tickets, these tickets have already been worked on.' =>
            '',
        'All tickets with a reminder set where the reminder date has been reached' =>
            'Ärenden med påminnelser där påminnelsetiden infallit',
        'Allows adding notes in the close ticket screen of the agent interface. Can be overwritten by Ticket::Frontend::NeedAccountedTime.' =>
            '',
        'Allows adding notes in the ticket free text screen of the agent interface. Can be overwritten by Ticket::Frontend::NeedAccountedTime.' =>
            '',
        'Allows adding notes in the ticket note screen of the agent interface. Can be overwritten by Ticket::Frontend::NeedAccountedTime.' =>
            '',
        'Allows adding notes in the ticket owner screen of a zoomed ticket in the agent interface. Can be overwritten by Ticket::Frontend::NeedAccountedTime.' =>
            '',
        'Allows adding notes in the ticket pending screen of a zoomed ticket in the agent interface. Can be overwritten by Ticket::Frontend::NeedAccountedTime.' =>
            '',
        'Allows adding notes in the ticket priority screen of a zoomed ticket in the agent interface. Can be overwritten by Ticket::Frontend::NeedAccountedTime.' =>
            '',
        'Allows adding notes in the ticket responsible screen of the agent interface. Can be overwritten by Ticket::Frontend::NeedAccountedTime.' =>
            '',
        'Allows agents to exchange the axis of a stat if they generate one.' =>
            '',
        'Allows agents to generate individual-related stats.' => '',
        'Allows choosing between showing the attachments of a ticket in the browser (inline) or just make them downloadable (attachment).' =>
            '',
        'Allows choosing the next compose state for customer tickets in the customer interface.' =>
            'Aktiverar rätt att välja nästa tillstånd för kundärenden i kundgränssnittet.',
        'Allows customers to change the ticket priority in the customer interface.' =>
            'Aktiverar rätt att ändra ärendeprioritet i kundgränssnittet.',
        'Allows customers to set the ticket SLA in the customer interface.' =>
            'Aktiverar rätt att välja ärendets servicenivåavtal (SLA) i kundgränssnittet.',
        'Allows customers to set the ticket priority in the customer interface.' =>
            'Aktiverar rätt att sätta ärendeprioritet i kundgränssnittet.',
        'Allows customers to set the ticket queue in the customer interface. If this is not enabled, QueueDefault should be configured.' =>
            '',
        'Allows customers to set the ticket service in the customer interface.' =>
            '',
        'Allows customers to set the ticket type in the customer interface. If this is not enabled, TicketTypeDefault should be configured.' =>
            '',
        'Allows default services to be selected also for non existing customers.' =>
            '',
        'Allows defining services and SLAs for tickets (e. g. email, desktop, network, ...), and escalation attributes for SLAs (if ticket service/SLA feature is enabled).' =>
            '',
        'Allows extended search conditions in ticket search of the agent interface. With this feature you can search e. g. ticket title with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".' =>
            '',
        'Allows extended search conditions in ticket search of the customer interface. With this feature you can search e. g. ticket title with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".' =>
            '',
        'Allows extended search conditions in ticket search of the generic agent interface. With this feature you can search e. g. ticket title with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".' =>
            '',
        'Allows generic agent to execute custom modules.' => '',
        'Allows having a medium format ticket overview (CustomerInfo => 1 - shows also the customer information).' =>
            '',
        'Allows having a small format ticket overview (CustomerInfo => 1 - shows also the customer information).' =>
            '',
        'Allows invalid agents to generate individual-related stats.' => '',
        'Allows the administrators to login as other customers, via the customer user administration panel.' =>
            '',
        'Allows the administrators to login as other users, via the users administration panel.' =>
            '',
        'Allows to save current work as draft in the close ticket screen of the agent interface.' =>
            '',
        'Allows to save current work as draft in the email outbound screen of the agent interface.' =>
            '',
        'Allows to save current work as draft in the ticket compose screen of the agent interface.' =>
            '',
        'Allows to save current work as draft in the ticket forward screen of the agent interface.' =>
            '',
        'Allows to save current work as draft in the ticket free text screen of the agent interface.' =>
            '',
        'Allows to save current work as draft in the ticket move screen of the agent interface.' =>
            '',
        'Allows to save current work as draft in the ticket note screen of the agent interface.' =>
            '',
        'Allows to save current work as draft in the ticket owner screen of the agent interface.' =>
            '',
        'Allows to save current work as draft in the ticket pending screen of the agent interface.' =>
            '',
        'Allows to save current work as draft in the ticket phone inbound screen of the agent interface.' =>
            '',
        'Allows to save current work as draft in the ticket phone outbound screen of the agent interface.' =>
            '',
        'Allows to save current work as draft in the ticket priority screen of the agent interface.' =>
            '',
        'Allows to save current work as draft in the ticket responsible screen of the agent interface.' =>
            '',
        'Allows to set a new ticket state in the move ticket screen of the agent interface.' =>
            '',
        'Always show RichText if available' => '',
        'Answer' => 'Svar',
        'Appointment Calendar overview page.' => 'Kalenderhändelseöversikt.',
        'Appointment Notifications' => 'Kalenderhändelsepåminnelser',
        'Appointment calendar event module that prepares notification entries for appointments.' =>
            '',
        'Appointment calendar event module that updates the ticket with data from ticket appointment.' =>
            '',
        'Appointment edit screen.' => 'Redigera kalenderhändelse-vy.',
        'Appointment list' => 'Kalenderhändelser',
        'Appointment list.' => 'Kalenderhändelser.',
        'Appointment notifications' => 'Kalenderhändelsepåminnelser',
        'Appointments' => 'Kalenderhändelser',
        'Arabic (Saudi Arabia)' => '',
        'Article attributes that should be available in ticket invoker configuration frontend (0 = visible/selectable, 1 = default/preselected).' =>
            '',
        'ArticleTree' => '',
        'Attachment Name' => '',
        'Autoloading of Znuny4OTOBOPasswordPolicy extensions.' => '',
        'Automated line break in text messages after x number of chars.' =>
            '',
        'Automatically change the state of a ticket with an invalid owner once it is unlocked. Maps from a state type to a new ticket state.' =>
            '',
        'Automatically generate statistics reports and email them to the specified recipients.' =>
            '',
        'Automatically lock and set owner to current Agent after opening the move ticket screen of the agent interface.' =>
            '',
        'Automatically lock and set owner to current Agent after selecting for an Bulk Action.' =>
            '',
        'Automatically sets the owner of a ticket as the responsible for it (if ticket responsible feature is enabled). This will only work by manually actions of the logged in user. It does not work for automated actions e.g. GenericAgent, Postmaster and GenericInterface.' =>
            '',
        'Automatically sets the responsible of a ticket (if it is not set yet) after the first owner update.' =>
            '',
        'Avatar' => '',
        'Balanced white skin by Felix Niklas (slim version).' => '',
        'Balanced white skin by Felix Niklas.' => '',
        'Based on global RichText setting' => '',
        'Basic fulltext index settings. Execute "bin/otobo.Console.pl Maint::Ticket::FulltextIndex --rebuild" in order to generate a new index.' =>
            '',
        'Blocks all the incoming emails that do not have a valid ticket number in subject with From: @example.com address.' =>
            '',
        'Bounced to "%s".' => 'Bounced to "%s".',
        'Bulgarian' => 'Bulgariska',
        'Bulk Action' => 'Massförändring',
        'CMD example setup. Ignores emails where external CMD returns some output on STDOUT (email will be piped into STDIN of some.bin).' =>
            '',
        'CSV Separator' => 'CSV-separator',
        'Cache time in seconds for agent authentication in the GenericInterface.' =>
            '',
        'Cache time in seconds for customer authentication in the GenericInterface.' =>
            '',
        'Cache time in seconds for the DB ACL backend.' => 'Cache tid i sekunder för DB ACL.',
        'Cache time in seconds for the DB process backend.' => 'Cache tid i sekunder för DB processer.',
        'Cache time in seconds for the SSL certificate attributes.' => 'Cache tid i sekunder för SSL certifikatsattribut.',
        'Cache time in seconds for the ticket process navigation bar output module.' =>
            '',
        'Cache time in seconds for the web service config backend.' => 'Cache minne i sekunder för webbtjänsten konfiguration.',
        'Calendar manage screen.' => 'Hantera kalendrar-vy.',
        'Cancel whole escalation if ticket is in configured suspend state (EscalationSuspendStates). Ticket will not escalate at all in configured suspend state. No escalation times are shown. Ticket will not be shown in escalation view.' =>
            '',
        'Catalan' => 'Katalanska',
        'Categories used in ticket presentation. If no default color is given, item will not be shown if selection is not defined in the color hash. Optionally the attribute Text can be added to override the field value, templating methods can be used (e.g. "Text" => "[% Data.Value | remove(\'^.+::\') %]"). Link can be used the same way.' =>
            '',
        'Categories used in ticket presentation. Order is only used to determine the starting position before size arrangement. If no default color is given, item will not be shown if selection is not defined in the color hash. Optionally the attribute Text can be added to override the field value, templating methods can be used (e.g. "Text" => "[% Data.Value | remove(\'^.+::\') %]"). Link can be used the same way.' =>
            '',
        'Change Ticket' => '',
        'Change Ticket information' => '',
        'Change queue!' => 'Ändra kö!',
        'Change the customer for this ticket' => 'Byt kund för detta ärende',
        'Change the owner for this ticket' => 'Byt ansvarig handläggare för ärendet',
        'Change the priority for this ticket' => 'Ändra prioritet för detta ärende',
        'Change the responsible for this ticket' => 'Ändra ansvarige för ärendet',
        'Change your avatar image.' => '',
        'Change your password and more.' => '',
        'Changed SLA to "%s" (%s).' => '',
        'Changed archive state to "%s".' => '',
        'Changed customer to "%s".' => '',
        'Changed dynamic field %s from "%s" to "%s".' => '',
        'Changed owner to "%s" (%s).' => '',
        'Changed pending time to "%s".' => '',
        'Changed priority from "%s" (%s) to "%s" (%s).' => 'Changed priority from "%s" (%s) to "%s" (%s).',
        'Changed queue to "%s" (%s) from "%s" (%s).' => '',
        'Changed responsible to "%s" (%s).' => '',
        'Changed service to "%s" (%s).' => '',
        'Changed state from "%s" to "%s".' => '',
        'Changed title from "%s" to "%s".' => '',
        'Changed type from "%s" (%s) to "%s" (%s).' => '',
        'Changes the owner of tickets to everyone (useful for ASP). Normally only agent with rw permissions in the queue of the ticket will be shown.' =>
            '',
        'Chat communication channel.' => '',
        'Checkbox' => 'Kryssruta',
        'Checks for articles that needs to be updated in the article search index.' =>
            '',
        'Checks for communication log entries to be deleted.' => '',
        'Checks for queued outgoing emails to be sent.' => '',
        'Checks if an E-Mail is a followup to an existing ticket by searching the subject for a valid ticket number.' =>
            '',
        'Checks if an email is a follow-up to an existing ticket with external ticket number which can be found by ExternalTicketNumberRecognition filter module.' =>
            '',
        'Checks the SystemID in ticket number detection for follow-ups. If not enabled, SystemID will be changed after using the system.' =>
            '',
        'Child' => 'Barn',
        'Chinese (Simplified)' => 'Kinesiska (förenklad)',
        'Chinese (Traditional)' => 'Kinesiska (traditionell)',
        'Choose for which kind of appointment changes you want to receive notifications.' =>
            '',
        'Choose for which kind of ticket changes you want to receive notifications. Please note that you can\'t completely disable notifications marked as mandatory.' =>
            '',
        'Choose which notifications you\'d like to receive.' => '',
        'Christmas Eve' => 'Julafton',
        'Close' => 'Stäng',
        'Close this ticket' => 'Stäng detta ärende',
        'Closed Tickets' => '',
        'Closed tickets (customer user)' => 'Stängda ärenden (kundanvändare)',
        'Closed tickets (customer)' => 'Stängda ärenden (kunder)',
        'Cloud Services' => 'Molntjänster',
        'Cloud service admin module registration for the transport layer.' =>
            '',
        'Collect support data for asynchronous plug-in modules.' => '',
        'Color definitions for the customer interface.' => '',
        'Column ticket filters for Ticket Overviews type "Small".' => '',
        'Columns that can be filtered in the escalation view of the agent interface. Note: Only Ticket attributes, Dynamic Fields (DynamicField_NameX) and Customer attributes (e.g. CustomerUserPhone, CustomerCompanyName, ...) are allowed.' =>
            '',
        'Columns that can be filtered in the locked view of the agent interface. Note: Only Ticket attributes, Dynamic Fields (DynamicField_NameX) and Customer attributes (e.g. CustomerUserPhone, CustomerCompanyName, ...) are allowed.' =>
            '',
        'Columns that can be filtered in the queue view of the agent interface. Note: Only Ticket attributes, Dynamic Fields (DynamicField_NameX) and Customer attributes (e.g. CustomerUserPhone, CustomerCompanyName, ...) are allowed.' =>
            '',
        'Columns that can be filtered in the responsible view of the agent interface. Note: Only Ticket attributes, Dynamic Fields (DynamicField_NameX) and Customer attributes (e.g. CustomerUserPhone, CustomerCompanyName, ...) are allowed.' =>
            '',
        'Columns that can be filtered in the service view of the agent interface. Note: Only Ticket attributes, Dynamic Fields (DynamicField_NameX) and Customer attributes (e.g. CustomerUserPhone, CustomerCompanyName, ...) are allowed.' =>
            '',
        'Columns that can be filtered in the status view of the agent interface. Note: Only Ticket attributes, Dynamic Fields (DynamicField_NameX) and Customer attributes (e.g. CustomerUserPhone, CustomerCompanyName, ...) are allowed.' =>
            '',
        'Columns that can be filtered in the ticket search result view of the agent interface. Note: Only Ticket attributes, Dynamic Fields (DynamicField_NameX) and Customer attributes (e.g. CustomerUserPhone, CustomerCompanyName, ...) are allowed.' =>
            '',
        'Columns that can be filtered in the watch view of the agent interface. Note: Only Ticket attributes, Dynamic Fields (DynamicField_NameX) and Customer attributes (e.g. CustomerUserPhone, CustomerCompanyName, ...) are allowed.' =>
            '',
        'Comment for new history entries in the customer interface.' => '',
        'Comment2' => '',
        'Communication' => 'Kommunikation',
        'Communication & Notifications' => '',
        'Communication Log GUI' => '',
        'Communication log limit per page for Communication Log Overview.' =>
            '',
        'CommunicationLog Overview Limit' => '',
        'Company Status' => 'Organisationens status',
        'Company Tickets.' => '',
        'Company name which will be included in outgoing emails as an X-Header.' =>
            'Organisationens namn som kommer att sättas som en X-rubrik i utgående e-brev.',
        'Compat module for AgentZoom to AgentTicketZoom.' => '',
        'Complex' => '',
        'Compose' => 'Författa',
        'Configure Processes.' => '',
        'Configure and manage ACLs.' => 'Konfigurera och hantera åtkomstkonfiguration (ACL).',
        'Configure any additional readonly mirror databases that you want to use.' =>
            '',
        'Configure sending of support data to OTOBO Team for improved support.' =>
            '',
        'Configure the About information.' => '',
        'Configure the privacy policy.' => '',
        'Configure which screen should be shown after a new ticket has been created.' =>
            'Ställ in vilken vy som skall visas efter att ett nytt ärende har skapats.',
        'Configure your own log text for PGP.' => 'Ställ in egen loggningstext för PGP.',
        'Configures a default TicketDynamicField setting. "Name" defines the dynamic field which should be used, "Value" is the data that will be set, and "Event" defines the trigger event. Please check the developer manual (https://doc.otobo.org/), chapter "Ticket Event Module".' =>
            '',
        'Controls how to display the ticket history entries as readable values.' =>
            '',
        'Controls if CustomerID is automatically copied from the sender address for unknown customers.' =>
            '',
        'Controls if CustomerID is read-only in the agent interface.' => '',
        'Controls if customers have the ability to sort their tickets.' =>
            '',
        'Controls if more than one from entry can be set in the new phone ticket in the agent interface.' =>
            '',
        'Controls if the admin is allowed to import a saved system configuration in SysConfig.' =>
            'Tillåt administratören att importera sparade konfigurationsinställningar i SysConfig. ',
        'Controls if the admin is allowed to make changes to the database via AdminSelectBox.' =>
            '',
        'Controls if the autocomplete field will be used for the customer ID selection in the AdminCustomerUser interface.' =>
            '',
        'Controls if the ticket and article seen flags are removed when a ticket is archived.' =>
            '',
        'Converts HTML mails into text messages.' => '',
        'Create New process ticket.' => '',
        'Create Templates for AdminDynamicFieldTitle.' => '',
        'Create Ticket' => '',
        'Create a new calendar appointment linked to this ticket' => '',
        'Create and manage Service Level Agreements (SLAs).' => 'Skapa och hantera Servicenivåavtal (SLA).',
        'Create and manage agents.' => 'Skapa och hantera handläggare.',
        'Create and manage appointment notifications.' => '',
        'Create and manage attachments.' => 'Skapa och hantera bilagor.',
        'Create and manage calendars.' => '',
        'Create and manage customer users.' => 'Skapa och hantera kundanvändare.',
        'Create and manage customers.' => 'Skapa och hantera kunder.',
        'Create and manage dynamic fields.' => 'Skapa och hantera dynamiska fält.',
        'Create and manage groups.' => 'Skapa och hantera grupper.',
        'Create and manage queues.' => 'Skapa och hantera köer.',
        'Create and manage responses that are automatically sent.' => 'Skapa och hantera svar som skickas automatiskt.',
        'Create and manage roles.' => 'Skapa och hantera roller.',
        'Create and manage salutations.' => 'Skapa och hantera hälsningsfraser.',
        'Create and manage services.' => 'Skapa och hantera tjänster.',
        'Create and manage signatures.' => 'Skapa och hantera signaturer.',
        'Create and manage templates.' => 'Skapa och hantera mallar.',
        'Create and manage ticket notifications.' => 'Skapa och hantera ärendemeddelanden.',
        'Create and manage ticket priorities.' => 'Skapa och hantera ärendeprioriteter.',
        'Create and manage ticket states.' => 'Skapa och hantera ärendestatusar.',
        'Create and manage ticket types.' => 'Skapa och hantera ärendetyper.',
        'Create and manage web services.' => 'Skapa och hantera webbtjänster.',
        'Create new Ticket.' => 'Skapa nytt ärende.',
        'Create new appointment.' => 'Lägg till kalenderhändelse.',
        'Create new email ticket and send this out (outbound).' => '',
        'Create new email ticket.' => 'Spaka nytt e-post ärende.',
        'Create new phone ticket (inbound).' => '',
        'Create new phone ticket.' => 'Skapa nytt telefonärende.',
        'Create new process ticket.' => '',
        'Create tickets.' => 'Skapa ärenden.',
        'Create your first ticket' => 'Skapa ditt första ärende',
        'Created ticket [%s] in "%s" with priority "%s" and state "%s".' =>
            '',
        'Croatian' => '',
        'Custom RSS Feed' => '',
        'Custom text for the page shown to customers that have no tickets yet (if you need those text translated add them to a custom translation module).' =>
            '',
        'Customer Administration' => 'Kundadministration',
        'Customer Companies' => 'Kundorganisationer',
        'Customer Dashboard' => '',
        'Customer Dynamic Field Database Detailed Search' => '',
        'Customer Dynamic Field Database Details' => '',
        'Customer Dynamic Field Database Search' => '',
        'Customer IDs' => '',
        'Customer Information Center Search.' => '',
        'Customer Information Center search.' => '',
        'Customer Information Center.' => '',
        'Customer Password.' => '',
        'Customer Ticket Print Module.' => '',
        'Customer User Administration' => 'Hantera kundanvändare',
        'Customer User Information' => '',
        'Customer User Information Center Search.' => '',
        'Customer User Information Center search.' => '',
        'Customer User Information Center.' => '',
        'Customer Users ↔ Customers' => '',
        'Customer Users ↔ Groups' => '',
        'Customer Users ↔ Services' => '',
        'Customer dynamic field database detailed search.' => '',
        'Customer dynamic field database details.' => '',
        'Customer dynamic field database search.' => '',
        'Customer item (icon) which shows the closed tickets of this customer as info block. Setting CustomerUserLogin to 1 searches for tickets based on login name rather than CustomerID.' =>
            '',
        'Customer item (icon) which shows the open tickets of this customer as info block. Setting CustomerUserLogin to 1 searches for tickets based on login name rather than CustomerID.' =>
            '',
        'Customer preferences.' => '',
        'Customer ticket overview' => '',
        'Customer ticket search.' => '',
        'Customer ticket zoom' => '',
        'Customer user search' => 'Sök på kundanvändare',
        'CustomerID search' => 'Sök på kund-ID',
        'CustomerName' => 'Kundens namn',
        'CustomerUser' => '',
        'Customers ↔ Groups' => '',
        'Customizable stop words for fulltext index. These words will be removed from the search index.' =>
            '',
        'Czech' => 'Tjeckiska',
        'Danish' => 'Danska',
        'Dashboard overview.' => '',
        'Data used to export the search result in CSV format.' => 'Data för sökresultatsexporten i CSV-format.',
        'Date / Time' => 'Datum/tid',
        'Default (Slim)' => '',
        'Default ACL values for ticket actions.' => '',
        'Default ProcessManagement entity prefixes for entity IDs that are automatically generated.' =>
            '',
        'Default agent name' => '',
        'Default data to use on attribute for ticket search screen. Example: "TicketCreateTimePointFormat=year;TicketCreateTimePointStart=Last;TicketCreateTimePoint=2;".' =>
            '',
        'Default data to use on attribute for ticket search screen. Example: "TicketCreateTimeStartYear=2010;TicketCreateTimeStartMonth=10;TicketCreateTimeStartDay=4;TicketCreateTimeStopYear=2010;TicketCreateTimeStopMonth=11;TicketCreateTimeStopDay=3;".' =>
            '',
        'Default display type for recipient (To,Cc) names in AgentTicketZoom and CustomerTicketZoom.' =>
            '',
        'Default display type for sender (From) names in AgentTicketZoom and CustomerTicketZoom.' =>
            '',
        'Default loop protection module.' => '',
        'Default queue ID used by the system in the agent interface.' => 'Kö-ID:t som används som standard i handläggargränssnittet.',
        'Default skin for the agent interface (slim version).' => '',
        'Default skin for the agent interface.' => '',
        'Default skin for the customer interface.' => 'Standardtema för kundgränssnittet.',
        'Default ticket ID used by the system in the agent interface.' =>
            'Ärende-ID-typ som används som standard i handläggargränssnittet.',
        'Default ticket ID used by the system in the customer interface.' =>
            'Ärende-ID att användas av OTOBO-installationen i kundgränssnittet.',
        'Default value for NameX' => '',
        'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js.' =>
            '',
        'Define a filter for html output to add links behind a defined string. The element Image allows two input kinds. At once the name of an image (e.g. faq.png). In this case the OTOBO image path will be used. The second possiblity is to insert the link to the image.' =>
            '',
        'Define a mapping between variables of the customer user data (keys) and dynamic fields of a ticket (values). The purpose is to store customer user data in ticket dynamic fields. The dynamic fields must be present in the system and should be enabled for AgentTicketFreeText, so that they can be set/updated manually by the agent. They mustn\'t be enabled for AgentTicketPhone, AgentTicketEmail and AgentTicketCustomer. If they were, they would have precedence over the automatically set values. To use this mapping, you have to also activate the Ticket::EventModulePost###4100-DynamicFieldFromCustomerUser setting.' =>
            '',
        'Define a result field for the TicketID of the invoker response per web service (WebserviceID => DynamicFieldName).' =>
            '',
        'Define dynamic field name for end time. This field has to be manually added to the system as Ticket: "Date / Time" and must be activated in ticket creation screens and/or in any other ticket action screens.' =>
            '',
        'Define dynamic field name for start time. This field has to be manually added to the system as Ticket: "Date / Time" and must be activated in ticket creation screens and/or in any other ticket action screens.' =>
            '',
        'Define the max depth of queues.' => '',
        'Define the queue comment 2.' => '',
        'Define the service comment 2.' => '',
        'Define the sla comment 2.' => '',
        'Define the start day of the week for the date picker for the indicated calendar.' =>
            '',
        'Define the start day of the week for the date picker.' => '',
        'Define which avatar default image should be used for the article view if no gravatar is assigned to the mail address. Check https://gravatar.com/site/implement/images/ for further information.' =>
            '',
        'Define which avatar default image should be used for the current agent if no gravatar is assigned to the mail address of the agent. Check https://gravatar.com/site/implement/images/ for further information.' =>
            '',
        'Define which avatar engine should be used for the agent avatar on the header and the sender images in AgentTicketZoom. If \'None\' is selected, initials will be displayed instead. Please note that selecting anything other than \'None\' will transfer the encrypted email address of the particular user to an external service.' =>
            '',
        'Define which columns are shown in the linked appointment widget (LinkObject::ViewMode = "complex"). Possible settings: 0 = Disabled, 1 = Available, 2 = Enabled by default.' =>
            '',
        'Define which columns are shown in the linked tickets widget (LinkObject::ViewMode = "complex"). Note: Only Ticket attributes and Dynamic Fields (DynamicField_NameX) are allowed for DefaultColumns.' =>
            '',
        'Defines a customer item, which generates a LinkedIn icon at the end of a customer info block.' =>
            '',
        'Defines a customer item, which generates a XING icon at the end of a customer info block.' =>
            '',
        'Defines a customer item, which generates a google icon at the end of a customer info block.' =>
            '',
        'Defines a customer item, which generates a google maps icon at the end of a customer info block.' =>
            '',
        'Defines a filter for html output to add links behind CVE numbers. The element Image allows two input kinds. At once the name of an image (e.g. faq.png). In this case the OTOBO image path will be used. The second possiblity is to insert the link to the image.' =>
            '',
        'Defines a filter for html output to add links behind MSBulletin numbers. The element Image allows two input kinds. At once the name of an image (e.g. faq.png). In this case the OTOBO image path will be used. The second possiblity is to insert the link to the image.' =>
            '',
        'Defines a filter for html output to add links behind a defined string. The element Image allows two input kinds. At once the name of an image (e.g. faq.png). In this case the OTOBO image path will be used. The second possiblity is to insert the link to the image.' =>
            '',
        'Defines a filter for html output to add links behind bugtraq numbers. The element Image allows two input kinds. At once the name of an image (e.g. faq.png). In this case the OTOBO image path will be used. The second possiblity is to insert the link to the image.' =>
            '',
        'Defines a filter to collect CVE numbers from article texts in AgentTicketZoom. The results will be displayed in a meta box next to the article. Fill in URLPreview if you would like to see a preview when moving your mouse cursor above the link element. This could be the same URL as in URL, but also an alternate one. Please note that some websites deny being displayed within an iframe (e.g. Google) and thus won\'t work with the preview mode.' =>
            '',
        'Defines a filter to process the text in the articles, in order to highlight predefined keywords.' =>
            '',
        'Defines a permission context for customer to group assignment.' =>
            '',
        'Defines a regular expression that excludes some addresses from the syntax check (if "CheckEmailAddresses" is set to "Yes"). Please enter a regex in this field for email addresses, that aren\'t syntactically valid, but are necessary for the system (i.e. "root@localhost").' =>
            '',
        'Defines a regular expression that filters all email addresses that should not be used in the application.' =>
            '',
        'Defines a sleep time in microseconds between tickets while they are been processed by a job.' =>
            '',
        'Defines a useful module to load specific user options or to display news.' =>
            '',
        'Defines all the X-headers that should be scanned.' => '',
        'Defines all the languages that are available to the application. Specify only English names of languages here.' =>
            '',
        'Defines all the languages that are available to the application. Specify only native names of languages here.' =>
            '',
        'Defines all the parameters for the RefreshTime object in the customer preferences of the customer interface.' =>
            '',
        'Defines all the parameters for the ShownTickets object in the customer preferences of the customer interface.' =>
            '',
        'Defines all the parameters for this item in the customer preferences.' =>
            '',
        'Defines all the parameters for this item in the customer preferences. \'PasswordRegExp\' allows to match passwords against a regular expression. Define the minimum number of characters using \'PasswordMinSize\'. Define if at least 2 lowercase and 2 uppercase letter characters are needed by setting the appropriate option to \'1\'. \'PasswordMin2Characters\' defines if the password needs to contain at least 2 letter characters (set to 0 or 1). \'PasswordNeedDigit\' controls the need of at least 1 digit (set to 0 or 1 to control).' =>
            '',
        'Defines all the parameters for this notification transport.' => '',
        'Defines all the possible stats output formats.' => '',
        'Defines an alternate URL, where the login link refers to.' => '',
        'Defines an alternate URL, where the logout link refers to.' => '',
        'Defines an alternate login URL for the customer panel..' => '',
        'Defines an alternate logout URL for the customer panel.' => '',
        'Defines an external link to the database of the customer (e.g. \'http://yourhost/customer.php?CID=[% Data.CustomerID %]\' or \'\').' =>
            '',
        'Defines an icon with link to the google map page of the current location in appointment edit screen.' =>
            '',
        'Defines an overview module to show the address book view of a customer user list.' =>
            '',
        'Defines available article actions for Chat articles.' => '',
        'Defines available article actions for Email articles.' => '',
        'Defines available article actions for Internal articles.' => '',
        'Defines available article actions for Phone articles.' => '',
        'Defines available article actions for invalid articles.' => '',
        'Defines available groups for the admin overview screen.' => '',
        'Defines chat communication channel.' => '',
        'Defines default headers for outgoing emails.' => '',
        'Defines email communication channel.' => '',
        'Defines from which ticket attributes the agent can select the result order.' =>
            '',
        'Defines groups for preferences items.' => '',
        'Defines how many deployments the system should keep.' => '',
        'Defines how the From field from the emails (sent from answers and email tickets) should look like.' =>
            '',
        'Defines if a pre-sorting by priority should be done in the queue view.' =>
            '',
        'Defines if a pre-sorting by priority should be done in the service view.' =>
            '',
        'Defines if a ticket lock is required for the quick close.' => '',
        'Defines if a ticket lock is required in the close ticket screen of the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            '',
        'Defines if a ticket lock is required in the email outbound screen of the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            '',
        'Defines if a ticket lock is required in the email resend screen of the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            '',
        'Defines if a ticket lock is required in the ticket bounce screen of the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            '',
        'Defines if a ticket lock is required in the ticket compose screen of the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            '',
        'Defines if a ticket lock is required in the ticket forward screen of the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            '',
        'Defines if a ticket lock is required in the ticket free text screen of the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            '',
        'Defines if a ticket lock is required in the ticket merge screen of a zoomed ticket in the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            '',
        'Defines if a ticket lock is required in the ticket note screen of the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            '',
        'Defines if a ticket lock is required in the ticket owner screen of a zoomed ticket in the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            '',
        'Defines if a ticket lock is required in the ticket pending screen of a zoomed ticket in the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            '',
        'Defines if a ticket lock is required in the ticket phone inbound screen of the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            '',
        'Defines if a ticket lock is required in the ticket phone outbound screen of the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            '',
        'Defines if a ticket lock is required in the ticket priority screen of a zoomed ticket in the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            '',
        'Defines if a ticket lock is required in the ticket responsible screen of the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            '',
        'Defines if a ticket lock is required to change the customer of a ticket in the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            '',
        'Defines if agents should be allowed to login if they have no shared secret stored in their preferences and therefore are not using two-factor authentication.' =>
            '',
        'Defines if customers should be allowed to login if they have no shared secret stored in their preferences and therefore are not using two-factor authentication.' =>
            '',
        'Defines if the communication between this system and the servers that provide cloud services is possible. If set to \'Disable cloud services\', some functionality will be lost such as support data sending, Package Verify™ and product News dashboard widgets, among others.' =>
            '',
        'Defines if the enhanced mode should be used (enables use of table, replace, subscript, superscript, paste from word, etc.) in customer interface.' =>
            '',
        'Defines if the enhanced mode should be used (enables use of table, replace, subscript, superscript, paste from word, etc.).' =>
            '',
        'Defines if the first article should be displayed as expanded, that is visible for the related customer. If nothing defined, latest article will be expanded.' =>
            '',
        'Defines if the message in the email outbound screen of the agent interface is visible for the customer by default.' =>
            '',
        'Defines if the message in the email resend screen of the agent interface is visible for the customer by default.' =>
            '',
        'Defines if the message in the ticket compose screen of the agent interface is visible for the customer by default.' =>
            '',
        'Defines if the message in the ticket forward screen of the agent interface is visible for the customer by default.' =>
            '',
        'Defines if the note in the close ticket screen of the agent interface is visible for the customer by default.' =>
            '',
        'Defines if the note in the ticket bulk screen of the agent interface is visible for the customer by default.' =>
            '',
        'Defines if the note in the ticket free text screen of the agent interface is visible for the customer by default.' =>
            '',
        'Defines if the note in the ticket note screen of the agent interface is visible for the customer by default.' =>
            '',
        'Defines if the note in the ticket owner screen of the agent interface is visible for the customer by default.' =>
            '',
        'Defines if the note in the ticket pending screen of the agent interface is visible for the customer by default.' =>
            '',
        'Defines if the note in the ticket priority screen of the agent interface is visible for the customer by default.' =>
            '',
        'Defines if the note in the ticket responsible screen of the agent interface is visible for the customer by default.' =>
            '',
        'Defines if the previously valid token should be accepted for authentication. This is slightly less secure but gives users 30 seconds more time to enter their one-time password.' =>
            '',
        'Defines if the values for filters should be retrieved from all available tickets. If enabled, only values which are actually used in any ticket will be available for filtering. Please note: The list of customers will always be retrieved like this.' =>
            '',
        'Defines if time accounting is mandatory in the agent interface. If enabled, a note must be entered for all ticket actions (no matter if the note itself is configured as active or is originally mandatory for the individual ticket action screen).' =>
            '',
        'Defines if time accounting must be set to all tickets in bulk action.' =>
            '',
        'Defines internal communication channel.' => '',
        'Defines out of office message template. Two string parameters (%s) available: end date and number of days left.' =>
            '',
        'Defines phone communication channel.' => '',
        'Defines queues that\'s tickets are used for displaying as calendar events.' =>
            'Köer vars ärenden visas som kalenderhändelser.',
        'Defines the HTTP hostname for the support data collection with the public module \'PublicSupportDataCollector\' (e.g. used from the OTOBO Daemon).' =>
            '',
        'Defines the IP regular expression for accessing the local repository. You need to enable this to have access to your local repository and the package::RepositoryList is required on the remote host.' =>
            '',
        'Defines the PostMaster header to be used on the filter for keeping the current state of the ticket.' =>
            '',
        'Defines the URL CSS path.' => '',
        'Defines the URL base path of icons, CSS and Java Script.' => '',
        'Defines the URL image path of icons for navigation.' => '',
        'Defines the URL java script path.' => '',
        'Defines the URL rich text editor path.' => '',
        'Defines the address of a dedicated DNS server, if necessary, for the "CheckMXRecord" look-ups.' =>
            '',
        'Defines the agent preferences key where the shared secret key is stored.' =>
            '',
        'Defines the available steps in time selections. Select "Minute" to be able to select all minutes of one hour from 1-59. Select "30 Minutes" to only make full and half hours available.' =>
            '',
        'Defines the body for the quick close action, which gets used for ticket history in the agent interface.' =>
            '',
        'Defines the body text for notification mails sent to agents, about new password.' =>
            '',
        'Defines the body text for notification mails sent to agents, with token about new requested password.' =>
            '',
        'Defines the body text for notification mails sent to customers, about new account.' =>
            '',
        'Defines the body text for notification mails sent to customers, about new password.' =>
            '',
        'Defines the body text for notification mails sent to customers, with token about new requested password.' =>
            '',
        'Defines the body text for rejected emails.' => '',
        'Defines the calendar width in percent. Default is 95%.' => '',
        'Defines the close state for quick close.' => '',
        'Defines the column to store the keys for the preferences table.' =>
            '',
        'Defines the communication chanel for the quick close article action.' =>
            '',
        'Defines the config options for the autocompletion feature.' => 'Konfigueringsalternativ för autocomplete-funktionen.',
        'Defines the config parameters of this item, to be shown in the preferences view.' =>
            '',
        'Defines the config parameters of this item, to be shown in the preferences view. \'PasswordRegExp\' allows to match passwords against a regular expression. Define the minimum number of characters using \'PasswordMinSize\'. Define if at least 2 lowercase and 2 uppercase letter characters are needed by setting the appropriate option to \'1\'. \'PasswordMin2Characters\' defines if the password needs to contain at least 2 letter characters (set to 0 or 1). \'PasswordNeedDigit\' controls the need of at least 1 digit (set to 0 or 1 to control). \'PasswordMaxLoginFailed\' allows to set an agent to invalid-temporarily if max failed logins reached. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.' =>
            '',
        'Defines the config parameters of this item, to be shown in the preferences view. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.' =>
            '',
        'Defines the connections for http/ftp, via a proxy.' => '',
        'Defines the customer preferences key where the shared secret key is stored.' =>
            '',
        'Defines the date input format used in forms (option or input fields).' =>
            '',
        'Defines the default CSS used in rich text editors.' => '',
        'Defines the default agent name in the ticket zoom view of the customer interface.' =>
            '',
        'Defines the default auto response type of the article for this operation.' =>
            '',
        'Defines the default body of a note in the ticket free text screen of the agent interface.' =>
            '',
        'Defines the default filter fields in the customer user address book search (CustomerUser or CustomerCompany). For the CustomerCompany fields a prefix \'CustomerCompany_\' must be added.' =>
            '',
        'Defines the default frontend (HTML) theme to be used by the agents and customers. If you like, you can add your own theme. Please refer the administrator manual located at https://doc.otobo.org/.' =>
            '',
        'Defines the default frontend language. All the possible values are determined by the available language files on the system. These values are listed as the keys in the setting \'DefaultUsedLanguages\'.' =>
            '',
        'Defines the default history type in the customer interface.' => '',
        'Defines the default interface. Unknown pathes below the script alias are redirected to the selected interface.' =>
            '',
        'Defines the default maximum number of X-axis attributes for the time scale.' =>
            '',
        'Defines the default maximum number of statistics per page on the overview screen.' =>
            '',
        'Defines the default next state for a ticket after customer follow-up in the customer interface.' =>
            '',
        'Defines the default next state of a ticket after adding a note, in the close ticket screen of the agent interface.' =>
            '',
        'Defines the default next state of a ticket after adding a note, in the ticket free text screen of the agent interface.' =>
            '',
        'Defines the default next state of a ticket after adding a note, in the ticket note screen of the agent interface.' =>
            '',
        'Defines the default next state of a ticket after adding a note, in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            '',
        'Defines the default next state of a ticket after adding a note, in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            '',
        'Defines the default next state of a ticket after adding a note, in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            '',
        'Defines the default next state of a ticket after adding a note, in the ticket responsible screen of the agent interface.' =>
            '',
        'Defines the default next state of a ticket after being bounced, in the ticket bounce screen of the agent interface.' =>
            '',
        'Defines the default next state of a ticket after being forwarded, in the ticket forward screen of the agent interface.' =>
            '',
        'Defines the default next state of a ticket after the message has been sent, in the email outbound screen of the agent interface.' =>
            '',
        'Defines the default next state of a ticket if it is composed / answered in the ticket compose screen of the agent interface.' =>
            '',
        'Defines the default next state of a ticket, in the ticket bulk screen of the agent interface.' =>
            '',
        'Defines the default note body text for phone tickets in the ticket phone inbound screen of the agent interface.' =>
            '',
        'Defines the default note body text for phone tickets in the ticket phone outbound screen of the agent interface.' =>
            '',
        'Defines the default priority of follow-up customer tickets in the ticket zoom screen in the customer interface.' =>
            '',
        'Defines the default priority of new customer tickets in the customer interface.' =>
            '',
        'Defines the default priority of new tickets.' => 'Prioritetsvärdet för nya ärenden.',
        'Defines the default queue for new customer tickets in the customer interface.' =>
            '',
        'Defines the default queue for new tickets in the agent interface.' =>
            '',
        'Defines the default selection at the drop down menu for dynamic objects (Form: Common Specification).' =>
            '',
        'Defines the default selection at the drop down menu for permissions (Form: Common Specification).' =>
            '',
        'Defines the default selection at the drop down menu for stats format (Form: Common Specification). Please insert the format key (see Stats::Format).' =>
            '',
        'Defines the default sender type for phone tickets in the ticket phone inbound screen of the agent interface.' =>
            '',
        'Defines the default sender type for phone tickets in the ticket phone outbound screen of the agent interface.' =>
            '',
        'Defines the default sender type for tickets in the ticket zoom screen of the customer interface.' =>
            '',
        'Defines the default shown ticket search attribute for ticket search screen (AllTickets/ArchivedTickets/NotArchivedTickets).' =>
            '',
        'Defines the default shown ticket search attribute for ticket search screen.' =>
            '',
        'Defines the default shown ticket search attribute for ticket search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.' =>
            '',
        'Defines the default sort criteria for all queues displayed in the queue view.' =>
            '',
        'Defines the default sort criteria for all services displayed in the service view.' =>
            '',
        'Defines the default sort order for all queues in the queue view, after priority sort.' =>
            '',
        'Defines the default sort order for all services in the service view, after priority sort.' =>
            '',
        'Defines the default state of new customer tickets in the customer interface.' =>
            '',
        'Defines the default state of new tickets.' => '',
        'Defines the default subject for phone tickets in the ticket phone inbound screen of the agent interface.' =>
            '',
        'Defines the default subject for phone tickets in the ticket phone outbound screen of the agent interface.' =>
            '',
        'Defines the default subject of a note in the ticket free text screen of the agent interface.' =>
            '',
        'Defines the default the number of seconds (from current time) to re-schedule a generic interface failed task.' =>
            '',
        'Defines the default ticket attribute for ticket sorting in a ticket search of the customer interface.' =>
            '',
        'Defines the default ticket attribute for ticket sorting in the escalation view of the agent interface.' =>
            '',
        'Defines the default ticket attribute for ticket sorting in the locked ticket view of the agent interface.' =>
            '',
        'Defines the default ticket attribute for ticket sorting in the responsible view of the agent interface.' =>
            '',
        'Defines the default ticket attribute for ticket sorting in the status view of the agent interface.' =>
            '',
        'Defines the default ticket attribute for ticket sorting in the watch view of the agent interface.' =>
            '',
        'Defines the default ticket attribute for ticket sorting of the ticket search result of the agent interface.' =>
            '',
        'Defines the default ticket attribute for ticket sorting of the ticket search result of this operation.' =>
            '',
        'Defines the default ticket bounced notification for customer/sender in the ticket bounce screen of the agent interface.' =>
            '',
        'Defines the default ticket next state after adding a phone note in the ticket phone inbound screen of the agent interface.' =>
            '',
        'Defines the default ticket next state after adding a phone note in the ticket phone outbound screen of the agent interface.' =>
            '',
        'Defines the default ticket order (after priority sort) in the escalation view of the agent interface. Up: oldest on top. Down: latest on top.' =>
            '',
        'Defines the default ticket order (after priority sort) in the status view of the agent interface. Up: oldest on top. Down: latest on top.' =>
            '',
        'Defines the default ticket order in the responsible view of the agent interface. Up: oldest on top. Down: latest on top.' =>
            '',
        'Defines the default ticket order in the ticket locked view of the agent interface. Up: oldest on top. Down: latest on top.' =>
            '',
        'Defines the default ticket order in the ticket search result of the agent interface. Up: oldest on top. Down: latest on top.' =>
            '',
        'Defines the default ticket order in the ticket search result of the this operation. Up: oldest on top. Down: latest on top.' =>
            '',
        'Defines the default ticket order in the watch view of the agent interface. Up: oldest on top. Down: latest on top.' =>
            '',
        'Defines the default ticket order of a search result in the customer interface. Up: oldest on top. Down: latest on top.' =>
            '',
        'Defines the default ticket priority in the close ticket screen of the agent interface.' =>
            '',
        'Defines the default ticket priority in the ticket bulk screen of the agent interface.' =>
            '',
        'Defines the default ticket priority in the ticket free text screen of the agent interface.' =>
            '',
        'Defines the default ticket priority in the ticket note screen of the agent interface.' =>
            '',
        'Defines the default ticket priority in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            '',
        'Defines the default ticket priority in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            '',
        'Defines the default ticket priority in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            '',
        'Defines the default ticket priority in the ticket responsible screen of the agent interface.' =>
            '',
        'Defines the default ticket type for new customer tickets in the customer interface.' =>
            '',
        'Defines the default ticket type.' => '',
        'Defines the default used Frontend-Module if no Action parameter given in the url on the agent interface.' =>
            '',
        'Defines the default used Frontend-Module if no Action parameter given in the url on the customer interface.' =>
            '',
        'Defines the default value for the action parameter for the public frontend. The action parameter is used in the scripts of the system.' =>
            '',
        'Defines the default viewable sender types of a ticket (default: customer).' =>
            '',
        'Defines the default visibility of the article to customer for this operation.' =>
            '',
        'Defines the displayed style of the From field in notes that are visible for customers. A default agent name can be defined in Ticket::Frontend::CustomerTicketZoom###DefaultAgentName setting.' =>
            '',
        'Defines the dynamic fields that are used for displaying on calendar events.' =>
            '',
        'Defines the event object types that will be handled via AdminAppointmentNotificationEvent.' =>
            '',
        'Defines the fall-back path to open fetchmail binary. Note: The name of the binary needs to be \'fetchmail\', if it is different please use a symbolic link.' =>
            '',
        'Defines the filter that processes the HTML templates.' => '',
        'Defines the filter that processes the text in the articles, in order to highlight URLs.' =>
            '',
        'Defines the format of responses in the ticket compose screen of the agent interface ([% Data.OrigFrom | html %] is From 1:1, [% Data.OrigFromName | html %] is only realname of From).' =>
            '',
        'Defines the fully qualified domain name of the system. This setting is used as a variable, OTOBO_CONFIG_FQDN which is found in all forms of messaging used by the application, to build links to the tickets within your system.' =>
            '',
        'Defines the groups every customer user will be in (if CustomerGroupSupport is enabled and you don\'t want to manage every customer user for these groups).' =>
            '',
        'Defines the groups every customer will be in (if CustomerGroupSupport is enabled and you don\'t want to manage every customer for these groups).' =>
            '',
        'Defines the headers which will be shown to generic content for the requested key.' =>
            '',
        'Defines the height for the rich text editor component for this screen. Enter number (pixels) or percent value (relative).' =>
            '',
        'Defines the height for the rich text editor component. Enter number (pixels) or percent value (relative).' =>
            '',
        'Defines the history comment for the close ticket screen action, which gets used for ticket history in the agent interface.' =>
            '',
        'Defines the history comment for the email ticket screen action, which gets used for ticket history in the agent interface.' =>
            '',
        'Defines the history comment for the phone ticket screen action, which gets used for ticket history in the agent interface.' =>
            '',
        'Defines the history comment for the ticket free text screen action, which gets used for ticket history.' =>
            '',
        'Defines the history comment for the ticket note screen action, which gets used for ticket history in the agent interface.' =>
            '',
        'Defines the history comment for the ticket owner screen action, which gets used for ticket history in the agent interface.' =>
            '',
        'Defines the history comment for the ticket pending screen action, which gets used for ticket history in the agent interface.' =>
            '',
        'Defines the history comment for the ticket phone inbound screen action, which gets used for ticket history in the agent interface.' =>
            '',
        'Defines the history comment for the ticket phone outbound screen action, which gets used for ticket history in the agent interface.' =>
            '',
        'Defines the history comment for the ticket priority screen action, which gets used for ticket history in the agent interface.' =>
            '',
        'Defines the history comment for the ticket responsible screen action, which gets used for ticket history in the agent interface.' =>
            '',
        'Defines the history comment for the ticket zoom action, which gets used for ticket history in the customer interface.' =>
            '',
        'Defines the history comment for this operation, which gets used for ticket history in the agent interface.' =>
            '',
        'Defines the history type for the close ticket screen action, which gets used for ticket history in the agent interface.' =>
            '',
        'Defines the history type for the email ticket screen action, which gets used for ticket history in the agent interface.' =>
            '',
        'Defines the history type for the phone ticket screen action, which gets used for ticket history in the agent interface.' =>
            '',
        'Defines the history type for the ticket free text screen action, which gets used for ticket history.' =>
            '',
        'Defines the history type for the ticket note screen action, which gets used for ticket history in the agent interface.' =>
            '',
        'Defines the history type for the ticket owner screen action, which gets used for ticket history in the agent interface.' =>
            '',
        'Defines the history type for the ticket pending screen action, which gets used for ticket history in the agent interface.' =>
            '',
        'Defines the history type for the ticket phone inbound screen action, which gets used for ticket history in the agent interface.' =>
            '',
        'Defines the history type for the ticket phone outbound screen action, which gets used for ticket history in the agent interface.' =>
            '',
        'Defines the history type for the ticket priority screen action, which gets used for ticket history in the agent interface.' =>
            '',
        'Defines the history type for the ticket responsible screen action, which gets used for ticket history in the agent interface.' =>
            '',
        'Defines the history type for the ticket zoom action, which gets used for ticket history in the customer interface.' =>
            '',
        'Defines the history type for this operation, which gets used for ticket history in the agent interface.' =>
            '',
        'Defines the hours and week days of the indicated calendar, to count the working time.' =>
            '',
        'Defines the hours and week days to count the working time.' => '',
        'Defines the key to be checked with Kernel::Modules::AgentInfo module. If this user preferences key is true, the message is accepted by the system.' =>
            '',
        'Defines the key to check with CustomerAccept. If this user preferences key is true, then the message is accepted by the system.' =>
            '',
        'Defines the link type \'Normal\'. If the source name and the target name contain the same value, the resulting link is a non-directional one; otherwise, the result is a directional link.' =>
            '',
        'Defines the link type \'ParentChild\'. If the source name and the target name contain the same value, the resulting link is a non-directional one; otherwise, the result is a directional link.' =>
            '',
        'Defines the link type groups. The link types of the same group cancel one another. Example: If ticket A is linked per a \'Normal\' link with ticket B, then these tickets could not be additionally linked with link of a \'ParentChild\' relationship.' =>
            '',
        'Defines the list of online repositories. Another installations can be used as repository, for example: Key="http://example.com/otobo/public.pl?Action=PublicRepository;File=" and Content="Some Name".' =>
            '',
        'Defines the list of params that can be passed to ticket search function.' =>
            '',
        'Defines the list of possible next actions on an error screen, a full path is required, then is possible to add external links if needed.' =>
            '',
        'Defines the list of types for templates.' => '',
        'Defines the location to get online repository list for additional packages. The first available result will be used.' =>
            '',
        'Defines the log module for the system. "File" writes all messages in a given logfile, "SysLog" uses the syslog daemon of the system, e.g. syslogd.' =>
            '',
        'Defines the maximal size (in bytes) for file uploads via the browser. Warning: Setting this option to a value which is too low could cause many masks in your OTOBO instance to stop working (probably any mask which takes input from the user).' =>
            '',
        'Defines the maximal valid time (in seconds) for a session id.' =>
            '',
        'Defines the maximum number of affected tickets per job.' => '',
        'Defines the maximum number of pages per PDF file.' => '',
        'Defines the maximum number of quoted lines to be added to responses.' =>
            '',
        'Defines the maximum number of tasks to be executed as the same time.' =>
            '',
        'Defines the maximum size (in MB) of the log file.' => '',
        'Defines the maximum size in KiloByte of GenericInterface responses that get logged to the gi_debugger_entry_content table.' =>
            '',
        'Defines the module that shows all the currently logged in agents in the agent interface.' =>
            '',
        'Defines the module that shows all the currently logged in customers in the agent interface.' =>
            '',
        'Defines the module that shows the currently logged in agents in the customer interface.' =>
            '',
        'Defines the module that shows the currently logged in customers in the customer interface.' =>
            '',
        'Defines the module to authenticate customers.' => '',
        'Defines the module to display a notification in the agent interface if the OTOBO Daemon is not running.' =>
            '',
        'Defines the module to display a notification in the agent interface if the system configuration is out of sync.' =>
            '',
        'Defines the module to display a notification in the agent interface, if the agent has not yet selected a time zone.' =>
            '',
        'Defines the module to display a notification in the agent interface, if the agent is logged in while having out-of-office active.' =>
            '',
        'Defines the module to display a notification in the agent interface, if the agent is logged in while having system maintenance active.' =>
            '',
        'Defines the module to display a notification in the agent interface, if the agent session limit prior warning is reached.' =>
            '',
        'Defines the module to display a notification in the agent interface, if the system is used by the admin user (normally you shouldn\'t work as admin).' =>
            '',
        'Defines the module to display a notification in the agent interface, if there are invalid sysconfig settings deployed.' =>
            '',
        'Defines the module to display a notification in the agent interface, if there are modified sysconfig settings that are not deployed yet.' =>
            '',
        'Defines the module to display a notification in the customer interface, if the customer is logged in while having system maintenance active.' =>
            '',
        'Defines the module to display a notification in the customer interface, if the customer user has not yet selected a time zone.' =>
            '',
        'Defines the module to generate code for periodic page reloads.' =>
            '',
        'Defines the module to send emails. "DoNotSendEmail" doesn\'t send emails at all. Any of the "SMTP" mechanisms use a specified (external) mailserver. "Sendmail" directly uses the sendmail binary of your operating system. "Test" doesn\'t send emails, but writes them to $OTOBO_HOME/var/tmp/CacheFileStorable/EmailTest/ for testing purposes.' =>
            '',
        'Defines the module used to store the session data. With "DB" the frontend server can be splitted from the db server. "FS" is faster.' =>
            '',
        'Defines the modules in Kernel/Output/HTML/GenericContent/ which provide the inner content to the chosen key.' =>
            '',
        'Defines the name of the application, shown in the web interface, tabs and title bar of the web browser.' =>
            '',
        'Defines the name of the column to store the data in the preferences table.' =>
            '',
        'Defines the name of the column to store the user identifier in the preferences table.' =>
            '',
        'Defines the name of the indicated calendar.' => '',
        'Defines the name of the key for customer sessions.' => '',
        'Defines the name of the session key. E.g. Session, SessionID or OTOBO.' =>
            '',
        'Defines the name of the table where the user preferences are stored.' =>
            '',
        'Defines the next possible states after composing / answering a ticket in the ticket compose screen of the agent interface.' =>
            '',
        'Defines the next possible states after forwarding a ticket in the ticket forward screen of the agent interface.' =>
            '',
        'Defines the next possible states after sending a message in the email outbound screen of the agent interface.' =>
            '',
        'Defines the next possible states for customer tickets in the customer interface.' =>
            '',
        'Defines the next state of a ticket after adding a note, in the close ticket screen of the agent interface.' =>
            '',
        'Defines the next state of a ticket after adding a note, in the ticket free text screen of the agent interface.' =>
            '',
        'Defines the next state of a ticket after adding a note, in the ticket note screen of the agent interface.' =>
            '',
        'Defines the next state of a ticket after adding a note, in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            '',
        'Defines the next state of a ticket after adding a note, in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            '',
        'Defines the next state of a ticket after adding a note, in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            '',
        'Defines the next state of a ticket after adding a note, in the ticket responsible screen of the agent interface.' =>
            '',
        'Defines the next state of a ticket after being bounced, in the ticket bounce screen of the agent interface.' =>
            '',
        'Defines the next state of a ticket after being moved to another queue, in the move ticket screen of the agent interface.' =>
            '',
        'Defines the next state of a ticket, in the ticket bulk screen of the agent interface.' =>
            '',
        'Defines the number of character per line used in case an HTML article preview replacement on TemplateGenerator for EventNotifications.' =>
            '',
        'Defines the number of days to keep the daemon log files.' => '',
        'Defines the number of header fields in frontend modules for add and update postmaster filters. It can be up to 99 fields.' =>
            '',
        'Defines the number of hours a communication will be stored, whichever its status.' =>
            '',
        'Defines the number of hours a successful communication will be stored.' =>
            '',
        'Defines the number of tickets shown in the widget.' => '',
        'Defines the parameters for the customer preferences table.' => '',
        'Defines the parameters for the dashboard backend. "Cmd" is used to specify command with parameters. "Group" is used to restrict access to the plugin (e. g. Group: admin;group1;group2;). "Default" indicates if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTL" indicates the cache expiration period in minutes for the plugin. "Mandatory" determines if the plugin is always shown and can not be removed by agents. Only works if DashboardBackend::AllowCmdOutput is enabled in Config.pm.' =>
            '',
        'Defines the parameters for the dashboard backend. "Group" is used to restrict access to the plugin (e. g. Group: admin;group1;group2;). "Default" indicates if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTL" indicates the cache expiration period in minutes for the plugin. "Mandatory" determines if the plugin is always shown and can not be removed by agents.' =>
            '',
        'Defines the parameters for the dashboard backend. "Limit" defines the number of entries displayed by default. "Group" is used to restrict access to the plugin (e. g. Group: admin;group1;group2;). "Default" indicates if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTL" indicates the cache expiration period in minutes for the plugin. "Mandatory" determines if the plugin is always shown and can not be removed by agents.' =>
            '',
        'Defines the parameters for the dashboard backend. "Limit" defines the number of entries displayed by default. "Group" is used to restrict access to the plugin (e. g. Group: admin;group1;group2;). "Default" indicates if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" defines the cache expiration period in minutes for the plugin. "Mandatory" determines if the plugin is always shown and can not be removed by agents.' =>
            '',
        'Defines the path and TTF-File to handle bold italic monospaced font in PDF documents.' =>
            '',
        'Defines the path and TTF-File to handle bold italic proportional font in PDF documents.' =>
            '',
        'Defines the path and TTF-File to handle bold monospaced font in PDF documents.' =>
            '',
        'Defines the path and TTF-File to handle bold proportional font in PDF documents.' =>
            '',
        'Defines the path and TTF-File to handle italic monospaced font in PDF documents.' =>
            '',
        'Defines the path and TTF-File to handle italic proportional font in PDF documents.' =>
            '',
        'Defines the path and TTF-File to handle monospaced font in PDF documents.' =>
            '',
        'Defines the path and TTF-File to handle proportional font in PDF documents.' =>
            '',
        'Defines the path of the shown info file, that is located under Kernel/Output/HTML/Templates/Standard/CustomerAccept.tt.' =>
            '',
        'Defines the path to PGP binary.' => '',
        'Defines the path to open ssl binary. It may need a HOME env ($ENV{HOME} = \'/var/lib/wwwrun\';).' =>
            '',
        'Defines the path to the Google Chrome or Chromium binary. If set, this binary will be used instead of PhantomJS::Bin.' =>
            '',
        'Defines the path to the PhantomJS binary. You can use a static build from http://phantomjs.org/download.html for an easy installation process.' =>
            '',
        'Defines the period of time (in minutes) before agent is marked as "away" due to inactivity (e.g. in the "Logged-In Users" widget or for the chat).' =>
            '',
        'Defines the period of time (in minutes) before customer is marked as "away" due to inactivity (e.g. in the "Logged-In Users" widget or for the chat).' =>
            '',
        'Defines the postmaster default queue.' => 'Anger standardkön för inkommande e-post.',
        'Defines the priority in which the information is logged and presented.' =>
            '',
        'Defines the recipient target of the phone ticket and the sender of the email ticket ("Queue" shows all queues, "System address" displays all system addresses) in the agent interface.' =>
            '',
        'Defines the recipient target of the tickets ("Queue" shows all queues, "SystemAddress" shows only the queues which are assigned to system addresses) in the customer interface.' =>
            '',
        'Defines the required permission to show a ticket in the escalation view of the agent interface.' =>
            '',
        'Defines the search limit for the stats.' => '',
        'Defines the search parameters for the AgentCustomerUserAddressBook screen. With the setting \'CustomerTicketTextField\' the values for the recipient field can be specified.' =>
            '',
        'Defines the sender for rejected emails.' => 'Anger avsändaren för avvisade e-brev.',
        'Defines the separator between the agents real name and the given queue email address.' =>
            '',
        'Defines the shown columns and the position in the AgentCustomerUserAddressBook result screen.' =>
            '',
        'Defines the shown links in the footer area of the customer interface of this OTOBO system. The value in "Key" is the external URL, the value in "Content" is the shown label. <OTOBO_CONFIG_HttpType>, <OTOBO_CONFIG_FQDN> and <OTOBO_CONFIG_ScriptAlias> will be substituted.' =>
            '',
        'Defines the source dynamic field for storing historical data.' =>
            '',
        'Defines the standard permissions available for customers within the application. If more permissions are needed, you can enter them here. Permissions must be hard coded to be effective. Please ensure, when adding any of the afore mentioned permissions, that the "rw" permission remains the last entry.' =>
            '',
        'Defines the standard size of PDF pages.' => 'Anger skönsvärdet för PDF-sidor, t ex A4.',
        'Defines the state of a ticket if it gets a follow-up and the ticket was already closed.' =>
            '',
        'Defines the state of a ticket if it gets a follow-up.' => '',
        'Defines the state type of the reminder for pending tickets.' => '',
        'Defines the subject for notification mails sent to agents, about new password.' =>
            'Anger rubriken för e-brev om glömt lösenord till handläggare.',
        'Defines the subject for notification mails sent to agents, with token about new requested password.' =>
            '',
        'Defines the subject for notification mails sent to customers, about new account.' =>
            '',
        'Defines the subject for notification mails sent to customers, about new password.' =>
            'Anger rubriken för e-brev om glömt lösenord till kunder.',
        'Defines the subject for notification mails sent to customers, with token about new requested password.' =>
            'Anger rubriken för e-brev om begärt nytt lösenord till kunder.',
        'Defines the subject for rejected emails.' => '',
        'Defines the subject for the quick close action, which gets used for ticket history in the agent interface.' =>
            '',
        'Defines the system administrator\'s email address. It will be displayed in the error screens of the application.' =>
            '',
        'Defines the system identifier. Every ticket number and http session string contains this ID. This ensures that only tickets which belong to your system will be processed as follow-ups (useful when communicating between two instances of OTOBO).' =>
            '',
        'Defines the target attribute in the link to external customer database. E.g. \'AsPopup PopupType_TicketAction\'.' =>
            '',
        'Defines the target attribute in the link to external customer database. E.g. \'target="cdb"\'.' =>
            '',
        'Defines the target dynamic fields for storing historical data.' =>
            '',
        'Defines the ticket appointment type backend for ticket dynamic field date time.' =>
            '',
        'Defines the ticket appointment type backend for ticket escalation time.' =>
            '',
        'Defines the ticket appointment type backend for ticket pending time.' =>
            '',
        'Defines the ticket fields that are going to be displayed calendar events. The "Key" defines the field or ticket attribute and the "Content" defines the display name.' =>
            '',
        'Defines the ticket plugin for calendar appointments.' => '',
        'Defines the time zone of the indicated calendar, which can be assigned later to a specific queue.' =>
            '',
        'Defines the timeout (in seconds, minimum is 20 seconds) for the support data collection with the public module \'PublicSupportDataCollector\' (e.g. used from the OTOBO Daemon).' =>
            '',
        'Defines the two-factor module to authenticate agents.' => '',
        'Defines the two-factor module to authenticate customers.' => '',
        'Defines the type of protocol that is used by the web server to serve the application. If the webserver uses HTTP instead of of HTTPS, then \'http\' must be specified here. The setting of \'HttpType\' has no affect on the web server\'s settings or behavior. Specifically, it will not change the method of access to the application. If the setting is wrong, it will not prevent you from logging into the application. This setting is used mainly via the template variable OTOBO_CONFIG_HttpType. This variable is found in all forms of messaging used by the application. It is used to build links to the tickets within your system. Another effect of keeping \'HttpType\' set to \'https\' is that the session management cookie will only be set for secure connections.' =>
            '',
        'Defines the used character for plaintext email quotes in the ticket compose screen of the agent interface. If this is empty or inactive, original emails will not be quoted but appended to the response.' =>
            '',
        'Defines the user identifier for the customer panel.' => '',
        'Defines the users avatar. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.' =>
            '',
        'Defines the valid state types for a ticket. If a ticket is in a state which have any state type from this setting, this ticket will be considered as open, otherwise as closed.' =>
            '',
        'Defines the valid states for unlocked tickets. To unlock tickets the script "bin/otobo.Console.pl Maint::Ticket::UnlockTimeout" can be used.' =>
            '',
        'Defines the viewable locks of a ticket. NOTE: When you change this setting, make sure to delete the cache in order to use the new value. Default: unlock, tmp_lock.' =>
            '',
        'Defines the width for the rich text editor component for this screen. Enter number (pixels) or percent value (relative).' =>
            '',
        'Defines the width for the rich text editor component. Enter number (pixels) or percent value (relative).' =>
            '',
        'Defines time in minutes since last modification for drafts of specified type before they are considered expired.' =>
            '',
        'Defines whether to index archived tickets for fulltext searches.' =>
            '',
        'Defines which article sender types should be shown in the preview of a ticket.' =>
            '',
        'Defines which items are available for \'Action\' in third level of the ACL structure.' =>
            '',
        'Defines which items are available in first level of the ACL structure.' =>
            '',
        'Defines which items are available in second level of the ACL structure.' =>
            '',
        'Defines which states should be set automatically (Content), after the pending time of state (Key) has been reached.' =>
            '',
        'Defines, which tickets of which ticket state types should not be listed in linked ticket lists.' =>
            '',
        'Delete expired cache from core modules.' => '',
        'Delete expired loader cache weekly (Sunday mornings).' => '',
        'Delete expired sessions.' => '',
        'Delete expired ticket draft entries.' => '',
        'Delete expired upload cache hourly.' => '',
        'Delete this ticket' => 'Ta bort detta ärende',
        'Deleted link to ticket "%s".' => 'Deleted link to ticket "%s".',
        'Deletes a session if the session id is used with an invalid remote IP address.' =>
            'Ta bort sessionen om ID:t används med en ogiltig fjärr-IP-adress.',
        'Deletes requested sessions if they have timed out.' => '',
        'Delivers extended debugging information in the frontend in case any AJAX errors occur, if enabled.' =>
            '',
        'DeploymentHistory' => '',
        'Detached' => '',
        'Determines if a button to delete a link should be displayed next to each link in each zoom mask.' =>
            '',
        'Determines if the list of possible queues to move to ticket into should be displayed in a dropdown list or in a new window in the agent interface. If "New Window" is set you can add a move note to the ticket.' =>
            '',
        'Determines if the statistics module may generate ticket lists.' =>
            '',
        'Determines the next possible ticket states, after the creation of a new email ticket in the agent interface.' =>
            '',
        'Determines the next possible ticket states, after the creation of a new phone ticket in the agent interface.' =>
            '',
        'Determines the next possible ticket states, for process tickets in the agent interface.' =>
            '',
        'Determines the next possible ticket states, for process tickets in the customer interface.' =>
            '',
        'Determines the next screen after new customer ticket in the customer interface.' =>
            '',
        'Determines the next screen after the follow-up screen of a zoomed ticket in the customer interface.' =>
            '',
        'Determines the next screen after the process screen of a zoomed ticket in the customer interface.' =>
            '',
        'Determines the next screen after the ticket is moved. LastScreenOverview will return the last overview screen (e.g. search results, queueview, dashboard). TicketZoom will return to the TicketZoom.' =>
            '',
        'Determines the possible states for pending tickets that changed state after reaching time limit.' =>
            '',
        'Determines the strings that will be shown as recipient (To:) of the phone ticket and as sender (From:) of the email ticket in the agent interface. For Queue as NewQueueSelectionType "<Queue>" shows the names of the queues and for SystemAddress "<Realname> <<Email>>" shows the name and email of the recipient.' =>
            '',
        'Determines the strings that will be shown as recipient (To:) of the ticket in the customer interface. For Queue as CustomerPanelSelectionType, "<Queue>" shows the names of the queues, and for SystemAddress, "<Realname> <<Email>>" shows the name and email of the recipient.' =>
            '',
        'Determines the way the linked objects are displayed in each zoom mask.' =>
            '',
        'Determines which options will be valid of the recipient (phone ticket) and the sender (email ticket) in the agent interface.' =>
            '',
        'Determines which queues will be valid for ticket\'s recepients in the customer interface.' =>
            '',
        'Disable HTTP header "Content-Security-Policy" to allow loading of external script contents. Disabling this HTTP header can be a security issue! Only disable it, if you know what you are doing!' =>
            '',
        'Disable HTTP header "X-Frame-Options: SAMEORIGIN" to allow OTOBO to be included as an IFrame in other websites. Disabling this HTTP header can be a security issue! Only disable it, if you know what you are doing!' =>
            '',
        'Disable autocomplete in the login screen.' => '',
        'Disable cloud services' => '',
        'Disables sending reminder notifications to the responsible agent of a ticket (Ticket::Responsible needs to be enabled).' =>
            '',
        'Disables the redirection to the last screen overview / dashboard after a ticket is closed.' =>
            '',
        'Display a warning and prevent search when using stop words within fulltext search.' =>
            '',
        'Display communication log entries.' => '',
        'Display settings to override defaults for Process Tickets.' => '',
        'Displays the accounted time for an article in the ticket zoom view.' =>
            '',
        'Displays the number of all tickets with the same CustomerID as current ticket in the ticket zoom view.' =>
            '',
        'Down' => 'Ner',
        'Dropdown' => '',
        'Dutch' => '',
        'Dutch stop words for fulltext index. These words will be removed from the search index.' =>
            '',
        'Dynamic Fields Checkbox Backend GUI' => '',
        'Dynamic Fields Contact Data Backend GUI' => '',
        'Dynamic Fields Database Backend GUI' => '',
        'Dynamic Fields Date Time Backend GUI' => '',
        'Dynamic Fields Drop-down Backend GUI' => '',
        'Dynamic Fields GUI' => '',
        'Dynamic Fields Multiselect Backend GUI' => '',
        'Dynamic Fields Overview Limit' => '',
        'Dynamic Fields Text Backend GUI' => '',
        'Dynamic Fields Web Service Backend GUI' => '',
        'Dynamic Fields used to export the search result in CSV format.' =>
            '',
        'Dynamic fields groups for process widget. The key is the name of the group, the value contains the fields to be shown. Example: \'Key => My Group\', \'Content: Name_X, NameY\'.' =>
            '',
        'Dynamic fields limit per page for Dynamic Fields Overview.' => '',
        'Dynamic fields options shown in the ticket message screen of the customer interface. NOTE. If you want to display these fields also in the ticket zoom of the customer interface, you have to enable them in CustomerTicketZoom###DynamicField.' =>
            '',
        'Dynamic fields options shown in the ticket reply section in the ticket zoom screen of the customer interface.' =>
            '',
        'Dynamic fields shown in the email outbound screen of the agent interface.' =>
            '',
        'Dynamic fields shown in the process widget in ticket zoom screen of the agent interface.' =>
            '',
        'Dynamic fields shown in the sidebar of the ticket zoom screen of the agent interface.' =>
            '',
        'Dynamic fields shown in the ticket close screen of the agent interface.' =>
            '',
        'Dynamic fields shown in the ticket compose screen of the agent interface.' =>
            '',
        'Dynamic fields shown in the ticket email screen of the agent interface.' =>
            '',
        'Dynamic fields shown in the ticket forward screen of the agent interface.' =>
            '',
        'Dynamic fields shown in the ticket free text screen of the agent interface.' =>
            '',
        'Dynamic fields shown in the ticket medium format overview screen of the agent interface.' =>
            '',
        'Dynamic fields shown in the ticket move screen of the agent interface.' =>
            '',
        'Dynamic fields shown in the ticket note screen of the agent interface.' =>
            '',
        'Dynamic fields shown in the ticket overview screen of the customer interface.' =>
            '',
        'Dynamic fields shown in the ticket owner screen of the agent interface.' =>
            '',
        'Dynamic fields shown in the ticket pending screen of the agent interface.' =>
            '',
        'Dynamic fields shown in the ticket phone inbound screen of the agent interface.' =>
            '',
        'Dynamic fields shown in the ticket phone outbound screen of the agent interface.' =>
            '',
        'Dynamic fields shown in the ticket phone screen of the agent interface.' =>
            '',
        'Dynamic fields shown in the ticket preview format overview screen of the agent interface.' =>
            '',
        'Dynamic fields shown in the ticket print screen of the agent interface.' =>
            '',
        'Dynamic fields shown in the ticket print screen of the customer interface.' =>
            '',
        'Dynamic fields shown in the ticket priority screen of the agent interface.' =>
            '',
        'Dynamic fields shown in the ticket responsible screen of the agent interface.' =>
            '',
        'Dynamic fields shown in the ticket search overview results screen of the customer interface.' =>
            '',
        'Dynamic fields shown in the ticket search screen of the agent interface.' =>
            '',
        'Dynamic fields shown in the ticket search screen of the customer interface.' =>
            '',
        'Dynamic fields shown in the ticket small format overview screen of the agent interface.' =>
            '',
        'Dynamic fields shown in the ticket zoom screen of the customer interface.' =>
            '',
        'DynamicField' => '',
        'DynamicField backend registration.' => '',
        'DynamicField object registration.' => '',
        'DynamicFieldScreen' => '',
        'DynamicField_%s' => '',
        'E-Mail Outbound' => 'E-post utgående',
        'Edit Customer Companies.' => '',
        'Edit Customer Users.' => '',
        'Edit appointment' => 'Redigera kalenderhändelse',
        'Edit contacts with data' => '',
        'Edit contacts with data.' => '',
        'Edit customer company' => 'Redigera organisationen',
        'Elasticsearch quick result module.' => '',
        'Email Addresses' => 'E-postadresser',
        'Email Outbound' => '',
        'Email Resend' => '',
        'Email communication channel.' => '',
        'Enable highlighting queues based on ticket age.' => '',
        'Enable keep-alive connection header for SOAP responses.' => '',
        'Enable this if you trust in all your public and private pgp keys, even if they are not certified with a trusted signature.' =>
            '',
        'Enabled filters.' => 'Aktiva filter.',
        'Enables PGP support. When PGP support is enabled for signing and encrypting mail, it is HIGHLY recommended that the web server runs as the OTOBO user. Otherwise, there will be problems with the privileges when accessing .gnupg folder.' =>
            '',
        'Enables S/MIME support.' => '',
        'Enables customers to create their own accounts.' => 'Aktivera rätt att skapa egna användarkonton för kunderna.',
        'Enables fetch S/MIME from CustomerUser backend support.' => '',
        'Enables file upload in the package manager frontend.' => '',
        'Enables or disables the caching for templates. WARNING: Do NOT disable template caching for production environments for it will cause a massive performance drop! This setting should only be disabled for debugging reasons!' =>
            '',
        'Enables or disables the debug mode over frontend interface.' => '',
        'Enables or disables the ticket watcher feature, to keep track of tickets without being the owner nor the responsible.' =>
            '',
        'Enables performance log (to log the page response time). It will affect the system performance. Frontend::Module###AdminPerformanceLog must be enabled.' =>
            '',
        'Enables the minimal ticket counter size (if "Date" was selected as TicketNumberGenerator).' =>
            '',
        'Enables ticket bulk action feature for the agent frontend to work on more than one ticket at a time.' =>
            '',
        'Enables ticket bulk action feature only for the listed groups.' =>
            '',
        'Enables ticket responsible feature, to keep track of a specific ticket.' =>
            '',
        'Enables ticket type feature.' => '',
        'Enables ticket watcher feature only for the listed groups.' => '',
        'Enabling SecureMode disables the web installer (http://yourhost.example.com/otobo/installer.pl) and the migrations. This is done in order to prevent the system from being hijacked. When SecureMode is not enabled the system can be reinstalled. In this case the current basic configuration will be used to pre-populate the questions within the installer script. Enabling SecureMode also enables GenericAgent, PackageManager and SQL Box.' =>
            '',
        'English (Canada)' => 'Engelska (Kanada)',
        'English (United Kingdom)' => 'Engelska (Storbritannien)',
        'English (United States)' => 'Engelska (USA)',
        'English stop words for fulltext index. These words will be removed from the search index.' =>
            '',
        'Enroll process for this ticket' => '',
        'Enter your shared secret to enable two factor authentication. WARNING: Make sure that you add the shared secret to your generator application and the application works well. Otherwise you will be not able to login anymore without the two factor token.' =>
            '',
        'Escalated Tickets' => 'Eskalerade ärenden',
        'Escalation view' => 'Eskaleringsvy',
        'EscalationTime' => '',
        'Estonian' => 'Estniska',
        'Event module registration (store historical data in dynamic fields).' =>
            '',
        'Event module registration. For more performance you can define a trigger event (e. g. Event => TicketCreate).' =>
            '',
        'Event module registration. For more performance you can define a trigger event (e. g. Event => TicketCreate). This is only possible if all Ticket dynamic fields need the same event.' =>
            '',
        'Event module that performs an update statement on TicketIndex to rename the queue name there if needed and if StaticDB is actually used.' =>
            '',
        'Event module that updates customer company object name for dynamic fields.' =>
            '',
        'Event module that updates customer user object name for dynamic fields.' =>
            '',
        'Event module that updates customer user search profiles if login changes.' =>
            '',
        'Event module that updates customer user service membership if login changes.' =>
            '',
        'Event module that updates customer users after an update of the Customer.' =>
            '',
        'Event module that updates tickets after an update of the Customer User.' =>
            '',
        'Event module that updates tickets after an update of the Customer.' =>
            '',
        'Events Ticket Calendar' => 'Händelseärendekalender',
        'Example package autoload configuration.' => '',
        'Execute SQL statements.' => 'Exekvera SQL-uttryck.',
        'Executes a custom command or module. Note: if module is used, function is required.' =>
            '',
        'Executes follow-up checks on In-Reply-To or References headers for mails that don\'t have a ticket number in the subject.' =>
            '',
        'Executes follow-up checks on OTOBO Header \'X-OTOBO-Bounce\'.' =>
            '',
        'Executes follow-up checks on attachment contents for mails that don\'t have a ticket number in the subject.' =>
            '',
        'Executes follow-up checks on email body for mails that don\'t have a ticket number in the subject.' =>
            '',
        'Executes follow-up checks on the raw source email for mails that don\'t have a ticket number in the subject.' =>
            '',
        'Exports the whole article tree in search result (it can affect the system performance).' =>
            '',
        'External' => '',
        'External Link' => '',
        'Fetch emails via fetchmail (using SSL).' => 'Hämta e-post med fetchmail och SSL.',
        'Fetch emails via fetchmail.' => 'Hämta e-post med fetchmail.',
        'Fetch incoming emails from configured mail accounts.' => 'Hämta e-post från alla konfigurerade systemadresser.',
        'Fetches packages via proxy. Overwrites "WebUserAgent::Proxy".' =>
            '',
        'Fields of the customer company index, used for the company fulltext search. Fields are also stored, but are not mandatory for the overall functionality.' =>
            '',
        'Fields of the ticket index, used for the ticket fulltext search. Fields are also stored, but are not mandatory for the overall functionality. If fields are added which can be updated (especially DynamicFields), their respective update event has to be added to the TicketManagement invoker of the Elasticsearch webservice!' =>
            '',
        'Fields stored in the customer company index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.' =>
            '',
        'Fields stored in the customer user index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory.' =>
            '',
        'Fields stored in the ticket index which are used for other things besides fulltext searches. For the complete functionality all fields are mandatory. If fields are added which can be updated (especially DynamicFields), their respective update event has to be added to the TicketManagement invoker of the Elasticsearch webservice!' =>
            '',
        'Fields to be searched in ticket index. Fields are also stored, but are not mandatory for the overall functionality.' =>
            '',
        'File that is displayed in the Kernel::Modules::AgentInfo module, if located under Kernel/Output/HTML/Templates/Standard/AgentInfo.tt.' =>
            '',
        'Filter for debugging ACLs. Note: More ticket attributes can be added in the format <OTOBO_TICKET_Attribute> e.g. <OTOBO_TICKET_Priority>.' =>
            '',
        'Filter for debugging Transitions. Note: More filters can be added in the format <OTOBO_TICKET_Attribute> e.g. <OTOBO_TICKET_Priority>.' =>
            '',
        'Filter incoming emails.' => '',
        'Finnish' => 'Finska',
        'First Christmas Day' => 'Juldagen',
        'First Queue' => '',
        'First response time' => '',
        'FirstLock' => '',
        'FirstResponse' => '',
        'FirstResponseDiffInMin' => '',
        'FirstResponseInMin' => '',
        'Firstname Lastname' => 'Förnamn Efternamn',
        'Firstname Lastname (UserLogin)' => 'Förnamn Efternamn (Användarnamn)',
        'For these state types the ticket numbers are striked through in the link table.' =>
            '',
        'Force the storage of the original article text in the article search index, without executing filters or applying stop word lists. This will increase the size of the search index and thus may slow down fulltext searches.' =>
            '',
        'Forces encoding of outgoing emails (7bit|8bit|quoted-printable|base64).' =>
            '',
        'Forces to choose a different ticket state (from current) after lock action. Define the current state as key, and the next state after lock action as content.' =>
            '',
        'Forces to unlock tickets after being moved to another queue.' =>
            '',
        'Format of Creation date shown for tickets. As an example \'%Y-%m-%d %H:%M:%S\' would be interpreted as \'2020-01-22 18:07:23\'. Please refer to http://search.cpan.org/~drolsky/DateTime-1.21/lib/DateTime.pm#strftime_Patterns.' =>
            '',
        'Format to be ingested.' => '',
        'Forwarded to "%s".' => 'Forwarded to "%s".',
        'French' => '',
        'French (Canada)' => '',
        'French stop words for fulltext index. These words will be removed from the search index.' =>
            '',
        'Frontend' => '',
        'Frontend module registration (disable AgentTicketService link if Ticket Service feature is not used).' =>
            '',
        'Frontend module registration (disable company link if no company feature is used).' =>
            '',
        'Frontend module registration (disable ticket processes screen if no process available).' =>
            '',
        'Frontend module registration (show personal favorites as sub navigation items of \'Admin\').' =>
            '',
        'Frontend module registration for the admin interface.' => '',
        'Frontend module registration for the agent interface.' => '',
        'Frontend module registration for the customer interface.' => '',
        'Frontend module registration for the public interface.' => '',
        'Full value' => '',
        'Fulltext index regex filters to remove parts of the text.' => '',
        'Fulltext search' => 'Fulltextsökning',
        'Fulltext search using Elasticsearch.' => '',
        'FulltextES' => '',
        'Galician' => 'Galisiska',
        'General ticket data shown in the ticket overviews (fall-back). Note that TicketNumber can not be disabled, because it is necessary.' =>
            '',
        'Generate HTML comment hooks for the specified blocks so that filters can use them.' =>
            '',
        'Generate dashboard statistics.' => '',
        'Generic Info module.' => '',
        'GenericAgent' => 'GenerellAgent',
        'GenericInterface Debugger GUI' => '',
        'GenericInterface ErrorHandling GUI' => '',
        'GenericInterface Invoker Event GUI' => '',
        'GenericInterface Invoker GUI' => '',
        'GenericInterface Operation GUI' => '',
        'GenericInterface TransportHTTPREST GUI' => '',
        'GenericInterface TransportHTTPSOAP GUI' => '',
        'GenericInterface Web Service GUI' => '',
        'GenericInterface Web Service History GUI' => '',
        'GenericInterface Web Service Mapping GUI' => '',
        'GenericInterface module registration for an error handling module.' =>
            '',
        'GenericInterface module registration for the PassThrough invoker layer.' =>
            '',
        'GenericInterface module registration for the TicketCreate invoker layer.' =>
            '',
        'GenericInterface module registration for the TicketUpdate invoker layer.' =>
            '',
        'GenericInterface module registration for the invoker layer.' => '',
        'GenericInterface module registration for the mapping layer.' => '',
        'GenericInterface module registration for the operation layer.' =>
            '',
        'GenericInterface module registration for the transport layer.' =>
            '',
        'German' => '',
        'German stop words for fulltext index. These words will be removed from the search index.' =>
            '',
        'Gives customer users group based access to tickets from customer users of the same customer (ticket CustomerID is a CustomerID of the customer user).' =>
            '',
        'Gives end users the possibility to override the separator character for CSV files, defined in the translation files. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.' =>
            '',
        'Global Search Module.' => '',
        'Go to dashboard!' => 'Gå till översikten!',
        'Good PGP signature.' => '',
        'Google Authenticator' => '',
        'Graph: Bar Chart' => '',
        'Graph: Line Chart' => '',
        'Graph: Stacked Area Chart' => '',
        'Greek' => '',
        'Hebrew' => '',
        'Helps to extend your articles full-text search (From, To, Cc, Subject and Body search). It will strip all articles and will build an index after article creation, increasing fulltext searches about 50%. To create an initial index use "bin/otobo.Console.pl Maint::Ticket::FulltextIndex --rebuild".' =>
            '',
        'High Contrast' => '',
        'High contrast skin for visually impaired users.' => '',
        'Hindi' => '',
        'Hungarian' => '',
        'If "DB" was selected for Customer::AuthModule, a database driver (normally autodetection is used) can be specified.' =>
            '',
        'If "DB" was selected for Customer::AuthModule, a password to connect to the customer table can be specified.' =>
            '',
        'If "DB" was selected for Customer::AuthModule, a username to connect to the customer table can be specified.' =>
            '',
        'If "DB" was selected for Customer::AuthModule, the DSN for the connection to the customer table must be specified.' =>
            '',
        'If "DB" was selected for Customer::AuthModule, the column name for the CustomerPassword in the customer table must be specified.' =>
            '',
        'If "DB" was selected for Customer::AuthModule, the encryption type of passwords must be specified.' =>
            '',
        'If "DB" was selected for Customer::AuthModule, the name of the column for the CustomerKey in the customer table must be specified.' =>
            '',
        'If "DB" was selected for Customer::AuthModule, the name of the table where your customer data should be stored must be specified.' =>
            '',
        'If "DB" was selected for SessionModule, a table in database where session data will be stored must be specified.' =>
            '',
        'If "FS" was selected for SessionModule, a directory where the session data will be stored must be specified.' =>
            '',
        'If "HTTPBasicAuth" was selected for Customer::AuthModule, you can specify (by using a RegExp) to strip parts of REMOTE_USER (e. g. for to remove trailing domains). RegExp-Note, $1 will be the new Login.' =>
            '',
        'If "HTTPBasicAuth" was selected for Customer::AuthModule, you can specify to strip leading parts of user names (e. g. for domains like example_domain\user to user).' =>
            '',
        'If "LDAP" was selected for Customer::AuthModule and if you want to add a suffix to every customer login name, specifiy it here, e. g. you just want to write the username user but in your LDAP directory exists user@domain.' =>
            '',
        'If "LDAP" was selected for Customer::AuthModule and special paramaters are needed for the Net::LDAP perl module, you can specify them here. See "perldoc Net::LDAP" for more information about the parameters.' =>
            '',
        'If "LDAP" was selected for Customer::AuthModule and you wish to use TLS security to communicate with the LDAP server, the "verify" parameter can be specified here. See Net::LDAP::start_tls for more information about the parameter.' =>
            '',
        'If "LDAP" was selected for Customer::AuthModule and your users have only anonymous access to the LDAP tree, but you want to search through the data, you can do this with a user who has access to the LDAP directory. Specify the password for this special user here.' =>
            '',
        'If "LDAP" was selected for Customer::AuthModule and your users have only anonymous access to the LDAP tree, but you want to search through the data, you can do this with a user who has access to the LDAP directory. Specify the username for this special user here.' =>
            '',
        'If "LDAP" was selected for Customer::AuthModule, the BaseDN must be specified.' =>
            '',
        'If "LDAP" was selected for Customer::AuthModule, the LDAP host can be specified.' =>
            '',
        'If "LDAP" was selected for Customer::AuthModule, the user identifier must be specified.' =>
            '',
        'If "LDAP" was selected for Customer::AuthModule, user attributes can be specified. For LDAP posixGroups use UID, for non LDAP posixGroups use full user DN.' =>
            '',
        'If "LDAP" was selected for Customer::AuthModule, you can specify access attributes here.' =>
            '',
        'If "LDAP" was selected for Customer::AuthModule, you can specify if the applications will stop if e. g. a connection to a server can\'t be established due to network problems.' =>
            '',
        'If "LDAP" was selected for Customer::Authmodule, you can check if the user is allowed to authenticate because he is in a posixGroup, e.g. user needs to be in a group xyz to use OTOBO. Specify the group, who may access the system.' =>
            '',
        'If "LDAP" was selected, you can add a filter to each LDAP query, e.g. (mail=*), (objectclass=user) or (!objectclass=computer).' =>
            '',
        'If "Radius" was selected for Customer::AuthModule, the password to authenticate to the radius host must be specified.' =>
            '',
        'If "Radius" was selected for Customer::AuthModule, the radius host must be specified.' =>
            '',
        'If "Radius" was selected for Customer::AuthModule, you can specify if the applications will stop if e. g. a connection to a server can\'t be established due to network problems.' =>
            '',
        'If "Sendmail" was selected as SendmailModule, the location of the sendmail binary and the needed options must be specified.' =>
            '',
        'If "SysLog" was selected for LogModule, a special log facility can be specified.' =>
            '',
        'If "SysLog" was selected for LogModule, the charset that should be used for logging can be specified.' =>
            '',
        'If "bcrypt" was selected for CryptType, use cost specified here for bcrypt hashing. Currently max. supported cost value is 31.' =>
            '',
        'If "file" was selected for LogModule, a logfile must be specified. If the file doesn\'t exist, it will be created by the system.' =>
            '',
        'If active, none of the regular expressions may match the user\'s email address to allow registration.' =>
            '',
        'If active, one of the regular expressions has to match the user\'s email address to allow registration.' =>
            '',
        'If any of the "SMTP" mechanisms was selected as SendmailModule, and authentication to the mail server is needed, a password must be specified.' =>
            '',
        'If any of the "SMTP" mechanisms was selected as SendmailModule, and authentication to the mail server is needed, an username must be specified.' =>
            '',
        'If any of the "SMTP" mechanisms was selected as SendmailModule, the mailhost that sends out the mails must be specified.' =>
            '',
        'If any of the "SMTP" mechanisms was selected as SendmailModule, the port where your mailserver is listening for incoming connections must be specified.' =>
            '',
        'If enabled debugging information for ACLs is logged.' => '',
        'If enabled debugging information for transitions is logged.' => '',
        'If enabled defines the preselected state for customer follow-up in the customer interface.' =>
            '',
        'If enabled the daemon will redirect the standard error stream to a log file.' =>
            '',
        'If enabled the daemon will redirect the standard output stream to a log file.' =>
            '',
        'If enabled the daemon will use this directory to create its PID files. Note: Please stop the daemon before any change and use this setting only if <$OTOBOHome>/var/run/ can not be used.' =>
            '',
        'If enabled, OTOBO will deliver all CSS files in minified form.' =>
            '',
        'If enabled, OTOBO will deliver all JavaScript files in minified form.' =>
            '',
        'If enabled, TicketPhone and TicketEmail will be open in new windows.' =>
            '',
        'If enabled, the OTOBO version tag will be removed from the Webinterface, the HTTP headers and the X-Headers of outgoing mails. NOTE: If you change this option, please make sure to delete the cache.' =>
            '',
        'If enabled, the cache data be held in memory.' => '',
        'If enabled, the cache data will be stored in cache backend.' => '',
        'If enabled, the customer can search for tickets in all services (regardless what services are assigned to the customer).' =>
            '',
        'If enabled, the different overviews (Dashboard, LockedView, QueueView) will automatically refresh after the specified time.' =>
            'Om detta är aktiverat kommer överblicksvyer (Dashboard, Lås-vy, Kö-vy) uppdateras automatiskt efter angiven tid.',
        'If enabled, the first level of the main menu opens on mouse hover (instead of click only).' =>
            '',
        'If enabled, the quick close action will create an article.' => '',
        'If enabled, users that haven\'t selected a time zone yet will be notified to do so. Note: Notification will not be shown if (1) user has not yet selected a time zone and (2) OTOBOTimeZone and UserDefaultTimeZone do match and (3) are not set to UTC.' =>
            '',
        'If no SendmailNotificationEnvelopeFrom is specified, this setting makes it possible to use the email\'s from address instead of an empty envelope sender (required in certain mail server configurations).' =>
            '',
        'If set, this address is used as envelope sender header in outgoing notifications. If no address is specified, the envelope sender header is empty (unless SendmailNotificationEnvelopeFrom::FallbackToEmailFrom is set).' =>
            '',
        'If set, this address is used as envelope sender in outgoing messages (not notifications - see below). If no address is specified, the envelope sender is equal to queue e-mail address.' =>
            '',
        'If this option is enabled, tickets created via the web interface, via Customers or Agents, will receive an autoresponse if configured. If this option is not enabled, no autoresponses will be sent.' =>
            '',
        'If this regex matches, no message will be send by the autoresponder.' =>
            'Om det här reguljära uttrycket matchar skickas inget autosvar. ',
        'If this setting is enabled, it is possible to install packages which are not verified by OTOBO Team. These packages could threaten your whole system!' =>
            '',
        'If this setting is enabled, local modifications will not be highlighted as errors in the package manager and support data collector.' =>
            '',
        'If you\'re going to be out of office, you may wish to let other users know by setting the exact dates of your absence.' =>
            '',
        'Ignore system sender article types (e. g. auto responses or email notifications) to be flagged as \'Unread Article\' in AgentTicketZoom or expanded automatically in Large view screens.' =>
            '',
        'Ignores not ticket related attributes.' => '',
        'Import appointments screen.' => 'Importera kalenderhändelse-vy.',
        'Include tickets of subqueues per default when selecting a queue.' =>
            'Inkludera ärenden från underköer som standard när du väljer en kö',
        'Include unknown customers in ticket filter.' => '',
        'Includes article create times in the ticket search of the agent interface.' =>
            '',
        'Incoming Phone Call.' => '',
        'IndexAccelerator: to choose your backend TicketViewAccelerator module. "RuntimeDB" generates each queue view on the fly from ticket table (no performance problems up to approx. 60.000 tickets in total and 6.000 open tickets in the system). "StaticDB" is the most powerful module, it uses an extra ticket-index table that works like a view (recommended if more than 80.000 and 6.000 open tickets are stored in the system). Use the command "bin/otobo.Console.pl Maint::Ticket::QueueIndexRebuild" for initial index creation.' =>
            '',
        'Indicates if a bounce e-mail should always be treated as normal follow-up.' =>
            '',
        'Indonesian' => '',
        'Inline' => '',
        'Input' => '',
        'Interface language' => 'Gränssnittsspråk',
        'Internal communication channel.' => '',
        'International Workers\' Day' => 'Första maj',
        'It is possible to configure different skins, for example to distinguish between diferent agents, to be used on a per-domain basis within the application. Using a regular expression (regex), you can configure a Key/Content pair to match a domain. The value in "Key" should match the domain, and the value in "Content" should be a valid skin on your system. Please see the example entries for the proper form of the regex.' =>
            '',
        'It is possible to configure different skins, for example to distinguish between diferent customers, to be used on a per-domain basis within the application. Using a regular expression (regex), you can configure a Key/Content pair to match a domain. The value in "Key" should match the domain, and the value in "Content" should be a valid skin on your system. Please see the example entries for the proper form of the regex.' =>
            '',
        'It is possible to configure different themes, for example to distinguish between agents and customers, to be used on a per-domain basis within the application. Using a regular expression (regex), you can configure a Key/Content pair to match a domain. The value in "Key" should match the domain, and the value in "Content" should be a valid theme on your system. Please see the example entries for the proper form of the regex.' =>
            '',
        'It was not possible to check the PGP signature, this may be caused by a missing public key or an unsupported algorithm.' =>
            '',
        'Italian' => 'Italienska',
        'Italian stop words for fulltext index. These words will be removed from the search index.' =>
            '',
        'Ivory' => '',
        'Ivory (Slim)' => '',
        'Japanese' => 'Japanska',
        'JavaScript function for the search frontend.' => '',
        'Jump to OTOBO!' => '',
        'Korean' => '',
        'Language' => 'Språk',
        'Large' => 'Stor',
        'Last Screen Overview' => '',
        'Last customer subject' => '',
        'Lastname Firstname' => 'Efternamn förnamn',
        'Lastname Firstname (UserLogin)' => '',
        'Lastname, Firstname' => 'Efternamn, förnamn',
        'Lastname, Firstname (UserLogin)' => 'Förnamn Efternamn (Användarnamn)',
        'LastnameFirstname' => '',
        'Latvian' => 'Lettiska',
        'Left' => '',
        'Link Object' => 'Länka objekt',
        'Link Object.' => '',
        'Link agents to groups.' => 'Koppla handläggare till grupper.',
        'Link agents to roles.' => 'Koppla handläggare till roller.',
        'Link customer users to customers.' => '',
        'Link customer users to groups.' => '',
        'Link customer users to services.' => '',
        'Link customers to groups.' => '',
        'Link queues to auto responses.' => 'Koppla köer till autosvar.',
        'Link roles to groups.' => 'Koppla roller till grupper',
        'Link templates to attachments.' => '',
        'Link templates to queues.' => 'Koppla mallar till köer.',
        'Link this ticket to other objects' => 'Länka detta ärende till andra objekt',
        'Links 2 tickets with a "Normal" type link.' => '',
        'Links 2 tickets with a "ParentChild" type link.' => '',
        'Links appointments and tickets with a "Normal" type link.' => '',
        'List of CSS files to always be loaded for the agent interface.' =>
            '',
        'List of CSS files to always be loaded for the customer interface.' =>
            '',
        'List of JS files to always be loaded for the agent interface.' =>
            '',
        'List of JS files to always be loaded for the customer interface.' =>
            '',
        'List of all CustomerCompany events to be displayed in the GUI.' =>
            'Alla organisationens händelser som visas som en lista i gränssnittet.',
        'List of all CustomerUser events to be displayed in the GUI.' => '',
        'List of all DynamicField events to be displayed in the GUI.' => '',
        'List of all LinkObject events to be displayed in the GUI.' => '',
        'List of all Package events to be displayed in the GUI.' => '',
        'List of all appointment events to be displayed in the GUI.' => '',
        'List of all article events to be displayed in the GUI.' => '',
        'List of all calendar events to be displayed in the GUI.' => '',
        'List of all queue events to be displayed in the GUI.' => '',
        'List of all ticket events to be displayed in the GUI.' => '',
        'List of colors in hexadecimal RGB which will be available for selection during calendar creation. Make sure the colors are dark enough so white text can be overlayed on them.' =>
            '',
        'List of default Standard Templates which are assigned automatically to new Queues upon creation.' =>
            '',
        'List of responsive CSS files to always be loaded for the agent interface.' =>
            '',
        'List of responsive CSS files to always be loaded for the customer interface.' =>
            '',
        'List of states for which escalations should be suspended.' => '',
        'List view' => '',
        'Lithuanian' => '',
        'Loader module registration for the agent interface.' => '',
        'Loader module registration for the customer interface.' => '',
        'Lock / unlock this ticket' => 'Lås / lås upp det här ärendet',
        'Locked Tickets' => 'Låsta ärenden',
        'Locked Tickets.' => 'Låsta Ärenden.',
        'Locked ticket.' => 'Låst ärende.',
        'Logged in users.' => '',
        'Logged-In Users' => '',
        'Logout of customer panel.' => '',
        'Look into a ticket!' => 'Visa ärendet!',
        'Loop protection: no auto-response sent to "%s".' => '',
        'Macedonian' => '',
        'Mail Accounts' => '',
        'MailQueue configuration settings.' => '',
        'Main menu for the agent interface.' => '',
        'Main menu item registration.' => '',
        'Main menu registration.' => 'Huvudmeny för registrering av OTOBO-installationen.',
        'Makes the application block external content loading.' => '',
        'Makes the application check the MX record of email addresses before sending an email or submitting a telephone or email ticket.' =>
            '',
        'Makes the application check the syntax of email addresses.' => '',
        'Makes the session management use html cookies. If html cookies are disabled or if the client browser disabled html cookies, then the system will work as usual and append the session id to the links.' =>
            '',
        'Malay' => 'Malaysiska',
        'Manage OTOBO Team cloud services.' => '',
        'Manage PGP keys for email encryption.' => 'Hantera PGP-nycklar för e-postkryptering.',
        'Manage POP3 or IMAP accounts to fetch email from.' => '',
        'Manage S/MIME certificates for email encryption.' => '',
        'Manage System Configuration Deployments.' => '',
        'Manage different calendars.' => '',
        'Manage dynamic field in screens.' => '',
        'Manage existing sessions.' => 'Hantera aktuella sessioner.',
        'Manage support data.' => 'Hantera supportdata.',
        'Manage system registration.' => 'Systemregistreringshantering.',
        'Manage tasks triggered by event or time based execution.' => '',
        'Mark as Spam!' => 'Markera som spam!',
        'Mark this ticket as junk!' => 'Märk ärendet som skräp!',
        'Max size (in characters) of the customer information table (phone and email) in the compose screen.' =>
            '',
        'Max size (in rows) of the informed agents box in the agent interface.' =>
            '',
        'Max size (in rows) of the involved agents box in the agent interface.' =>
            '',
        'Max size of the subjects in an email reply and in some overview screens.' =>
            '',
        'Maximal auto email responses to own email-address a day (Loop-Protection).' =>
            '',
        'Maximal auto email responses to own email-address a day, configurable by email address (Loop-Protection).' =>
            '',
        'Maximal number of results returned by ES per field.' => '',
        'Maximal size in KBytes for mails that can be fetched via POP3/POP3S/IMAP/IMAPS (KBytes).' =>
            '',
        'Maximum Number of a calendar shown in a dropdown.' => '',
        'Maximum file size for the ingest plugin.' => '',
        'Maximum length (in characters) of the dynamic field in the article of the ticket zoom view.' =>
            '',
        'Maximum length (in characters) of the dynamic field in the sidebar of the ticket zoom view.' =>
            '',
        'Maximum number of active calendars in overview screens. Please note that large number of active calendars can have a performance impact on your server by making too much simultaneous calls.' =>
            '',
        'Maximum number of tickets to be displayed in the result of a search in the agent interface.' =>
            '',
        'Maximum number of tickets to be displayed in the result of a search in the customer interface.' =>
            '',
        'Maximum number of tickets to be displayed in the result of this operation.' =>
            '',
        'Maximum size (in characters) of the customer information table in the ticket zoom view.' =>
            '',
        'Medium' => 'Mellan',
        'Merge this ticket and all articles into another ticket' => '',
        'Merged Ticket (%s/%s) to (%s/%s).' => '',
        'Merged Ticket <OTOBO_TICKET> to <OTOBO_MERGE_TO_TICKET>.' => '',
        'Minute' => '',
        'Miscellaneous' => 'Övrigt',
        'Module for To-selection in new ticket screen in the customer interface.' =>
            '',
        'Module to check if a incoming e-mail message is bounce.' => '',
        'Module to check if arrived emails should be marked as internal (because of original forwarded internal email). IsVisibleForCustomer and SenderType define the values for the arrived email/article.' =>
            '',
        'Module to check the group permissions for customer access to tickets.' =>
            '',
        'Module to check the group permissions for the access to tickets.' =>
            '',
        'Module to compose signed messages (PGP or S/MIME).' => '',
        'Module to define the email security options to use (PGP or S/MIME).' =>
            '',
        'Module to encrypt composed messages (PGP or S/MIME).' => '',
        'Module to fetch customer users SMIME certificates of incoming messages.' =>
            '',
        'Module to filter and manipulate incoming messages. Block/ignore all spam email with From: noreply@ address.' =>
            '',
        'Module to filter and manipulate incoming messages. Get a 4 digit number to ticket free text, use regex in Match e. g. From => \'(.+?)@.+?\', and use () as [***] in Set =>.' =>
            '',
        'Module to filter encrypted bodies of incoming messages.' => '',
        'Module to generate accounted time ticket statistics.' => '',
        'Module to generate html OpenSearch profile for short ticket search in the agent interface.' =>
            '',
        'Module to generate html OpenSearch profile for short ticket search in the customer interface.' =>
            '',
        'Module to generate ticket solution and response time statistics.' =>
            '',
        'Module to generate ticket statistics.' => '',
        'Module to grant access if the CustomerID of the customer has necessary group permissions.' =>
            '',
        'Module to grant access if the CustomerID of the ticket matches the CustomerID of the customer.' =>
            '',
        'Module to grant access if the CustomerUserID of the ticket matches the CustomerUserID of the customer.' =>
            '',
        'Module to grant access to any agent that has been involved in a ticket in the past (based on ticket history entries).' =>
            '',
        'Module to grant access to the agent responsible of a ticket.' =>
            '',
        'Module to grant access to the creator of a ticket.' => '',
        'Module to grant access to the owner of a ticket.' => '',
        'Module to grant access to the watcher agents of a ticket.' => '',
        'Module to show notifications and escalations (ShownMax: max. shown escalations, EscalationInMinutes: Show ticket which will escalation in, CacheTime: Cache of calculated escalations in seconds).' =>
            '',
        'Module to use database filter storage.' => '',
        'Module used to detect if attachments are present.' => '',
        'My Queues' => 'Mina köer',
        'My Services' => 'Mina tjänster',
        'My last changed tickets' => '',
        'MyLastChangedTickets dashboard widget.' => '',
        'Name of custom queue. The custom queue is a queue selection of your preferred queues and can be selected in the preferences settings.' =>
            '',
        'Name of custom service. The custom service is a service selection of your preferred services and can be selected in the preferences settings.' =>
            '',
        'NameX' => '',
        'New Tickets' => 'Nya ärenden',
        'New Window' => '',
        'New Year\'s Day' => 'Nyårsdagen',
        'New Year\'s Eve' => 'Nyårsafton',
        'New process ticket' => '',
        'News about OTOBO.' => '',
        'Next possible ticket states after adding a phone note in the ticket phone inbound screen of the agent interface.' =>
            '',
        'Next possible ticket states after adding a phone note in the ticket phone outbound screen of the agent interface.' =>
            '',
        'No public key found.' => '',
        'No valid OpenPGP data found.' => '',
        'None' => '',
        'Norwegian' => 'Norska',
        'Notification Settings' => 'Inställningar för meddelanden',
        'Notified about response time escalation.' => '',
        'Notified about solution time escalation.' => '',
        'Notified about update time escalation.' => '',
        'Number of displayed tickets' => 'Antal visade ärenden',
        'Number of lines (per ticket) that are shown by the search utility in the agent interface.' =>
            '',
        'Number of shards (NS), replicas (NR) and fields limit for the index \'ticket\'.' =>
            '',
        'Number of shards (NS), replicas (NR) and fields limit for the index. Note: \'Elasticsearch::ArticleIndexCreationSettings\' is deprecated. For upwards compatibility use \'Elasticsearch::IndexSettings###Default\' instead.' =>
            '',
        'Number of shards (NS), replicas (NR) and fields limit for the indices. This replaces \'Elasticsearch::ArticleIndexCreationSettings\' in future versions. If both are present and not equal this one has priority. Use \'Elasticsearch::IndexSettings###...\' if you want to define special settings for single indices.\'...\' may be one of \'Customer\', \'CustomerUser\', \'Ticket\' or \'ConfigItem\'.' =>
            '',
        'Number of tickets to be displayed in each page of a search result in the agent interface.' =>
            '',
        'Number of tickets to be displayed in each page of a search result in the customer interface.' =>
            '',
        'OTOBO News' => 'OTOBO-nyheter',
        'OTOBO Team Services' => '',
        'OTOBO can use one or more readonly mirror databases for expensive operations like fulltext search or statistics generation. Here you can specify the DSN for the first mirror database.' =>
            '',
        'OTOBO doesn\'t support recurring Appointments without end date or number of iterations. During import process, it might happen that ICS file contains such Appointments. Instead, system creates all Appointments in the past, plus Appointments for the next N months (120 months/10 years by default).' =>
            '',
        'Objects to search for, how many entries and which attributs to show.' =>
            '',
        'Objects to search for, how many entries and which attributs to show. Ticket attributes, except queue, have to explicitely be stored via Elasticsearch.' =>
            '',
        'Open an external link!' => '',
        'Open the OTOBO home page in a new window' => '',
        'Open tickets (customer user)' => 'Öppna ärenden (kundanvändare)',
        'Open tickets (customer)' => 'Öppna ärenden (kund)',
        'Option' => '',
        'Optional queue limitation for the CreatorCheck permission module. If set, permission is only granted for tickets in the specified queues.' =>
            '',
        'Optional queue limitation for the InvolvedCheck permission module. If set, permission is only granted for tickets in the specified queues.' =>
            '',
        'Optional queue limitation for the OwnerCheck permission module. If set, permission is only granted for tickets in the specified queues.' =>
            '',
        'Optional queue limitation for the ResponsibleCheck permission module. If set, permission is only granted for tickets in the specified queues.' =>
            '',
        'Other Customers' => '',
        'Out Of Office' => 'Frånvarande',
        'Out Of Office Time' => 'Frånvarande',
        'Out of Office users.' => '',
        'Outbound request headers not allowed to be used in frontend configuration.' =>
            '',
        'Outbound response headers not allowed to be used in frontend configuration.' =>
            '',
        'Output filter to inject the necessary Dynamic field names in hidden input.' =>
            '',
        'Overloads (redefines) existing functions in Kernel::System::Ticket. Used to easily add customizations.' =>
            '',
        'Overview Escalated Tickets.' => 'Översikt av eskalerade ärenden',
        'Overview Refresh Time' => 'Automatisk uppdateringsintervall',
        'Overview of all Tickets per assigned Queue.' => '',
        'Overview of all appointments.' => 'Kalenderhändelseöversikt.',
        'Overview of all escalated tickets.' => 'Översikt över alla eskalerade ärenden.',
        'Overview of all open Tickets.' => 'Översikt över alla öppna ärenden',
        'Overview of all open tickets.' => 'Översikt över alla öppna ärenden.',
        'Overview of customer tickets.' => 'Översikt över kundärenden.',
        'PGP Key' => 'PGP-nyckel',
        'PGP Key Management' => 'PGP-nyckelhantering',
        'PGP Keys' => 'PGP-nycklar',
        'Package event module file a scheduler task for update registration.' =>
            '',
        'Package event module trigger package reinstall in containers.' =>
            '',
        'Parameters for the CreateNextMask object in the preference view of the agent interface. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.' =>
            '',
        'Parameters for the CustomQueue object in the preference view of the agent interface. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.' =>
            '',
        'Parameters for the CustomService object in the preference view of the agent interface. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.' =>
            '',
        'Parameters for the RefreshTime object in the preference view of the agent interface. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.' =>
            '',
        'Parameters for the column filters of the small ticket overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.' =>
            '',
        'Parameters for the dashboard backend of the closed tickets overview of the agent interface. "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. Note: Only Ticket attributes and Dynamic Fields (DynamicField_NameX) are allowed for DefaultColumns.' =>
            '',
        'Parameters for the dashboard backend of the customer company information of the agent interface. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.' =>
            '',
        'Parameters for the dashboard backend of the customer id list overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.' =>
            '',
        'Parameters for the dashboard backend of the customer id status widget of the agent interface . "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.' =>
            '',
        'Parameters for the dashboard backend of the customer user information of the agent interface. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.' =>
            '',
        'Parameters for the dashboard backend of the customer user list overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.' =>
            '',
        'Parameters for the dashboard backend of the new tickets overview of the agent interface. "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "Mandatory" determines if the plugin is always shown and can not be removed by agents. Note: Only Ticket attributes and Dynamic Fields (DynamicField_NameX) are allowed for DefaultColumns.' =>
            '',
        'Parameters for the dashboard backend of the new tickets overview of the agent interface. "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. Note: Only Ticket attributes and Dynamic Fields (DynamicField_NameX) are allowed for DefaultColumns.' =>
            '',
        'Parameters for the dashboard backend of the open tickets overview of the agent interface. "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "Mandatory" determines if the plugin is always shown and can not be removed by agents. Note: Only Ticket attributes and Dynamic Fields (DynamicField_NameX) are allowed for DefaultColumns.' =>
            '',
        'Parameters for the dashboard backend of the open tickets overview of the agent interface. "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. Note: Only Ticket attributes and Dynamic Fields (DynamicField_NameX) are allowed for DefaultColumns.' =>
            '',
        'Parameters for the dashboard backend of the queue overview widget of the agent interface. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "QueuePermissionGroup" is not mandatory, queues are only listed if they belong to this permission group if you enable it. "States" is a list of states, the key is the sort order of the state in the widget. "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "Mandatory" determines if the plugin is always shown and can not be removed by agents.' =>
            '',
        'Parameters for the dashboard backend of the running process tickets overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "Mandatory" determines if the plugin is always shown and can not be removed by agents.' =>
            '',
        'Parameters for the dashboard backend of the ticket escalation overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "Mandatory" determines if the plugin is always shown and can not be removed by agents. Note: Only Ticket attributes and Dynamic Fields (DynamicField_NameX) are allowed for DefaultColumns.' =>
            '',
        'Parameters for the dashboard backend of the ticket escalation overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. Note: Only Ticket attributes and Dynamic Fields (DynamicField_NameX) are allowed for DefaultColumns.' =>
            '',
        'Parameters for the dashboard backend of the ticket escalation overview of the agent interface. "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. Note: Only Ticket attributes and Dynamic Fields (DynamicField_NameX) are allowed for DefaultColumns.' =>
            '',
        'Parameters for the dashboard backend of the ticket events calendar of the agent interface. "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "Mandatory" determines if the plugin is always shown and can not be removed by agents.' =>
            '',
        'Parameters for the dashboard backend of the ticket pending reminder overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "Mandatory" determines if the plugin is always shown and can not be removed by agents. Note: Only Ticket attributes and Dynamic Fields (DynamicField_NameX) are allowed for DefaultColumns.' =>
            '',
        'Parameters for the dashboard backend of the ticket pending reminder overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. Note: Only Ticket attributes and Dynamic Fields (DynamicField_NameX) are allowed for DefaultColumns.' =>
            '',
        'Parameters for the dashboard backend of the ticket pending reminder overview of the agent interface. "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. Note: Only Ticket attributes and Dynamic Fields (DynamicField_NameX) are allowed for DefaultColumns.' =>
            '',
        'Parameters for the dashboard backend of the ticket stats of the agent interface. "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "Mandatory" determines if the plugin is always shown and can not be removed by agents.' =>
            '',
        'Parameters for the dashboard backend of the upcoming events widget of the agent interface. "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. "Mandatory" determines if the plugin is always shown and can not be removed by agents.' =>
            '',
        'Parameters for the pages (in which the communication log entries are shown) of the communication log overview.' =>
            '',
        'Parameters for the pages (in which the dynamic fields are shown) of the dynamic fields overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.' =>
            '',
        'Parameters for the pages (in which the tickets are shown) of the medium ticket overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.' =>
            '',
        'Parameters for the pages (in which the tickets are shown) of the small ticket overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.' =>
            '',
        'Parameters for the pages (in which the tickets are shown) of the ticket preview overview. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.' =>
            '',
        'Parameters of the example SLA attribute Comment2.' => '',
        'Parameters of the example queue attribute Comment2.' => '',
        'Parameters of the example service attribute Comment2.' => '',
        'Parent' => 'Förälder',
        'ParentChild' => '',
        'Path for the log file (it only applies if "FS" was selected for LoopProtectionModule and it is mandatory).' =>
            '',
        'Pending time' => '',
        'People' => 'Personer',
        'Performs the configured action for each event (as an Invoker) for each configured web service.' =>
            '',
        'Permitted width for compose email windows.' => '',
        'Permitted width for compose note windows.' => '',
        'Persian' => 'Persiska',
        'Phone Call Inbound' => 'Telefonsamtal inkommande',
        'Phone Call Outbound' => 'Telefonsamtal utgående',
        'Phone Call.' => 'Telefonsamtal',
        'Phone call' => 'Telefonsamtal',
        'Phone communication channel.' => '',
        'Phone-Ticket' => 'Telefonärende',
        'Picture Upload' => '',
        'Picture upload module.' => '',
        'Picture-Upload' => '',
        'Please click the button below to create your first ticket.' => 'Vänligen klicka på knappen nedan för att skapa ditt första ärende',
        'Plugin search' => '',
        'Plugin search module for autocomplete.' => '',
        'Polish' => 'Polska',
        'Portuguese' => 'Portugisiska',
        'Portuguese (Brasil)' => 'Portugisiska (Brasilien)',
        'PostMaster Filters' => 'PostMaster Filter',
        'PostMaster Mail Accounts' => 'PostMaster E-postkonton',
        'Print this ticket' => 'Skriv ut detta ärende',
        'Priorities' => 'Prioriteter',
        'Process Management Activity Dialog GUI' => '',
        'Process Management Activity GUI' => '',
        'Process Management Path GUI' => '',
        'Process Management Transition Action GUI' => '',
        'Process Management Transition GUI' => '',
        'Process pending tickets.' => 'Behandla pågående ärende.',
        'ProcessID' => 'Process-ID',
        'Processes & Automation' => '',
        'Protection against CSRF (Cross Site Request Forgery) exploits (for more info see https://en.wikipedia.org/wiki/Cross-site_request_forgery).' =>
            '',
        'Protection against brute force attacks. MaxAttempt: How many login attempts are allowed before a ban. BanDuration: Duration of the ban. KeepCacheDuration: How long failed attempts are remembered.' =>
            '',
        'Provides a matrix overview of the tickets per state per queue' =>
            '',
        'Provides customer users access to tickets even if the tickets are not assigned to a customer user of the same customer ID(s), based on permission groups.' =>
            '',
        'Public Calendar' => 'Öppen kalender',
        'Public Interface' => '',
        'Public calendar.' => 'Öppen kalender.',
        'Queue view' => 'Kö-vy',
        'Queues ↔ Auto Responses' => '',
        'Quick Close' => '',
        'Rebuild the ticket index for AgentTicketQueue.' => '',
        'Rebuilds Elasticsearch indices. Can be used for example, if CustomerUsers are authenticated via LDAP. Highly inefficient however, as the whole index is rebuild every time.' =>
            '',
        'Rebuilds the ACL preselection cache.' => '',
        'Rebuilds the escalation index.' => '',
        'Recognize if a ticket is a follow-up to an existing ticket using an external ticket number. Note: the first capturing group from the \'NumberRegExp\' expression will be used as the ticket number value.' =>
            '',
        'Redis server address. Example: 127.0.0.1:6379.' => '',
        'Refresh interval' => 'Uppdateringsintervall',
        'Registers a log module, that can be used to log communication related information.' =>
            '',
        'Reminder Tickets' => 'Påminnelse ärenden',
        'Removed subscription for user "%s".' => 'Removed subscription for user "%s".',
        'Removes old generic interface debug log entries created before the specified amount of days.' =>
            '',
        'Removes old system configuration deployments (Sunday mornings).' =>
            '',
        'Removes old ticket number counters (each 10 minutes).' => '',
        'Removes the ticket watcher information when a ticket is archived.' =>
            '',
        'Renew existing SMIME certificates from customer backend. Note: SMIME and SMIME::FetchFromCustomer needs to be enabled in SysConfig and customer backend needs to be configured to fetch UserSMIMECertificate attribute.' =>
            '',
        'Replaces the original sender with current customer\'s email address on compose answer in the ticket compose screen of the agent interface.' =>
            '',
        'Reports' => 'Rapporter',
        'Reprocess mails from spool directory that could not be imported in the first place.' =>
            '',
        'Required permissions to change the customer of a ticket in the agent interface.' =>
            '',
        'Required permissions to use quick close in the agent interface.' =>
            '',
        'Required permissions to use the close ticket screen in the agent interface.' =>
            '',
        'Required permissions to use the email outbound screen in the agent interface.' =>
            '',
        'Required permissions to use the email resend screen in the agent interface.' =>
            '',
        'Required permissions to use the ticket bounce screen in the agent interface.' =>
            '',
        'Required permissions to use the ticket compose screen in the agent interface.' =>
            '',
        'Required permissions to use the ticket forward screen in the agent interface.' =>
            '',
        'Required permissions to use the ticket free text screen in the agent interface.' =>
            '',
        'Required permissions to use the ticket merge screen of a zoomed ticket in the agent interface.' =>
            '',
        'Required permissions to use the ticket note screen in the agent interface.' =>
            '',
        'Required permissions to use the ticket owner screen of a zoomed ticket in the agent interface.' =>
            '',
        'Required permissions to use the ticket pending screen of a zoomed ticket in the agent interface.' =>
            '',
        'Required permissions to use the ticket phone inbound screen in the agent interface.' =>
            '',
        'Required permissions to use the ticket phone outbound screen in the agent interface.' =>
            '',
        'Required permissions to use the ticket priority screen of a zoomed ticket in the agent interface.' =>
            '',
        'Required permissions to use the ticket responsible screen in the agent interface.' =>
            '',
        'Resend Ticket Email.' => '',
        'Resent email to "%s".' => '',
        'Resets and unlocks the owner of a ticket if it was moved to another queue.' =>
            '',
        'Responsible Tickets' => '',
        'Responsible Tickets.' => '',
        'Restores a ticket from the archive (only if the event is a state change to any open available state).' =>
            '',
        'Retains all services in listings even if they are children of invalid elements.' =>
            '',
        'Right' => '',
        'Roles ↔ Groups' => '',
        'Romanian' => '',
        'Run file based generic agent jobs (Note: module name needs to be specified in -configuration-module param e.g. "Kernel::System::GenericAgent").' =>
            '',
        'Running Process Tickets' => '',
        'Runs an initial wildcard search of the existing contacts with data when accessing the AdminContactWD module.' =>
            '',
        'Runs an initial wildcard search of the existing customer company when accessing the AdminCustomerCompany module.' =>
            '',
        'Runs an initial wildcard search of the existing customer users when accessing the AdminCustomerUser module.' =>
            '',
        'Runs the system in "Demo" mode. If enabled, agents can change preferences, such as selection of language and theme via the agent web interface. These changes are only valid for the current session. It will not be possible for agents to change their passwords.' =>
            '',
        'Russian' => 'Ryska',
        'S/MIME Certificates' => 'S/MIME-certifikat',
        'Salutations' => 'Hälsningsfraser',
        'Sample command output' => '',
        'Saves the attachments of articles. "DB" stores all data in the database (not recommended for storing big attachments). "FS" stores the data on the filesystem; this is faster but the webserver should run under the OTOBO user. You can switch between the modules even on a system that is already in production without any loss of data. Note: Searching for attachment names is not supported when "FS" is used. "S3" is experimental.' =>
            '',
        'Schedule a maintenance period.' => '',
        'Screen after new ticket' => 'Vy efter inmatning av nytt ärende',
        'Search Customer' => 'Sök kund',
        'Search Ticket.' => '',
        'Search Tickets.' => '',
        'Search User' => 'Sök användare',
        'Search backend default router.' => '',
        'Search backend router.' => '',
        'Search.' => '',
        'Second Christmas Day' => 'Annandag jul',
        'Second Queue' => '',
        'Select after which period ticket overviews should refresh automatically.' =>
            '',
        'Select how many tickets should be shown in overviews by default.' =>
            '',
        'Select the algorithm used for encryption. Fallback is aes256. Try "/usr/bin/openssl enc -ciphers" to get a list of ciphers supported by your system (written without the leading \'-\').' =>
            '',
        'Select the main interface language.' => '',
        'Select the separator character used in CSV files (stats and searches). If you don\'t select a separator here, the default separator for your language will be used.' =>
            'Ange separator som används i CSV-filer (statistik och sökningar). Om du inte väljer en separator, kommer standardvärdet för ditt språk att användas',
        'Select your personal time zone. All times will be displayed relative to this time zone.' =>
            '',
        'Select your preferred layout for the software.' => '',
        'Select your preferred theme for OTOBO.' => '',
        'Selects the cache backend to use.' => '',
        'Selects the module to handle uploads via the web interface. "DB" stores all uploads in the database, "FS" uses the file system.' =>
            '',
        'Selects the ticket number generator module. "AutoIncrement" increments the ticket number, the SystemID and the counter are used with SystemID.counter format (e.g. 1010138, 1010139). With "Date" the ticket numbers will be generated by the current date, the SystemID and the counter. The format looks like Year.Month.Day.SystemID.counter (e.g. 200206231010138, 200206231010139). With "DateChecksum"  the counter will be appended as checksum to the string of date and SystemID. The checksum will be rotated on a daily basis. The format looks like Year.Month.Day.SystemID.Counter.CheckSum (e.g. 2002070110101520, 2002070110101535).' =>
            '',
        'Send new outgoing mail from this ticket' => '',
        'Send notifications to users.' => 'Skicka notifieringar till användare.',
        'Sender type for new tickets from the customer inteface.' => '',
        'Sends agent follow-up notification only to the owner, if a ticket is unlocked (the default is to send the notification to all agents).' =>
            '',
        'Sends all outgoing email via bcc to the specified address. Please use this only for backup reasons.' =>
            'Skickar alla utgående e-brev med blind-kopia till följande adress. Använd endast av backup-orsak.',
        'Sends customer notifications just to the mapped customer.' => '',
        'Sends registration information to OTOBO group.' => '',
        'Sends reminder notifications of unlocked ticket after reaching the reminder date (only sent to ticket owner).' =>
            '',
        'Sends the notifications which are configured in the admin interface under "Ticket Notifications".' =>
            '',
        'Sent "%s" notification to "%s" via "%s".' => '',
        'Sent auto follow-up to "%s".' => '',
        'Sent auto reject to "%s".' => '',
        'Sent auto reply to "%s".' => '',
        'Sent email to "%s".' => '',
        'Sent email to customer.' => '',
        'Sent notification to "%s".' => '',
        'Serbian Cyrillic' => '',
        'Serbian Latin' => '',
        'Service Level Agreements' => 'Servicenivåavtal',
        'Service view' => 'Tjänste-vy',
        'ServiceView' => '',
        'Set a new password by filling in your current password and a new one.' =>
            '',
        'Set sender email addresses for this system.' => '',
        'Set the default height (in pixels) of inline HTML articles in AgentTicketZoom.' =>
            '',
        'Set the limit of tickets that will be executed on a single genericagent job execution.' =>
            '',
        'Set the maximum height (in pixels) of inline HTML articles in AgentTicketZoom.' =>
            '',
        'Set the minimum log level. If you select \'error\', just errors are logged. With \'debug\' you get all logging messages. The order of log levels is: \'debug\', \'info\', \'notice\' and \'error\'.' =>
            '',
        'Set this ticket to pending' => 'Sätt ärendet som väntande',
        'Sets if SLA must be selected by the agent.' => '',
        'Sets if SLA must be selected by the customer.' => '',
        'Sets if note must be filled in by the agent. Can be overwritten by Ticket::Frontend::NeedAccountedTime.' =>
            '',
        'Sets if queue must be selected by the agent.' => '',
        'Sets if service must be selected by the agent.' => '',
        'Sets if service must be selected by the customer.' => '',
        'Sets if state must be selected by the agent.' => '',
        'Sets if ticket owner must be selected by the agent.' => '',
        'Sets if ticket responsible must be selected by the agent.' => '',
        'Sets the PendingTime of a ticket to 0 if the state is changed to a non-pending state.' =>
            '',
        'Sets the age in minutes (first level) for highlighting queues that contain untouched tickets.' =>
            '',
        'Sets the age in minutes (second level) for highlighting queues that contain untouched tickets.' =>
            '',
        'Sets the configuration level of the administrator. Depending on the config level, some sysconfig options will be not shown. The config levels are in in ascending order: Expert, Advanced, Beginner. The higher the config level is (e.g. Beginner is the highest), the less likely is it that the user can accidentally configure the system in a way that it is not usable any more.' =>
            '',
        'Sets the count of articles visible in preview mode of ticket overviews.' =>
            '',
        'Sets the default article customer visibility for new email tickets in the agent interface.' =>
            '',
        'Sets the default article customer visibility for new phone tickets in the agent interface.' =>
            '',
        'Sets the default article customer visibility for quick close action in the agent interface.' =>
            '',
        'Sets the default body text for notes added in the close ticket screen of the agent interface.' =>
            '',
        'Sets the default body text for notes added in the ticket move screen of the agent interface.' =>
            '',
        'Sets the default body text for notes added in the ticket note screen of the agent interface.' =>
            '',
        'Sets the default body text for notes added in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            '',
        'Sets the default body text for notes added in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            '',
        'Sets the default body text for notes added in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            '',
        'Sets the default body text for notes added in the ticket responsible screen of the agent interface.' =>
            '',
        'Sets the default error message for the login screen on Agent and Customer interface, it\'s shown when a running system maintenance period is active.' =>
            '',
        'Sets the default link type of split tickets in the agent interface.' =>
            '',
        'Sets the default link type of splitted tickets in the agent interface.' =>
            '',
        'Sets the default message for the login screen on Agent and Customer interface, it\'s shown when a running system maintenance period is active.' =>
            '',
        'Sets the default message for the notification is shown on a running system maintenance period.' =>
            '',
        'Sets the default next state for new phone tickets in the agent interface.' =>
            '',
        'Sets the default next ticket state, after the creation of an email ticket in the agent interface.' =>
            '',
        'Sets the default note text for new telephone tickets. E.g \'New ticket via call\' in the agent interface.' =>
            '',
        'Sets the default priority for new email tickets in the agent interface.' =>
            '',
        'Sets the default priority for new phone tickets in the agent interface.' =>
            '',
        'Sets the default sender type for new email tickets in the agent interface.' =>
            '',
        'Sets the default sender type for new phone ticket in the agent interface.' =>
            '',
        'Sets the default subject for new email tickets (e.g. \'email Outbound\') in the agent interface.' =>
            '',
        'Sets the default subject for new phone tickets (e.g. \'Phone call\') in the agent interface.' =>
            '',
        'Sets the default subject for notes added in the close ticket screen of the agent interface.' =>
            '',
        'Sets the default subject for notes added in the ticket move screen of the agent interface.' =>
            '',
        'Sets the default subject for notes added in the ticket note screen of the agent interface.' =>
            '',
        'Sets the default subject for notes added in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            '',
        'Sets the default subject for notes added in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            '',
        'Sets the default subject for notes added in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            '',
        'Sets the default subject for notes added in the ticket responsible screen of the agent interface.' =>
            '',
        'Sets the default text for new email tickets in the agent interface.' =>
            '',
        'Sets the inactivity time (in seconds) to pass before a session is killed and a user is logged out.' =>
            '',
        'Sets the maximum number of active agents within the timespan defined in SessionActiveTime before a prior warning will be visible for the logged in agents.' =>
            '',
        'Sets the maximum number of active agents within the timespan defined in SessionMaxIdleTime.' =>
            '',
        'Sets the maximum number of active customers within the timespan defined in SessionMaxIdleTime.' =>
            '',
        'Sets the maximum number of active sessions per agent within the timespan defined in SessionMaxIdleTime.' =>
            '',
        'Sets the maximum number of active sessions per customers within the timespan defined in SessionMaxIdleTime.' =>
            '',
        'Sets the method PGP will use to sing and encrypt emails. Note Inline method is not compatible with RichText messages.' =>
            '',
        'Sets the minimal ticket counter size if "AutoIncrement" was selected as TicketNumberGenerator. Default is 5, this means the counter starts from 10000.' =>
            '',
        'Sets the minutes a notification is shown for notice about upcoming system maintenance period.' =>
            '',
        'Sets the number of lines that are displayed in text messages (e.g. ticket lines in the QueueZoom).' =>
            '',
        'Sets the options for PGP binary.' => '',
        'Sets the password for private PGP key.' => 'Lösenordet för den privata PGP-nyckeln.',
        'Sets the prefered time units (e.g. work units, hours, minutes).' =>
            '',
        'Sets the preferred digest to be used for PGP binary.' => '',
        'Sets the prefix to the scripts folder on the server, as configured on the web server. This setting is used as a variable, OTOBO_CONFIG_ScriptAlias which is found in all forms of messaging used by the application, to build links to the tickets within the system.' =>
            '',
        'Sets the queue in the ticket close screen of a zoomed ticket in the agent interface.' =>
            '',
        'Sets the queue in the ticket free text screen of a zoomed ticket in the agent interface.' =>
            '',
        'Sets the queue in the ticket note screen of a zoomed ticket in the agent interface.' =>
            '',
        'Sets the queue in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            '',
        'Sets the queue in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            '',
        'Sets the queue in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            '',
        'Sets the queue in the ticket responsible screen of a zoomed ticket in the agent interface.' =>
            '',
        'Sets the responsible agent of the ticket in the close ticket screen of the agent interface.' =>
            '',
        'Sets the responsible agent of the ticket in the ticket bulk screen of the agent interface.' =>
            '',
        'Sets the responsible agent of the ticket in the ticket free text screen of the agent interface.' =>
            '',
        'Sets the responsible agent of the ticket in the ticket note screen of the agent interface.' =>
            '',
        'Sets the responsible agent of the ticket in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            '',
        'Sets the responsible agent of the ticket in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            '',
        'Sets the responsible agent of the ticket in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            '',
        'Sets the responsible agent of the ticket in the ticket responsible screen of the agent interface.' =>
            '',
        'Sets the service in the close ticket screen of the agent interface (Ticket::Service needs to be enabled).' =>
            '',
        'Sets the service in the ticket free text screen of the agent interface (Ticket::Service needs to be enabled).' =>
            '',
        'Sets the service in the ticket note screen of the agent interface (Ticket::Service needs to be enabled).' =>
            '',
        'Sets the service in the ticket owner screen of a zoomed ticket in the agent interface (Ticket::Service needs to be enabled).' =>
            '',
        'Sets the service in the ticket pending screen of a zoomed ticket in the agent interface (Ticket::Service needs to be enabled).' =>
            '',
        'Sets the service in the ticket priority screen of a zoomed ticket in the agent interface (Ticket::Service needs to be enabled).' =>
            '',
        'Sets the service in the ticket responsible screen of the agent interface (Ticket::Service needs to be enabled).' =>
            '',
        'Sets the state of a ticket in the close ticket screen of the agent interface.' =>
            '',
        'Sets the state of a ticket in the ticket bulk screen of the agent interface.' =>
            '',
        'Sets the state of a ticket in the ticket free text screen of the agent interface.' =>
            '',
        'Sets the state of a ticket in the ticket note screen of the agent interface.' =>
            '',
        'Sets the state of a ticket in the ticket responsible screen of the agent interface.' =>
            '',
        'Sets the state of the ticket in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            '',
        'Sets the state of the ticket in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            '',
        'Sets the state of the ticket in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            '',
        'Sets the stats hook.' => '',
        'Sets the ticket owner in the close ticket screen of the agent interface.' =>
            '',
        'Sets the ticket owner in the ticket bulk screen of the agent interface.' =>
            '',
        'Sets the ticket owner in the ticket free text screen of the agent interface.' =>
            '',
        'Sets the ticket owner in the ticket note screen of the agent interface.' =>
            '',
        'Sets the ticket owner in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            '',
        'Sets the ticket owner in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            '',
        'Sets the ticket owner in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            '',
        'Sets the ticket owner in the ticket responsible screen of the agent interface.' =>
            '',
        'Sets the ticket type in the close ticket screen of the agent interface (Ticket::Type needs to be enabled).' =>
            '',
        'Sets the ticket type in the ticket bulk screen of the agent interface.' =>
            '',
        'Sets the ticket type in the ticket free text screen of the agent interface (Ticket::Type needs to be enabled).' =>
            '',
        'Sets the ticket type in the ticket note screen of the agent interface (Ticket::Type needs to be enabled).' =>
            '',
        'Sets the ticket type in the ticket owner screen of a zoomed ticket in the agent interface (Ticket::Type needs to be enabled).' =>
            '',
        'Sets the ticket type in the ticket pending screen of a zoomed ticket in the agent interface (Ticket::Type needs to be enabled).' =>
            '',
        'Sets the ticket type in the ticket priority screen of a zoomed ticket in the agent interface (Ticket::Type needs to be enabled).' =>
            '',
        'Sets the ticket type in the ticket responsible screen of the agent interface (Ticket::Type needs to be enabled).' =>
            '',
        'Sets the time zone being used internally by OTOBO to e. g. store dates and times in the database. WARNING: This setting must not be changed once set and tickets or any other data containing date/time have been created.' =>
            '',
        'Sets the time zone that will be assigned to newly created users and will be used for users that haven\'t yet set a time zone. This is the time zone being used as default to convert date and time between the OTOBO time zone and the user\'s time zone.' =>
            '',
        'Sets the timeout (in seconds) for http/ftp downloads.' => '',
        'Sets the timeout (in seconds) for package downloads. Overwrites "WebUserAgent::Timeout".' =>
            '',
        'Settings for the customer login screen.' => '',
        'Shared Secret' => '',
        'Show a responsible selection in phone and email tickets in the agent interface.' =>
            '',
        'Show article as rich text even if rich text writing is disabled.' =>
            '',
        'Show command line output.' => '',
        'Show queues even when only locked tickets are in.' => '',
        'Show the current owner in the customer interface.' => '',
        'Show the current queue in the customer interface.' => '',
        'Show the history for this ticket' => '',
        'Show the ticket history' => 'Visa ärende-historik',
        'Show various content.' => '',
        'Shows a count of attachments in the ticket zoom, if the article has attachments.' =>
            '',
        'Shows a link in the menu for creating a calendar appointment linked to the ticket directly from the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu for subscribing / unsubscribing from a ticket in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu that allows linking a ticket with another object in the ticket zoom view of the agent interface.  Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu that allows merging tickets in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to access the history of a ticket in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to add a free text field in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to add a note in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to add a note to a ticket in every ticket overview of the agent interface.' =>
            '',
        'Shows a link in the menu to add a phone call inbound in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to add a phone call outbound in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to change the customer who requested the ticket in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to change the owner of a ticket in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to change the responsible agent of a ticket in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to close a ticket in every ticket overview of the agent interface.' =>
            '',
        'Shows a link in the menu to close a ticket in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to delete a ticket in every ticket overview of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2".' =>
            '',
        'Shows a link in the menu to delete a ticket in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to enroll a ticket into a process in the ticket zoom view of the agent interface.' =>
            '',
        'Shows a link in the menu to go back in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to lock / unlock a ticket in the ticket overviews of the agent interface.' =>
            '',
        'Shows a link in the menu to lock/unlock tickets in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to move a ticket in every ticket overview of the agent interface.' =>
            '',
        'Shows a link in the menu to print a ticket or an article in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to quick close a ticket in every ticket overview of the agent interface.' =>
            '',
        'Shows a link in the menu to quick close a ticket in the ticket zoom view of the agent interface.' =>
            '',
        'Shows a link in the menu to see the history of a ticket in every ticket overview of the agent interface.' =>
            '',
        'Shows a link in the menu to see the priority of a ticket in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to send an outbound email in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to set a ticket as junk in every ticket overview of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2".' =>
            '',
        'Shows a link in the menu to set a ticket as pending in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to set the priority of a ticket in every ticket overview of the agent interface.' =>
            '',
        'Shows a link in the menu to zoom a ticket in the ticket overviews of the agent interface.' =>
            '',
        'Shows a link to access article attachments via a html online viewer in the zoom view of the article in the agent interface.' =>
            '',
        'Shows a link to download article attachments in the zoom view of the article in the agent interface.' =>
            '',
        'Shows a link to see a zoomed email ticket in plain text.' => '',
        'Shows a link to set a ticket as junk in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a list of all the involved agents on this ticket, in the close ticket screen of the agent interface.' =>
            '',
        'Shows a list of all the involved agents on this ticket, in the ticket free text screen of the agent interface.' =>
            '',
        'Shows a list of all the involved agents on this ticket, in the ticket note screen of the agent interface.' =>
            '',
        'Shows a list of all the involved agents on this ticket, in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            '',
        'Shows a list of all the involved agents on this ticket, in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            '',
        'Shows a list of all the involved agents on this ticket, in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            '',
        'Shows a list of all the involved agents on this ticket, in the ticket responsible screen of the agent interface.' =>
            '',
        'Shows a list of all the possible agents (all agents with note permissions on the queue/ticket) to determine who should be informed about this note, in the close ticket screen of the agent interface.' =>
            '',
        'Shows a list of all the possible agents (all agents with note permissions on the queue/ticket) to determine who should be informed about this note, in the ticket free text screen of the agent interface.' =>
            '',
        'Shows a list of all the possible agents (all agents with note permissions on the queue/ticket) to determine who should be informed about this note, in the ticket note screen of the agent interface.' =>
            '',
        'Shows a list of all the possible agents (all agents with note permissions on the queue/ticket) to determine who should be informed about this note, in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            '',
        'Shows a list of all the possible agents (all agents with note permissions on the queue/ticket) to determine who should be informed about this note, in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            '',
        'Shows a list of all the possible agents (all agents with note permissions on the queue/ticket) to determine who should be informed about this note, in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            '',
        'Shows a list of all the possible agents (all agents with note permissions on the queue/ticket) to determine who should be informed about this note, in the ticket responsible screen of the agent interface.' =>
            '',
        'Shows a preview of the ticket overview (CustomerInfo => 1 - shows also Customer-Info, CustomerInfoMaxSize max. size in characters of Customer-Info).' =>
            '',
        'Shows all both ro and rw queues in the queue view.' => '',
        'Shows all both ro and rw tickets in the service view.' => '',
        'Shows all the articles of the ticket (expanded) in the agent zoom view.' =>
            '',
        'Shows all the articles of the ticket (expanded) in the customer zoom view.' =>
            '',
        'Shows all the customer identifiers in a multi-select field (not useful if you have a lot of customer identifiers).' =>
            '',
        'Shows all the customer user identifiers in a multi-select field (not useful if you have a lot of customer user identifiers).' =>
            '',
        'Shows an owner selection in phone and email tickets in the agent interface.' =>
            '',
        'Shows customer history tickets in AgentTicketPhone, AgentTicketEmail and AgentTicketCustomer.' =>
            '',
        'Shows either the last customer article\'s subject or the ticket title in the small format overview.' =>
            '',
        'Shows existing parent/child queue lists in the system in the form of a tree or a list.' =>
            '',
        'Shows information on how to start OTOBO Daemon' => '',
        'Shows link to external page in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2".' =>
            '',
        'Shows the article head information in the agent zoom view.' => '',
        'Shows the articles sorted normally or in reverse, under ticket zoom in the agent interface.' =>
            '',
        'Shows the customer user information (phone and email) in the compose screen.' =>
            '',
        'Shows the enabled ticket attributes in the customer interface (0 = Disabled and 1 = Enabled).' =>
            '',
        'Shows the message of the day (MOTD) in the agent dashboard. "Group" is used to restrict access to the plugin (e. g. Group: admin;group1;group2;). "Default" indicates if the plugin is enabled by default or if the user needs to enable it manually. "Mandatory" determines if the plugin is always shown and can not be removed by agents.' =>
            '',
        'Shows the message of the day on login screen of the agent interface.' =>
            '',
        'Shows the ticket history (reverse ordered) in the agent interface.' =>
            '',
        'Shows the ticket priority options in the close ticket screen of the agent interface.' =>
            '',
        'Shows the ticket priority options in the move ticket screen of the agent interface.' =>
            '',
        'Shows the ticket priority options in the ticket bulk screen of the agent interface.' =>
            '',
        'Shows the ticket priority options in the ticket free text screen of the agent interface.' =>
            '',
        'Shows the ticket priority options in the ticket note screen of the agent interface.' =>
            '',
        'Shows the ticket priority options in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            '',
        'Shows the ticket priority options in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            '',
        'Shows the ticket priority options in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            '',
        'Shows the ticket priority options in the ticket responsible screen of the agent interface.' =>
            '',
        'Shows the title field in the close ticket screen of the agent interface.' =>
            '',
        'Shows the title field in the ticket free text screen of the agent interface.' =>
            '',
        'Shows the title field in the ticket note screen of the agent interface.' =>
            '',
        'Shows the title field in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            '',
        'Shows the title field in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            '',
        'Shows the title field in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            '',
        'Shows the title field in the ticket responsible screen of the agent interface.' =>
            '',
        'Shows time in long format (days, hours, minutes), if enabled; or in short format (days, hours), if not enabled.' =>
            '',
        'Shows time use complete description (days, hours, minutes), if enabled; or just first letter (d, h, m), if not enabled.' =>
            '',
        'Signature data.' => '',
        'Signatures' => 'Signaturer',
        'Simple' => '',
        'Skin' => 'Tema',
        'Slovak' => 'Slovakiska',
        'Slovenian' => 'Slovenska',
        'Small' => 'Liten',
        'Software Package Manager.' => '',
        'Solution time' => '',
        'SolutionDiffInMin' => 'Lösningstidsskillnad',
        'SolutionInMin' => 'Lösningstid',
        'Some description!' => 'En beskrivning.',
        'Some picture description!' => 'En bildbeskrivning.',
        'Sorts the tickets (ascendingly or descendingly) when a single queue is selected in the queue view and after the tickets are sorted by priority. Values: 0 = ascending (oldest on top, default), 1 = descending (youngest on top). Use the QueueID for the key and 0 or 1 for value.' =>
            '',
        'Sorts the tickets (ascendingly or descendingly) when a single queue is selected in the service view and after the tickets are sorted by priority. Values: 0 = ascending (oldest on top, default), 1 = descending (youngest on top). Use the ServiceID for the key and 0 or 1 for value.' =>
            '',
        'Spam' => '',
        'Spam Assassin example setup. Ignores emails that are marked with SpamAssassin.' =>
            'Exempelkonfiguration för Spam assassin. Ignorerar spam-märkta e-brev.',
        'Spam Assassin example setup. Moves marked mails to spam queue.' =>
            'Exempelkonfiguration för Spam assassin. Flyttar spam-märkta e-brev till spamkön.',
        'Spanish' => 'Spanska',
        'Spanish (Colombia)' => 'Spanska (Colombia)',
        'Spanish (Mexico)' => 'Spanska (Mexiko)',
        'Spanish stop words for fulltext index. These words will be removed from the search index.' =>
            '',
        'Specifies if an agent should receive email notification of his own actions.' =>
            'Aktiverar att handläggare får e-postmeddelande för egna åtgärder.',
        'Specifies the directory to store the data in, if "FS" was selected for ArticleStorage.' =>
            '',
        'Specifies the directory where SSL certificates are stored.' => 'Katalogen för SSL-certifikat.',
        'Specifies the directory where private SSL certificates are stored.' =>
            'Katalogen för privata SSL-certifikat.',
        'Specifies the email address that should be used by the application when sending notifications. The email address is used to build the complete display name for the notification master (i.e. "OTOBO Notifications" otobo@your.example.com). You can use the OTOBO_CONFIG_FQDN variable as set in your configuation, or choose another email address.' =>
            '',
        'Specifies the email addresses to get notification messages from scheduler tasks.' =>
            '',
        'Specifies the group where the user needs rw permissions so that he can access the "SwitchToCustomer" feature.' =>
            '',
        'Specifies the group where the user needs rw permissions so that they can edit other users preferences.' =>
            '',
        'Specifies the name that should be used by the application when sending notifications. The sender name is used to build the complete display name for the notification master (i.e. "OTOBO Notifications" otobo@your.example.com).' =>
            '',
        'Specifies the order in which the firstname and the lastname of agents will be displayed.' =>
            '',
        'Specifies the path of the file for the logo in the page header (gif|jpg|png, 700 x 100 pixel).' =>
            '',
        'Specifies the path of the file for the performance log.' => '',
        'Specifies the path to the converter that allows the view of Microsoft Excel files, in the web interface.' =>
            '',
        'Specifies the path to the converter that allows the view of Microsoft Word files, in the web interface.' =>
            '',
        'Specifies the path to the converter that allows the view of PDF documents, in the web interface.' =>
            '',
        'Specifies the path to the converter that allows the view of XML files, in the web interface.' =>
            '',
        'Specifies the text that should appear in the log file to denote a CGI script entry.' =>
            '',
        'Specifies user id of the postmaster data base.' => '',
        'Specifies whether all storage backends should be checked when looking for attachments. This is only required for installations where some attachments are in the file system, and others in the database.' =>
            '',
        'Specifies whether the (MIMEBase) article attachments will be indexed and searchable.' =>
            '',
        'Specify how many sub directory levels to use when creating cache files. This should prevent too many cache files being in one directory.' =>
            '',
        'Specify the password to authenticate for the first mirror database.' =>
            'Specificera lösenordet för autentisering av den första spegeldatabasen.',
        'Specify the username to authenticate for the first mirror database.' =>
            'Specificera användarnamnet för autentisering av den första spegeldatabasen.',
        'Standard available permissions for agents within the application. If more permissions are needed, they can be entered here. Permissions must be defined to be effective. Some other good permissions have also been provided built-in: note, close, pending, customer, freetext, move, compose, responsible, forward and bounce. Make sure that "rw" is always the last registered permission, as rw automatically grants all additional permissions.' =>
            '',
        'Start number for statistics counting. Every new stat increments this number.' =>
            '',
        'Started response time escalation.' => '',
        'Started solution time escalation.' => '',
        'Started update time escalation.' => '',
        'Starts a wildcard search of the active object after the link object mask is started.' =>
            '',
        'Stat#' => 'Rapport#',
        'States' => 'Status',
        'Statistics overview.' => '',
        'Statistics reports.' => '',
        'Status view' => 'Status-vy',
        'Stopped response time escalation.' => '',
        'Stopped solution time escalation.' => '',
        'Stopped update time escalation.' => '',
        'Stores cookies after the browser has been closed.' => '',
        'Strips empty lines on the ticket preview in the queue view.' => '',
        'Strips empty lines on the ticket preview in the service view.' =>
            '',
        'Support Agent' => '',
        'Suspend already escalated tickets.' => '',
        'Swahili' => 'Swahili',
        'Swedish' => 'Svenska',
        'System Address Display Name' => '',
        'System Configuration Deployment' => '',
        'System Configuration Group' => '',
        'System Configuration Setting History' => '',
        'System Maintenance' => 'Systemunderhåll',
        'Templates ↔ Attachments' => '',
        'Templates ↔ Queues' => '',
        'Textarea' => 'Textarea',
        'Thai' => 'Thai',
        'The PGP signature is expired.' => '',
        'The PGP signature was made by a revoked key, this could mean that the signature is forged.' =>
            '',
        'The PGP signature was made by an expired key.' => '',
        'The PGP signature with the keyid has not been verified successfully.' =>
            '',
        'The PGP signature with the keyid is good.' => '',
        'The agent skin\'s InternalName which should be used in the agent interface. Please check the available skins in Frontend::Agent::Skins.' =>
            '',
        'The customer skin\'s InternalName which should be used in the customer interface. Please check the available skins in Frontend::Customer::Skins.' =>
            '',
        'The daemon registration for sync with S3.' => '',
        'The daemon registration for the scheduler cron task manager.' =>
            '',
        'The daemon registration for the scheduler future task manager.' =>
            '',
        'The daemon registration for the scheduler generic agent task manager.' =>
            '',
        'The daemon registration for the scheduler task worker.' => '',
        'The daemon registration for the system configuration deployment sync manager.' =>
            '',
        'The divider between TicketHook and ticket number. E.g \': \'.' =>
            '',
        'The duration in minutes after emitting an event, in which the new escalation notify and start events are suppressed.' =>
            '',
        'The format of the subject. \'Left\' means \'[TicketHook#:12345] Some Subject\', \'Right\' means \'Some Subject [TicketHook#:12345]\', \'None\' means \'Some Subject\' and no ticket number. In the latter case you should verify that the setting PostMaster::CheckFollowUpModule###0200-References is activated to recognize followups based on email headers.' =>
            '',
        'The headline shown in the customer interface.' => 'Rubriken som visas i kundgränssnittet.',
        'The identifier for a ticket, e.g. Ticket#, Call#, MyTicket#. The default is Ticket#.' =>
            '',
        'The logo and signet shown in the header of the customer interface. The URL to the image can be a relative URL to the skin image directory, or a full URL to a remote web server. The signet will be scaled to 32px*32px, the logo to 196px*32px. (In the mobile setup both have a height of 24px with variable length.)' =>
            '',
        'The logo shown in the header of the agent interface for the skin "default". See "AgentLogo" for further description.' =>
            '',
        'The logo shown in the header of the agent interface. The URL to the image can be a relative URL to the skin image directory, or a full URL to a remote web server.' =>
            '',
        'The logo shown on top of the login box of the agent interface. The URL to the image can be a relative URL to the skin image directory, or a full URL to a remote web server.' =>
            '',
        'The maximal number of articles expanded on a single page in AgentTicketZoom.' =>
            'Det maximala antalet artiklar som utökats på en sida i AgentTicketZoom.',
        'The maximal number of articles shown on a single page in AgentTicketZoom.' =>
            'Det maximala antalet artiklar som visas på en sida i AgentTicketZoom.',
        'The maximum number of mails fetched at once before reconnecting to the server.' =>
            'Det maximala antalet e-post som hämtas på en gång innan återanslutning till servern.',
        'The secret you supplied is invalid. The secret must only contain letters (A-Z, uppercase) and numbers (2-7) and must consist of 16 characters.' =>
            '',
        'The text at the beginning of the subject in an email reply, e.g. RE, AW, or AS.' =>
            '',
        'The text at the beginning of the subject when an email is forwarded, e.g. FW, Fwd, or WG.' =>
            '',
        'The value of the From field' => '',
        'Theme' => 'Tema',
        'This configuration defines all possible screens to enable or disable default columns.' =>
            '',
        'This configuration defines all possible screens to enable or disable dynamic fields.' =>
            '',
        'This configuration defines if only valids or all (invalids) dynamic fields should be shown.' =>
            '',
        'This configuration defines the number of iterations that should be performed at max for calculating the WorkingTime for a Ticket. Attention: Setting this configuration to high can lead to performance issues.' =>
            '',
        'This configuration registers an OutputFilter module that injects the javascript functionality to remove PendingTime.' =>
            '',
        'This event module stores attributes from CustomerUser as DynamicFields tickets. Please see DynamicFieldFromCustomerUser::Mapping setting for how to configure the mapping.' =>
            '',
        'This is a Description for Comment on Framework.' => '',
        'This is a Description for DynamicField on Framework.' => '',
        'This is the default orange - black skin for the customer interface.' =>
            '',
        'This is the default orange - black skin.' => '',
        'This key is not certified with a trusted signature!' => '',
        'This module and its PreRun() function will be executed, if defined, for every request. This module is useful to check some user options or to display news about new applications.' =>
            '',
        'This module is being used to extend the password policy.' => '',
        'This module is part of the admin area of OTOBO.' => '',
        'This option defines the dynamic field in which a Process Management activity entity id is stored.' =>
            '',
        'This option defines the dynamic field in which a Process Management process entity id is stored.' =>
            '',
        'This option defines the process tickets default lock.' => '',
        'This option defines the process tickets default priority.' => '',
        'This option defines the process tickets default queue.' => '',
        'This option defines the process tickets default state.' => '',
        'This option will deny the access to customer company tickets, which are not created by the customer user.' =>
            '',
        'This setting allows you to override the built-in country list with your own list of countries. This is particularly handy if you just want to use a small select group of countries.' =>
            '',
        'This setting is deprecated. Set OTOBOTimeZone instead.' => '',
        'This setting shows the sorting attributes in all overview screen, not only in queue view.' =>
            '',
        'Ticket Close' => '',
        'Ticket Close.' => '',
        'Ticket Compose Bounce Email.' => '',
        'Ticket Compose email Answer.' => '',
        'Ticket Customer.' => '',
        'Ticket Forward Email.' => '',
        'Ticket FreeText.' => '',
        'Ticket History.' => '',
        'Ticket Lock.' => '',
        'Ticket Merge.' => '',
        'Ticket Move.' => 'Ärende Flytta.',
        'Ticket Note.' => '',
        'Ticket Notifications' => 'Ärendemeddelanden',
        'Ticket Outbound Email.' => '',
        'Ticket Overview "Medium" Limit' => 'Ärendeöversikt "mellan"',
        'Ticket Overview "Preview" Limit' => 'Ärendeöversikt "förhandsgranskning"',
        'Ticket Overview "Small" Limit' => 'Ärendeöversikt "liten"',
        'Ticket Owner.' => '',
        'Ticket Pending.' => '',
        'Ticket Print.' => '',
        'Ticket Priority.' => '',
        'Ticket Queue Overview' => 'Kö-översikt',
        'Ticket Responsible.' => '',
        'Ticket Watcher' => '',
        'Ticket Zoom' => '',
        'Ticket Zoom.' => '',
        'Ticket attributes that should be available in ticket invoker configuration frontend (0 = visible/selectable, 1 = default/preselected).' =>
            '',
        'Ticket bulk module.' => '',
        'Ticket event module that triggers the escalation stop events.' =>
            '',
        'Ticket limit per page for Ticket Overview "Medium".' => '',
        'Ticket limit per page for Ticket Overview "Preview".' => '',
        'Ticket limit per page for Ticket Overview "Small".' => '',
        'Ticket notifications' => 'Ärendemeddelanden',
        'Ticket overview' => 'Ärendeöversikt',
        'Ticket plain view of an email.' => '',
        'Ticket split dialog.' => '',
        'Ticket title' => '',
        'Ticket zoom view.' => '',
        'TicketNumber' => 'Ärendenummer',
        'Tickets in the following queues will not be stored on the Elasticsearch server. To apply this to existing tickets, the ticket migration has to be run via console, after changing this option.' =>
            '',
        'Tickets.' => 'Ärenden.',
        'Tile registration for the CustomerDashboard. Module is required.' =>
            '',
        'Time in seconds that gets added to the actual time if setting a pending-state (default: 86400 = 1 day).' =>
            '',
        'To accept login information, such as an EULA or license.' => '',
        'To download attachments.' => '',
        'To view HTML attachments.' => '',
        'Toggles display of OTOBO FeatureAddons list in PackageManager.' =>
            'Växla visning av FeatureAddons i pakethanteraren.',
        'Toolbar Item for a shortcut. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2".' =>
            '',
        'Transport selection for appointment notifications. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.' =>
            '',
        'Transport selection for ticket notifications. Please note: setting \'Active\' to 0 will only prevent agents from editing settings of this group in their personal preferences, but will still allow administrators to edit the settings of another user\'s behalf. Use \'PreferenceGroup\' to control in which area these settings should be shown in the user interface.' =>
            '',
        'Tree view' => 'Träd-vy',
        'Triggers add or update of automatic calendar appointments based on certain ticket times.' =>
            '',
        'Triggers ticket escalation events and notification events for escalation.' =>
            '',
        'Turkish' => 'Turkiska',
        'Turns off SSL certificate validation, for example if you use a transparent HTTPS proxy. Use at your own risk!' =>
            '',
        'Turns on drag and drop for the main navigation.' => '',
        'Turns on the remote ip address check. It should not be enabled if the application is used, for example, via a proxy farm or a dialup connection, because the remote ip address is mostly different for the requests.' =>
            '',
        'Tweak the system as you wish.' => '',
        'Type of daemon log rotation to use: Choose \'OTOBO\' to let OTOBO system to handle the file rotation, or choose \'External\' to use a 3rd party rotation mechanism (i.e. logrotate). Note: External rotation mechanism requires its own and independent configuration.' =>
            '',
        'Ukrainian' => 'Ukrainska',
        'Unlock tickets that are past their unlock timeout.' => '',
        'Unlock tickets whenever a note is added and the owner is out of office.' =>
            '',
        'Unlocked ticket.' => 'Upplåst ärende.',
        'Up' => 'Upp',
        'Upcoming Events' => 'Kommande händelser',
        'Update Ticket "Seen" flag if every article got seen or a new Article got created.' =>
            '',
        'Update time' => '',
        'Updates the ticket escalation index after a ticket attribute got updated.' =>
            '',
        'Updates the ticket index accelerator.' => '',
        'Upload your PGP key.' => '',
        'Upload your S/MIME certificate.' => '',
        'Use Redis::Fast instead of Redis.' => '',
        'Use new type of select and autocomplete fields in agent interface, where applicable (InputFields).' =>
            '',
        'Use specified Redis logical database.' => '',
        'User Profile' => 'Användarprofil',
        'UserFirstname' => '',
        'UserLastname' => '',
        'Users, Groups & Roles' => '',
        'Uses richtext for viewing and editing ticket notification.' => 'Använder formatering för visning och redigering av ärendemeddelanden.',
        'Uses richtext for viewing and editing: articles, salutations, signatures, standard templates, auto responses and notifications.' =>
            '',
        'Vietnam' => 'Vietnam',
        'View performance benchmark results.' => '',
        'Watch this ticket' => 'Bevaka detta ärende',
        'Watched Tickets' => 'Bevakade ärenden',
        'Watched Tickets.' => 'Bevakade ärenden.',
        'We are performing scheduled maintenance.' => 'Schemalagt underhåll pågår.',
        'We are performing scheduled maintenance. Login is temporarily not available.' =>
            'Schemalagt underhåll pågår. Inloggning kan inte ske under tiden.',
        'We are performing scheduled maintenance. We should be back online shortly.' =>
            'Schemalagt underhåll pågår. OTOBO-instansen är snart tillgänglig igen.',
        'We have changed the default ticket unlock behaviour in OTOBO 10.1. Now, the ticket is not only unlocked, but also handed over to the system user again. Thus, the behaviour is clearer, but it is no longer possible to read out who last edited the ticket. Please deactivate this option to restore the behaviour of OTRS version 2-6 and OTOBO 10..' =>
            '',
        'Web Service' => '',
        'Web Services' => 'Webbtjänster',
        'Welcome text for the dashboard header. Name will be inserted to %s of the WelcomeText. "UserTitle", "UserFirstname", "UserLastname", "UserEmail" and "UserLogin" will be substituted.' =>
            '',
        'When agent creates a ticket, whether or not the ticket is automatically locked to the agent.' =>
            '',
        'When tickets are merged, a note will be added automatically to the ticket which is no longer active. Here you can define the body of this note (this text cannot be changed by the agent).' =>
            '',
        'When tickets are merged, a note will be added automatically to the ticket which is no longer active. Here you can define the subject of this note (this subject cannot be changed by the agent).' =>
            '',
        'When tickets are merged, the customer can be informed per email by setting the check box "Inform Sender". In this text area, you can define a pre-formatted text which can later be modified by the agents.' =>
            '',
        'Whether extended customer information is shown in the ticket print screen of the customer interface.' =>
            '',
        'Whether fields should be automatically filled (1), and in that case also be hidden from ticket formulars (2).' =>
            '',
        'Whether or not to collect meta information from articles using filters configured in Ticket::Frontend::ZoomCollectMetaFilters.' =>
            '',
        'Whether the execution of TicketACL can be avoided by checking cached field dependencies. This can improve loading times of ticket formulars, but has to be disabled, if ACLModules are to be used for Ticket- and Form-ReturnTypes.' =>
            '',
        'Whether to force redirect all requests from http to https protocol. Please check that your web server is configured correctly for https protocol before enable this option.' =>
            '',
        'Yes, but hide archived tickets' => 'Ja, men dölj arkiverade ärenden',
        'Your email with ticket number "<OTOBO_TICKET>" is bounced to "<OTOBO_BOUNCE_TO>". Contact this address for further information.' =>
            'Ditt e-brev med ärendenummer "<OTOBO_TICKET>" studsades till "<OTOBO_BOUNCE_TO>". För mer information kontakta dem.',
        'Your email with ticket number "<OTOBO_TICKET>" is merged to "<OTOBO_MERGE_TO_TICKET>".' =>
            'Ditt ärende "<OTOBO_TICKET>" har slagits samman med "<OTOBO_MERGE_TO_TICKET>".',
        'Your queue selection of your preferred queues. You also get notified about those queues via email if enabled.' =>
            '',
        'Your service selection of your preferred services. You also get notified about those services via email if enabled.' =>
            '',
        'Zoom' => 'Zooma',
        'attachment' => 'bilaga',
        'bounce' => '',
        'compose' => '',
        'debug' => '',
        'error' => 'fel',
        'forward' => '',
        'info' => '',
        'inline' => '',
        'normal' => 'normal',
        'notice' => '',
        'pending' => '',
        'phone' => 'telefon',
        'responsible' => '',
        'reverse' => 'baklänges',
        'stats' => '',

    };

    $Self->{JavaScriptStrings} = [
        ' ...and %s more',
        ' ...show less',
        '%s B',
        '%s GB',
        '%s KB',
        '%s MB',
        '%s TB',
        '+%s more',
        'A key with this name (\'%s\') already exists.',
        'A package upgrade was recently finished. Click here to see the results.',
        'A popup of this screen is already open. Do you want to close it and load this one instead?',
        'A preview of this website can\'t be provided because it didn\'t allow to be embedded.',
        'Add',
        'Add Event Trigger',
        'Add all',
        'Add entry',
        'Add key',
        'Add new draft',
        'Add new entry',
        'Add to favourites',
        'Agent',
        'All occurrences',
        'All-day',
        'An error occurred during communication.',
        'An error occurred! Please check the browser error log for more details!',
        'An item with this name is already present.',
        'An unconnected transition is already placed on the canvas. Please connect this transition first before placing another transition.',
        'An unknown error occurred when deleting the attachment. Please try again. If the error persists, please contact your system administrator.',
        'An unknown error occurred. Please contact the administrator.',
        'Apply',
        'Appointment',
        'Apr',
        'April',
        'Are you sure you want to delete this appointment? This operation cannot be undone.',
        'Are you sure you want to remove all user values?',
        'Are you sure you want to update all installed packages?',
        'Are you using a browser plugin like AdBlock or AdBlockPlus? This can cause several issues and we highly recommend you to add an exception for this domain.',
        'Article display',
        'Article filter',
        'As soon as you use this button or link, you will leave this screen and its current state will be saved automatically. Do you want to continue?',
        'Ascending sort applied, ',
        'Attachment was deleted successfully.',
        'Attachments',
        'Aug',
        'August',
        'Available space %s of %s.',
        'Basic information',
        'By restoring this deployment all settings will be reverted to the value they had at the time of the deployment. Do you really want to continue?',
        'Calendar',
        'Cancel',
        'Cannot proceed',
        'Clear',
        'Clear all',
        'Clear debug log',
        'Clear search',
        'Click to delete this attachment.',
        'Click to select a file for upload.',
        'Click to select a file or just drop it here.',
        'Click to select files or just drop them here.',
        'Click to select or drop files here.',
        'Clone web service',
        'Close preview',
        'Close this dialog',
        'Complex %s with %s arguments',
        'Confirm',
        'Could not open popup window. Please disable any popup blockers for this application.',
        'Current selection',
        'Currently not possible',
        'Customer interface does not support articles not visible for customers.',
        'Data Protection',
        'Date/Time',
        'Day',
        'Dec',
        'December',
        'Delete',
        'Delete Entity',
        'Delete conditions',
        'Delete draft',
        'Delete error handling module',
        'Delete field',
        'Delete invoker',
        'Delete operation',
        'Delete this Attachment',
        'Delete this Event Trigger',
        'Delete this Invoker',
        'Delete this Key Mapping',
        'Delete this Mail Account',
        'Delete this Operation',
        'Delete this PostMasterFilter',
        'Delete this Template',
        'Delete web service',
        'Deleting attachment...',
        'Deleting the field and its data. This may take a while...',
        'Deleting the mail account and its data. This may take a while...',
        'Deleting the postmaster filter and its data. This may take a while...',
        'Deleting the template and its data. This may take a while...',
        'Deploy',
        'Deploy now',
        'Deploying, please wait...',
        'Deployment comment...',
        'Deployment successful. You\'re being redirected...',
        'Descending sort applied, ',
        'Description',
        'Dismiss',
        'Do not show this warning again.',
        'Do you really want to continue?',
        'Do you really want to delete "%s"?',
        'Do you really want to delete this certificate?',
        'Do you really want to delete this dynamic field? ALL associated data will be LOST!',
        'Do you really want to delete this generic agent job?',
        'Do you really want to delete this key?',
        'Do you really want to delete this language?',
        'Do you really want to delete this link?',
        'Do you really want to delete this notification language?',
        'Do you really want to delete this notification?',
        'Do you really want to delete this report?',
        'Do you really want to delete this scheduled system maintenance?',
        'Do you really want to delete this statistic?',
        'Do you really want to reset this setting to it\'s default value?',
        'Do you really want to revert this setting to its historical value?',
        'Don\'t save, update manually',
        'Draft title',
        'Duplicate event.',
        'Duplicated entry',
        'Edit Field Details',
        'Edit this setting',
        'Edit this transition',
        'End date',
        'Error',
        'Error during AJAX communication',
        'Error during AJAX communication. Status: %s, Error: %s',
        'Error in the mail settings. Please correct and try again.',
        'Error: Browser Check failed!',
        'Event Type Filter',
        'Expanded',
        'Feb',
        'February',
        'Filters',
        'Finished',
        'First select a customer user, then select a customer ID to assign to this ticket.',
        'Fr',
        'Fri',
        'Friday',
        'Generate',
        'Generate Result',
        'Generating...',
        'Grouped',
        'Help',
        'Hide EntityIDs',
        'If you now leave this page, all open popup windows will be closed, too!',
        'Ignore',
        'Import web service',
        'Information about the OTOBO Daemon',
        'Invalid date (need a future date)!',
        'Invalid date (need a past date)!',
        'Invalid date!',
        'It is going to be deleted from the field, please try again.',
        'It is not possible to add a new event trigger because the event is not set.',
        'It is not possible to set this entry to invalid. All affected configuration settings have to be changed beforehand.',
        'It was not possible to delete this draft.',
        'It was not possible to generate the Support Bundle.',
        'Jan',
        'January',
        'Jul',
        'July',
        'Jump',
        'Jun',
        'June',
        'Just this occurrence',
        'Keys with values can\'t be renamed. Please remove this key/value pair instead and re-add it afterwards.',
        'Less',
        'Link',
        'Loading, please wait...',
        'Loading...',
        'Location',
        'Mail check successful.',
        'Mapping for Key',
        'Mapping for Key %s',
        'Mar',
        'March',
        'May',
        'May_long',
        'Migrate',
        'Mo',
        'Mon',
        'Monday',
        'Month',
        'More',
        'Name',
        'Namespace %s could not be initialized, because %s could not be found.',
        'Next',
        'No Data Available.',
        'No TransitionActions assigned.',
        'No data found.',
        'No dialogs assigned yet. Just pick an activity dialog from the list on the left and drag it here.',
        'No matches found.',
        'No package information available.',
        'No response from get package upgrade result.',
        'No response from get package upgrade run status.',
        'No response from package upgrade all.',
        'No sort applied, ',
        'No space left for the following files: %s',
        'Not available',
        'Notice',
        'Notification',
        'Nov',
        'November',
        'OK',
        'Oct',
        'October',
        'One or more errors occurred!',
        'Open URL in new tab',
        'Open date selection',
        'Open this node in a new window',
        'Package',
        'Please add values for all keys before saving the setting.',
        'Please check the fields marked as red for valid inputs.',
        'Please either turn some off first or increase the limit in configuration.',
        'Please enter at least one search value or * to find anything.',
        'Please enter at least one search word to find anything.',
        'Please note that at least one of the settings you have changed requires a page reload. Click here to reload the current screen.',
        'Please only select at most %s files for upload.',
        'Please only select one file for upload.',
        'Please remove the following words from your search as they cannot be searched for:',
        'Please see the documentation or ask your admin for further information.',
        'Please turn off Compatibility Mode in Internet Explorer!',
        'Please wait...',
        'Preparing to deploy, please wait...',
        'Press Ctrl+C (Cmd+C) to copy to clipboard',
        'Previous',
        'Process state',
        'Queues',
        'Reload page',
        'Reload page (%ss)',
        'Remove',
        'Remove Entity from canvas',
        'Remove active filters for this widget.',
        'Remove all user changes.',
        'Remove from favourites',
        'Remove selection',
        'Remove the Transition from this Process',
        'Remove the filter',
        'Remove this dynamic field',
        'Remove this entry',
        'Repeat',
        'Request Details',
        'Request Details for Communication ID',
        'Reset',
        'Reset globally',
        'Reset locally',
        'Reset option is required!',
        'Reset options',
        'Reset setting',
        'Reset setting on global level.',
        'Resource',
        'Resources',
        'Restore default settings',
        'Restore web service configuration',
        'Results',
        'Rule',
        'Running',
        'Sa',
        'Sat',
        'Saturday',
        'Save',
        'Save and update automatically',
        'Scale preview content',
        'Search',
        'Search attributes',
        'Search the System Configuration',
        'Searching for linkable objects. This may take a while...',
        'Select a customer ID to assign to this ticket',
        'Select a customer ID to assign to this ticket.',
        'Select all',
        'Sending Update...',
        'Sep',
        'September',
        'Setting a template will overwrite any text or attachment.',
        'Settings',
        'Show',
        'Show EntityIDs',
        'Show all',
        'Show current selection',
        'Show less',
        'Show or hide the content.',
        'Slide the navigation bar',
        'Sorry, but you can\'t disable all methods for notifications marked as mandatory.',
        'Sorry, but you can\'t disable all methods for this notification.',
        'Sorry, the only existing condition can\'t be removed.',
        'Sorry, the only existing field can\'t be removed.',
        'Sorry, the only existing parameter can\'t be removed.',
        'Sorry, you can only upload %s files.',
        'Sorry, you can only upload one file here.',
        'Split',
        'Stacked',
        'Start date',
        'Status',
        'Stream',
        'Su',
        'Sun',
        'Sunday',
        'Support Bundle',
        'Support Data information was successfully sent.',
        'Switch to desktop mode',
        'Switch to mobile mode',
        'System Registration',
        'Team',
        'Th',
        'The browser you are using is too old.',
        'The deployment is already running.',
        'The following files are not allowed to be uploaded: %s',
        'The following files exceed the maximum allowed size per file of %s and were not uploaded: %s',
        'The following files were already uploaded and have not been uploaded again: %s',
        'The item you\'re currently viewing is part of a not-yet-deployed configuration setting, which makes it impossible to edit it in its current state. Please wait until the setting has been deployed. If you\'re unsure what to do next, please contact your system administrator.',
        'The key must not be empty.',
        'The mail could not be sent',
        'There are currently no elements available to select from.',
        'There are no more drafts available.',
        'There is a package upgrade process running, click here to see status information about the upgrade progress.',
        'There was an error deleting the attachment. Please check the logs for more information.',
        'There was an error. Please save all settings you are editing and check the logs for more information.',
        'This Activity cannot be deleted because it is the Start Activity.',
        'This Activity is already used in the Process. You cannot add it twice!',
        'This Transition is already used for this Activity. You cannot use it twice!',
        'This TransitionAction is already used in this Path. You cannot use it twice!',
        'This address already exists on the address list.',
        'This dynamic field database value is already selected.',
        'This element has children elements and can currently not be removed.',
        'This event is already attached to the job, Please use a different one.',
        'This field can have no more than 250 characters.',
        'This field is required.',
        'This is %s',
        'This is a repeating appointment',
        'This is currently disabled because of an ongoing package upgrade.',
        'This item still contains sub items. Are you sure you want to remove this item including its sub items?',
        'This option is currently disabled because the OTOBO Daemon is not running.',
        'This software runs with a huge lists of browsers, please upgrade to one of these.',
        'This window must be called from compose window.',
        'Thu',
        'Thursday',
        'Time needed',
        'Timeline Day',
        'Timeline Month',
        'Timeline Week',
        'Title',
        'Today',
        'Too many active calendars',
        'Try again',
        'Tu',
        'Tue',
        'Tuesday',
        'Unfortunately deploying is currently not possible, maybe because another agent is already deploying. Please try again later.',
        'Uninstall from OTOBO',
        'Unknown',
        'Unlock setting.',
        'Update All Packages',
        'Update Result',
        'Update all packages',
        'Update manually',
        'Upload information',
        'Uploading...',
        'Use options below to narrow down for which tickets appointments will be automatically created.',
        'WARNING: When you change the name of the group \'admin\', before making the appropriate changes in the SysConfig, you will be locked out of the administrations panel! If this happens, please rename the group back to admin per SQL statement.',
        'Warning',
        'Was not possible to send Support Data information.',
        'We',
        'Wed',
        'Wednesday',
        'Week',
        'Would you like to edit just this occurrence or all occurrences?',
        'Yes',
        'You can either have the affected settings updated automatically to reflect the changes you just made or do it on your own by pressing \'update manually\'.',
        'You can use the category selection to limit the navigation tree below to entries from the selected category. As soon as you select the category, the tree will be re-built.',
        'You have undeployed settings, would you like to deploy them?',
        'activate to apply a descending sort',
        'activate to apply an ascending sort',
        'activate to remove the sort',
        'and %s more...',
        'day',
        'month',
        'more',
        'no',
        'none',
        'or',
        'sorting is disabled',
        'user(s) have modified this setting.',
        'week',
        'yes',
    ];

    # $$STOP$$
    return;
}

1;
