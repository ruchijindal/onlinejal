/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package bill.generator;

import java.util.Date;

/**
 *
 * @author smp-06
 */
public class BillDescription {
    String consNO;
    Date billFrom;
    Date billTo;
    double rate;
    double rebate;
    double cessAmount;
    double principal;
    double interest;
    double surcharge;
    double security;
    double nocFee;
    double transferFee;
    double regularFee;
    String createdBy;
    Date createdDate;
    Date dueDate;
    double discount;
    public Date getBillFrom() {
        return billFrom;
    }

    public void setBillFrom(Date billFrom) {
        this.billFrom = billFrom;
    }

    public Date getBillTo() {
        return billTo;
    }

    public void setBillTo(Date billTo) {
        this.billTo = billTo;
    }

    public double getCessAmount() {
        return cessAmount;
    }

    public void setCessAmount(double cessAmount) {
        this.cessAmount = cessAmount;
    }

    public String getConsNO() {
        return consNO;
    }

    public void setConsNO(String consNO) {
        this.consNO = consNO;
    }

    public double getInterest() {
        return interest;
    }

    public void setInterest(double interest) {
        this.interest = interest;
    }

    public double getPrincipal() {
        return principal;
    }

    public void setPrincipal(double principal) {
        this.principal = principal;
    }

    public double getRate() {
        return rate;
    }

    public void setRate(double rate) {
        this.rate = rate;
    }

    public double getRebate() {
        return rebate;
    }

    public void setRebate(double rebate) {
        this.rebate = rebate;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public double getNocFee() {
        return nocFee;
    }

    public void setNocFee(double nocFee) {
        this.nocFee = nocFee;
    }

    public double getRegularFee() {
        return regularFee;
    }

    public void setRegularFee(double regularFee) {
        this.regularFee = regularFee;
    }

    public double getSecurity() {
        return security;
    }

    public void setSecurity(double security) {
        this.security = security;
    }

    public double getSurcharge() {
        return surcharge;
    }

    public void setSurcharge(double surcharge) {
        this.surcharge = surcharge;
    }

    public double getTransferFee() {
        return transferFee;
    }

    public void setTransferFee(double transferFee) {
        this.transferFee = transferFee;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }
    

}
