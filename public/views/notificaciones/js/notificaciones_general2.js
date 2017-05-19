$(document).ready(function()
{
    html =  '';
    html2 = '';
    var audionoti = $('#audio_noti');
    // $('<audio id="audio_fb"><source src="sonidos/sonido_notificacion.wav" type="audio/wav">, <source src="sonidos/sonido_notificacion.ogg" type="audio/ogg">, <source src="sonidos/sonido_notificacion.mp3" type="audio/mpeg"></audio>').appendTo("body");
	//observaciones();
	notificaciones();
    // numero_total();
    var tpl_notificacion = `<li class="li_noti">
                              <a href="{{obj.ref_url}}">
                                <span>
                                  <span><b>{{obj.not_asunto}}</b></span>

                                </span>
                                <span class="message">
                                  <span>{{obj.not_mensaje}}</span>
                                  <br>
                                  <p class="time" data-fecha-notifi="{{obj.not_fecha}}">{{obj.not_fechaf}}</p>
                                </span>

                              </a>
                            </li>`;
    var tpl_ver_todas =  `<li>
                            <div class="text-center">
                              <a href="{{url}}">
                                <strong>Ver todas las notificaciones</strong>
                                <i class="fa fa-angle-right"></i>
                              </a>
                            </div>
                          </li>`;
    setInterval(notificaciones,1500) ;
    //setInterval(numero_total(),10000) ;

    function notificaciones_realtime(data){

            var animate_in = 'bounceInDown', animate_out = 'fadeOutDown';
            new PNotify({
                title: data.not_asunto,
                text: data.not_mensaje,
                styling:'bootstrap3',
                type:'info',
                animate: {
                    animate: true,
                    in_class: animate_in,
                    out_class: animate_out
                }
            });
            audionoti.get(0).play();
    }
    var refid = [];
    var firsts = true;
    var hmenu = $('#menu1');
    function existeref(id,contenedor){
        for (var i = contenedor.length - 1; i >= 0; i--) {
            if(contenedor[i] == id) return true;
        };
        return false;

    }
    function getdata(id,tipo,datas){
        for (var i = datas.length - 1; i >= 0; i--) {
            if(datas[i]['not_id'] == id && datas[i]['not_tipo'] == tipo)
                return datas[i];
        };
    }
   //comprobar si hay notificaciones nuevas
	function notificaciones () {
        $.getJSON(BASE_URL + '/notificaciones/comprar_notificaciones_custom', {}, function(data, text){
            // console.log(data);
            var refidstemp = [];
            refidstemp = data.refid;
            var datos = data.notificaciones;
            var t  = Handlebars.compile(tpl_notificacion);
            var html = '';

            if (data.cantidad == 0 )    {
                $('#cantidad_notificaciones').text('');
            }else {
                $('#cantidad_notificaciones').html(data.cantidad);


            }
            for (i = 0; i < datos.length; i++) {

                // refidstemp.push(datos[i]['not_id']+'-'+datos[i]['not_tipo']);


                datos[i]['not_fechaf'] = moment(datos[i]['not_fecha']).fromNow();
                if(datos[i]['not_tipo'] == 1)
                    datos[i]['ref_url'] = BASE_URL + 'notificaciones/leer_notificacion/' + datos[i]['not_id'];
                else
                    datos[i]['ref_url'] = BASE_URL + 'notificaciones/leer_observacion/' + datos[i]['not_id'];
                html += t({obj : datos[i]});
            }
            html += (Handlebars.compile(tpl_ver_todas))({url : BASE_URL + 'notificaciones/gestionar_notificaciones'});



            var changehtml = false;
            if(!firsts){
                for (var i = refidstemp.length - 1; i >= 0; i--) {
                    if(!existeref(refidstemp[i],refid)){
                        var t = refidstemp[i].split('-');
                        notificaciones_realtime(getdata(t[0],t[1],datos));
                        changehtml = true;
                    }
                };

                for (var i = refid.length - 1; i >= 0; i--) {
                    if(!existeref(refid[i],refidstemp)){
                        changehtml = true;
                    }
                };

            }else{
                firsts = false;
                refid = refidstemp;
                changehtml = true;

            }
            if(changehtml){
                hmenu.html('');
                hmenu.prepend($(html));
                refid = refidstemp;
            }
            $('.li_noti').find('.time').each(function(e,v){
                $(v).text(moment(v.dataset.fechaNotifi).fromNow());
            })
        }).fail(fnFailAjax);
        // notificaciones_realtime();
	 //  $.ajax({
		// 		type: "POST",
		// 		url: BASE_URL + "notificaciones/comprobar_notificaciones" ,
		// 	    dataType : 'json',
		// 		cache: false,
		// 		//async:false,
		// 		success: function(datos)
		// 		{

  //                   var t  = Handlebars.compile(tpl_notificacion);
		// 			html = '';
		// 			for (i = 0; i < datos.length; i++) {

  //                      datos[i]['rel_fecha'] = moment(datos[i]['rel_fecha']).fromNow();
  //                      datos[i]['ref_url'] = BASE_URL + 'notificaciones/leer_notificacion/' + datos[i]['rel_id'];
  //                      html += t({obj : datos[i]})
  //               	}


  //               	$('#menu1').prepend($(html));

  //               //peticion ajax anidada
  //               $.ajax({

		// 		type: "POST",
		// 		url: BASE_URL + "notificaciones/comprobar_observaciones" ,
		// 	    dataType : 'json',
		// 		cache: false,
		// 		//async:false,
		// 		success: function(datos2)
		// 		{
		// 			console.log("hola"); //para forzar la lectura de observaciones

		// 			for (i = 0; i < datos2.length; i++) {
		// 			   html2  += '<li>';
		// 			   html2  +=   '<a href="' + BASE_URL + 'notificaciones/leer_observacion/' + datos2[i]['obs_id'] + '">';
  //                      html2  += 	  '<span>';
  //                      html2  += 		'<span>Observacion ' + (i + 1 ) + '</span>';
  //                      html2  += 		'<span class="time">' + datos2[i]['obs_fecha'] + '</span>';
  //                      html2  += 	  '</span>';
  //                      html2  += 	  '<span class="message">' + datos2[i]['obs_asunto'] + '</span>';
  //                      html2  +=   '</a>';
		// 			   html2  +=  '</li>';
  //               	}

		// 			//para ver todas las notificaciones
		// 			html2 += ' <li><div class="text-center">';
		// 			html2 +=  '<a href="' + BASE_URL + 'notificaciones/gestionar_notificaciones"> <strong>Ver todas </strong><i class="fa fa-angle-right"></i></a>';
		// 			html2 +=  '</div></li>';

  //               	$('#menu1').append(html2 );

		// 		},
		// 		error: function(xhr, ajaxOptions, thrownError) {
		// 			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		// 			}
		// 		}); //fin del ajax de observaciones


		// 	},
		// 	error: function(xhr, ajaxOptions, thrownError) {
		// 		alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		// 		}
		// });//fin del Notificaciones de observaciones
   }

	// function numero_total () {
	//  $.ajax({
	// 		type: "POST",
	// 		url: BASE_URL + "notificaciones/contador_notifi_observ" ,
	// 	    dataType : 'json',
	// 		cache: false,
	// 		//async:false,
	// 		success: function(total)
	// 		{
	// 			if (total == 0 )	{
	// 				$('#cantidad_notificaciones').hide();
	// 			}else {
	// 				$('#cantidad_notificaciones').html(total);
	// 			}
	// 		},
	// 		error: function(xhr, ajaxOptions, thrownError) {
	// 			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	// 			}
	// 		});
 // 	}
}); // document end