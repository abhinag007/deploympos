package com.tech.mpos.loginResponse

data class LoginResponse(
    val accessToken: String,
    val `data`: Data,
    val refreshToken: String
)