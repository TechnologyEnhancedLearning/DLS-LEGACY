var config = {
    version: 'Digital Learning Solutions/1.0.837',
    //apiKey: 'a42fcebd-5b43-4b89-a065-74450fb91255', // SDK 
    //apiKeyCC: '9c967f6b-a846-4df2-b43d-5167e47d81e1' // SDK+CC 
    apiKey: '595a1aeb-e6dc-4e5b-be96-bb38adc83da1', // SDK
    apiKeyCC: '08c97289-7d57-404f-bd97-a6047403e370' // SDK+UI
};
var sfbState;
var meSIP;
var app;
var sfbapi;
var adminID;
var delegateID;
function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, '\\$&');
    var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, ' '));
}
$(window).on("load", function () {
    // the variable is defined
    if (typeof app !== 'undefined') {
        setupSkypeUI();
    }
    else {
        setupSignIn();
    }
});
function setupSignIn() {
    var semail;
    if (getParameterByName('attemail') !== null) {
        semail = getParameterByName('attemail');
    } else {
        var suri = getParameterByName('uri');
        semail = suri.substring(4, suri.indexOf(';'));
    }
    $('#tbSFBUsername').val(semail);
    $(document).ready(function () {
        setTimeout(function () {
            $("#tbSFBUsername").attr('readonly', false);
            $("#sfbPassword").attr('readonly', false);
            $("#sfbPassword").focus();
        }, 500);
    });
    console.log("App Loaded");
    Skype.initialize({ apiKey: config.apiKeyCC }, function (api) {
        //app = new api.application();
        sfbapi = api;
        app = api.UIApplicationInstance;
        //Make sign in table appear
        // whenever client.state changes, store state to var
        app.signInManager.state.changed(function (state) {
            sfbState = state;
            if (sfbState !== "SignedIn") {
                $(".collapse:not(#joinskype)").collapse('hide');
                $('#joinskype').collapse('show');
            }
        });
        sEm = $('#tbSFBUsername').val();
        sEncP = Cookies.get(sEm);
        if (typeof sEncP !== 'undefined') {
            $('#cbRememberMe').prop("checked", true);
            $.ajax({
                url: "services.asmx/DecryptPw",
                type: "POST",
                data: "sEmail=" + escape(sEm) + "&sCipher=" + escape(sEncP),
                success: function (data) {
                    if (typeof data.firstChild.innerHTML === "undefined") {
                        d = data.firstChild.firstChild.data;
                    }
                    else {
                        d = data.firstChild.innerHTML;
                    }
                    $('#sfbPassword').val(d);
                    sfbSignIn();
                }
            });
        }
    }, function (err) {
        console.log(err);
    });
    $('#btnSFBSignin').on("click", function () {
        sfbSignIn();
    });

}
function sfbSignOut() {
    if (sfbState === "SignedIn") {
        app.signInManager.signOut().then(function () {
            // signed out succesfully
        }, function (error) {
            $(".collapse:not(#joinskype)").collapse('hide');
            $('#joinskype').collapse('show');
        });
    }
}
function raiseError(err, msg) {
    $('#lblErrorTitle').text(err);
    $('#lblErrorText').text(msg);
    $(".collapse:not(#skypeerror)").collapse('hide');
    $('#skypeerror').collapse('show');
}
function sfbSignIn() {
    console.log('Signing in...');
    // and invoke its asynchronous "signIn" method
    app.signInManager.signIn({
        username: $('#tbSFBUsername').val(),
        password: $('#sfbPassword').val(),
        origins: [
            "https://nh-slpews01.nhs.net/autodiscover/autodiscoverservice.svc/root",
            "https://nh-slpews03.nhs.net/autodiscover/autodiscoverservice.svc/root",
            "https://nh-slpews05.nhs.net/autodiscover/autodiscoverservice.svc/root",
            "https://nh-hepews02.nhs.net/autodiscover/autodiscoverservice.svc/root",
            "https://nh-hepews04.nhs.net/autodiscover/autodiscoverservice.svc/root",
            "https://nh-hepews06.nhs.net/autodiscover/autodiscoverservice.svc/root"
        ]
    }).then(function () {
        $('#btnSFBSignOut').click(function () {
            // start signing out
            sfbSignOut();
        });
        console.log('Logged In Succesfully');
        //CHECK IF REMEMBER ME CLICKED AND STORE COOKIE
        if ($('#cbRememberMe').prop("checked") === true) {
            var sPW = $('#sfbPassword').val();
            var sEm = $('#tbSFBUsername').val();
            $.ajax({
                url: "services.asmx/EncryptPw",
                type: "POST",
                data: "sEmail=" + escape(sEm) + "&sPassword=" + escape(sPW),
                success: function (data) {
                    if (typeof data.firstChild.innerHTML === "undefined") {
                        d = data.firstChild.firstChild.data;
                    }
                    else {
                        d = data.firstChild.innerHTML;
                    }
                    Cookies.set(escape(sEm), d, { expires: 90 });
                }
            });
        }
        var me = app.personsAndGroupsManager.mePerson;
        console.log('<b>Details about logged in user</b>');
        console.log('displayName: ' + me.displayName());
        $('#lblUIDisplayName').text(me.displayName());
        console.log('ID: ' + me.id());
        meSIP = app.personsAndGroupsManager.mePerson.id();
        $.ajax({
            url: "services.asmx/ValidateSfbAdmin",
            type: "POST",
            data: "sEmail=" + escape(meSIP.replace("sip:", "")),
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            error: function () {
                console.log("Failed!! call to ../services.asmx/ValidateSfbAdmin with parameters sEmail=" + escape(meSIP.replace("sip:", "")) + " FAILED");
                //$('#lbltTitlePrepend').val('Signin Error: ');
                //$('#lblSession').val('An error occured matching your email address to your DLS after successful Skype signin. Please close this window and try again.');
                raiseError('Signin Error: ', 'An error occured matching your email address to your DLS record after successful Skype signin. Please close this window and try again.');
            },
            success: function (data) {
                console.log("Success!! call to ../services.asmx/ValidateSfbAdmin with parameters sEmail=" + escape(meSIP.replace("sip:", "")) + " SUCCEEDED");
                if (typeof data.firstChild.innerHTML === "undefined") {
                    d = data.firstChild.firstChild.data;
                }
                else {
                    d = data.firstChild.innerHTML;
                }
                adminID = parseInt(d);
                if (d == '0') {
                    //$('#lbltTitlePrepend').val('Error Invalid Attendee: ');
                    //$('#lblSession').val('An error occured matching your email address to your DLS after successful Skype signin. Please close this window and try again.');
                    $.ajax({
                        url: "services.asmx/ValidateSfbDelegate",
                        type: "POST",
                        data: "sEmail=" + escape(meSIP.replace("sip:", "")),
                        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                        error: function () {
                            console.log("Failed!! call to ../services.asmx/ValidateSfbDelegate with parameters sEmail=" + escape(meSIP.replace("sip:", "")) + " FAILED");
                            //$('#lbltTitlePrepend').val('Signin Error: ');
                            //$('#lblSession').val('An error occured matching your email address to your DLS after successful Skype signin. Please close this window and try again.');
                            raiseError('Signin Error: ', 'An error occured matching your email address to your DLS record after successful Skype signin. Please close this window and try again.');
                        },
                        success: function (data) {

                            console.log("Success!! call to ../services.asmx/ValidateSfbDelegate with parameters sEmail=" + escape(meSIP.replace("sip:", "")) + " SUCCEEDED");
                            if (typeof data.firstChild.innerHTML === "undefined") {
                                d = data.firstChild.firstChild.data;
                            }
                            else {
                                d = data.firstChild.innerHTML;
                            }
                            delegateID = parseInt(d);
                            if (d == '0') {
                                //$('#lbltTitlePrepend').val('Error Invalid Attendee: ');
                                //$('#lblSession').val('An error occured matching your email address to your DLS after successful Skype signin. Please close this window and try again.');
                                raiseError('Error Invalid Attendee: ', 'Your email address does not match the DLS record of any of the session attendees. Please check that your DLS email address matches your Skype for Business NHSmail address.');
                            } else {
                                setupSkypeUI();
                                //delegateSkypeUI();
                            }
                        }
                    });
                } else {
                    setupSkypeUI();
                }
            }
        });


    }).then(null, function (error) {
        // if either of the operations above fails, tell the user about the problem
        if (error.errorDetails) { console.log(error.errorDetails.message); }
        $('#loginerror').collapse('show');
        return false;
    });
}
function setupSkypeUI() {
    $(".collapse:not(#skypeui)").collapse('hide');
    $('#skypeui').collapse('show');
    if (adminID != 0) {
        arrAttendees = $('#hfAttendees').val().split(',');
        $('#lblUIAttendeeCount').text(arrAttendees.length);
        $.each(arrAttendees, function (key, value) {
            $('#listAttendees').append('<li data-sip=' + value + ' class="list-group-item contact">' + value.replace('sip:', '') + '<div class="contactPresence"></div></li>');
        });
        $('#messagearea').removeClass("d-none");
    };
    //getPresence(arrAttendees);
    //if the user is the supervisor, create the conversation:
    //
    //var participants = [];
    //participants = $('#hfAttendees').val().split(',');
    //}
    //if (participants == [""]) {
    //    delegateSkypeUI();
    //}
    //else {
    var uri = getParameterByName('uri');
    var mtgconv = app.conversationsManager.getConversationByUri(uri);

    //var div = document.createElement('div');
    //var control = document.querySelector('#skypeuicontrols');
    //control.appendChild(div);
    sfbapi.renderConversation('#skypeuicontrols', {
        conversation: mtgconv
    }).then(function (conversation) {
        //do stuff
        conversation.audioService.start().then(null, function (error) {
            console.log('error joining audio');
        });
        setTimeout(function () {
            $('[data-swx-testid="conversationTopic"]').text($('#lblUISessionTitle').text());
        }, 500);
    });
}
window.onbeforeunload = function () {
    if (sfbState === "SignedIn") { app.signInManager.signOut(); }
};