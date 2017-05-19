<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>jQuery File Upload Example</title>
<link href="{$public_url}vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
    <link href="{$public_url}vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link href="{$public_url}vendors/pnotify/dist/pnotify.css" rel="stylesheet">
<link href="{$public_url}vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
<link href="{$public_url}vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet">
<style type="text/css">
    .bar {
        height: 18px;
        background: green;
    }
</style>
</head>
<body>
<input id="fileupload" type="file" name="files[]" data-url="{$base_url}server/php/" multiple>
<div id="progress">
    <div class="bar" style="width: 0%;"></div>
</div>
<!-- <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script> -->
<script src="{$public_url}vendors/jquery/dist/jquery.min.js"></script>
    <script src="{$public_url}vendors/pnotify/dist/pnotify.js"></script>
    <script src="{$public_url}vendors/pnotify/dist/pnotify.buttons.js"></script>
    <script src="{$public_url}vendors/pnotify/dist/pnotify.nonblock.js"></script>
    <script src="{$public_url}vendors/pnotify/dist/pnotify.callbacks.js"></script>
<script src="{$public_url}vendors/jquery-upload/js/vendor/jquery.ui.widget.js"></script>
<script src="{$public_url}vendors/jquery-upload/js/jquery.iframe-transport.js"></script>
<script src="{$public_url}vendors/jquery-upload/js/jquery.fileupload.js"></script>
<script>
// var loader;
var loaders_num = 0;
window.onload = function(){
    function fake_load() {
        loaders_num++;
        var cur_value = 1,
            progress;

        // Make a loader.
        // loader = new PNotify({
        //     title: "Creating series of tubes",
        //     text: '<div class="progress progress-striped active" style="margin:0" id=loader-"'+ loaders_num +'">\
        //         <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0">\
        //             <span class="sr-only">0%</span>\
        //         </div>\
        //     </div>'
        //     ,
        //     //icon: 'fa fa-moon-o fa-spin',
        //     icon: 'fa fa-cog fa-spin',
        //     hide: false,
        //     buttons: {
        //         closer: false,
        //         sticker: false
        //     },
        //     history: {
        //         history: false
        //     },
        //     before_open: function(notice) {
        //         console.log('asdasd');
        //         console.log(notice);
        //         // progress = notice.get().find("#loader-" + loaders_num + " .progress-bar");
        //         console.log(notice.get());
        //         progress = notice.get().find("div.progress-bar");
        //         progress.width(cur_value + "%").attr("aria-valuenow", cur_value).find("span").html(cur_value + "%");
        //         // Pretend to do something.
        //         var timer = setInterval(function() {
        //             console.log('ss');
        //             if (cur_value == 70) {
        //                 loader.update({
        //                     title: "Aligning discrete worms",
        //                     icon: "fa fa-circle-o-notch fa-spin"
        //                 });
        //             }
        //             if (cur_value == 80) {
        //                 loader.update({
        //                     title: "Connecting end points",
        //                     icon: "fa fa-refresh fa-spin"
        //                 });
        //             }
        //             if (cur_value == 90) {
        //                 loader.update({
        //                     title: "Dividing and conquering",
        //                     icon: "fa fa-spinner fa-spin"
        //                 });
        //             }
        //             if (cur_value >= 100) {
        //                 // Remove the interval.
        //                 window.clearInterval(timer);
        //                 loader.remove();
        //                 return;
        //             }
        //             cur_value += 1;
        //             progress.width(cur_value + "%").attr("aria-valuenow", cur_value).find("span").html(cur_value + "%");
        //         }, 495);
        //     }
        // });
    }
    $('#fileupload').fileupload({

        dataType: 'json',
        acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
        add: function (e, data) {
           // data.cnotifica =  new PNotify({
           //      title: "Creating series of tubes",
           //      text: '<div class="progress progress-striped active" style="margin:0" id=loader-"'+ loaders_num +'">\
           //          <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0">\
           //              <span class="sr-only">0%</span>\
           //          </div>\
           //      </div>'
           //      ,
           //      //icon: 'fa fa-moon-o fa-spin',
           //      icon: 'fa fa-cog fa-spin',
           //      hide: false,
           //      buttons: {
           //          closer: false,
           //          sticker: false
           //      },
           //      history: {
           //          history: false
           //      },
           //      before_open: function(notice) {
           //          console.log('asdasd');
           //          console.log(notice);

           //      }
           //  });
            // fake_load();
            console.log(data);
            // data.contex2t = $('<button/>').text('Upload')
            //     .appendTo(document.body)
            //     .click(function () {
            //         data.contex2t = $('<p/>').text('Uploading...').replaceAll($(this));
                    data.submit();
                // });

        },
        // add: function (e, data) {
        //     data.context = $('<p/>').text('Uploading...').appendTo(document.body);
        //     data.submit();
        // },
        done: function (e, data) {
            console.log(data);
            // data.contex2t.text('Upload finished: ');
        },
        // done: function (e, data) {
        //     $.each(data.result.files, function (index, file) {
        //         $('<p/>').text(file.name).appendTo(document.body);
        //     });
        // },
        progress: function (e, data) {
            // var elprogress;
            // console.log(data);
            var progress = parseInt(data.loaded / data.total * 100, 10);
            console.log(progress);
            // data.contex2t.text(progress);

            // $('#progress .bar').css(
            //     'width',
            //     progress + '%'
            // );
        }
        // progressall: function (e, data) {
        //     // var elprogress;

        //     var progress = parseInt(data.loaded / data.total * 100, 10);

        //     // $('#progress .bar').css(
        //     //     'width',
        //     //     progress + '%'
        //     // );
        // }
    });
}
$(function () {



});
</script>
</body>
</html>