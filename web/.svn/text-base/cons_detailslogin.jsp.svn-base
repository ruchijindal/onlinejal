<%--
    Document   : index
    Created on : Nov 12, 2009, 1:45:33 PM
    Author     : Admin
--%>

<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache ,must-revalidate");

            response.setDateHeader("Expires", 0);

%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>
<%@page  language="java" import="javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.DocumentBuilder,org.w3c.dom.*" %>





<%!    int date;
    int year;
    int month;
    String sess;
    int t = 0;
    String xmlpath;
    int len;
    int a = 0;
    String errormsg = "";
    ArrayList<String> sectorList = new ArrayList<String>();
    ArrayList<Integer> sectorListnum = new ArrayList<Integer>();
    ArrayList<String> sectorListChar = new ArrayList<String>();

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head> <title>Noida Jal Board : Consumer Details</title>
        <jsp:include page="jsppages/common/header.jsp"/>

        <script  type="text/javascript" src="resources/jquery/jquery-1.3.2.js"></script>
        <script type="text/javascript" src="resources/jquery/jquery.validate.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                $("#userform").validate();

            });
        </script>
        <script type="text/javascript">
            $(document).ready(function(){
                $("#userform2").validate();

            });
            $(document).ready(function(){


            $("#userform1").validate();
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
            {

                var dd = document.getElementById("sec").selectedIndex;
                var sec = document.getElementById("sec")[dd].text;
                //alert(sec);
                //var x= document.getElementById("consno");
                //x.length=0;
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
                xmlHttp.open("GET",url,true)
                xmlHttp.send(null)
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
                       top.location.href="cons_login.jsp?a=1&sec="+sec+"&blkno="+block+"&flatno="+flatNo+"&consno="+consn;
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

            function check()
            {
                //var conType= document.getElementById("consno").value;
                //alert(conType);
            }



        </script>
    </head>


    <%
                request.getSession(false);



                String ph1 = (String) pageContext.getServletContext().getAttribute("ph1");
                String ph2 = (String) pageContext.getServletContext().getAttribute("ph2");

    %>


    <body>
        <!-- Menu Starts -->
        <jsp:include page="jsppages/common/navigation.jsp"/>

        <div id="helper">
            <div class="inside">
                <div class="container">
                    <div class="bgr">

                    </div> <!-- #helper .leftcorners -->
                </div> <!-- #helper .container -->
            </div> <!-- #helper .inside -->
        </div> <!-- #helper -->




        <div id="breadcrumbs">
            <div class="inside">
                <div class="container">
                    <div id="breadcrumb">

                        <div class="youarehere">
                            <div class="leftcorners">
                                <div class="rightarrow">
                                    <div class="bg">
                                        You are here:
                                    </div> <!-- #breadcrums .bg -->
                                </div> <!-- #breadcrums .rightarrow -->
                            </div> <!-- #breadcrums .leftcorners -->
                        </div> <!-- #breadcrums .youarehere -->

                        <div class="inactive">
                            <a href="index.jsp" title="Home">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Home
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->

                        <div class="active">
                            <a href="#" title="Forms">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Consumer Details
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->

                    </div> <!-- #breadcrums .breadcrumb -->
                </div> <!-- #breadcrums .container -->
            </div> <!-- #breadcrums .inside -->
        </div> <!-- #breadcrums -->

        <!-- Container Starts -->
        <div id="content">
            <div class="inside">
                <div class="container">
                    <div id="contentrail" class="half">



                        <h2>Enter Address</h2>

                        <%
                                    if (request.getAttribute("t") != null) {
                                        t = (Integer) request.getAttribute("t");

                                        if (t == 1) {
                        %>
                        <p class="errorcolor"><label>Invalid Address</label></p>
                        <%
                                            t = (Integer) 0;
                                        }
                                    }
                        %>



                        <form id="userform"  onsubmit="showConsumerNo()" method="post">
                            <fieldset>
                                <ul>
                                    <li>
                                        <table>
                                            <tbody>

                                                <tr>

                                                    <td><label for="sec" >Sector: <span class="required">*</span></label></td>
                                                    <td><select name="sec" id="sec" class="required" style="margin-left: 52px"  onchange="selectdiv()">
                                                            <option value=" Select">Select</option>
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
                                                        </select><br/><br/></td>

                                                </tr>

                                                <tr>
                                                    <td><label for="blkno"  >Block: <span class="required">*</span></label></td>
                                                    <td>
                                                        <select name="blkno" id="blkno" class="required"  style="margin-left: 52px"   >
                                                            <option label="Select">Select</option>



                                                        </select><br/><br/></td>
                                                </tr>
                                                <tr>
                                                    <td> <label for="flatno" >Flat No:  <span class="required">*</span></label></td>
                                                    <td>  <input  type="text" name="flatno" id="flatno"   onblur="showConsumerNo()" style="width: 100px;margin-left: 52px"/>

                                                        <select name="consno" id="consno"  class="required" style="width: 100px; display:none; margin-left: 8px ">

                                                        </select>


                                                        <br/><br/></td>
                                                </tr>




                                                <tr>

                                                    <td></td><td>
                                                        <div class="buttons"  style="margin-left: 48px;">

                                                            <button class="submit" type="submit" value="Submit"   >
                                                                <span class="leftcorners">
                                                                    <span class="rightcorners">
                                                                        <span class="bg">
                                                                            Submit
                                                                        </span>
                                                                    </span>
                                                                </span>
                                                            </button>

                                                        </div>

                                                        <div class="buttons">
                                                            <button class="submit" type="reset" value="Reset">
                                                                <span class="leftcorners">
                                                                    <span class="rightcorners">
                                                                        <span class="bg">
                                    		Reset
                                                                        </span>
                                                                    </span>
                                                                </span>
                                                            </button>

                                                        </div>
                                                    </td></tr>

                                            </tbody>
                                        </table>
                                    </li>
                                </ul>
                            </fieldset>


                        </form>
                        <div id="report" style="margin-top: 40px;">
                            <div id="contentrail" class="half" >


                                <h2>Enter Consumer Number</h2>
                                <%
                                            if (request.getAttribute("t10") != null) {
                                                t = (Integer) request.getAttribute("t10");

                                                if (t == 1) {
                                %>
                                <p class="errorcolor"><label>Invalid Consumer Number</label></p>
                                <%
                                                    t = (Integer) 0;
                                                }
                                            }
                                %>

                                <div class="content">
                                    <div class="leftcorners">
                                        <div class="rightcorners">
                                            <div class="bg">
                                                <div class="insider">
                                                    <form id="userform2" action="consumer.jsp" method="post">
                                                        <fieldset>
                                                            <ul>
                                                                <li>
                                                                    <table>
                                                                        <tbody>
                                                                            <tr>
                                                                                <td> <label for="consumerNo" >Consumer No.:  <span class="required">*</span></label></td>
                                                                                <td>  <input  type="text" name="consumerNo" id="consumerNo"  class="required"   /><br/><br/></td>
                                                                            </tr>
                                                                            <tr>

                                                                                <td></td><td>
                                                                                    <div class="buttons"   >

                                                                                        <button class="submit" type="submit" value="Submit"  >
                                                                                            <span class="leftcorners">
                                                                                                <span class="rightcorners">
                                                                                                    <span class="bg">
                                                                                                        Submit
                                                                                                    </span>
                                                                                                </span>
                                                                                            </span>
                                                                                        </button>

                                                                                    </div>

                                                                                    <div class="buttons">
                                                                                        <button class="submit" type="reset" value="Reset">
                                                                                            <span class="leftcorners">
                                                                                                <span class="rightcorners">
                                                                                                    <span class="bg">
                                    		Reset
                                                                                                    </span>
                                                                                                </span>
                                                                                            </span>
                                                                                        </button>

                                                                                    </div>
                                                                                </td></tr>
                                                                            <tr><td><br/></td>
                                                                            </tr>
                                                                             <tr><td colspan="2"><p class="required">* Required Fields</p></td></tr>
                                                                        </tbody>
                                                                    </table>
                                                                </li>
                                                            </ul>
                                                        </fieldset>
                                                    </form>
                                                </div> <!-- #news .article -->
                                            </div>  <!-- #news .insider -->
                                        </div> <!-- #news .bg -->
                                    </div> <!-- #news .rightcorners -->
                                </div> <!-- #news .leftcorners -->

                            </div> <!-- #rightrail -->
                        </div>
                    </div> <!-- #news .article -->
                    <div id="report" >
                        <div id="contentrail" class="half" >


                            <h2>Find Consumer No.</h2>



                            <form id="userform1" action="<%= request.getContextPath()%>/ViewConsumerDetReport" method="post" onSubmit="return validate()">
                                <fieldset>
                                    <ul>
                                        <li><table><tbody>


                                                    <tr>

                                                        <td><label  for="sec">Sector:<span class="required"> *</span></label></td>
                                                        <td>  <select name="sec" id="sec" class="required" style="margin-left: 52px;"   >
                                                                <option value="" selected>select</option>
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
                                                            </select>

                                                        </td>
                                                        <td class="errorcolor" id="error1"><label id="err"  ><%=errormsg%></label><br/><br/></td>
                                                    </tr>


                                                   
                                                    <tr>
                                                        <td></td><td><div class="buttons" style="margin-left: 48px;">

                                                                <button class="submit " type="submit" value="Submit">
                                                                    <span class="leftcorners">
                                                                        <span class="rightcorners">
                                                                            <span class="bg">
                                    			Submit
                                                                            </span>
                                                                        </span>
                                                                    </span>
                                                                </button>



                                                                <button class="submit" type="reset" value="Reset">
                                                                    <span class="leftcorners">
                                                                        <span class="rightcorners">
                                                                            <span class="bg">
                                    		Reset
                                                                            </span>
                                                                        </span>
                                                                    </span>
                                                                </button>

                                                            </div></td></tr></tbody>
                                            </table>


                                        </li>
                                    </ul>
                                </fieldset>


                            </form>



                        </div> <!-- #rightrail -->
                    </div>




                    <!-- #centerrail -->
                </div>
            </div>
        </div>

        <!-- Footer Starts -->
        <jsp:include page="jsppages/common/footer.jsp"/>
        <!-- Footer Ends -->


    </body>
</html>









































