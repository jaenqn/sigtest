var rrg = {};

jQuery(document).ready(function($) {
    rrg.selYear = $('#selYear');
    rrg.containermes = $('.containermes');
    rrg.btnGenerar = $('#btnGenerar');
    rrg.containertotal = $('.containertotal');
    rrg.containerpro = $('.containerpro');
    rrg.selYear.on('change',fnChangeYear);

});

function fnChangeYear(){
    // console.log(this.value);
    if(rrg.btnGenerar.attr('disabled') == 'disabled') rrg.btnGenerar.attr('disabled', false);
    rrg.btnGenerar.attr('href',BASE_URL + 'residuo/reportes_general_solidos?r=excel&d=' + this.value);

    $.getJSON(BASE_URL + 'residuo/get_generacion_residuos_solidos/' + this.value, {}, function(json, textStatus) {
            var nf = new Intl.NumberFormat("de-DE", {minimumFractionDigits : 2, maximumFractionDigits : 2});
            console.log(json);
            var ot = 0, it = 0, npt = 0, pt = 0, rt = 0;
            var op = 0, ip = 0, npp = 0, pp = 0, rp = 0;
            var countfilters = 0;
            rrg.containermes.each(function(e,v){
                console.log(v.dataset.resMes);
                var target = rrg.getData(json,v.dataset.resMes);
                var npo = 0, npi = 0, tnp = 0, p = 0, tr = 0;
                if(target){
                    countfilters++;
                    npo = target.no_pel_org == null ? 0 : +target.no_pel_org;
                    ot += npo;
                    npi = target.no_pel_ino == null ? 0 : +target.no_pel_ino;
                    it += npi;
                    tnp = +npo + +npi;
                    npt += tnp;
                    p = target.pel == null ? 0 : +target.pel;
                    pt += p;
                    tr = target.total_solidos == null ? 0 : +target.total_solidos;
                    rt += tr;
                }

                $(v).find('.res-np-organico').text(nf.format(npo)).end().
                    find('.res-np-inorganico').text(nf.format(npi)).end().
                    find('.res-np-total').text(nf.format(tnp)).end().
                    find('.res-p-total').text(nf.format(p)).end().
                    find('.res-total').text(nf.format(tr));
            });
            op = ot/12;
            ip = it/12;
            npp = npt/12;
            pp = pt/12;
            rp = rt/12;

            rrg.containertotal.
                find('.total-np-org').text(nf.format(ot)).end().
                find('.total-np-ino').text(nf.format(it)).end().
                find('.total-np').text(nf.format(npt)).end().
                find('.total-pel').text(nf.format(pt)).end().
                find('.total-res').text(nf.format(rt));
            rrg.containerpro.
                find('.pro-np-org').text(nf.format(op)).end().
                find('.pro-np-ino').text(nf.format(ip)).end().
                find('.pro-np').text(nf.format(npp)).end().
                find('.pro-pel').text(nf.format(pp)).end().
                find('.pro-res').text(nf.format(rp));
    });
    console.log('asdasd');
}
rrg.getData = function(vArray, sValue){
    for (var i = 0; i < vArray.length; i++) {
        if(+vArray[i].mes == sValue) return vArray[i];
    };
    return false;
}