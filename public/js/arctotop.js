$.ajaxSetup({
  headers: {
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  }
});
function arctotop() {
  if (!$("#topanarc").hasClass('toped')) {
    $.post('/article/top',"hash="+$("#topanarc").attr('archsh'),function(data, textStatus, jqXHR){
      $("#cd-arc-info").html(data);})
  };
};
function arcrate(r) {
  if (!$("#ratesofarc").hasClass('rateed')) {
    $.post('/article/rate',"hash="+$("#ratesofarc").attr('archsh')+"&rate="+r,function(data, textStatus, jqXHR){
      $("#cd-arc-rate").html(data);})
  };
};
$(document).ready(function() {
  $("#cd-arc-info").load("/article/top/"+$("#cd-arc-info").attr("archsh"));
  $("#cd-arc-tag").load("/article/tag/"+$("#cd-arc-tag").attr("archsh"));
  $("#cd-arc-rate").load("/article/rate/"+$("#cd-arc-rate").attr("archsh"));
});
