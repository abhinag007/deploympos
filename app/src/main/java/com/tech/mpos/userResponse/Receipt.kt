package com.tech.mpos.userResponse

data class Receipt(
    val email: Boolean,
    val print: Boolean,
    val sms: Boolean
)