package com.tech.mpos.userResponse

data class Settings(
    val country: String,
    val currency: String,
    val dateFormat: String,
    val locale: String,
    val timeFormat: String,
    val timezone: String
)