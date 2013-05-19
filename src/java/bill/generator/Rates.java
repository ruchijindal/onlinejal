/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bill.generator;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Date;

/**
 *
 * @author smp-06
 */

public class Rates {

    private BigDecimal id;

    private String connType;

    private String connCategory;

    private Date dateFrom;

    private Date dateTo;

    private BigInteger minPlotSize;

    private BigInteger maxPlotSize;

    private BigInteger pipeSize;

    private Double rate;

    private String flatType;

    private String sector;

    public Rates() {
    }

    public Rates(BigDecimal id) {
        this.id = id;
    }

    public BigDecimal getId() {
        return id;
    }

    public void setId(BigDecimal id) {
        this.id = id;
    }

    public String getConnType() {
        return connType;
    }

    public void setConnType(String connType) {
        this.connType = connType;
    }

    public String getConnCategory() {
        return connCategory;
    }

    public void setConnCategory(String connCategory) {
        this.connCategory = connCategory;
    }

    public Date getDateFrom() {
        return dateFrom;
    }

    public void setDateFrom(Date dateFrom) {
        this.dateFrom = dateFrom;
    }

    public Date getDateTo() {
        return dateTo;
    }

    public void setDateTo(Date dateTo) {
        this.dateTo = dateTo;
    }

    public BigInteger getMinPlotSize() {
        return minPlotSize;
    }

    public void setMinPlotSize(BigInteger minPlotSize) {
        this.minPlotSize = minPlotSize;
    }

    public BigInteger getMaxPlotSize() {
        return maxPlotSize;
    }

    public void setMaxPlotSize(BigInteger maxPlotSize) {
        this.maxPlotSize = maxPlotSize;
    }

    public BigInteger getPipeSize() {
        return pipeSize;
    }

    public void setPipeSize(BigInteger pipeSize) {
        this.pipeSize = pipeSize;
    }

    public Double getRate() {
        return rate;
    }

    public void setRate(Double rate) {
        this.rate = rate;
    }

    public String getFlatType() {
        return flatType;
    }

    public void setFlatType(String flatType) {
        this.flatType = flatType;
    }

    public String getSector() {
        return sector;
    }

    public void setSector(String sector) {
        this.sector = sector;
    }


}
