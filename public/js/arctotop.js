$.ajaxSetup({
  headers: {
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  }
});
function arctotop() {
  $.post('/article/top',"hash="+$("#topanarc").attr('archsh'),function(data, textStatus, jqXHR){
  	$("#cd-arcinfo").load("/article/top/"+$("#cd-arcinfo").attr("archsh"));})
};
$(document).ready(function() {
  $("#cd-arcinfo").load("/article/top/"+$("#cd-arcinfo").attr("archsh"))
});