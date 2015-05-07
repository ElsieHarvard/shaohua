$.ajaxSetup({
  headers: {
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  }
});
function arctotop() {
  $.post('/article/top',"hash="+$("#topanarc").attr('archsh'),function(data, textStatus, jqXHR){
  	$("#cd-arc-info").load("/article/top/"+$("#cd-arc-info").attr("archsh"));})
};
$(document).ready(function() {
  $("#cd-arc-info").load("/article/top/"+$("#cd-arc-info").attr("archsh"));
  $("#cd-arc-tag").load("/article/tag/"+$("#cd-arc-tag").attr("archsh"));
});
