{extends $_template}
{block 'css'}


{/block}
{block 'contenido'}
    <!--Contenido HTML-->
<div class="row">
    <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="x_panel">
            <div class="x_title">
                <h2>Bitacora</h2>


                <div class="clearfix"></div>
            </div>
            <div class="x_content">
                <div class="dashboard-widget-content">

                    <ul class="list-unstyled timeline widget">
                      {foreach $lstBitacora as $objB}
                      <li>
                        <div class="block">
                          <div class="block_content">
                            <h2 class="title">
                                              <a>{$objB->bbi_titulo}</a>
                                          </h2>
                            <div class="byline">
                              <span class="txt-fecha" data-fecha="{$objB->bbi_fecha}">-- -- --</span> por <a>{$objB->usu_nombre}&nbsp;{$objB->usu_apellidos}</a>
                            </div>
                            <p class="excerpt">{$objB->bbi_descripcion}</p>
                          </div>
                        </div>
                      </li>
                      {/foreach}
                    </ul>
                  </div>
            </div>
        </div>
    </div>
</div>


{/block}
{block 'script'}

<script type="text/javascript">
  $(document).ready(function() {
    $('.txt-fecha').each(function(e,v){
      var f = moment(v.dataset.fecha);
      var a = moment();
      if(f.isValid()){
        if(a.diff(f, 'days') >= 1)
          $(v).text(f.format('lll'));
        else
          $(v).text(f.fromNow());
      }

    });
  });
</script>
{/block}