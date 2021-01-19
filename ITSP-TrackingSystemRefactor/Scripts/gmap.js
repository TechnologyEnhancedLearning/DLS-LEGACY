function getGeoCode() {
    var address = document.getElementById("tbPwPostCode").value + ", UK";
    var addressfixed = address.split(' ').join('+');
    $.ajax({
        type: "POST",
        url: "../services.asmx/GetGeoCode",
        data: "{'addstr': '" + addressfixed + "'}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: geoCoded,
        error: geoFailed
    });
    //ITSP_TrackingSystemRefactor.services.GetGeoCode(addressfixed, geoCoded, geoFailed);
}
function geoCoded(e) {
    var data = eval('(' + e.d + ')');
    if (data.status == "OK") {
        var resultLat = data.results[0].geometry.location.lat;
        document.getElementById("hfLattitude").value = parseFloat(resultLat);
        document.getElementById("tbLattitude").value = parseFloat(resultLat);
        var resultLng = data.results[0].geometry.location.lng;
        document.getElementById("hfLongitude").value = parseFloat(resultLng);
        document.getElementById("tbLongitude").value = parseFloat(resultLng);
        alert('dls.nhs.uk centre map location found based on postcode');
        return true;
    }
    else {
        alert('dls.nhs.uk centre map location not found - postcode error.');
        return true;
    }
}
function geoFailed() {
    alert('dls.nhs.uk centre map location not found - web service error.');
}
$(function () {
    $("#btnFind").click(function () {
        getGeoCode();
        return false;
    });
});