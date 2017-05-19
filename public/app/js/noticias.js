(function(jq){
   // window.onload = function(){
     var p =$('.cat-noticia') ;
      p.find('.cont-img img').each(function(e,v){
        var  o = $(v).prev();
        o.height(v.height);
        o.width(v.width);
        var pp = o.find('p');
        pp.css('margin-top',(v.height/2) - (pp.get(0).offsetHeight/2));

      })
      p.find('.cont-img')
        .on('mouseover',function(e){
          $(this).find('div').css('visibility','visible');
        })
        .on('mouseleave',function(e){
          $(this).find('div').css('visibility','hidden');
        })
   // }


})(jQuery || this.jQuery || window.jQuery)