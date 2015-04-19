$.ajaxSetup({
  headers: {
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  }
});
function arctotop() {
  $.post('/article/top',"archsh="+$("#topanarc").attr('archsh'),function(data, textStatus, jqXHR){alert('已赞！('+data+' + 1)');})
};