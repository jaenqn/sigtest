window.onload = fnLoad;

function fnLoad(){


            AmCharts.makeChart("char_boletasig", {
            "type": "pie",
            "balloonText": "[[title]]<br><span style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</span>",
            "titleField": "bol_estado_text",
            "valueField": "cantidad",
            "allLabels": [],
            "fontFamily": "Roboto",
            "startDuration": 0,
            "balloon": {},
            "labelText": " [[percents]]%",
            "legend": {
                "enabled": true,
                "align": "center",
                "markerType": "circle",
                "position": "bottom"
            },
            "titles": [
                {
                    "id": "boleta_sig",
                    "text": "Boleta SIG"
                }
            ],
            "dataLoader": {
                "url": BASE_URL + "boletasig/resumen",
                "showCurtain": true
            },
        });


}