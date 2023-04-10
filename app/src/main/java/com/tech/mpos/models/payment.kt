package com.tech.mpos.models

data class processPayment(val amount: String, val tax: String)
data class makePayment(val cardNo: String, val bankName: String)
data class paymentResponse(val transactionId: String, val status: String)
