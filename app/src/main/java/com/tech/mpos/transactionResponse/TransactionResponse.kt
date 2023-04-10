package com.tech.mpos.transactionResponse

data class TransactionResponse(
    val totalTransaction: Int,
    val transactions: List<Transaction>,
    val walletBalance: Int
)