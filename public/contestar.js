 function cargar(id){
    $("body").append("<div id='divContestar'></div>");
    $.get("http://localhost:3000/encuestas/"+id+"/contestar",function(result){
           $("div#divContestar").html(result);
     },'html');


 }