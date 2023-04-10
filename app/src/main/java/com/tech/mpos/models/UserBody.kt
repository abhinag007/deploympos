package com.tech.mpos.models

data class UserBody(val businessName: String,
                    val mobileNumber: String,
                    val email: String,
                    val password: String)