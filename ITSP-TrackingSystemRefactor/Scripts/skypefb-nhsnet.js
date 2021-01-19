var config = {
    apiKey: 'a42fcebd-5b43-4b89-a065-74450fb91255', // SDK
    apiKeyCC: '9c967f6b-a846-4df2-b43d-5167e47d81e1' // SDK+UI
};


$(window).on("load", function () {
    console.log("App Loaded");
    //$('#loggedinbox').hide();
    //$('#conversationheader').hide();
    //$('#conversationfooter').hide();
    //$('#conversationbox').hide();
    //$('#stopaudio').hide();
    //$('#stopChat').hide();
    //$('#start_video').hide();
    Skype.initialize({ apiKey: config.apiKey }, function (api) {
        window.skypeWebApp = new api.application();
        //Make sign in table appear
        // whenever client.state changes, display its value
        window.skypeWebApp.signInManager.state.changed(function (state) {
            $('#client_state').text(state);
        });
    }, function (err) {
        console.log(err);
    });
});
