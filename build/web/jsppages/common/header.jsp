
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/style.css" type="text/css" />
<link rel="stylesheet" href="../../resources/css/jquery.css"/>

    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.cycle.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.tweet.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.srcoll.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.lightbox.js"></script>
    <script type="text/javascript">

        function menu(){
            $(" #menu ul li ul ").css({display: "none"});
            $(" #menu ul li").hover(function(){
                $(this).find('ul:first').css({visibility: "visible",display: "none"}).slideToggle(500);
            },function(){
                $(this).find('ul:first').css({visibility: "hidden"});
            });
        }
        $(document).ready(function(){
            menu();
        });

        $('#slides').cycle({
            fx:     'srcollHorz',
            prev:   '#arrowleft',
            next:   '#arrowright',
            timeout: 0
        });

        $(document).ready(function(){
            $("#tweet").tweet({
                username: "sketchdock", // Change your Twitter name
                avatar_size: 0,
                count: 1,
                loading_text: "Loading-2520latest-2520tweet..-2E"
            });
        });

        $(document).ready(
        function(){
            $("#arrowhide a").click(function(){
                $("#headinger").slideToggle("slow");
                $("#arrowhide a").toggleClass("hidden");
            });
        });

        // Z-index in IE7 Improvement
        $(function() {
            var zIndexNumber = 1000;
            $('div').each(function() {
                $(this).css('zIndex', zIndexNumber);
                zIndexNumber -= 10;
            });
        });


    </script>

