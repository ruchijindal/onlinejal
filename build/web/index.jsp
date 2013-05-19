
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");

            response.setDateHeader("Expires", 0);


%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>
<%@page  language="java" import="javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.DocumentBuilder,org.w3c.dom.*" %>

<%!    int t = 0;
    int j = 0;
    String sql;
    String content;
    String content_type;
    String con_id;
    String con_date;
    String con_title;
    PreparedStatement pst;
    Connection con;
    ResultSet rs;
    String content1;
    String sql1;
    String content2;
    String content3;
    int rownum = 0;
    int index;
    int x;
    String str;
    String heading;
    String newslink;
    String newsdate;
    String infolink;
    String caption_heading;
    String captiontxt;
    String id;
    String path;
    String userrole;
    String block;
    int len;
    String xmlpath;
    ArrayList<String> sectorList = new ArrayList<String>();
    ArrayList<Integer> sectorListnum = new ArrayList<Integer>();
    ArrayList<String> sectorListChar = new ArrayList<String>();

%>


<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head> <title>Noida Jal Board : Home</title>

        <link rel="stylesheet" href="resources/css/style.css" type="text/css" />


        <script type="text/javascript" src="resources/js/jquery.min.js"></script>
        <script type="text/javascript" src="resources/js/jquery.scroll.js"></script>
        <script type="text/javascript" src="resources/js/jquery.cycle.js"></script>
        <script type="text/javascript" src="resources/js/jquery.tweet.js"></script>
        <script type="text/javascript" src="resources/jquery/jquery.validate.js"></script>
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
                fx:     'scrollHorz',
                prev:   '#arrowleft',
                next:   '#arrowright',
                timeout: 5000
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
                    $("#slideshower").slideToggle("slow");
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
            function GetXmlHttpObject()
            {
                var xmlHttp=null;
                try
                {
                    // Firefox, Opera 8.0+, Safari
                    xmlHttp=new XMLHttpRequest();
                }
                catch (e)
                {
                    //Internet Explorer
                    try
                    {
                        xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
                    }
                    catch (e)
                    {
                        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
                    }
                }
                return xmlHttp;
            }
            function selectdiv()
            { //document.getElementById("consno").style.display="none";

                var dd = document.getElementById("sec").selectedIndex;
                var sec = document.getElementById("sec")[dd].text;
                //alert(sec);
                // var x= document.getElementById("consno");
                //  x.length=0;
                //document.getElementById("consno").options[0]=new Option("Select",null);

                xmlHttp=GetXmlHttpObject()

                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request")
                    return
                }

                var url="/OnlineJal/blockList"
                url=url+"?&sec="+sec;

                xmlHttp.onreadystatechange=stateChanged
                //document.getElementById("consno").style.display="none";
                xmlHttp.open("GET",url,true)
                xmlHttp.send(null)
            }
            function stateChanged()
            {
                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {
                    var showdata1 = xmlHttp.responseText;

                    //document.form1.project_code.focus();
                    var valarray = showdata1.split(":");
                    //alert(showdata1);
                    var x= document.getElementById("blkno");
                    var l=x.options.length;

                    for(j=l;j>0;j--)
                    {
                        x.remove(j);
                    }
                    var count=0;
                    if(valarray.length>1)
                    {
                        for(i=0;i<=valarray.length;++i)
                        {


                            document.getElementById("blkno").options[i+1]=new Option(valarray[i],valarray[i]);
                            count++;
                            // alert("helo")

                        }
                        document.getElementById("blkno").options[count]=new Option("N/A",null);
                    }
                    else
                        document.getElementById("blkno").options[count+1]=new Option("N/A",null);


                    //document.form1.block_no.value=valarray[1];

                }
            }
            function showConsumerNo()
            {

                var dd = document.getElementById("sec").selectedIndex;
                var sec = document.getElementById("sec")[dd].text;
                var indexBlock=document.getElementById("blkno").selectedIndex;
                var block = document.getElementById("blkno")[indexBlock].text;
                var flatNo=document.getElementById("flatno").value;

                if((sec =='Select' || block=='Select') )
                {
                    if(flatNo!=""){
                        alert("You did not select Sector or Block!!");
                        document.getElementById("flatno").value="";
                    }
                    else{


                    }
                }
                else
                {
                    xmlHttp=GetXmlHttpObject()

                    if (xmlHttp==null)
                    {
                        alert ("Browser does not support HTTP Request")
                        return
                    }

                    var url="/OnlineJal/showConsumerNo"
                    if(document.getElementById("consno").style.display=="inline")
                    {
                        var consn=document.getElementById("consno").value;
                        url=url+"?&sec="+sec+"&blkNo="+block+"&flatNo="+flatNo+"&consno="+consn;
                    }
                    else
                    {
                        url=url+"?&sec="+sec+"&blkNo="+block+"&flatNo="+flatNo;

                    }

                    //alert(url);
                    xmlHttp.onreadystatechange=stateChanged1
                    xmlHttp.open("GET",url,true)
                    xmlHttp.send(null)
                }


            }


            function stateChanged1()
            {

                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {

                    var showdata1 = xmlHttp.responseText;
                    //alert(showdata1);
                    var valarray = showdata1.split(":");

                    var x= document.getElementById("consno").value;
                    x.length=0;
                    var arrayList=new Array("select","1st","2nd","3rd","4th","5th","6th","7th","8th","9th","10th","11th","12th","13th","14th","15th","16th","17th","18th","19th","20th");


                    if( valarray.length==1  )
                    {
                        //alert("valarray length=1");
                        var dd = document.getElementById("sec").selectedIndex;
                        var sec = document.getElementById("sec")[dd].text;
                        var indexBlock=document.getElementById("blkno").selectedIndex;
                        var block = document.getElementById("blkno")[indexBlock].text;
                        var flatNo=document.getElementById("flatno").value;
                        var consn=document.getElementById("consno").value;
                        top.location.href="cons_login.jsp?&sec="+sec+"&blkno="+block+"&flatno="+flatNo+"&consno="+consn;
                        document.getElementById("consno").options[0]="0";
                        document.getElementById("consno").style.display="none";
                        //alert(valarray[0]);

                    }
                    else
                    {


                        document.getElementById("consno").style.display="inline";

                        document.getElementById("consno").options[0]=new Option(arrayList[0],"");

                        for(i=1;i<valarray.length+1;i++)
                        {


                            document.getElementById("consno").options[i]=new Option(arrayList[i]+' Conn',valarray[i-1]);



                        }



                    }

                    //document.form1.block_no.value=valarray[1];

                }
            }


            function newsstop()
            {
                document.getElementById('newsFlash').stop();

            }
            function newsstart()
            {
                document.getElementById('newsFlash').start();

            }

            function wait()
            {

                if(document.getElementById("consno").style.display=="none")
                {
                    // alert("none");
                    showConsumerNo();
                    //alert("in if wait");
                }
                else{


                    showConsumerNo();
                    //alert("in else wait");
                    //                var dd = document.getElementById("sec").selectedIndex;
                    //                var sec = document.getElementById("sec")[dd].text;
                    //                var indexBlock=document.getElementById("blkno").selectedIndex;
                    //                var block = document.getElementById("blkno")[indexBlock].text;
                    //                var flatNo=document.getElementById("flatno").value;
                    //                var dd1 = document.getElementById("consno").selectedIndex;
                    //                var consno=document.getElementById("consno")[dd1].text;
                    //                var consn=document.getElementById("consno").value;
                    //                //alert("sec="+sec+"&blkno="+block+"&flatno="+flatNo+"&consno="+consn+"");
                    //
                    //                top.location.href="cons_login.jsp?&sec="+sec+"&blkno="+block+"&flatno="+flatNo+"&consno="+consn+"";
                }
            }
        </script>
        <script type="text/javascript">
            $(document).ready(function(){


                $("#consLogin").validate( );

            });
        </script>


    </head>
    <body>
        <%
                    userrole = (String) session.getAttribute("userrole");
                    String ph1 = (String) pageContext.getServletContext().getAttribute("ph1");
                    String ph2 = (String) pageContext.getServletContext().getAttribute("ph2");

        %>


        <!--	<marquee id="newsFlash" scrolldelay="0" scrollamount="4"><div style="width: 0px" onMouseOver="newsstop();" onMouseOut="newsstart();"><nobr>News Flash Text Goes Here</nobr></div></marquee>-->


        <jsp:include page="jsppages/common/navigation.jsp"/>

        <div id="helper">
            <div class="inside">
                <div class="container">
                    <div class="leftcorners">
                        <div class="rightcorners">
                            <div class="bg">
                            </div> <!-- #helper .bg -->
                        </div> <!-- #helper .rightcorners -->
                    </div> <!-- #helper .leftcorners -->
                </div> <!-- #helper .container -->
            </div> <!-- #helper .inside -->
        </div> <!-- #helper -->







        <div id="slideshow" >
            <div class="inside">
                <div class="container">
                    <div id="slideshower">
                        <div id="arrowleft"><a href="#" title="Previous"></a></div> <!-- #slideshow .arrowleft -->
                        <div id="slides" style="visibility: hidden" >

                            <%

                                        try {
                                            InitialContext initialContext = new InitialContext();
                                            DataSource dataSource = (DataSource) initialContext.lookup("OnlineJal");
                                            con = dataSource.getConnection();
                                            sql = "select id,path,captiontxt,caption_heading from slider_image";

                                            //con = (Connection) pageContext.getServletContext().getAttribute("con");
                                            pst = con.prepareStatement(sql);
                                            rs = pst.executeQuery();
                                            while (rs.next()) {
                                                id = rs.getString(1);
                                                path = rs.getString(2);
                                                captiontxt = rs.getString(3);
                                                caption_heading = rs.getString(4);

                            %>

                            <div    class="slide" style="width:940px;background: url(<%=path%>) center no-repeat; ">

                                <div class="content">

                                    <h4><%=caption_heading%></h4>
                                    <p><%=captiontxt%></p>
                                </div> <!-- #slideshow .content -->

                            </div> <!-- #slideshow #slide1 -->
                            <%
                                            }
                                        } catch (Exception ex) {
                                            System.out.println(ex);
                                        }
                            %>




                        </div> <!-- #slideshow #slides -->

                        <div id="arrowright"><a href="#" title="Next"></a></div> <!-- #slideshow .arrowright -->
                    </div> <!-- #slideshow #slideshower -->

                    <div id="arrowhide"><a href="#" title="Hide/Show Slideshow"></a></div> <!-- #slideshow .arrowhide -->
                    <br class="clear" />
                </div> <!-- #slideshow .container -->
            </div> <!-- #slideshow .inside -->
        </div> <!-- #slideshow -->


        <div class="inside">
            <div class="container">
                <div id="centerrail" >
                    <div id="news" class="box box620 w1">

                        <marquee id="newsFlash" scrolldelay="0" scrollamount="2"><div onMouseOver="newsstop();" onMouseOut="newsstart();">

                                <%
                                            try {
                                                sql1 = "select con_id,con_title,content,content_type,to_char(con_date,'dd Mon,yyyy') from jal_content where content_type='news' and display='default' order by con_date desc,priority ";
                                                pst = con.prepareStatement(sql1);
                                                rs = pst.executeQuery();
                                                rownum = 0;
                                                while (rs.next() && rownum < 5) {
                                                    con_id = rs.getString(1);
                                                    con_title = rs.getString(2);
                                                    content = rs.getString(3);
                                                    content_type = rs.getString(4);
                                                    con_date = rs.getString(5);
                                                    str = content;
                                                    index = 0;
                                                    if (content != null) {
                                                        content = content.replaceAll("\\<.*?>", " ");
                                                        String newslink = "";
                                                        if (content.length() < 200) {
                                                            newslink = content;
                                                        } else {
                                                            newslink = content.substring(0, 200);


                                                        }

                                %>


                                &nbsp;&nbsp;&nbsp;&nbsp;<a href="jsppages/sitepages/news.jsp?con_id=<%=con_id%>" title="continue"><label><%=con_title%></label></a>
                                <!--           <img src="resources/images/logo.png" alt="noida_logo" width="50" height="20"/>-->



                                <%}
                                                    rownum++;
                                                }




                                            } catch (Exception ex) {
                                                System.out.println(ex);
                                            }
                                %>

                            </div></marquee>

                    </div>
                </div></div></div>

        <div id="breadcrumbs">
            <div class="inside">
                <div class="container">
                    <div id="breadcrumb">

                        <div class="youarehere">
                            <div class="leftcorners">
                                <div class="rightarrow">
                                    <div class="bg">
                                        You are here :
                                    </div> <!-- #breadcrums .bg -->
                                </div> <!-- #breadcrums .rightarrow -->
                            </div> <!-- #breadcrums .leftcorners -->
                        </div> <!-- #breadcrums .youarehere -->

                        <div class="active">
                            <a href="#" title="Home">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Home
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->

                    </div> <!-- #breadcrums .breadcrumb -->
                </div> <!-- #breadcrums .container -->
            </div> <!-- #breadcrums .inside -->
        </div> <!-- #breadcrums -->


        <div id="content">
            <div class="inside">
                <div class="container">
                    <div id="contentrail">

                        <div class="news">
                            <div class="content">
                                <div class="insider">
                                    <div class="article">
                                        <br class="clear" />
                                        <%

                                                    try {
                                                        int count = 0;
                                                        //con = (Connection) pageContext.getServletContext().getAttribute("con");
                                                        con_id = request.getParameter("con_id");
                                                        con_title = request.getParameter("con_title");
                                                        content = request.getParameter("content");
                                                        content_type = request.getParameter("content_type");
                                                        con_date = request.getParameter("con_date");
                                                        sql = "select con_id,con_title,content,content_type,con_date from jal_content where content_type='message' and display='home' order by priority";
                                                        pst = con.prepareStatement(sql);
                                                        rs = pst.executeQuery();
                                                        while (rs.next() && count < 2) {
                                                            con_id = rs.getString(1);
                                                            con_title = rs.getString(2);
                                                            content = rs.getString(3);
                                                            content_type = rs.getString(4);
                                                            con_date = rs.getString(5);

                                        %>

                                        <h2><%=con_title%></h2>

                                        <div class="home"><%=content%></div><br class="clear"/>


                                        <%
                                                            count++;
                                                        }
                                                    } catch (Exception ex) {
                                                        System.out.println(ex);
                                                    }
                                        %>
                                    </div> <!-- #news .article -->

                                </div>  <!-- #news .insider -->
                            </div> <!-- #news .content -->
                        </div> <!-- #news -->

                        <br class="clear" />
                        <br/>


                    </div> <!-- #centerrail -->

                    <div id="rightrail">


                        <%
                                    if (userrole == null) {
                        %>
                        <div id="newsletter" class="box box300">
                            <div class="heading heading35">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">

                                            <h3>Consumer Enquiry</h3>

                                        </div> <!-- #newsletter .bg -->
                                    </div> <!-- #newsletter .rightcorners -->
                                </div> <!-- #newsletter .leftcorners -->
                            </div> <!-- #newsletter .heading -->
                            <div class="content">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">
                                            <div class="insider">
                                                <br class="clear" />
                                                <%
                                                                                        if (request.getAttribute("t") != null) {
                                                                                            t = (Integer) request.getAttribute("t");

                                                                                            if (t == 1) {
                                                %>
                                                <p class="errorcolor" style="margin-left:15px;"><label>Invalid Address</label></p>
                                                <%
                                                                                                                                                t = (Integer) 0;
                                                                                                                                            }
                                                                                                                                        } else {
                                                %>

                                                <p style="margin-left:15px;"><label>Enter Address</label></p>
                                                <%                   }
                                                %>
                                                <div class="newslettersignup">
                                                    <form id="consLogin"  method="post" onsubmit=" showConsumerNo()">
                                                        <fieldset >
                                                            <!--label>Cons No: </label><br/>
                                                           <input  type="text" name="userid" id="userid"  size="23" /><br/-->
                                                            <label style="text-align: left" >Sector: </label>

                                                            <select name="sec" id="sec" class="required"  onchange="selectdiv()" style="width: 160px; height: 28px; margin-bottom: 10px;"  >
                                                                <option value="selected">Select</option>
                                                                <%
                                                                                                        try {

                                                                                                            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
                                                                                                            DocumentBuilder db = dbf.newDocumentBuilder();

                                                                                                            xmlpath = this.getServletContext().getRealPath("") + "/resources/jalutilXML/" + "jal.xml";  // get path on the server
                                                                                                            Document doc = db.parse(xmlpath);

                                                                                                            NodeList nl1 = doc.getElementsByTagName("sector");
                                                                                                            len = nl1.getLength();
                                                                                                            sectorList.clear();
                                                                                                            sectorListnum.clear();
                                                                                                            sectorListChar.clear();
                                                                                                            String sectorNO;
                                                                                                            for (int i = 0; i < len; i++) {
                                                                                                                sectorNO = nl1.item(i).getFirstChild().getNodeValue();
                                                                                                                if ((sectorNO.charAt(0) >= 'A' && sectorNO.charAt(0) <= 'Z') || (sectorNO.charAt(0) >= 'a' && sectorNO.charAt(0) <= 'z')) {
                                                                                                                    sectorListChar.add(sectorNO);
                                                                                                                } else {

                                                                                                                    if (sectorNO.length() > 2) {
                                                                                                                        char[] chrArray = sectorNO.toCharArray();
                                                                                                                        boolean flag = false;

                                                                                                                        for (int j = 0; j < chrArray.length; j++) {
                                                                                                                            if ((chrArray[j] >= 'A' && chrArray[j] <= 'Z') || (chrArray[j] >= 'a' && chrArray[j] <= 'z')) {
                                                                                                                                flag = true;
                                                                                                                                break;
                                                                                                                            }
                                                                                                                        }
                                                                                                                        if (flag == true) {
                                                                                                                            sectorList.add(sectorNO);

                                                                                                                        } else {
                                                                                                                            sectorListnum.add(Integer.parseInt(sectorNO));

                                                                                                                        }
                                                                                                                    } else {
                                                                                                                        sectorList.add(sectorNO);
                                                                                                                    }
                                                                                                                }

                                                                                                            }
                                                                                                            Collections.sort(sectorList);
                                                                                                            Collections.sort(sectorListnum);
                                                                                                            Collections.sort(sectorListChar);

                                                                                                            for (int i = 0; i < sectorList.size(); i++) {

                                                                %>
                                                                <option value="<%= sectorList.get(i)%>"><%= sectorList.get(i)%></option>
                                                                <%
                                                                                                                                                                            }
                                                                                                                                                                            for (int i = 0; i < sectorListnum.size(); i++) {

                                                                %>
                                                                <option value="<%= sectorListnum.get(i)%>"><%= sectorListnum.get(i)%></option>
                                                                <%
                                                                                                                                                                            }
                                                                                                                                                                            for (int i = 0; i < sectorListChar.size(); i++) {

                                                                %>
                                                                <option value="<%= sectorListChar.get(i)%>"><%= sectorListChar.get(i)%></option>
                                                                <%
                                                                                                            }
                                                                                                        } catch (Exception ex) {
                                                                                                            System.out.println(ex);
                                                                                                        }
                                                                %>
                                                            </select><br/>

                                                            <label style="text-align: left" >Block: </label>


                                                            <select name="blkno" id="blkno" class="required" style="width: 160px; height: 28px; margin-bottom: 10px;"  >
                                                                <option label="Select">Select</option>



                                                            </select>

                                                            <label style="text-align: left" >Flat No: </label>

                                                            <br/> <input  type="text" name="flatno" id="flatno"   />

                                                            <select name="consno" id="consno" class="required"   style="width: 90px;height: 25px;margin-top: 5px;margin-left: 10px; display: none" >

                                                            </select>

                                                            <br/> <br/>


                                                            <div class="buttons" >

                                                                <button  id="button" class="submit" type="submit" style="margin-right: 115px"   >
                                                                    <span class="leftcorners" >
                                                                        <span class="rightcorners">
                                                                            <span class="bg" style="margin-right: 10px;" >
                                                                                Submit
                                                                            </span>
                                                                        </span>
                                                                    </span></button>
                                                            </div>
                                                        </fieldset>
                                                    </form>
                                                </div> <!-- #newsletter .newslettersignup -->

                                                <br class="clear" />
                                            </div> <!-- #newsletter .insider -->
                                        </div> <!-- #newsletter .bg -->
                                    </div> <!-- #newsletter .rightcorners -->
                                </div> <!-- #newsletter .leftcorners -->
                            </div> <!-- #newsletter .content -->
                        </div> <!-- #newsletter -->
                        <br class="clear" />
                        <%
                                    }
                        %>

                        <br class="clear" />


                        <div id="features"  style="margin-top: -20px"  >
                            <div class="box box300 last">
                                <div class="heading heading40">
                                    <div class="leftcorners">
                                        <div class="rightcorners">
                                            <div class="bg">
                                                <div class="icon analyzeevolve"></div>
                                                <h3>  Call Us </h3>
                                            </div> <!-- #features .bg -->
                                        </div> <!-- #features .rightcorners -->
                                    </div> <!-- #features .leftcorners -->
                                </div> <!-- #features .heading -->


                                <div class="content" >
                                    <div class="leftcorners">
                                        <div class="rightcorners">
                                            <div class="bg">
                                                <div class="insider">
                                                    <br class="clear" />
                                                    <p style="margin-top: -10px">For any Assistance, please call our Customer Care Number, Monday to Friday Between 10:00AM to 05:00PM</p>
                                                    <br/>


                                                    <div style="padding-left: 50px">
                                                        <img src="<%=request.getContextPath()%>/resources/images/Phone.png" alt="Phone"/>
                                                        <h3 style="margin-left: 60px; margin-top: -50px"> <%= ph1%></h3>
                                                        <br/>
                                                        <h3 style="margin-left: 60px; margin-top: -47px"> <%= ph2%></h3>
                                                    </div>


                                                </div> <!-- #features .insider -->


                                            </div> <!-- #features .bg -->
                                        </div> <!-- #features .rightcorners -->
                                    </div> <!-- #features .leftcorners -->
                                    <!-- #features .content -->
                                </div>
                                <%

                                            try {
                                                sql = "select con_id,con_title,content,content_type,con_date from jal_content where content_type='testimonial' and display='home' order by con_date desc";
                                                pst = con.prepareStatement(sql);
                                                rs = pst.executeQuery();
                                                if (rs.next()) {
                                                    con_id = rs.getString(1);
                                                    con_title = rs.getString(2);
                                                    content = rs.getString(3);
                                                    content_type = rs.getString(4);
                                                    con_date = rs.getString(5);
                                %>

                                <br class="clear"/>
                                <br class="clear"/>
                                <div id="features">
                                    <div class="box box300 last">
                                        <div class="heading heading40">
                                            <div class="leftcorners">
                                                <div class="rightcorners">
                                                    <div class="bg">
                                                        <div class="icon analyzeevolve"></div>
                                                        <h3> <%=con_title%> </h3>
                                                    </div> <!-- #features .bg -->
                                                </div> <!-- #features .rightcorners -->
                                            </div> <!-- #features .leftcorners -->
                                        </div> <!-- #features .heading -->

                                        <div class="content">
                                            <div class="leftcorners">
                                                <div class="rightcorners">
                                                    <div class="bg">
                                                        <div class="insider">
                                                            <br class="clear" />

                                                            <%
                                                                                                                str = content;
                                                                                                                index = 0;


                                                                                                                String noticelink = "";
                                                                                                                if (content.length() < 200) {
                                                                                                                    noticelink = content;
                                                                                                                } else {
                                                                                                                    noticelink = content.substring(0, 200);


                                                                                                                }


                                                            %>

                                                            <%=content%>
                                                            <%
                                                                            }
                                                                        } catch (Exception ex) {
                                                                            System.out.println(ex);
                                                                        } finally {
                                                                            con.close();
                                                                        }
                                                            %>

                                                        </div> <!-- #features .insider -->

                                                        <br class="clear" />
                                                    </div> <!-- #features .bg -->
                                                </div> <!-- #features .rightcorners -->
                                            </div> <!-- #features .leftcorners -->
                                        </div> <!-- #features .content -->

                                    </div> <!-- #features .box -->

                                </div> <!-- #rightrail -->
                                <br class="clear" />
                            </div>
                        </div>
                    </div> <!-- #features -->

                </div> <!-- #content .inside .container -->
            </div> <!-- #content .inside -->
            <br class="clear" />


        </div> <!-- #content -->

        <jsp:include page="jsppages/common/footer.jsp"/>




    </body>
</html>