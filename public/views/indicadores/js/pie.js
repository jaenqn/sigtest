$(document).ready(function() {

  var theme = {
          color: [
              '#26B99A', '#34495E', '#BDC3C7', '#3498DB',
              '#9B59B6', '#8abb6f', '#759c6a', '#bfd3b7'
          ],

          title: {
              itemGap: 8,
              textStyle: {
                  fontWeight: 'normal',
                  color: '#408829'
              }
          },

          dataRange: {
              color: ['#1f610a', '#97b58d']
          },

          toolbox: {
              color: ['#408829', '#408829', '#408829', '#408829']
          },

          tooltip: {
              backgroundColor: 'rgba(0,0,0,0.5)',
              axisPointer: {
                  type: 'line',
                  lineStyle: {
                      color: '#408829',
                      type: 'dashed'
                  },
                  crossStyle: {
                      color: '#408829'
                  },
                  shadowStyle: {
                      color: 'rgba(200,200,200,0.3)'
                  }
              }
          },

          dataZoom: {
              dataBackgroundColor: '#eee',
              fillerColor: 'rgba(64,136,41,0.2)',
              handleColor: '#408829'
          },
          grid: {
              borderWidth: 0
          },

          categoryAxis: {
              axisLine: {
                  lineStyle: {
                      color: '#408829'
                  }
              },
              splitLine: {
                  lineStyle: {
                      color: ['#eee']
                  }
              }
          },

          valueAxis: {
              axisLine: {
                  lineStyle: {
                      color: '#408829'
                  }
              },
              splitArea: {
                  show: true,
                  areaStyle: {
                      color: ['rgba(250,250,250,0.1)', 'rgba(200,200,200,0.1)']
                  }
              },
              splitLine: {
                  lineStyle: {
                      color: ['#eee']
                  }
              }
          },
          timeline: {
              lineStyle: {
                  color: '#408829'
              },
              controlStyle: {
                  normal: {color: '#408829'},
                  emphasis: {color: '#408829'}
              }
          },

          k: {
              itemStyle: {
                  normal: {
                      color: '#68a54a',
                      color0: '#a9cba2',
                      lineStyle: {
                          width: 1,
                          color: '#408829',
                          color0: '#86b379'
                      }
                  }
              }
          },
          map: {
              itemStyle: {
                  normal: {
                      areaStyle: {
                          color: '#ddd'
                      },
                      label: {
                          textStyle: {
                              color: '#c12e34'
                          }
                      }
                  },
                  emphasis: {
                      areaStyle: {
                          color: '#99d2dd'
                      },
                      label: {
                          textStyle: {
                              color: '#c12e34'
                          }
                      }
                  }
              }
          },
          force: {
              itemStyle: {
                  normal: {
                      linkStyle: {
                          strokeColor: '#408829'
                      }
                  }
              }
          },
          chord: {
              padding: 4,
              itemStyle: {
                  normal: {
                      lineStyle: {
                          width: 1,
                          color: 'rgba(128, 128, 128, 0.5)'
                      },
                      chordStyle: {
                          lineStyle: {
                              width: 1,
                              color: 'rgba(128, 128, 128, 0.5)'
                          }
                      }
                  },
                  emphasis: {
                      lineStyle: {
                          width: 1,
                          color: 'rgba(128, 128, 128, 0.5)'
                      },
                      chordStyle: {
                          lineStyle: {
                              width: 1,
                              color: 'rgba(128, 128, 128, 0.5)'
                          }
                      }
                  }
              }
          },
          gauge: {
              startAngle: 225,
              endAngle: -45,
              axisLine: {
                  show: true,
                  lineStyle: {
                      color: [[0.2, '#86b379'], [0.8, '#68a54a'], [1, '#408829']],
                      width: 8
                  }
              },
              axisTick: {
                  splitNumber: 10,
                  length: 12,
                  lineStyle: {
                      color: 'auto'
                  }
              },
              axisLabel: {
                  textStyle: {
                      color: 'auto'
                  }
              },
              splitLine: {
                  length: 18,
                  lineStyle: {
                      color: 'auto'
                  }
              },
              pointer: {
                  length: '90%',
                  color: 'auto'
              },
              title: {
                  textStyle: {
                      color: '#333'
                  }
              },
              detail: {
                  textStyle: {
                      color: 'auto'
                  }
              }
          },
          textStyle: {
              fontFamily: 'Arial, Verdana, sans-serif'
          }
      };
 
//listado cuando cambia el tipo de select
  $('#unidad, #tipo ,  #ano ,#mes' ).on('change', function() { 	 
  	 		  
	    var id_unidad=$("#unidad").val();
		var tiempo2=$('input:radio[name=tiempo]:checked').val();
				
		console.log(tiempo2);
		
	   switch(tiempo2) {
	   	//mes
	    case '1':
	    	$('#contenedor_mes').show(); 
	        console.log('llamar reporte meses');
	        if(id_unidad != '') {
	        	 
	        	  dibujar_grafico_meses();
	        	  $('#reporte_pie').show();//muestro oculto la parte de grafico
	        }
	      
	        break;
	    //trimestre
	    case '2':
	       console.log('oculto mes');
	        $('#reporte_pie').hide();//oculto la parte de grafico
	        $('#contenedor_mes').hide();        
	        
	        break;
	    //año
	    case '3':
	        $('#reporte_pie').hide();//oculto la parte de grafico
	        $('#contenedor_mes').hide();   
	        break;
	    default:
	            console.log('defecto');
			}    	  	  	
});



//CUANDO CAMBIA EL RADIO BUTON DE TIEMPO	
$('input[type=radio][name=tiempo]').on('change' , function (){	
    var id_unidad=$("#unidad").val();
	var tiempo2=$('input:radio[name=tiempo]:checked').val();
	
	console.log(tiempo2);
	
   switch(tiempo2) {
   	//mes
    case '1':
    	$('#contenedor_mes').show(); 
    	
        console.log('llamar reporte meses');
        if(id_unidad != '') {
        	 dibujar_grafico_meses();
        	 $('#reporte_pie').show();//muestro
        }        
        break;
    //trimestre
    case '2':
       console.log('oculto mes');
        $('#reporte_pie').hide();//oculto la parte de grafico
        $('#contenedor_mes').hide();        
        
        break;
    //año
    case '3':
         $('#reporte_pie').hide();//oculto la parte de grafico
        $('#contenedor_mes').hide();   
        break;
    default:
            console.log('defecto');
		} 
	
}); 











function dibujar_grafico_meses () {
      
      
	/* var id_unidad=13;	
	var mes=12;
	var ano=2016;	
	var tipo=$("#tipo").val();	 */
	
	var id_unidad=$("#unidad").val();	
	var mes=$("#mes").val();
	var ano=$("#ano").val();
	var tipo=$("#tipo").val();	
	//var tiempo=$('input:radio[name=tiempo]').val();	
		
	
	var tiempo=$('input:radio[name=tiempo]').val();	
	var paralabel = new Array(); //GLOBAL
	var paradatos = new Array(); //GLOBAL
	
	console.log(id_unidad);
	
	var dataString = 'id_unidad=' + id_unidad + '&mes=' + mes + '&ano=' + ano + '&tipo='+ tipo;
      
      
      $.ajax({					
			type: "POST",
			url: BASE_URL + 'Indicadores/reporte_meses',
			data: dataString,
			cache: false,
			dataType : 'json',
			async: false,
			success: function(data)
			{				
			   //var id=e;
			   console.log('entre 123');  
			  
			  
			  for (var i=0; i < data.length; i++) {		
			  	
			  			console.log('imprimir  push');
			  			//console.log(data[i].ind_indicador); 		
				 	 	paralabel.push(data[i].ind_indicador);
				 	 		
				 	 	paradatos.push( {value:data[i].induni_consumo , name:data[i].ind_indicador });
				  	
				};		
			   var cantidad =  paralabel.length ;  
			  console.log('tengo: ' , cantidad  );
			    			   	  
			}, //success end
			error: function(xhr, ajaxOptions, thrownError) {			
						alert('No se pudo cargar');
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
						} 
		}); // ajax end
 
var cantidad =  paralabel.length ;  
console.log('tengo: ' , cantidad  );

var cantidad =  paradatos.length ;  
console.log('datos tengo: ' , cantidad  );

 for (var i=0; i < paralabel.length; i++) {
 	console.log('imprimir  array');		 		
	console.log(paralabel[i]);	
				  	
};	      

      
//var paralabel = ['jark', 'ortiz']; 

var datos = [{ value: 335, name: 'jark' }, { value: 310, name: 'ortiz'  }];


 var echartPie = echarts.init(document.getElementById('echart_pie'), theme);

      echartPie.setOption({
        tooltip: {
          trigger: 'item',
          formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
          x: 'left',
          y: 'bottom',
          //data: ['jark', 'E-mail Marketing', 'Union Ad', 'Video Ads', 'Search Engine']
          //data: ['jark', 'ortiz']
          data: paralabel
        },
        toolbox: {
          show: true,
          feature: {
            magicType: {
              show: true,
              type: ['pie', 'funnel'],
              option: {
                funnel: {
                  x: '25%',
                  width: '50%',
                  funnelAlign: 'left',
                  max: 1548
                }
              }
            },
            restore: {
              show: true,
              title: "Restore"
            },
            saveAsImage: {
              show: true,
              title: "Save Image"
            }
          }
        },
        calculable: true,
        series: [{
          name: 'Indicadores',
          type: 'pie',
          radius: '55%',
          center: ['50%', '48%'],
          data:  paradatos
         /*data: [{
            value: 335,
            name: 'jark'
          }, {
            value: 310,
            name: 'E-mail Marketing'
          }, {
            value: 234,
            name: 'Union Ad'
          }, {
            value: 135,
            name: 'Video Ads'
          }, {
            value: 1548,
            name: 'Search Engine'
          }]*/
        }]
      });

      var dataStyle = {
        normal: {
          label: {
            show: false
          },
          labelLine: {
            show: false
          }
        }
      };

      var placeHolderStyle = {
        normal: {
          color: 'rgba(0,0,0,0)',
          label: {
            show: false
          },
          labelLine: {
            show: false
          }
        },
        emphasis: {
          color: 'rgba(0,0,0,0)'
        }
      };
      
  } //fin funcion dibujar gráfico meses
  
  
});  