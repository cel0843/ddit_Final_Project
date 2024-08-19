$(document).ready(function() {
    $("#datetime-datepicker").flatpickr({
        enableTime: true,
        dateFormat: "Y-m-d H:i"
    });

    $("#getDateTime").on('click', function() {
        var dateTime = $("#datetime-datepicker").val();
        console.log("Selected DateTime: " + dateTime);
        
        
    });
    

});