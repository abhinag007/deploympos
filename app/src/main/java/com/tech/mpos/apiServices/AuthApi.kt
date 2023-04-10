package com.tech.mpos.apiServices

import com.tech.mpos.loginResponse.LoginResponse
import com.tech.mpos.models.*
import com.tech.mpos.transactionResponse.TransactionResponse
import com.tech.mpos.userResponse.UserResponse
import okhttp3.RequestBody
import okhttp3.ResponseBody
import retrofit2.Call
import retrofit2.http.*

interface ApiInterface {
    @Headers("Content-Type:application/json")
    @POST("users/login")
    fun signin(@Body info: SignInBody): Call<LoginResponse>

    @Headers("Content-Type:application/json")
    @POST("users/register")
    fun registerUser(
        @Body info: UserBody
    ): retrofit2.Call<ResponseBody>

    @Headers("Content-Type:application/json", "Accept: 'application/json")
    @GET("transactions")
    fun transactionsData(@Header("Authorization") token: String): Call<TransactionResponse>

    @Headers("Content-Type:application/json")
    @POST("users/me")
    fun updateReceiptEmail(@Header("Authorization") token: String, @Body requestBody: ReceiptEmail):Call<UserResponse>

    @Headers("Content-Type:application/json")
    @GET("users/me")
    fun getUserData(@Header("Authorization") token: String):Call<UserResponse>

    @Headers("Content-Type:application/json")
    @POST("users/me")
    fun updateEmail(@Header("Authorization") token: String, @Body requestBody: EmailUpdate):Call<UserResponse>

    @Headers("Content-Type:application/json")
    @POST("payments")
    fun processPayment(@Header("Authorization") token: String, @Body requestBody: processPayment):Call<com.tech.mpos.paymentResponse.processPayment>

//    @Headers("Content-Type:application/json")
//    @POST("payments/${TRANSACTION_ID}")
//    fun makePayment(@Header("Authorization") token: String, @Body requestBody: processPayment)

//    @Headers("Content-Type:application/json")
//    @POST("payments")
//    fun responsePayment(@Header("Authorization") token: String, @Body requestBody: processPayment)


}