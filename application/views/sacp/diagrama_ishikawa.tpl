<!DOCTYPE html>
  <head>
    <title>Diagrama de Ishikawa</title>
    <meta charset="utf-8">
   <link href="{$public_url}views/sacp/js/d3/style.css" rel="stylesheet">
  </head>
  <body>

<script src="{$public_url}views/sacp/js/d3/d3.min.js"></script>
<script src="{$public_url}views/sacp/js/d3/d3.fishbone.js"></script>

<script>
 var datos_json = {$datos_json};
 console.log(datos_json);
{literal}
   // load the data
   		var fishbone = d3.fishbone();
    
     // d3.json( false,function(datos_json){
      	data = datos_json;
      	
        // the most reliable way to get the screen size
        console.log(data);
        console.log(datos_json , 'data');
        
        var size = (function(){
            return {width: this.clientWidth, height: this.clientHeight};
          }).bind(window.document.documentElement),
        
        svg = d3.select("body")
          .append("svg")
          // firefox needs a real size
          .attr(size())
          // set the data so the reusable chart can find it
          .datum(data)
          // set up the default arrowhead
          .call(fishbone.defaultArrow)
          // call the selection modifier
          .call(fishbone);
          
        // this is the actual `force`: just start it
        fishbone.force().start();
        
        // handle resizing the window
        d3.select(window).on("resize", function(){
          fishbone.force()
            .size([size().width, size().height])
            .start();
          svg.attr(size())
        });
        
     // });

</script>
{/literal}

 
  </body>
</html>