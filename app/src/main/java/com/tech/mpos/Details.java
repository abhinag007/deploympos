package com.tech.mpos;

import java.io.Serializable;

public class Details implements Serializable {

    static final long serialVersionUID = -1335351770906357695L;
    int amount;
    String type,exp_month,exp_year,acc_number,cvv;

    @Override
    public String toString() {
        return "Details{" +
                "amount=" + amount +
                ", type='" + type + '\'' +
                ", exp_month='" + exp_month + '\'' +
                ", exp_year='" + exp_year + '\'' +
                ", acc_number='" + acc_number + '\'' +
                ", cvv='" + cvv + '\'' +
                '}';
    }

    public Details(String cvv, int amount, String type, String exp_month, String exp_year, String acc_number) {
        this.cvv = cvv;
        this.amount = amount;
        this.type = type;
        this.exp_month = exp_month;
        this.exp_year = exp_year;
        this.acc_number = acc_number;
    }

    public String getCvv() {
        return cvv;
    }

    public void setCvv(String cvv) {
        this.cvv = cvv;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getExp_month() {
        return exp_month;
    }

    public void setExp_month(String exp_month) {
        this.exp_month = exp_month;
    }

    public String getExp_year() {
        return exp_year;
    }

    public void setExp_year(String exp_year) {
        this.exp_year = exp_year;
    }

    public String getAcc_number() {
        return acc_number;
    }

    public void setAcc_number(String acc_number) {
        this.acc_number = acc_number;
    }
}
