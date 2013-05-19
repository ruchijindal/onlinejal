/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bill.generator;

import java.util.Calendar;

/**
 *
 * @author Administrator
 */
public class FindRate {

    double rate;
    Calendar dtfr = Calendar.getInstance();
    Calendar dtto = Calendar.getInstance();

    //Date dtfr=new Date();
    // Date dtto=new Date();
    //Plots Residential/Industrial/Instituitional/Commercial.
    public double getRatePlot(String con_tp, String cons_ctg, String flat_type, float plot_size, int pipe_size, Calendar bl_per_fr) {
        ///////////-----------------Pipe size 15 -------------------------------------------------------------
        if (pipe_size == 15) {
            ///////////-----------------Residential Plots ---------------------------------------------------------
            if (con_tp.equals("R")) {
                //////---------------From 1,April,1990 to 31,March,1995-----------
             /*dtfr.setYear(90);
                dtfr.setMonth(2);
                dtfr.setDate(31);


                dtto.setYear(95);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1990, 2, 31);
                dtto.set(1995, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) // if(dtfr.before(bl_per_fr) && dtto.after(bl_per_fr))
                {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        //For plot size 1 to 250 sq m
                        if (plot_size >= 1 && plot_size <= 250) {
                            rate = 30;
                        }

                        //For plot size above 250 sq m
                        if (plot_size >= 251) {
                            rate = 30;
                        }
                    } //For temporary connection
                    else {
                        //For plot size 1 to 250 sq m
                        if (plot_size >= 1 && plot_size <= 250) {
                            rate = 150;
                        }

                        //For plot size above 250 sq m
                        if (plot_size >= 251) {
                            rate = 150;
                        }
                    }
                }

                ///////////---------------From 1,April,1995 to 31,March,1999---------------------------
           /* dtfr.setYear(95);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(99);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1995, 2, 31);
                dtto.set(1999, 3, 1);
                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        //For plot size 1 to 250 sq m
                        if ((plot_size >= 1 && plot_size <= 250)) {
                            rate = 60;
                        }

                        //For plot size above 250 sq m
                        if (plot_size >= 251) {
                            rate = 100;
                        }
                    } //For temporary connection
                    else {
                        //For plot size 1 to 250 sq m
                        if (plot_size >= 1 && plot_size <= 250) {
                            rate = 200;
                        }

                        //For plot size above 250 sq m
                        if (plot_size >= 251) {
                            rate = 200;
                        }
                    }
                }

                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
          /* dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        //For plot size 1 to 250 sq m
                        if ((plot_size >= 1 && plot_size <= 250)) {
                            rate = 90;
                        }

                        //For plot size above 250 sq m
                        if (plot_size >= 251) {
                            rate = 150;
                        }
                    } //For temporary connection
                    else {
                        //For plot size 1 to 250 sq m
                        if (plot_size >= 1 && plot_size <= 250) {
                            rate = 300;
                        }

                        //For plot size above 250 sq m
                        if (plot_size >= 251) {
                            rate = 300;
                        }
                    }
                }

                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
           /* dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);
                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        //For plot size 1 to 30 sq m
                        if ((plot_size >= 1 && plot_size <= 30)) {
                            rate = 40;
                        }

                        //For plot size 31 to 50 sq m
                        if ((plot_size >= 31 && plot_size <= 50)) {
                            rate = 50;
                        }

                        //For plot size 51 to 100 sq m
                        if ((plot_size >= 51 && plot_size <= 100)) {
                            rate = 120;
                        }

                        //For plot size 101 to 200 sq m
                        if ((plot_size >= 101 && plot_size <= 200)) {
                            rate = 150;
                        }

                        //For plot size 201 to 300 sq m
                        if ((plot_size >= 201 && plot_size <= 300)) {
                            rate = 200;
                        }

                        //For plot size 301 to 400 sq m
                        if ((plot_size >= 301 && plot_size <= 400)) {
                            rate = 230;
                        }

                        //For plot size 401 to 500 sq m
                        if ((plot_size >= 401 && plot_size <= 500)) {
                            rate = 270;
                        }

                        //For plot above 500 sq m
                        if ((plot_size > 500)) {
                            rate = 300;
                        }
                    } //For temporary connection
                    else {
                        //For plot size 1 to 30 sq m
                        if ((plot_size >= 1 && plot_size <= 30)) {
                            rate = 80;
                        }

                        //For plot size 31 to 50 sq m
                        if ((plot_size >= 31 && plot_size <= 50)) {
                            rate = 100;
                        }

                        //For plot size 51 to 100 sq m
                        if ((plot_size >= 51 && plot_size <= 100)) {
                            rate = 240;
                        }

                        //For plot size 101 to 200 sq m
                        if ((plot_size >= 101 && plot_size <= 200)) {
                            rate = 300;
                        }

                        //For plot size 201 to 300 sq m
                        if ((plot_size >= 201 && plot_size <= 300)) {
                            rate = 400;
                        }

                        //For plot size 301 to 400 sq m
                        if ((plot_size >= 301 && plot_size <= 400)) {
                            rate = 460;
                        }

                        //For plot size 401 to 500 sq m
                        if ((plot_size >= 401 && plot_size <= 500)) {
                            rate = 540;
                        }

                        //For plot above 500 sq m
                        if ((plot_size > 500)) {
                            rate = 600;
                        }
                    }
                }

                ///////////---------------Rate after 1,April,2003---------------------------
           /* dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/
                dtfr.set(2003, 2, 31);

                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        //For plot size 1 to 30 sq m
                        if ((plot_size >= 1 && plot_size <= 30)) {
                            rate = 40;
                        }

                        //For plot size 31 to 50 sq m
                        if ((plot_size >= 31 && plot_size <= 50)) {
                            rate = 50;
                        }

                        //For plot size 51 to 100 sq m
                        if ((plot_size >= 51 && plot_size <= 100)) {
                            rate = 120;
                        }

                        //For plot size 101 to 200 sq m
                        if ((plot_size >= 101 && plot_size <= 200)) {
                            rate = 150;
                        }

                        //For plot size 201 to 300 sq m
                        if ((plot_size >= 201 && plot_size <= 300)) {
                            rate = 200;
                        }

                        //For plot size 301 to 400 sq m
                        if ((plot_size >= 301 && plot_size <= 400)) {
                            rate = 230;
                        }

                        //For plot size 401 to 500 sq m
                        if ((plot_size >= 401 && plot_size <= 500)) {
                            rate = 270;
                        }

                        //For plot above 500 sq m
                        if ((plot_size > 500)) {
                            rate = 300;
                        }
                    } //For temporary connection
                    else {
                        //For plot size 1 to 30 sq m
                        if ((plot_size >= 1 && plot_size <= 30)) {
                            rate = 50;
                        }

                        //For plot size 31 to 50 sq m
                        if ((plot_size >= 31 && plot_size <= 50)) {
                            rate = 65;
                        }

                        //For plot size 51 to 100 sq m
                        if ((plot_size >= 51 && plot_size <= 100)) {
                            rate = 150;
                        }

                        //For plot size 101 to 200 sq m
                        if ((plot_size >= 101 && plot_size <= 200)) {
                            rate = 190;
                        }

                        //For plot size 201 to 300 sq m
                        if ((plot_size >= 201 && plot_size <= 300)) {
                            rate = 250;
                        }

                        //For plot size 301 to 400 sq m
                        if ((plot_size >= 301 && plot_size <= 400)) {
                            rate = 290;
                        }

                        //For plot size 401 to 500 sq m
                        if ((plot_size >= 401 && plot_size <= 500)) {
                            rate = 340;
                        }

                        //For plot above 500 sq m
                        if ((plot_size > 500)) {
                            rate = 375;
                        }
                    }
                }
            } //--------------------------------------------------------------------------------------------------------------  //
            ///////////////-----------------Industrial Plots ---------------------------------------------------------/////////
            else if (con_tp.equals("I")) {
                //////---------------From 1,April,1990 to 31,March,1995-----------
           /* dtfr.setYear(90);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(95);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1990, 2, 31);
                dtto.set(1995, 3, 1);
                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        //For plot size 1 to 250 sq m
                        if (plot_size >= 1 && plot_size <= 250) {
                            rate = 60;
                        }

                        //For plot size 251 to 500 sq m
                        if (plot_size >= 251 && plot_size <= 500) {
                            rate = 60;
                        }

                        //For plot size above 500 sq m
                        if (plot_size >= 501) {
                            rate = 60;
                        }
                    } //For temporary connection
                    else {
                        //For plot size 1 to 250 sq m
                        if (plot_size >= 1 && plot_size <= 250) {
                            rate = 150;
                        }

                        //For plot size 251 to 500 sq m
                        if (plot_size >= 251 && plot_size <= 500) {
                            rate = 150;
                        }

                        //For plot size above 500 sq m
                        if (plot_size >= 501) {
                            rate = 150;
                        }
                    }
                }


                ///////////---------------From 1,April,1995 to 31,March,1999---------------------------
           /* dtfr.setYear(95);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(99);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1995, 2, 31);
                dtto.set(1999, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        //For plot size 1 to 250 sq m
                        if (plot_size >= 1 && plot_size <= 250) {
                            rate = 60;
                        }

                        //For plot size 251 to 500 sq m
                        if (plot_size >= 251 && plot_size <= 500) {
                            rate = 90;
                        }

                        //For plot size above 500 sq m
                        if (plot_size >= 501) {
                            rate = 120;
                        }
                    } //For temporary connection
                    else {
                        //For plot size 1 to 250 sq m
                        if (plot_size >= 1 && plot_size <= 250) {
                            rate = 300;
                        }

                        //For plot size 251 to 500 sq m
                        if (plot_size >= 251 && plot_size <= 500) {
                            rate = 300;
                        }

                        //For plot size above 500 sq m
                        if (plot_size >= 501) {
                            rate = 300;
                        }
                    }
                }

                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
            /*dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        //For plot size 1 to 250 sq m
                        if (plot_size >= 1 && plot_size <= 250) {
                            rate = 90;
                        }

                        //For plot size 251 to 500 sq m
                        if (plot_size >= 251 && plot_size <= 500) {
                            rate = 135;
                        }

                        //For plot size above 500 sq m
                        if (plot_size >= 501) {
                            rate = 180;
                        }
                    } //For temporary connection
                    else {
                        //For plot size 1 to 250 sq m
                        if (plot_size >= 1 && plot_size <= 250) {
                            rate = 450;
                        }

                        //For plot size 251 to 500 sq m
                        if (plot_size >= 251 && plot_size <= 500) {
                            rate = 450;
                        }

                        //For plot size above 500 sq m
                        if (plot_size >= 501) {
                            rate = 450;
                        }
                    }
                }

                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
           /* dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        //For plot size 1 to 30 sq m
                        if ((plot_size >= 1 && plot_size <= 30)) {
                            rate = 125;
                        }

                        //For plot size 31 to 50 sq m
                        if ((plot_size >= 31 && plot_size <= 50)) {
                            rate = 125;
                        }

                        //For plot size 51 to 100 sq m
                        if ((plot_size >= 51 && plot_size <= 100)) {
                            rate = 180;
                        }

                        //For plot size 101 to 200 sq m
                        if ((plot_size >= 101 && plot_size <= 200)) {
                            rate = 225;
                        }

                        //For plot size 201 to 300 sq m
                        if ((plot_size >= 201 && plot_size <= 300)) {
                            rate = 300;
                        }

                        //For plot size 301 to 400 sq m
                        if ((plot_size >= 301 && plot_size <= 400)) {
                            rate = 345;
                        }

                        //For plot size 401 to 500 sq m
                        if ((plot_size >= 401 && plot_size <= 500)) {
                            rate = 405;
                        }

                        //For plot size 501 to 1000 sq m
                        if ((plot_size >= 501 && plot_size <= 1000)) {
                            rate = 450;
                        }

                        //For plot size above 1000 sq m
                        if ((plot_size > 1000)) {
                            rate = 500;
                        }
                    } //For temporary connection
                    else {
                        //For plot size 1 to 30 sq m
                        if ((plot_size >= 1 && plot_size <= 30)) {
                            rate = 250;
                        }

                        //For plot size 31 to 50 sq m
                        if ((plot_size >= 31 && plot_size <= 50)) {
                            rate = 250;
                        }

                        //For plot size 51 to 100 sq m
                        if ((plot_size >= 51 && plot_size <= 100)) {
                            rate = 360;
                        }

                        //For plot size 101 to 200 sq m
                        if ((plot_size >= 101 && plot_size <= 200)) {
                            rate = 450;
                        }

                        //For plot size 201 to 300 sq m
                        if ((plot_size >= 201 && plot_size <= 300)) {
                            rate = 600;
                        }

                        //For plot size 301 to 400 sq m
                        if ((plot_size >= 301 && plot_size <= 400)) {
                            rate = 690;
                        }

                        //For plot size 401 to 500 sq m
                        if ((plot_size >= 401 && plot_size <= 500)) {
                            rate = 810;
                        }

                        //For plot size 501 to 1000 sq m
                        if ((plot_size >= 501 && plot_size <= 1000)) {
                            rate = 900;
                        }

                        //For plot above 1000 sq m
                        if ((plot_size > 1000)) {
                            rate = 1000;
                        }
                    }
                }

                ///////////---------------Rate after 1,April,2003---------------------------
           /* dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);

                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        //For plot size 1 to 30 sq m
                        if ((plot_size >= 1 && plot_size <= 30)) {
                            rate = 100;
                        }

                        //For plot size 31 to 50 sq m
                        if ((plot_size >= 31 && plot_size <= 50)) {
                            rate = 100;
                        }

                        //For plot size 51 to 100 sq m
                        if ((plot_size >= 51 && plot_size <= 100)) {
                            rate = 150;
                        }

                        //For plot size 101 to 200 sq m
                        if ((plot_size >= 101 && plot_size <= 200)) {
                            rate = 190;
                        }

                        //For plot size 201 to 300 sq m
                        if ((plot_size >= 201 && plot_size <= 300)) {
                            rate = 250;
                        }

                        //For plot size 301 to 400 sq m
                        if ((plot_size >= 301 && plot_size <= 400)) {
                            rate = 290;
                        }

                        //For plot size 401 to 500 sq m
                        if ((plot_size >= 401 && plot_size <= 500)) {
                            rate = 340;
                        }

                        //For plot above 500 sq m to 1000 sq m
                        if ((plot_size >= 501 && plot_size <= 1000)) {
                            rate = 375;
                        }
                        //for plot above 1000 sq m
                        if (plot_size >= 1001) {
                            rate = 500;
                        }
                    } //For temporary connection
                    else {
                        //For plot size 1 to 30 sq m
                        if ((plot_size >= 1 && plot_size <= 30)) {
                            rate = 125;
                        }

                        //For plot size 31 to 50 sq m
                        if ((plot_size >= 31 && plot_size <= 50)) {
                            rate = 125;
                        }

                        //For plot size 51 to 100 sq m
                        if ((plot_size >= 51 && plot_size <= 100)) {
                            rate = 190;
                        }

                        //For plot size 101 to 200 sq m
                        if ((plot_size >= 101 && plot_size <= 200)) {
                            rate = 240;
                        }

                        //For plot size 201 to 300 sq m
                        if ((plot_size >= 201 && plot_size <= 300)) {
                            rate = 315;
                        }

                        //For plot size 301 to 400 sq m
                        if ((plot_size >= 301 && plot_size <= 400)) {
                            rate = 365;
                        }

                        //For plot size 401 to 500 sq m
                        if ((plot_size >= 401 && plot_size <= 500)) {
                            rate = 425;
                        }

                        //For plot above 500 sq m to 1000 sq m
                        if ((plot_size >= 501 && plot_size <= 1000)) {
                            rate = 470;
                        }
                        //for plot above 1000 sq m
                        if (plot_size >= 1001) {
                            rate = 625;
                        }
                    }
                }
            } //---------------------------------------------------------------------------------------------------------------//
            ///////////////-----------------Institutional Plots ---------------------------------------------------------/////////
            else if (con_tp.equals("T")) {
                //////---------------From 1,April,1990 to 31,March,1995-----------
           /* dtfr.setYear(90);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(95);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1990, 2, 31);
                dtto.set(1995, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        //For plot size 1 to 250 sq m
                        if (plot_size >= 1 && plot_size <= 250) {
                            rate = 60;
                        }

                        //For plot size 251 to 500 sq m
                        if (plot_size >= 251 && plot_size <= 500) {
                            rate = 60;
                        }

                        //For plot size above 500 sq m
                        if (plot_size >= 501) {
                            rate = 60;
                        }
                    } //For temporary connection
                    else {
                        //For plot size 1 to 250 sq m
                        if (plot_size >= 1 && plot_size <= 250) {
                            rate = 150;
                        }

                        //For plot size 251 to 500 sq m
                        if (plot_size >= 251 && plot_size <= 500) {
                            rate = 150;
                        }

                        //For plot size above 500 sq m
                        if (plot_size >= 501) {
                            rate = 150;
                        }
                    }
                }

                ///////////---------------From 1,April,1995 to 31,March,1999---------------------------
           /* dtfr.setYear(95);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(99);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1995, 2, 31);
                dtto.set(1999, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        //For plot size 1 to 250 sq m
                        if (plot_size >= 1 && plot_size <= 250) {
                            rate = 60;
                        }

                        //For plot size 251 to 500 sq m
                        if (plot_size >= 251 && plot_size <= 500) {
                            rate = 90;
                        }

                        //For plot size above 500 sq m
                        if (plot_size >= 501) {
                            rate = 120;
                        }
                    } //For temporary connection
                    else {
                        //For plot size 1 to 250 sq m
                        if (plot_size >= 1 && plot_size <= 250) {
                            rate = 300;
                        }

                        //For plot size 251 to 500 sq m
                        if (plot_size >= 251 && plot_size <= 500) {
                            rate = 300;
                        }

                        //For plot size above 500 sq m
                        if (plot_size >= 501) {
                            rate = 300;
                        }
                    }
                }

                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
           /* dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        //For plot size 1 to 250 sq m
                        if (plot_size >= 1 && plot_size <= 250) {
                            rate = 90;
                        }

                        //For plot size 251 to 500 sq m
                        if (plot_size >= 251 && plot_size <= 500) {
                            rate = 135;
                        }

                        //For plot size above 500 sq m
                        if (plot_size >= 501) {
                            rate = 180;
                        }
                    } //For temporary connection
                    else {
                        //For plot size 1 to 250 sq m
                        if (plot_size >= 1 && plot_size <= 250) {
                            rate = 450;
                        }

                        //For plot size 251 to 500 sq m
                        if (plot_size >= 251 && plot_size <= 500) {
                            rate = 450;
                        }

                        //For plot size above 500 sq m
                        if (plot_size >= 501) {
                            rate = 450;
                        }
                    }
                }

                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
          /*  dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        //For plot size 1 to 30 sq m
                        if ((plot_size >= 1 && plot_size <= 30)) {
                            rate = 125;
                        }

                        //For plot size 31 to 50 sq m
                        if ((plot_size >= 31 && plot_size <= 50)) {
                            rate = 125;
                        }

                        //For plot size 51 to 100 sq m
                        if ((plot_size >= 51 && plot_size <= 100)) {
                            rate = 180;
                        }

                        //For plot size 101 to 200 sq m
                        if ((plot_size >= 101 && plot_size <= 200)) {
                            rate = 225;
                        }

                        //For plot size 201 to 300 sq m
                        if ((plot_size >= 201 && plot_size <= 300)) {
                            rate = 300;
                        }

                        //For plot size 301 to 400 sq m
                        if ((plot_size >= 301 && plot_size <= 400)) {
                            rate = 345;
                        }

                        //For plot size 401 to 500 sq m
                        if ((plot_size >= 401 && plot_size <= 500)) {
                            rate = 405;
                        }

                        //For plot size 501 to 1000 sq m
                        if ((plot_size >= 501 && plot_size <= 1000)) {
                            rate = 450;
                        }

                        //For plot size above 1000 sq m
                        if ((plot_size > 1000)) {
                            rate = 500;
                        }
                    } //For temporary connection
                    else {
                        //For plot size 1 to 30 sq m
                        if ((plot_size >= 1 && plot_size <= 30)) {
                            rate = 250;
                        }

                        //For plot size 31 to 50 sq m
                        if ((plot_size >= 31 && plot_size <= 50)) {
                            rate = 250;
                        }

                        //For plot size 51 to 100 sq m
                        if ((plot_size >= 51 && plot_size <= 100)) {
                            rate = 360;
                        }

                        //For plot size 101 to 200 sq m
                        if ((plot_size >= 101 && plot_size <= 200)) {
                            rate = 450;
                        }

                        //For plot size 201 to 300 sq m
                        if ((plot_size >= 201 && plot_size <= 300)) {
                            rate = 600;
                        }

                        //For plot size 301 to 400 sq m
                        if ((plot_size >= 301 && plot_size <= 400)) {
                            rate = 690;
                        }

                        //For plot size 401 to 500 sq m
                        if ((plot_size >= 401 && plot_size <= 500)) {
                            rate = 810;
                        }

                        //For plot size 501 to 1000 sq m
                        if ((plot_size >= 501 && plot_size <= 1000)) {
                            rate = 900;
                        }

                        //For plot above 1000 sq m
                        if ((plot_size > 1000)) {
                            rate = 1000;
                        }
                    }
                }

                ///////////---------------Rate after 1,April,2003---------------------------
           /* dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);


                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        //For plot size 1 to 30 sq m
                        if ((plot_size >= 1 && plot_size <= 30)) {
                            rate = 100;
                        }

                        //For plot size 31 to 50 sq m
                        if ((plot_size >= 31 && plot_size <= 50)) {
                            rate = 100;
                        }

                        //For plot size 51 to 100 sq m
                        if ((plot_size >= 51 && plot_size <= 100)) {
                            rate = 150;
                        }

                        //For plot size 101 to 200 sq m
                        if ((plot_size >= 101 && plot_size <= 200)) {
                            rate = 190;
                        }

                        //For plot size 201 to 300 sq m
                        if ((plot_size >= 201 && plot_size <= 300)) {
                            rate = 250;
                        }

                        //For plot size 301 to 400 sq m
                        if ((plot_size >= 301 && plot_size <= 400)) {
                            rate = 290;
                        }

                        //For plot size 401 to 500 sq m
                        if ((plot_size >= 401 && plot_size <= 500)) {
                            rate = 340;
                        }

                        //For plot size 501 to 1000 sq m
                        if ((plot_size >= 501 && plot_size <= 1000)) {
                            rate = 375;
                        }

                        //For plot above 500 sq m
                        if ((plot_size > 1000)) {
                            rate = 500;
                        }
                    } //For temporary connection
                    else {
                        //For plot size 1 to 30 sq m
                        if ((plot_size >= 1 && plot_size <= 30)) {
                            rate = 125;
                        }

                        //For plot size 31 to 50 sq m
                        if ((plot_size >= 31 && plot_size <= 50)) {
                            rate = 125;
                        }

                        //For plot size 51 to 100 sq m
                        if ((plot_size >= 51 && plot_size <= 100)) {
                            rate = 190;
                        }

                        //For plot size 101 to 200 sq m
                        if ((plot_size >= 101 && plot_size <= 200)) {
                            rate = 240;
                        }

                        //For plot size 201 to 300 sq m
                        if ((plot_size >= 201 && plot_size <= 300)) {
                            rate = 315;
                        }

                        //For plot size 301 to 400 sq m
                        if ((plot_size >= 301 && plot_size <= 400)) {
                            rate = 365;
                        }

                        //For plot size 401 to 500 sq m
                        if ((plot_size >= 401 && plot_size <= 500)) {
                            rate = 425;
                        }

                        //For plot size 501 to 1000 sq m
                        if ((plot_size >= 401 && plot_size <= 500)) {
                            rate = 470;
                        }

                        //For plot above 1000 sq m
                        if ((plot_size > 1000)) {
                            rate = 625;
                        }
                    }
                }
            } //--------------------------------------------------------------------------------------------------------------//
            ///////////////-----------------Commercial Plots ---------------------------------------------------------/////////
            else if (con_tp.equals("C")) {
                //////---------------From 1,April,1990 to 31,March,1995-----------
           /* dtfr.setYear(90);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(95);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1990, 2, 31);
                dtto.set(1995, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        //For plot size 1 to 250 sq m
                        if (plot_size >= 1 && plot_size <= 250) {
                            rate = 60;
                        }

                        //For plot size 251 to 500 sq m
                        if (plot_size >= 251 && plot_size <= 500) {
                            rate = 60;
                        }

                        //For plot size above 500 sq m
                        if (plot_size >= 501) {
                            rate = 60;
                        }
                    } //For temporary connection
                    else {
                        //For plot size 1 to 250 sq m
                        if (plot_size >= 1 && plot_size <= 250) {
                            rate = 150;
                        }

                        //For plot size 251 to 500 sq m
                        if (plot_size >= 251 && plot_size <= 500) {
                            rate = 150;
                        }

                        //For plot size above 500 sq m
                        if (plot_size >= 501) {
                            rate = 150;
                        }
                    }
                }

                ///////////---------------From 1,April,1995 to 31,March,1999---------------------------
            /*dtfr.setYear(95);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(99);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1995, 2, 31);
                dtto.set(1999, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        //For plot size 1 to 250 sq m
                        if (plot_size >= 1 && plot_size <= 250) {
                            rate = 60;
                        }

                        //For plot size 251 to 500 sq m
                        if (plot_size >= 251 && plot_size <= 500) {
                            rate = 90;
                        }

                        //For plot size above 500 sq m
                        if (plot_size >= 501) {
                            rate = 120;
                        }
                    } //For temporary connection
                    else {
                        //For plot size 1 to 250 sq m
                        if (plot_size >= 1 && plot_size <= 250) {
                            rate = 300;
                        }

                        //For plot size 251 to 500 sq m
                        if (plot_size >= 251 && plot_size <= 500) {
                            rate = 300;
                        }

                        //For plot size above 500 sq m
                        if (plot_size >= 501) {
                            rate = 300;
                        }
                    }
                }

                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
           /* dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        //For plot size 1 to 250 sq m
                        if (plot_size >= 1 && plot_size <= 250) {
                            rate = 90;
                        }

                        //For plot size 251 to 500 sq m
                        if (plot_size >= 251 && plot_size <= 500) {
                            rate = 135;
                        }

                        //For plot size above 500 sq m
                        if (plot_size >= 501) {
                            rate = 180;
                        }
                    } //For temporary connection
                    else {
                        //For plot size 1 to 250 sq m
                        if (plot_size >= 1 && plot_size <= 250) {
                            rate = 450;
                        }

                        //For plot size 251 to 500 sq m
                        if (plot_size >= 251 && plot_size <= 500) {
                            rate = 450;
                        }

                        //For plot size above 500 sq m
                        if (plot_size >= 501) {
                            rate = 450;
                        }
                    }

                }

                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
           /* dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);
                 */

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);
                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        //For plot size 1 to 30 sq m
                        if ((plot_size >= 1 && plot_size <= 30)) {
                            rate = 150;
                        }

                        //For plot size 31 to 50 sq m
                        if ((plot_size >= 31 && plot_size <= 50)) {
                            rate = 150;
                        }

                        //For plot size 51 to 100 sq m
                        if ((plot_size >= 51 && plot_size <= 100)) {
                            rate = 240;
                        }

                        //For plot size 101 to 200 sq m
                        if ((plot_size >= 101 && plot_size <= 200)) {
                            rate = 300;
                        }

                        //For plot size 201 to 300 sq m
                        if ((plot_size >= 201 && plot_size <= 300)) {
                            rate = 400;
                        }

                        //For plot size 301 to 400 sq m
                        if ((plot_size >= 301 && plot_size <= 400)) {
                            rate = 460;
                        }

                        //For plot size 401 to 500 sq m
                        if ((plot_size >= 401 && plot_size <= 500)) {
                            rate = 540;
                        }

                        //For plot size 501 to 1000 sq m
                        if ((plot_size >= 501 && plot_size <= 1000)) {
                            rate = 600;
                        }

                        //For plot size above 1000 sq m
                        if ((plot_size > 1000)) {
                            rate = 600;
                        }
                    } //For temporary connection
                    else {
                        //For plot size 1 to 30 sq m
                        if ((plot_size >= 1 && plot_size <= 30)) {
                            rate = 300;
                        }

                        //For plot size 31 to 50 sq m
                        if ((plot_size >= 31 && plot_size <= 50)) {
                            rate = 300;
                        }

                        //For plot size 51 to 100 sq m
                        if ((plot_size >= 51 && plot_size <= 100)) {
                            rate = 480;
                        }

                        //For plot size 101 to 200 sq m
                        if ((plot_size >= 101 && plot_size <= 200)) {
                            rate = 600;
                        }

                        //For plot size 201 to 300 sq m
                        if ((plot_size >= 201 && plot_size <= 300)) {
                            rate = 800;
                        }

                        //For plot size 301 to 400 sq m
                        if ((plot_size >= 301 && plot_size <= 400)) {
                            rate = 920;
                        }

                        //For plot size 401 to 500 sq m
                        if ((plot_size >= 401 && plot_size <= 500)) {
                            rate = 1080;
                        }

                        //For plot size 501 to 1000 sq m
                        if ((plot_size >= 501 && plot_size <= 1000)) {
                            rate = 1200;
                        }

                        //For plot above 1000 sq m
                        if ((plot_size > 1000)) {
                            rate = 1200;
                        }
                    }
                }

                ///////////---------------Rate after 1,April,2003---------------------------
           /* dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);


                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        //For plot size 1 to 30 sq m
                        if ((plot_size >= 1 && plot_size <= 30)) {
                            rate = 150;
                        }

                        //For plot size 31 to 50 sq m
                        if ((plot_size >= 31 && plot_size <= 50)) {
                            rate = 150;
                        }

                        //For plot size 51 to 100 sq m
                        if ((plot_size >= 51 && plot_size <= 100)) {
                            rate = 240;
                        }

                        //For plot size 101 to 200 sq m
                        if ((plot_size >= 101 && plot_size <= 200)) {
                            rate = 300;
                        }

                        //For plot size 201 to 300 sq m
                        if ((plot_size >= 201 && plot_size <= 300)) {
                            rate = 400;
                        }

                        //For plot size 301 to 400 sq m
                        if ((plot_size >= 301 && plot_size <= 400)) {
                            rate = 460;
                        }

                        //For plot size 401 to 500 sq m
                        if ((plot_size >= 401 && plot_size <= 500)) {
                            rate = 540;
                        }

                        //For plot above 500 sq m
                        if ((plot_size > 500)) {
                            rate = 600;
                        }
                    } //For temporary connection
                    else {
                        //For plot size 1 to 30 sq m
                        if ((plot_size >= 1 && plot_size <= 30)) {
                            rate = 190;
                        }

                        //For plot size 31 to 50 sq m
                        if ((plot_size >= 31 && plot_size <= 50)) {
                            rate = 190;
                        }

                        //For plot size 51 to 100 sq m
                        if ((plot_size >= 51 && plot_size <= 100)) {
                            rate = 300;
                        }

                        //For plot size 101 to 200 sq m
                        if ((plot_size >= 101 && plot_size <= 200)) {
                            rate = 375;
                        }

                        //For plot size 201 to 300 sq m
                        if ((plot_size >= 201 && plot_size <= 300)) {
                            rate = 500;
                        }

                        //For plot size 301 to 400 sq m
                        if ((plot_size >= 301 && plot_size <= 400)) {
                            rate = 575;
                        }

                        //For plot size 401 to 500 sq m
                        if ((plot_size >= 401 && plot_size <= 500)) {
                            rate = 675;
                        }

                        //For plot above 500 sq m
                        if ((plot_size > 500)) {
                            rate = 750;
                        }
                    }
                }
            }
        } //---------------------Pipe size 20-------------------------------------------------
        else if (pipe_size == 20) {
            ///////////----------------- ---Resedential Plots------------------------------------------------------
             if (con_tp.equals("R")) {

                ///////////---------------From 1,April,1990 to 31,March,2002---------------------------
                dtfr.set(1990, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 657;
                    } //For temporary connection
//                    else {
//                        rate = 300;
//                    }
                }

                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 876;
                    } //For temporary connection
//                    else {
//                        rate = 600;
//                    }
                }

                ///////////---------------Rate after 1,April,2003---------------------------
           /*
                dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);


                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 876;
                    } //For temporary connection
//                    else {
//                        rate = 1095;
//                    }

                }
            }
             else if (con_tp.equals("I")) {

                ///////////---------------From 1,April,1990 to 31,March,1995---------------------------
                dtfr.set(1990, 2, 31);
                dtto.set(1995, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 120;
                    } //For temporary connection
//                    else {
//                        rate = 300;
//                    }
                }

                ///////////---------------From 1,April,1995 to 31,March,1999---------------------------
                dtfr.set(1995, 2, 31);
                dtto.set(1999, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 240;
                    } //For temporary connection
//                    else {
//                        rate = 600;
//                    }
                }




                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
           /*
                dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);
                 */

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 360;
                    } //For temporary connection
//                    else {
//                        rate = 900;
//                    }
                }
                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
           /*
                dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);
                 */

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 1314;
                    } //For temporary connection
//                    else {
//                        rate = 2628;
//                    }
                }
                ///////////---------------Rate after 1,April,2003---------------------------
           /*
                dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);


                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 1095;
                    } //For temporary connection
//                    else {
//                        rate = 1368.75;
//                    }

                }
            } ///////////----------------- ---Instituitional Plots------------------------------------------------------
            else if (con_tp.equals("T")) {

                ///////////---------------From 1,April,1990 to 31,March,1995---------------------------
                dtfr.set(1990, 2, 31);
                dtto.set(1995, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 120;
                    } //For temporary connection
//                    else {
//                        rate = 300;
//                    }
                }

                ///////////---------------From 1,April,1995 to 31,March,1999---------------------------
                dtfr.set(1995, 2, 31);
                dtto.set(1999, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 240;
                    } //For temporary connection
//                    else {
//                        rate = 600;
//                    }
                }


                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
           /* dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 360;
                    } //For temporary connection
//                    else {
//                        rate = 900;
//                    }
                }
                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
            /*dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 1314;
                    } //For temporary connection
//                    else {
//                        rate = 2628;
//                    }
                }
                ///////////---------------Rate after 1,April,2003---------------------------
           /* dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);
                 */

                dtfr.set(103, 2, 31);

                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 1095;
                    } //For temporary connection
//                    else {
//                        rate = 1368.75;
//                    }

                }
            } ///////////----------------- ---Commercial Plots------------------------------------------------------
            else if (con_tp.equals("C")) {

                ///////////---------------From 1,April,1990 to 31,March,1995---------------------------
                dtfr.set(1990, 2, 31);
                dtto.set(1995, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 120;
                    } //For temporary connection
//                    else {
//                        rate = 300;
//                    }
                }

                ///////////---------------From 1,April,1995 to 31,March,1999---------------------------
                dtfr.set(1995, 2, 31);
                dtto.set(1999, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 240;
                    } //For temporary connection
//                    else {
//                        rate = 600;
//                    }
                }


                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------

                /*dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 360;
                    } //For temporary connection
//                    else {
//                        rate = 900;
//                    }
                }
                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
           /* dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(102, 2, 31);
                dtto.set(103, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 1752;
                    } //For temporary connection
//                    else {
//                        rate = 3504;
//                    }
                }
                ///////////---------------Rate after 1,April,2003---------------------------
           /* dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);

                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 1752;
                    } //For temporary connection
//                    else {
//                        rate = 2190;
//                    }

                }
            }

        } //---------------------Pipe size 25-------------------------------------------------
        else if (pipe_size == 25) {
             ///////////----------------- ---Resedential Plots------------------------------------------------------
             if (con_tp.equals("R")) {

                ///////////---------------From 1,April,1990 to 31,March,2002---------------------------
                dtfr.set(1990, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 985.5;
                    } //For temporary connection
//                    else {
//                        rate = 300;
//                    }
                }

                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 1314;
                    } //For temporary connection
//                    else {
//                        rate = 600;
//                    }
                }

                ///////////---------------Rate after 1,April,2003---------------------------
           /*
                dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);


                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 1314;
                    } //For temporary connection
                    else {
                        rate = 1642.5;
                    }

                }
            }
             else
            ///////////----------------- ---Industrial Plots------------------------------------------------------
            if (con_tp.equals("I")) {
                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
           /* dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 1642.5;
                    } //For temporary connection
//                    else {
//                        rate = 2053.125;
//                    }
                }
                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
           /* dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 1971;
                    } //For temporary connection
                    else {
                        rate = 3942;
                    }
                }
                ///////////---------------Rate after 1,April,2003---------------------------

                /*dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);


                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 1642.5;
                    } //For temporary connection
                    else {
                        rate = 2053.13;
                    }

                }
            } ///////////----------------- ---Instituitional Plots------------------------------------------------------
            else if (con_tp.equals("T")) {
                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
            /*dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 1642.5;
                    } //For temporary connection
//                    else {
//                        rate = 2053.12;
//                    }
                }
                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
            /*dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 1971;
                    } //For temporary connection
                    else {
                        rate = 3942;
                    }
                }
                ///////////---------------Rate after 1,April,2003---------------------------
            /*dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);

                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 1642.5;
                    } //For temporary connection
                    else {
                        rate = 2053.13;
                    }

                }
            } ///////////----------------- ---Commercial Plots------------------------------------------------------
            else if (con_tp.equals("C")) {
                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
            /*dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 1642.5;
                    } //For temporary connection
//                    else {
//                        rate = 2053.12;
//                    }
                }
                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
           /* dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/


                dtfr.set(102, 2, 31);
                dtto.set(103, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 2628;
                    } //For temporary connection
                    else {
                        rate = 5256;
                    }
                }
                ///////////---------------Rate after 1,April,2003---------------------------
            /*dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);


                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 2628;
                    } //For temporary connection
                    else {
                        rate = 3285;
                    }

                }
            }

        } //---------------------Pipe size 32-------------------------------------------------
        else if (pipe_size == 32) {
             ///////////----------------- ---Resedential Plots------------------------------------------------------
             if (con_tp.equals("R")) {

                ///////////---------------From 1,April,1990 to 31,March,2002---------------------------
                dtfr.set(1990, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 1478.25;
                    } //For temporary connection
//                    else {
//                        rate = 300;
//                    }
                }

                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 1971;
                    } //For temporary connection
//                    else {
//                        rate = 600;
//                    }
                }

                ///////////---------------Rate after 1,April,2003---------------------------
           /*
                dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);


                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 1971;
                    } //For temporary connection
                    else {
                        rate = 2463.75;
                    }

                }
            }
             else
            ///////////----------------- ---Industrial Plots------------------------------------------------------
            if (con_tp.equals("I")) {
                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
            /*dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 2463.75;
                    } //For temporary connection
//                    else {
//                        rate = 3079.7;
//                    }
                }
                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
           /* dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 2956.5;
                    } //For temporary connection
                    else {
                        rate = 5913;
                    }
                }
                ///////////---------------Rate after 1,April,2003---------------------------
           /* dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);

                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 2463.75;
                    } //For temporary connection
                    else {
                        rate = 3079.69;
                    }

                }
            } ///////////----------------- ---Instituitional Plots------------------------------------------------------
            else if (con_tp.equals("T")) {
                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
            /*dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 2463.75;
                    } //For temporary connection
//                    else {
//                        rate = 3079.7;
//                    }
                }
                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
            /*dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 2956.5;
                    } //For temporary connection
                    else {
                        rate = 5913;
                    }
                }
                ///////////---------------Rate after 1,April,2003---------------------------
           /* dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(103, 2, 31);

                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 2463.75;
                    } //For temporary connection
                    else {
                        rate = 3079.69;
                    }

                }
            } ///////////----------------- ---Commercial Plots------------------------------------------------------
            else if (con_tp.equals("C")) {
                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
            /*dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 2463.75;
                    } //For temporary connection
//                    else {
//                        rate = 3079.7;
//                    }
                }
                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
           /* dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 3942;
                    } //For temporary connection
                    else {
                        rate = 7884;
                    }
                }
                ///////////---------------Rate after 1,April,2003---------------------------
          /*  dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(103, 2, 31);

                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 3942;
                    } //For temporary connection
                    else {
                        rate = 4927.5;
                    }

                }
            }

        } //---------------------Pipe size 40-------------------------------------------------
        else if (pipe_size == 40) {
             ///////////----------------- ---Resedential Plots------------------------------------------------------
             if (con_tp.equals("R")) {

                ///////////---------------From 1,April,1990 to 31,March,2002---------------------------
                dtfr.set(1990, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 2299.5;
                    } //For temporary connection
//                    else {
//                        rate = 300;
//                    }
                }

                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 3066;
                    } //For temporary connection
//                    else {
//                        rate = 600;
//                    }
                }

                ///////////---------------Rate after 1,April,2003---------------------------
           /*
                dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);


                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 3066;
                    } //For temporary connection
                    else {
                        rate = 3832.5;
                    }

                }
            }
             else
            ///////////----------------- ---Industrial Plots------------------------------------------------------
            if (con_tp.equals("I")) {
                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
            /*dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 3832.5;
                    } //For temporary connection
//                    else {
//                        rate = 4790.62;
//                    }
                }
                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
            /*dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 4599;
                    } //For temporary connection
                    else {
                        rate = 9198;
                    }
                }
                ///////////---------------Rate after 1,April,2003---------------------------
           /* dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);

                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 3832.5;
                    } //For temporary connection
                    else {
                        rate = 4790.63;
                    }

                }
            } ///////////----------------- ---Instituitional Plots------------------------------------------------------
            else if (con_tp.equals("T")) {
                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
            /*dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/
                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 3832.5;
                    } //For temporary connection
//                    else {
//                        rate = 4790.62;
//                    }
                }
                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
           /*dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 4599;
                    } //For temporary connection
                    else {
                        rate = 9198;
                    }
                }
                ///////////---------------Rate after 1,April,2003---------------------------
           /* dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);

                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 3832.5;
                    } //For temporary connection
                    else {
                        rate = 4790.63;
                    }

                }
            } ///////////----------------- ---Commercial Plots------------------------------------------------------
            else if (con_tp.equals("C")) {
                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
           /* dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 3832.5;
                    } //For temporary connection
//                    else {
//                        rate = 4790.62;
//                    }
                }
                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
            /*dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 6132;
                    } //For temporary connection
                    else {
                        rate = 12264;
                    }
                }
                ///////////---------------Rate after 1,April,2003---------------------------
           /* dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);


                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 6132;
                    } //For temporary connection
                    else {
                        rate = 7665;
                    }

                }
            }

        } //---------------------Pipe size 50-------------------------------------------------
        else if (pipe_size == 50) {
             ///////////----------------- ---Resedential Plots------------------------------------------------------
             if (con_tp.equals("R")) {

                ///////////---------------From 1,April,1990 to 31,March,2002---------------------------
                dtfr.set(1990, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 3613.5;
                    } //For temporary connection
//                    else {
//                        rate = 300;
//                    }
                }

                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 4818;
                    } //For temporary connection
//                    else {
//                        rate = 600;
//                    }
                }

                ///////////---------------Rate after 1,April,2003---------------------------
           /*
                dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);


                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 4818;
                    } //For temporary connection
                    else {
                        rate = 6022.5;
                    }

                }
            }
             else
            ///////////----------------- ---Industrial Plots------------------------------------------------------
            if (con_tp.equals("I")) {
                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
           /* dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 6022.5;
                    } //For temporary connection
//                    else {
//                        rate = 7528.12;
//                    }
                }
                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
           /* dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 7227;
                    } //For temporary connection
                    else {
                        rate = 14454;
                    }
                }
                ///////////---------------Rate after 1,April,2003---------------------------
            /*dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);

                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 6022.5;
                    } //For temporary connection
                    else {
                        rate = 7528.13;
                    }

                }
            } ///////////----------------- ---Instituitional Plots------------------------------------------------------
            else if (con_tp.equals("T")) {
                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
           /* dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 6022.5;
                    } //For temporary connection
//                    else {
//                        rate = 7528.12;
//                    }
                }
                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
           /* dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 7227;
                    } //For temporary connection
                    else {
                        rate = 14454;
                    }
                }
                ///////////---------------Rate after 1,April,2003---------------------------
            /*dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);


                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 6022.5;
                    } //For temporary connection
                    else {
                        rate = 7528.13;
                    }

                }
            } ///////////----------------- ---Commercial Plots------------------------------------------------------
            else if (con_tp.equals("C")) {
                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
           /* dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 6022.5;
                    } //For temporary connection
//                    else {
//                        rate = 7528.12;
//                    }
                }
                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
            /*dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 9636;
                    } //For temporary connection
                    else {
                        rate = 19272;
                    }
                }
                ///////////---------------Rate after 1,April,2003---------------------------
           /* dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);

                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 9636;
                    } //For temporary connection
                    else {
                        rate = 12045;
                    }

                }
            }

        } //---------------------Pipe size 65-------------------------------------------------
        else if (pipe_size == 65) {
             ///////////----------------- ---Resedential Plots------------------------------------------------------
             if (con_tp.equals("R")) {

                ///////////---------------From 1,April,1990 to 31,March,2002---------------------------
                dtfr.set(1990, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 5037;
                    } //For temporary connection
//                    else {
//                        rate = 300;
//                    }
                }

                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 6716;
                    } //For temporary connection
//                    else {
//                        rate = 600;
//                    }
                }

                ///////////---------------Rate after 1,April,2003---------------------------
           /*
                dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);


                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 6716;
                    } //For temporary connection
                    else {
                        rate = 8395;
                    }

                }
            }
             else
            ///////////----------------- ---Industrial Plots------------------------------------------------------
            if (con_tp.equals("I")) {
                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
            /*dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);



                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 8395;
                    } //For temporary connection
//                    else {
//                        rate = 10493.75;
//                    }
                }
                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
            /*dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);


                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 10074;
                    } //For temporary connection
                    else {
                        rate = 20148;
                    }
                }
                ///////////---------------Rate after 1,April,2003---------------------------
            /*dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);

                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 8395;
                    } //For temporary connection
                    else {
                        rate = 10493.8;
                    }

                }
            } ///////////----------------- ---Instituitional Plots------------------------------------------------------
            else if (con_tp.equals("T")) {
                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
           /* dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);


                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 8395;
                    } //For temporary connection
//                    else {
//                        rate = 10493.75;
//                    }
                }
                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
            /*dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);


                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 10074;
                    } //For temporary connection
                    else {
                        rate = 20148;
                    }
                }
                ///////////---------------Rate after 1,April,2003---------------------------
            /*dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(103, 2, 31);



                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 8395;
                    } //For temporary connection
                    else {
                        rate = 10493.8;
                    }

                }
            } ///////////----------------- ---Commercial Plots------------------------------------------------------
            else if (con_tp.equals("C")) {
                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
            /*dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);


                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 8395;
                    } //For temporary connection
//                    else {
//                        rate = 10493.75;
//                    }
                }
                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
           /* dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);


                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 13432;
                    } //For temporary connection
                    else {
                        rate = 26864;
                    }
                }
                ///////////---------------Rate after 1,April,2003---------------------------
           /* dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);


                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 13432;
                    } //For temporary connection
                    else {
                        rate = 16790;
                    }

                }
            }

        } //---------------------Pipe size 80-------------------------------------------------
        else if (pipe_size == 80) {
             ///////////----------------- ---Resedential Plots------------------------------------------------------
             if (con_tp.equals("R")) {

                ///////////---------------From 1,April,1990 to 31,March,2002---------------------------
                dtfr.set(1990, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 7181.38;
                    } //For temporary connection
//                    else {
//                        rate = 300;
//                    }
                }

                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 9575.17;
                    } //For temporary connection
//                    else {
//                        rate = 600;
//                    }
                }

                ///////////---------------Rate after 1,April,2003---------------------------
           /*
                dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);


                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 9575.17;
                    } //For temporary connection
                    else {
                        rate = 11968.96;
                    }

                }
            }
             else
            ///////////----------------- ---Industrial Plots------------------------------------------------------
            if (con_tp.equals("I")) {
                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
            /*dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);


                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 11968.96;
                    } //For temporary connection
//                    else {
//                        rate = 14961.2;
//                    }
                }
                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
            /*dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);


                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 14362.75;
                    } //For temporary connection
                    else {
                        rate = 28725.5;
                    }
                }
                ///////////---------------Rate after 1,April,2003---------------------------
            /*dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);

                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 11968.96;
                    } //For temporary connection
                    else {
                        rate = 14961.2;
                    }

                }
            } ///////////----------------- ---Instituitional Plots------------------------------------------------------
            else if (con_tp.equals("T")) {
                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
           /* dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);


                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 11968.96;
                    } //For temporary connection
//                    else {
//                        rate = 14961.2;
//                    }
                }
                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
            /*dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);


                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 14362.75;
                    } //For temporary connection
                    else {
                        rate = 28725.5;
                    }
                }
                ///////////---------------Rate after 1,April,2003---------------------------
           /* dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);

                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 11968.96;
                    } //For temporary connection
                    else {
                        rate = 14961.2;
                    }

                }
            } ///////////----------------- ---Commercial Plots------------------------------------------------------
            else if (con_tp.equals("C")) {
                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
           /* dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 11968.96;
                    } //For temporary connection
//                    else {
//                        rate = 14961.2;
//                    }
                }
                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
            /*dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 19150.33;
                    } //For temporary connection
                    else {
                        rate = 38300.67;
                    }
                }
                ///////////---------------Rate after 1,April,2003---------------------------
            /*dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);

                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 19150.33;
                    } //For temporary connection
                    else {
                        rate = 23937.92;
                    }

                }
            }

        } //---------------------Pipe size 100-------------------------------------------------
        else if (pipe_size == 100) {
             ///////////----------------- ---Resedential Plots------------------------------------------------------
             if (con_tp.equals("R")) {

                ///////////---------------From 1,April,1990 to 31,March,2002---------------------------
                dtfr.set(1990, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 12775;
                    } //For temporary connection
//                    else {
//                        rate = 300;
//                    }
                }

                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 17033.3;
                    } //For temporary connection
//                    else {
//                        rate = 600;
//                    }
                }

                ///////////---------------Rate after 1,April,2003---------------------------
           /*
                dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);


                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 17033.3;
                    } //For temporary connection
                    else {
                        rate = 21291.67;
                    }

                }
            }
             else
            ///////////----------------- ---Industrial Plots------------------------------------------------------
            if (con_tp.equals("I")) {
                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
            /*dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);


                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 21291.67;
                    } //For temporary connection
//                    else {
//                        rate = 26614.58;
//                    }
                }
                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
            /*dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 25550;
                    } //For temporary connection
                    else {
                        rate = 51100;
                    }
                }
                ///////////---------------Rate after 1,April,2003---------------------------
            /*dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);

                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 21291.67;
                    } //For temporary connection
                    else {
                        rate = 26614.6;
                    }

                }
            } ///////////----------------- ---Instituitional Plots------------------------------------------------------
            else if (con_tp.equals("T")) {
                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
           /* dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 21291.67;
                    } //For temporary connection
//                    else {
//                        rate = 26614.58;
//                    }
                }
                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
           /* dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 25550;
                    } //For temporary connection
                    else {
                        rate = 51100;
                    }
                }
                ///////////---------------Rate after 1,April,2003---------------------------
            /*dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);

                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 21291.67;
                    } //For temporary connection
                    else {
                        rate = 26614.6;
                    }

                }
            } ///////////----------------- ---Commercial Plots------------------------------------------------------
            else if (con_tp.equals("C")) {
                ///////////---------------From 1,April,1999 to 31,March,2002---------------------------
            /*dtfr.setYear(99);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(102);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(1999, 2, 31);
                dtto.set(2002, 3, 1);


                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 21291.67;
                    } //For temporary connection
//                    else {
//                        rate = 26614.58;
//                    }
                }
                ///////////---------------From 1,April,2002 to 31,March,2003---------------------------
            /*dtfr.setYear(102);
                dtfr.setMonth(2);
                dtfr.setDate(31);

                dtto.setYear(103);
                dtto.setMonth(3);
                dtto.setDate(1);*/

                dtfr.set(2002, 2, 31);
                dtto.set(2003, 3, 1);

                if (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {
                        rate = 34066.67;
                    } //For temporary connection
                    else {
                        rate = 68133.33;
                    }
                }
                ///////////---------------Rate after 1,April,2003---------------------------
            /*dtfr.setYear(103);
                dtfr.setMonth(2);
                dtfr.setDate(31);*/

                dtfr.set(2003, 2, 31);

                if (bl_per_fr.after(dtfr)) {
                    //For regular connection
                    if (cons_ctg.equals("R")) {

                        rate = 34066.67;
                    } //For temporary connection
                    else {
                        rate = 42583.33;
                    }

                }
            }

        }

        return rate;
    }

    //-------------------------------Rate for flats------------------------------------------------------------------------------------//
    public double getRateFlat(String con_tp, String cons_ctg, String flat_type, int pipe_size, Calendar bl_per_fr, String sec) {

        ///////------Rate from 1,April,1990 to 31,March,1995

        /*dtfr.setYear(90);
        dtfr.setMonth(2);
        dtfr.setDate(31);

        dtto.setYear(95);
        dtto.setMonth(3);
        dtto.setDate(1);*/

        dtfr.set(1990, 2, 31);
        dtto.set(1995, 3, 1);

        if (con_tp.equals("R") && cons_ctg.equals("R") && (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto))) {
            if (flat_type.equals("EWS")) {
                rate = 5;
            }

            if (flat_type.equals("EWSI")) {
                rate = 5;
            }

            if (flat_type.equals("LIG")) {
                rate = 8;
            }

            if (flat_type.equals("LIGI")) {
                rate = 8;
            }

            if (flat_type.equals("MIG")) {
                rate = 30;
            }

            if (flat_type.equals("MIGI")) {
                rate = 30;
            }

            if (flat_type.equals("MIG2")) {
                rate = 30;
            }

            if (flat_type.equals("HIG")) {
                rate = 45;
            }

            if (flat_type.equals("HIGI")) {
                rate = 30;
            }

            if (flat_type.equals("VILL")) {
                rate = 8;
            }
        }

        //--------Rate from 1,April,1995 to 31,March,1999

        /* dtfr.setYear(95);
        dtfr.setMonth(2);
        dtfr.setDate(31);

        dtto.setYear(99);
        dtto.setMonth(3);
        dtto.setDate(1);*/

        dtfr.set(1995, 2, 31);
        dtto.set(1999, 3, 1);

        if (con_tp.equals("R") && cons_ctg.equals("R") && (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto))) {
            if (flat_type.equals("EWS")) {
                rate = 7;
            }

            if (flat_type.equals("EWSI")) {
                rate = 7;
            }

            if (flat_type.equals("LIG")) {
                rate = 11;
            }

            if (flat_type.equals("LIGI")) {
                rate = 11;
            }

            if (sec.equals("21") || sec.equals("25")) {
                if (flat_type.equals("MIG")) {
                    rate = 50;
                }

                if (flat_type.equals("MIGI")) {
                    rate = 50;
                }

                if (flat_type.equals("MIG2")) {
                    rate = 50;
                }
            } else {
                if (flat_type.equals("MIG")) {
                    rate = 45;
                }

                if (flat_type.equals("MIGI")) {
                    rate = 45;
                }

                if (flat_type.equals("MIG2")) {
                    rate = 45;
                }
            }

            if (flat_type.equals("HIG")) {
                rate = 60;
            }

            if (flat_type.equals("HIGI")) {
                rate = 60;
            }

            if (flat_type.equals("DUPLEX")) {
                rate = 80;
            }

            if (flat_type.equals("VILL")) {
                rate = 11;
            }
        }

        //Rate from 1,April,1999 to 31,March,2002

        /*dtfr.setYear(99);
        dtfr.setMonth(2);
        dtfr.setDate(31);

        dtto.setYear(102);
        dtto.setMonth(3);
        dtto.setDate(1);*/

        dtfr.set(1999, 2, 31);
        dtto.set(2002, 3, 1);

        if (con_tp.equals("R") && cons_ctg.equals("R") && (bl_per_fr.after(dtfr) && bl_per_fr.before(dtto))) {
            if (flat_type.equals("EWS")) {
                rate = 10;
            }

            if (flat_type.equals("EWSI")) {
                rate = 10;
            }

            if (flat_type.equals("LIG")) {
                rate = 15;
            }

            if (flat_type.equals("LIGI")) {
                rate = 15;
            }

            if (sec.equals("11") || sec.equals("21") || sec.equals("25")) {
                if (flat_type.equals("MIG")) {
                    rate = 75;
                }

                if (flat_type.equals("MIGI")) {
                    rate = 75;
                }

                if (flat_type.equals("MIG2")) {
                    rate = 75;
                }
            } else {
                if (flat_type.equals("MIG")) {
                    rate = 70;
                }

                if (flat_type.equals("MIGI")) {
                    rate = 70;
                }

                if (flat_type.equals("MIG2")) {
                    rate = 70;
                }
            }

            if (sec.equals("52") || sec.equals("53") || sec.equals("61")) {
                if (flat_type.equals("HIG")) {
                    rate = 90;
                }

                if (flat_type.equals("HIGI")) {
                    rate = 90;
                }
            } else {
                if (flat_type.equals("HIG")) {
                    rate = 75;
                }

                if (flat_type.equals("HIGI")) {
                    rate = 90;
                }
            }


            if (flat_type.equals("DUPLEX")) {
                rate = 90;
            }

            if (flat_type.equals("VILL")) {
                rate = 15;
            }
        }
        //after 31/3/2002

        /*dtfr.setYear(102);
        dtfr.setMonth(2);
        dtfr.setDate(31);*/
        dtfr.set(2002, 2, 31);

        if (con_tp.equals("R") && cons_ctg.equals("R") && bl_per_fr.after(dtfr)) {
            if (flat_type.equals("EWS")) {
                rate = 25;
            }

            if (flat_type.equals("EWSI")) {
                rate = 40;
            }

            if (flat_type.equals("LIG")) {
                rate = 30;
            }

            if (flat_type.equals("LIGI")) {
                rate = 50;
            }

            if (flat_type.equals("MIG")) {
                rate = 100;
            }

            if (flat_type.equals("MIGI")) {
                rate = 120;
            }

            if (flat_type.equals("MIG2")) {
                rate = 150;
            }

            if (flat_type.equals("HIG")) {
                rate = 120;
            }

            if (flat_type.equals("HIGI")) {
                rate = 150;
            }

            if (flat_type.equals("DUPLEX")) {
                rate = 150;
            }

            if (flat_type.equals("VILL")) {
                rate = 40;
            }
        }
        //System.out.println(rate);
        return rate;
    }
}
