<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");

            response.setDateHeader("Expires", 0);

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>
<%!    String userrole;
    int t;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <jsp:include page="../common/header.jsp"/>
    <body>
        <%
                    request.getSession(false);
                    request.setAttribute("t", t);

                    userrole = (String) session.getAttribute("userrole");
                    String ph1 = (String) pageContext.getServletContext().getAttribute("ph1");
                    String ph2 = (String) pageContext.getServletContext().getAttribute("ph2");


        %>
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
                                            Privacy Policy
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
                                            <h2>Privacy Policy</h2>
                                        </div> <!-- #news .bg -->
                                    </div> <!-- #news .rightcorners -->
                                </div> <!-- #news .leftcorners -->
                            </div> <!-- #news .heading -->
                            <div class="content">
                                <div class="insider">


                                    <table width="100%" border="0">
                                        <tr>
                                            <td colspan="2" class="Content"><p>Thank you for visiting our
                                                    web site. This privacy policy tells you how we use personal
                                                    information collected at this site. Please read this privacy
                                                    policy before using the site or submitting any personal information.
                                                    By using the site, you are accepting the practices described
                                                    in this privacy policy. These practices may be changed, but
                                                    any changes will be posted and changes will only apply to
                                                    activities and information on a going forward, not retroactive
                                                    basis. You are encouraged to review the privacy policy whenever
                                                    you visit the site to make sure that you understand how any
                                                    personal information you provide will be used.</p>
                                                <p><strong>Note:</strong> the privacy practices set forth in
                                                    this privacy policy are for this web <a href="http://www.prashantsharma.com" class="Content" >site</a>
                                                    only. If you link to other web sites, please review the privacy
                                                    policies posted at those sites.</p>
                                                <p><strong>Collection of Information<br/>
                                                    </strong>We collect personally identifiable information, like
                                                    names, postal addresses, email addresses, etc., when voluntarily
                                                    submitted by our visitors. The information you provide is
                                                    used to fulfill you specific request. This information is
                                                    only used to fulfill your specific request, unless you give
                                                    us permission to use it in another manner, for example to
                                                    add you to one of our mailing lists.</p>
                                                <p><strong>Cookie/Tracking Technology<br/>
                                                    </strong>The Site may use cookie and tracking technology depending
                                                    on the features offered. Cookie and tracking technology are
                                                    useful for gathering information such as browser type and
                                                    operating system, tracking the number of visitors to the Site,
                                                    and understanding how visitors use the Site. Cookies can also
                                                    help customize the Site for visitors. Personal information
                                                    cannot be collected via cookies and other tracking technology,
                                                    however, if you previously provided personally identifiable
                                                    information, cookies may be tied to such information. Aggregate
                                                    cookie and tracking information may be shared with third parties.</p>
                                                <p><strong>Distribution of Information</strong><br/>
                                                    We may share information with governmental agencies or other
                                                    companies assisting us in fraud prevention or investigation.
                                                    We may do so when: (1) permitted or required by law; or, (2)
                                                    trying to protect against or prevent actual or potential fraud
                                                    or unauthorized transactions; or, (3) investigating fraud
                                                    which has already taken place. The information is not provided
                                                    to these companies for marketing purposes. </p>
                                                <p><strong>Commitment to Data Security</strong><br/>
                                                    Your personally identifiable information is kept secure. Only
                                                    authorized employees, agents and contractors (who have agreed
                                                    to keep information secure and confidential) have access to
                                                    this information. All emails and newsletters from this site
                                                    allow you to opt out of further mailings. </p>
                                                <p><strong>Privacy Contact Information</strong><br/>
                                                    If you have any questions, concerns, or comments about our
                                                    privacy policy you may contact us using the information below:<br/>
                                                    <br/>
                                                    By e-mail: <br/>
                                                    By Phone: </p>
                                                <p>We reserve the right to make changes to this policy. Any
                                                    changes to this policy will be posted.</p></td>
                                        </tr> </table>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Container Ends -->
        <!-- Footer Starts -->
        <jsp:include page="../common/footer.jsp"/>
        <!-- Footer Ends -->

    </body>
</html>
