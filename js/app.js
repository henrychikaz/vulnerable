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
openTab("Guestbook");
$('#flash').delay(2000).fadeOut('slow');

$("#guestbook_tab").on("click", function() {openTab("Guestbook")});
$("#feedback_tab").on("click", function() {openTab("Feedback")});
$("#settings_tab").on("click", function() {openTab("Settings")});

