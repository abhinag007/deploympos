package com.tech.mpos.transactionResponse

data class Transaction(
    val amount: Double,
    val createdAt: String,
    val currency: String,
    val customer: Customer,
    val id: String,
    val status: String,
    val tax: Double,
    val uid: String,
    val userId: String
)