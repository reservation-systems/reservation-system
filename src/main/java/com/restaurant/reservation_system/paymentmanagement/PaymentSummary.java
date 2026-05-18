package com.restaurant.reservation_system.paymentmanagement;

public class PaymentSummary {
    private long totalTransactions;
    private long paidPayments;
    private long pendingPayments;
    private double totalRevenue;

    public PaymentSummary(long totalTransactions, long paidPayments, long pendingPayments, double totalRevenue) {
        this.totalTransactions = totalTransactions;
        this.paidPayments = paidPayments;
        this.pendingPayments = pendingPayments;
        this.totalRevenue = totalRevenue;
    }

    public long getTotalTransactions() { return totalTransactions; }
    public long getPaidPayments() { return paidPayments; }
    public long getPendingPayments() { return pendingPayments; }
    public double getTotalRevenue() { return totalRevenue; }
}