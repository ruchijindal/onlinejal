<%-- 
    Document   : bankList
    Created on : 1 Apr, 2011, 5:41:43 PM
    Author     : smp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Noida Jal Board : Bank List</title>
        <jsp:include page="../common/header.jsp"/>
    </head>
    <body>
        <jsp:include page="../common/navigation.jsp"/>
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
                            <a href="../../index.jsp" title="Home">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Home
                                        </span>
                                    </span>
                                </span>
                            </a>
                        </div> <!-- #breadcrums .active -->
                        <div class="inactive">
                            <a href="#" title="Home">
                                <span class="leftcorners">
                                    <span class="rightarrow">
                                        <span class="bg">
                                            Consumer
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
                                            Bank List
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
                    <div id="contentrail">

                        <div id="table-blk" class="full">
                            <div class="heading heading35">
                                <div class="leftcorners">
                                    <div class="rightcorners">
                                        <div class="bg">
                                            <h2>List of Bank Name </h2>
                                        </div> <!-- #news .bg -->
                                    </div> <!-- #news .rightcorners -->
                                </div> <!-- #news .leftcorners -->
                            </div> <!-- #news .heading -->
                            <div class="content">
                                <div class="insider">

                                     Consumers can pay their bills at following branches -

                                     <br/>
                                      <br/>
                                     <table>
                                         <tr>
                                             <th>Serial No.</th>
                                             <th>Bank Name</th>
                                             <th>Branch</th>
                                         </tr>
                                         <tr>
                                             <td>1</td>
                                             <td>Central Bank of India</td>
                                             <td>Sector-02</td>
                                         </tr>
                                         <tr>
                                             <td>2</td>
                                             <td>Uco Bank</td>
                                             <td>Sector-03</td>
                                         </tr>
                                         <tr>
                                             <td>3</td>
                                             <td>Vijaya Bank</td>
                                             <td>Sector-06</td>
                                         </tr>
                                         <tr>
                                             <td>4</td>
                                             <td>Canara Bank</td>
                                             <td>Sector-06</td>
                                         </tr>
                                         <tr>
                                             <td>5</td>
                                             <td>Allahabad Bank</td>
                                             <td>Sector-10</td>
                                         </tr>
                                         <tr>
                                             <td>6</td>
                                             <td>Central Bank of India</td>
                                             <td>Sector-15A</td>
                                         </tr>
                                         <tr>
                                             <td>7</td>
                                             <td>Andhra Bank</td>
                                             <td>Sector-19</td>
                                         </tr>
                                         <tr>
                                             <td>8</td>
                                             <td>Vijaya Bank</td>
                                             <td>Sector-19</td>
                                         </tr>
                                         <tr>
                                             <td>9</td>
                                             <td>Oriental bank of commerce</td>
                                             <td>Sector-20, Bhangel</td>
                                         </tr>
                                         <tr>
                                             <td>10</td>
                                             <td>Federal Bank</td>
                                             <td>Sector-22</td>
                                         </tr>
                                         <tr>
                                             <td>11</td>
                                             <td>Punjab and Sind Bank</td>
                                             <td>Sector-24</td>
                                         </tr>
                                         <tr>
                                             <td>12</td>
                                             <td>Punjab National Bank</td>
                                             <td>Sector-27</td>
                                         </tr>
                                         <tr>
                                             <td>13</td>
                                             <td>Indian Overseas Bank</td>
                                             <td>Sector-31</td>
                                         </tr>
                                         <tr>
                                             <td>14</td>
                                             <td>Bank of India</td>
                                             <td>Sector-62</td>
                                         </tr>

                                         <tr>
                                             <td>15</td>
                                             <td>Zila Sahakari Bank</td>
                                             <td>Sector-26</td>
                                         </tr>
                                         <tr>
                                             <td>16</td>
                                             <td>Bank of India</td>
                                             <td>Sector-62</td>
                                         </tr>

                                     </table>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
                    <jsp:include page="../common/footer.jsp"/>
    </body>

</html>
