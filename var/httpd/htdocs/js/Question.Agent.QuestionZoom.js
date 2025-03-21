// --
// Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
// --
// This software comes with ABSOLUTELY NO WARRANTY. For details, see
// the enclosed file COPYING for license information (AGPL). If you
// did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
// --

"use strict";

var Question = Question || {};
Question.Agent = Question.Agent || {};

/**
 * @namespace
 * @exports TargetNS as Question.Agent.TicketZoom
 * @description
 *      This namespace contains the special module functions for TicketZoom.
 */
Question.Agent.QuestionZoom = (function (TargetNS) {

    /**
     * @name IframeAutoHeight
     * @memberof Question.Agent.QuestionZoom
     * @function
     * @param {jQueryObject} $Iframe - The iframe which should be auto-heighted
     * @description
     *      Set iframe height automatically based on real content height and default config setting.
     */
    TargetNS.IframeAutoHeight = function ($Iframe) {

        var NewHeight = $Iframe
            .contents()
            .find('html')
            .height();

        if (isJQueryObject($Iframe)) {

            // IE8 needs some more space due to incorrect height calculation
            if (NewHeight > 0 && $.browser.msie && $.browser.version === '8.0') {
                NewHeight = NewHeight + 4;
            }

            // if the iFrames height is 0, we collapse the widget
            if (NewHeight === 0) {
                $Iframe.closest('.WidgetSimple').removeClass('Expanded').addClass('Collapsed');
            }

            if (!NewHeight || isNaN(NewHeight)) {
                NewHeight = Core.Config.Get('Question::Frontend::AgentHTMLFieldHeightDefault');
            }
            else {
                if (NewHeight > Core.Config.Get('Question::Frontend::AgentHTMLFieldHeightMax')) {
                    NewHeight = Core.Config.Get('Question::Frontend::AgentHTMLFieldHeightMax');
                }
            }
            $Iframe.height(NewHeight + 'px');
        }
    };

    // init browser link message close button
    if ($('.QuestionMessageBrowser').length) {
        $('.QuestionMessageBrowser a.Close').on('click', function () {
            $('.QuestionMessageBrowser').fadeOut("slow");
            Core.Agent.PreferencesUpdate('UserAgentDoNotShowBrowserLinkMessage', 1);
            return false;
        });
    }

    return TargetNS;
}(Question.Agent.QuestionZoom || {}));
