function openTab(tabName) {
    var i;
    var x = document.getElementsByClassName("tab");
    for (i = 0; i < x.length; i++) {
        x[i].style.display = "none";
    }
    document.getElementById(tabName).style.display = "block";
}

$("#reset").on("click", function() {
    $.post("/clear_tags", function(data) {
        $("#result").html(data);
        $("#search_input").val("");
    });
});

$("#add_feedback").on("click", function() {
    $("#feedback_form").submit();
});

function refreshData() {
    window.location.href="/";
}

function updateSettings(settings_type, settings_value) {
    $("#xss_settings_form").submit();
}
var tabName = window.location.hash.substr(1);
if (tabName == "")
    tabName = $("#tabName").val();
openTab(tabName);
$('#flash').delay(2000).fadeOut('slow');

$("#guestbook_tab").on("click", function() {openTab("Guestbook"); refreshData();});
$("#feedback_tab").on("click", function() {openTab("Feedback")});
$("#search_tab").on("click", function() {openTab("Search")});
$("#settings_tab").on("click", function() {openTab("Settings")});

$("#xss_level").on("change", function() {updateSettings("xss", $(this).val())});