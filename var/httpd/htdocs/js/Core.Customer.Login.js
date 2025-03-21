// --
// OTOBO is a web-based ticketing system for service organisations.
// --
// Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
// Copyright (C) 2019-2024 Rother OSS GmbH, https://otobo.de/
// --
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free Software
// Foundation, either version 3 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.
// --

"use strict";

var Core = Core || {};
Core.Customer = Core.Customer || {};

/**
 * @namespace Core.Customer.Login
 * @memberof Core.Customer
 * @author
 * @description
 *      This namespace contains all functions for the Customer login.
 */
Core.Customer.Login = (function (TargetNS) {
    if (!Core.Debug.CheckDependency('Core.Customer.Login', 'Core.UI', 'Core.UI')) {
        return false;
    }

    /**
     * @private
     * @name ToggleLabel
     * @memberof Core.Customer.Login
     * @function
     * @param {DOMObject} PopulatedInput - DOM representation of an input field
     * @description
     *      This function hides the label of the given field if there is value in the field
     *      or the field has focus, otherwise the label is made visible.
     */
    function ToggleLabel(PopulatedInput) {
        var $PopulatedInput = $(PopulatedInput),
            $Label = $PopulatedInput.prev('label');

        if ($PopulatedInput.val() !== "" || $PopulatedInput[0] === document.activeElement) {
            $Label.hide();
        }
        else {
            $Label.show();
        }
    }

    /**
     * @name Init
     * @memberof Core.Customer.Login
     * @function
     * @returns {Boolean} False if browser is not supported
     * @description
     *      This function initializes the login functions.
     *      Time gets tracked in a hidden field.
     *      In the login we have four steps:
     *      1. input field gets focused -> label gets greyed out via class="Focused"
     *      2. something is typed -> label gets hidden
     *      3. user leaves input field -> if the field is blank the label gets shown again, 'focused' class gets removed
     *      4. first input field gets focused
     */
    TargetNS.Init = function () {
        var $Inputs = $('input:not(:checked, :hidden, :radio)'),
            $LocalInputs,
            Location,
            Now = new Date(),
            Diff = Now.getTimezoneOffset(),
            $Label,
            $SliderNavigationLinks = $('#Slider a'),
            LoginFailed = Core.Config.Get('LoginFailed'),
            SignupError = Core.Config.Get('SignupError');

        // Browser is too old
        if (!Core.Customer.SupportedBrowser) {
            $('#Login').hide();
            $('#Reset').hide();
            $('#Signup').hide();
            $('#PreLogin').hide();
            $('#OldBrowser').show();
            return false;
        }

        // enable login form
        Core.Form.EnableForm($('#Login form, #Reset form, #Signup form'));

        $('#TimeZoneOffset').val(Diff);

        if ($('#PreLogin').length) {
            $('#PreLogin form').submit();
            return false;
        }

        $('#oooRegister').on('click', function () {
            $('#Login').hide();
            $('#Signup').show();
        });
        $('#ForgotPassword').on('click', function () {
            $('#Login').hide();
            $('#Reset').show();
        });

        $('#Signup > a[href="#Login"]').on('click', function () {
            $('#Signup').hide();
            $('#Login').show();
        });

        $('#Reset > a[href="#Login"]').on('click', function () {
            $('#Reset').hide();
            $('#Login').show();
        });

        $('#User').blur(function () {
           if ($(this).val()) {
               // set the username-value and hide the field's label
               $('#ResetUser').val('').prev('label').hide();
           }
        });

        // check labels every 250ms, not all changes can be caught via
        //     events (e. g. when the user selects a predefined value
        //     from a browser auto completion list).
        window.setInterval(function(){
            $.each($Inputs, function(Index, Input) {
                if($(Input).val()){
                    ToggleLabel(Input);
                }
            });
        }, 250);

        // Fill the reset-password input field with the same value the user types in the login screen
        // so that the user doesnt have to type in his user name again if he already did
        $('#User').blur(function () {
            if ($(this).val()) {
                // clear the username-value and hide the field's label
                $('#ResetUser').val($(this).val()).prev('label').hide();
            }
        });

        // detect the location ("SignUp", "Reset" or "Login"):
        // default location is "Login"
        Location = '#Login';

        // check if the url contains an anchor
        if (document.location.toString().match('#')) {

            // cut out the anchor
            Location = '#' + document.location.toString().split('#')[1];
        }

        // get the input fields of the current location
        $LocalInputs = $(Location).find('input:not(:checked, :hidden, :radio)');

        // focus the first one
        $LocalInputs.first().focus();

        // add all tab-able inputs
        $LocalInputs.add($(Location + ' a, button'));

        // collect all global tab-able inputs
        // give the input fields of all other slides a negative 'tabindex' to prevent
        // the user from accidentally jumping to a hidden input field via the tab key
        $Inputs.add('a, button').not($LocalInputs).attr('tabindex', -1);

        // Change the 'tabindex' according to the navigation of the user
        $SliderNavigationLinks.click(function () {
            var I = 0,
                TargetID,
                $TargetInputs;

            TargetID = $(this).attr('href');

            // get the target id out of the href attribute of the anchor
            $TargetInputs = $(TargetID + ' input:not(:checked, :hidden, :radio), ' + TargetID + ' a, ' + TargetID + ' button');

            // give the inputs on the slide the user just leaves all a 'tabindex' of '-1'
            $(this).parentsUntil('#SlideArea').last().find('input:not(:checked, :hidden, :radio), a, button').attr('tabindex', -1);

            // give all inputs on the new shown slide an increasing 'tabindex'
            for (I; I < $TargetInputs.length; I++) {
                $TargetInputs.eq(I).attr('tabindex', I + 1);
            }
        });

        // shake login box on authentication failure
        if (typeof LoginFailed !== 'undefined' && parseInt(LoginFailed, 10) === 1) {
            Core.UI.Animate($('#Login'), 'Shake');
        }

        // navigate to Signup when SignupError exists
        if (typeof SignupError !== 'undefined' && parseInt(SignupError, 10) === 1) {
            window.location.hash = 'Signup';
        }
    };

    Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

    return TargetNS;
}(Core.Customer.Login || {}));
