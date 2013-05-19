<%
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "no-store, no-cache");

            response.setDateHeader("Expires", 0);

%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.smp.jal.*,java.io.*;"%>

<%!    int cp = 0;
    String userrole;
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
                                            Terms & Condition
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
                                            <h2>Terms & Conditions</h2>
                                        </div> <!-- #news .bg -->
                                    </div> <!-- #news .rightcorners -->
                                </div> <!-- #news .leftcorners -->
                            </div> <!-- #news .heading -->
                            <div class="content">
                                <div class="insider">





                                    <table  border="0" align="center" cellpadding="8" cellspacing="0" style="border-collapse:collapse;">

                                        <tr>
                                            <td><p align="justify">This page states the Terms and Conditions under  which you (Visitor) may visit this Web site. Please read this page carefully.  If you do not accept the Terms and Conditions stated here, we would request you  to exit this site. Tata Metaliks Limited., any of its business divisions and /  or its subsidiaries, associate companies or subsidiaries to subsidiaries or  such other investment companies (in India or abroad) reserve their respective  rights to revise these Terms and Conditions at any time by updating this  posting. You should visit this page periodically to re-appraise yourself of the  Terms and Conditions, because they are binding on all users of this Web Site.</p>
                                                <p><strong>Use of Content</strong></p>
                                                <p align="justify">All logos, brands, marks headings, labels, names,  signatures, numerals, shapes or any combinations thereof, appearing in this  site, except as otherwise noted, are properties either owned, or used under  licence, by Tata Metaliks Limited and / or its associate entities who feature  on this website. The use of these properties or any other content on this site,  except as provided in these terms and conditions or in the site content, is  strictly prohibited.</p>
                                                <p align="justify">You may not sell or modify the content of this Web  Site or reproduce, display, publicly perform, distribute, or otherwise use the  materials in any way for any public or commercial purpose without the  respective organisation&rsquo;s or entity&rsquo;s written permission. </p>
                                                <p align="justify"><strong>Acceptable Site Use</strong></p>
                                                <p><strong>(A) Security Rules</strong></p>
                                                <p align="justify">Visitors are prohibited from violating or attempting to  violate the security of the Web site, including, without limitation, (1)  accessing data not intended for such user or logging into a server or account  which the user is not authorised to access, (2) attempting to probe, scan or  test the vulnerability of a system or network or to breach security or  authentication measures without proper authorisation, (3) attempting to interfere with service to any user, host  or network, including, without limitation, via means of submitting a virus or  &quot;Trojan horse&quot; to the Web site, overloading, &quot;flooding&quot;,  &quot;mail bombing&quot; or &quot;crashing&quot;, or (4) sending unsolicited  electronic mail, including promotions and/or advertising of products or  services. Violations of system or network security may result in civil or  criminal liability. Tata Metaliks Limited and / or its associate entities will  have the right to investigate occurrences that they suspect as involving such  violations and will have the right to involve, and cooperate with, law enforcement  authorities in prosecuting users who are involved in such violations.</p>
                                                <p><strong>(B) General Rules</strong></p>
                                                <p align="justify">Visitors may not use the Web Site in order to  transmit, distribute, store or destroy material (a) that could constitute or  encourage conduct that would be considered a criminal offence or violate any  applicable law or regulation, (b) in a manner that will infringe the copyright,  trademark, trade secret or other intellectual property rights of others or  violate the privacy or publicity of other personal rights of others, or (c)  that is libellous, defamatory, pornographic, profane, obscene, threatening,  abusive or hateful. </p>
                                                <p><strong>Links to/from other Web Sites</strong> </p>
                                                <p align="justify">This Web site contains links to other Web Sites. These links  are provided solely as a convenience to you. Wherever such link/s lead to sites  which do not belong to Tata Metaliks Limited and / or its associate entities, Tata  Metaliks Limited is not responsible for the content of linked sites and does  not make any representations regarding the correctness or accuracy of the  content on such Web Sites. If you decide to access such linked Web Sites, you  do so at your own risk.</p>
                                                <p align="justify">Similarly, this Web site can be made accessible through a  link created by other Web sites. Access to this Web site through such link/s  shall not mean or be deemed to mean that the objectives, aims, purposes, ideas,  concepts of such other Web sites or their aim or purpose in establishing such  link/s to this Web site are necessarily the same or similar to the idea, concept,  aim or purpose of our web site or that such links have been authorised by Tata  Metaliks Limited and / or its associate entities. We are not responsible for  any representation/s of such other Web sites while affording such link and no  liability can arise upon Tata Metaliks Limited and / or its associate entities  consequent to such representation, its correctness or accuracy. In the event  that any link/s afforded by any other Web site/s derogatory in nature to the  objectives, aims, purposes, ideas and concepts of this Web site is utilised to  visit this Web site and such event is brought to the notice or is within the  knowledge of Tata Metaliks Limited and / or its associate entities, civil or  criminal remedies as may be appropriate shall be invoked. </p>
                                                <strong>Indemnity</strong>
                                                <p align="justify">You agree to defend, indemnify, and hold harmless Tata  Metaliks Limited and/ or its associate entities, their officers, directors,  employees and agents, from and against any claims, actions or demands, including  without limitation reasonable legal and accounting fees, alleging or resulting  from your use of the Web site material or your breach of these terms and  conditions of Web Site use. </p>
                                                <strong>Liability</strong>
                                                <p align="justify">While all reasonable care has been taken in providing the  content on this Web Site, Tata Metaliks Limited. and / or its associate  entities shall not be responsible or liable as to the completeness or  correctness of such information and any or all consequential liabilities  arising out of use of any information or contents on this Web Site. </p>
                                                <p align="justify">No warranty is given that the Web Site will operate  error-free or that this Web Site and its server are free of computer viruses or  other harmful mechanisms. If your use of the Web site results in the need for  servicing or replacing equipment or data, Tata Metaliks Limited and / or its  associate entities are not responsible for those costs. </p>
                                                <p align="justify">The web site is provided on an 'as is' basis without  any warranties either express or implied whatsoever. Tata Metaliks Limited. and  / or its associate entities, to the fullest extent permitted by law, disclaims  all warranties, including non-infringement of third parties rights, and the  warranty of fitness for a particular purpose and makes no warranties about the  accuracy, reliability, completeness, or timeliness of the content, services,  software, text, graphics, and links. </p>
                                                <strong>Disclaimer of Consequential Damages </strong>
                                                <p align="justify">In no event shall Tata Metaliks Limited, or any  parties, organisations or entities associated with the corporate brand name Tata  Metaliks or otherwise, mentioned at this Web Site be liable for any damages  whatsoever (including, without limitations, incidental and consequential  damages, lost profits, or damage to computer hardware or loss of data  information or business interruption) resulting from the use or inability to  use the Web Site and the Web site material, whether based on warranty,  contract, tort, or any other legal theory, and whether or not, such  organisations or entities were advised of the possibility of such damages. </p></td>
                                        </tr>
                                    </table>

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
