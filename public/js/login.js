$.ajaxSetup({
    headers: {
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
});
function client_first(){
    return 'SCRAM[usrname]='+$('#inputUserName').serialize()+'&SCRAM[noncec]='+CryptoJS.lib.WordArray.random(128/8);;
}
function usrlogin() {
    $.ajax({
        type:'POST',
        url:'/login/',
        data:client_first(),
        success:function(server_first){
            alert(server_first);
        },
        error:function(msg){
            alert('Failed to connect the server, please check your internet connection.'+"\n"+msg);
        }
    })
    return false;
}
