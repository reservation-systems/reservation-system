package com.restaurant.reservation_system.paymentmanagement;

public class PaymentRequest {
    private String customerName;
    private String customerEmail;
    private double amount;
    private String paymentMethod;
    private String cardNumber;
    private String offerCode;

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getCustomerEmail() { return customerEmail; }
    public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public String getCardNumber() { return cardNumber; }
    public void setCardNumber(String cardNumber) { this.cardNumber = cardNumber; }

    public String getOfferCode() { return offerCode; }
    public void setOfferCode(String offerCode) { this.offerCode = offerCode; }
}