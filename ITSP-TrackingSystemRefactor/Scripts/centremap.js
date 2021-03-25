var infos = [];
var markers = [];
var map;
function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
        center: { lat: 54.5567382, lng: -7.4247462 },
        zoom: 6,
        mapTypeControl: false,
        streetViewControl: false,

        styles: [
            {
                "featureType": "road",
                "elementType": "geometry",
                "stylers": [
                    {
                        "lightness": 100
                    },
                    {
                        "visibility": "simplified"
                    }
                ]
            },
            {
                "featureType": "water",
                "elementType": "geometry",
                "stylers": [
                    {
                        "visibility": "on"
                    },
                    {
                        "color": "#C6E2FF"
                    }
                ]
            },
            {
                "featureType": "poi",
                "elementType": "geometry.fill",
                "stylers": [
                    {
                        "color": "#C5E3BF"
                    }
                ]
            },
            {
                "featureType": "road",
                "elementType": "geometry.fill",
                "stylers": [
                    {
                        "color": "#D1D1B8"
                    }
                ]
            }
        ]
    });
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    if (urlParams.has('centreid')) {
        const cid = parseInt(urlParams.get('centreid'))
        if (isNaN(cid)) {
            loadMapMarkers(0);
        }
        else {
            loadMapMarkers(cid);
        }
    }
    else {
        loadMapMarkers(0);
    }
}
function loadMapMarkers(cid) {
    closeInfos();
    clearMarkers();
    map.controls[google.maps.ControlPosition.TOP_CENTER].clear();
    $.ajax({
        type: "POST",
        url: "services.asmx/GetMapData",
        data: "{'cid': '" + cid + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        xhrFields: {
            withCredentials: true
        },
        beforeSend: function (xhr) {
            xhr.withCredentials = true;
        },
        success: function (data) {
            var parsed = $.parseJSON(data.d);
            var infoWindows = [];
            for (var i in parsed) {
                var props = parsed[i];
                if (props.latitude && props.longitude) {
                    var myLatlng = new google.maps.LatLng(props.latitude, props.longitude);
                    var marker = new google.maps.Marker({
                        position: myLatlng,
                        title: props.title,
                        map: map
                    });

                    var content = getDescription(props)
                    var infowindow = new google.maps.InfoWindow()
                    google.maps.event.addListener(marker, 'click', (function (marker, content, infowindow) {
                        return function () {

                            /* close the previous info-window */
                            closeInfos();

                            infowindow.setContent(content);
                            infowindow.open(map, marker);

                            /* keep the handle, in order to close it on next click event */
                            infos[0] = infowindow;

                        };
                    })(marker, content, infowindow));
                    markers.push(marker);

                }
            };
            if (parsed.length !== 1) {

                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(function (position) {
                        var pos = {
                            lat: position.coords.latitude,
                            lng: position.coords.longitude
                        };
                        map.setCenter(pos);
                        map.setZoom(10);
                    });

                }
            }
            else {
                var pos = {
                    lat: parsed[0].latitude,
                    lng: parsed[0].longitude
                };
                map.setCenter(pos);
                map.setZoom(14);
                closeInfos();

                infowindow.setContent(content);
                infowindow.open(map, marker);

                /* keep the handle, in order to close it on next click event */
                infos[0] = infowindow;
                var resetControlDiv = document.createElement('div');
                var resetControl = new ResetControl(resetControlDiv, map);

                resetControlDiv.index = 1;
                map.controls[google.maps.ControlPosition.TOP_CENTER].push(resetControlDiv);
            }


        },
        error: function (XHR, errStatus, errorThrown) {
            var err = JSON.parse(XHR.responseText);
            errorMessage = err.Message;
            alert(errorMessage);
        }
    });
}
function clearMarkers() {
    for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(null);
    }
    markers.length = 0;
}
function closeInfos() {

    if (infos.length > 0) {

        /* detach the info-window from the marker ... undocumented in the API docs */
        infos[0].set("marker", null);

        /* and close it */
        infos[0].close();

        /* blank the array */
        infos.length = 0;
    }
}
function ResetControl(controlDiv, map) {

    // Set CSS for the control border.
    var controlUI = document.createElement('div');
    controlUI.style.backgroundColor = '#fff';
    controlUI.style.border = '2px solid #fff';
    controlUI.style.borderRadius = '3px';
    controlUI.style.boxShadow = '0 2px 6px rgba(0,0,0,.3)';
    controlUI.style.cursor = 'pointer';
    controlUI.style.marginBottom = '22px';
    controlUI.style.textAlign = 'center';
    controlUI.title = 'Click to reset the map';
    controlDiv.appendChild(controlUI);

    // Set CSS for the control interior.
    var controlText = document.createElement('div');
    controlText.style.color = 'rgb(25,25,25)';
    controlText.style.fontFamily = 'Roboto,Arial,sans-serif';
    controlText.style.fontSize = '16px';
    controlText.style.lineHeight = '38px';
    controlText.style.paddingLeft = '5px';
    controlText.style.paddingRight = '5px';
    controlText.innerHTML = 'Reset Map';
    controlUI.appendChild(controlText);

    // Setup the click event listeners: simply set the map to Chicago.
    controlUI.addEventListener('click', function () {
        loadMapMarkers(0);
    });

}

function getDescription(props) {
    var s = '<div class="m-2"><h4 class="mb-2">' + props.title + '</h4>';
    if (props.pwTelephone) {
        s = s + '<p title="Contact telephone"><i class="fas fa-phone mr-2"></i> ' + props.pwTelephone + '</p>'
    }
    if (props.pwEmail) {
        s = s + '<p title="Contact email"><a href="mailto:' + props.pwEmail + '"><i class="fas fa-envelope mr-2"></i> ' + props.pwEmail + '</a></p>'
    }
    if (props.pwWebURL) {
        s = s + '<p title="Website"><a href="' + props.pwWebURL + '" target="_blank"><i class="fas fa-globe mr-2"></i> ' + props.pwWebURL + '</a></p>'
    }
    if (props.pwTrainingLocations) {
        s = s + '<p title="Training Venues"><i class="fas fa-map-marker-alt mr-2"></i> ' + props.pwTrainingLocations + '</p>'
    }
    if (props.pwHours) {
        s = s + '<p title="Opening hours"><i class="fas fa-clock mr-2"></i> ' + props.pwHours + '</p>'
    }

    if (props.pwTrustsCovered) {
        s = s + '<p title="Organisations covered"><i class="fas fa-building mr-2"></i> ' + props.pwTrustsCovered + '</p>'
    }
    if (props.pwGeneralInfo) {
        s = s + '<p title="General info"><i class="fas fa-info-circle mr-2"></i> ' + props.pwGeneralInfo + '</p>'
    }
    s = s + "<p><a title='Register as a learner at this centre' href='register?app=lp&centreid=" + props.id + "' class='btn-primary float-right p-2'>Register</a></p>";
    s = s + "</div>";
    return s;
}
function OnRowClick(s, e) {
    var key = s.GetRowKey(e.visibleIndex);
    $('html, body').animate({
        scrollTop: ($('#ctremap').offset().top - 126)
    }, 500);
    loadMapMarkers(key);
}