/*
 * Created on Oct 25, 2006
 *
 */
package com.fusioncharts;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;

public class FusionChartsHelper {

    /*This page contains an array of colors to be used as default set of colors for FusionCharts
    'arr_FCColors is the array that would contain the hex code of colors
    'ALL COLORS HEX CODES TO BE USED WITHOUT #*/
    //We also initiate a counter variable to help us cyclically rotate through
    //the array of colors.
    int FC_ColorCounter = 0;
    String[] arr_FCColors = new String[]{
        "1941A5",
        "AFD8F8",
        "F6BD0F",
        "8BBA00",
        "A66EDD",
        "F984A1",
        "CCCC00",
        "999999",
        "0099CC",
        "FF0000",
        "006F00",
        "0099FF",
        "FF66CC",
        "669966",
        "7C7CB4",
        "FF9933",
        "9900FF",
        "99FFCC",
        "CCCCFF",
        "669900",};
    /*
    "1941A5"; //Dark Blue
    "CCCC00"; //Chrome Yellow+Green
    "999999"; //Grey
    "0099CC"; //Blue Shade
    "FF0000"; //Bright Red
    "006F00"; //Dark Green
    "0099FF"; //Blue (Light)
    "FF66CC"; //Dark Pink
    "669966"; //Dirty green
    "7C7CB4"; //Violet shade of blue
    "FF9933"; //Orange
    "9900FF"; //Violet
    "99FFCC";//Blue+Green Light
    "CCCCFF"; //Light violet
    "669900"; //Shade of green
     */

    //getFCColor method helps return a color from arr_FCColors array. It uses
    //cyclic iteration to return a color from a given index. The index value is
    //maintained in FC_ColorCounter
    public String getFCColor() {
        //Update index
        FC_ColorCounter += 1;
        //Return color
        return arr_FCColors[FC_ColorCounter % arr_FCColors.length];

    }

    public static String addCacheToDataURL(String strDataURL) {
        String cachedURL = strDataURL;

        Calendar nowCal = Calendar.getInstance();
        Date now = nowCal.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH_mm_ss a");
        String strNow = sdf.format(now);

        try {

            if (strDataURL.indexOf("?") > 0) {
                cachedURL = strDataURL + "&FCCurrTime="
                        + URLEncoder.encode(strNow, "UTF-8");
            } else {
                cachedURL = strDataURL + "?FCCurrTime="
                        + URLEncoder.encode(strNow, "UTF-8");
            }

        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            cachedURL = strDataURL + "?FCCurrTime=" + strNow;
        }

        return cachedURL;
    }

    public static String encodeDataURL(String strDataURL, String addNoCacheStr,
            HttpServletResponse response) {
        String encodedURL = strDataURL;
        //Add the no-cache string if required
        if (addNoCacheStr.equals("true")) {

            java.util.Calendar nowCal = java.util.Calendar.getInstance();
            java.util.Date now = nowCal.getTime();
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
                    "MM/dd/yyyy HH_mm_ss a");
            String strNow = sdf.format(now);
            if (strDataURL.indexOf("?") > 0) {
                encodedURL = strDataURL + "&FCCurrTime=" + strNow;
            } else {
                strDataURL = strDataURL + "?FCCurrTime=" + strNow;
            }
            encodedURL = response.encodeURL(strDataURL);

        }
        return encodedURL;
    }
}
