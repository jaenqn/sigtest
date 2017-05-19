// create the configurable selection modifier
      var fishbone = d3.fishbone();
      
      // load the data
      d3.json("./data.json", function(data){
        // the most reliable way to get the screen size
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
        
      });

