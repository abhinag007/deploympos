package com.tech.mpos.userResponse

data class UserResponse(
    val address: String,
    val bank: Bank,
    val businessName: String,
    val businessType: String,
    val createdAt: String,
    val email: String,
    val id: String,
    val isAdmin: Boolean,
    val mobileNumber: String,
    val mobileSync: Boolean,
    val passwordChangeRequired: Boolean,
    val pictureUrl: String,
    val receipt: Receipt,
    val settings: Settings,
    val tours: Tours,
    val uid: Long
)