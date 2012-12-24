#! /usr/bin python
# -*- coding: iso-8859-1 -*-
#  <p>This is the start of my <strong>dynamic</strong> Python server-side photo album.</p>

print """
<html>

<head>
    <meta charset="utf-8" />
    <title>Jeter Family Pictures</title>
    <link rel="stylesheet" type="text/css" href="/pictures/pic.css" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            $('nav').hover(
                function() {
                    $(this).find('iframe').contents().find('html').css('overflow', 'auto');
                    $('div#arrows').hide();
                    $(this).stop().animate(
                        {
                            left: '0',
                            backgroundColor: '#f00'
                        },
                        750
                        //'swing' is default, 'linear' is the only other option
                
                        );
                },
                function() {
                    $(this).find('iframe').contents().find('html').css('overflow', 'hidden');
                    $('div#arrows').show();
                    $(this).stop().animate(
                        {
                            left: '-155px',
                            backgroundColor: '#666'
                        },
                        1500,
                        'linear'
                        );
                }
            );
        });
    </script>
</head>
<body class="index">
    <nav>
        <div id="arrows"><b>&gt;&gt;</b></div>
        <iframe src="frameindex.py" id="index" seamless></iframe>
    </nav>
    <iframe src="framethumbnails.py" name="thumbnails" id="thumbnails"></iframe>
</body>

</html>"""