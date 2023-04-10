package com.tech.mpos

import android.content.Context
import android.content.Intent
import android.util.Log
import android.widget.Toast
import com.tech.mpos.LoginActivity.Companion.mProgress
import com.tech.mpos.MainActivity.Companion.ACCESS_TOKEN
import com.tech.mpos.MainActivity.Companion.UserData
import com.tech.mpos.MainActivity.Companion.transactionData
import com.tech.mpos.apiServices.ApiInterface
import com.tech.mpos.apiServices.RemoteDataSource
import com.tech.mpos.models.EmailUpdate
import com.tech.mpos.models.ReceiptEmail
import com.tech.mpos.models.UserBody
import com.tech.mpos.transactionResponse.TransactionResponse
import com.tech.mpos.userResponse.UserResponse
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class FetchTransactionData {

    fun getTransactionData(context: Context){
        val retIn = RemoteDataSource.getRetrofitInstance().create(ApiInterface::class.java)
        Log.d("Access Token: ", ACCESS_TOKEN)
        val apiInterface = retIn.transactionsData(token = "Bearer ${ACCESS_TOKEN}")

        apiInterface.enqueue( object : Callback<TransactionResponse> {

            override fun onResponse(
                call: Call<TransactionResponse>,
                response: Response<TransactionResponse>,
            ) {
                transactionData = response
                Log.d("Wallet: ", transactionData.body()?.walletBalance.toString())
                mProgress.dismiss()
                val intent = Intent(context, MainActivity::class.java)
                intent.putExtra("position","-1")
                intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
                context.startActivity(intent)
            }

            override fun onFailure(call: Call<TransactionResponse>, t: Throwable) {
                t.message?.let { Log.d("data: ", it) }
//                Toast.makeText(this@FirstFragment, "Data: ${ t.message }", Toast.LENGTH_SHORT).show()
            }

        })
    }

    fun getUserData(context: Context){
        val retIn = RemoteDataSource.getRetrofitInstance().create(ApiInterface::class.java)
        Log.d("Access Token: ", ACCESS_TOKEN)
        val apiInterface = retIn.getUserData(token = "Bearer ${ACCESS_TOKEN}")

        apiInterface.enqueue( object : Callback<UserResponse> {

            override fun onResponse(
                call: Call<UserResponse>,
                response: Response<UserResponse>,
            ) {
                if(response.code() == 200){
                    UserData = response
                    getTransactionData(context)
                }
            }

            override fun onFailure(call: Call<UserResponse>, t: Throwable) {
                t.message?.let { Log.d("data: ", it) }
//                Toast.makeText(this@FirstFragment, "Data: ${ t.message }", Toast.LENGTH_SHORT).show()
            }

        })
    }

    fun updateUserReceiptData(context: Context?, receiptEmail: ReceiptEmail){
        val retIn = RemoteDataSource.getRetrofitInstance().create(ApiInterface::class.java)
//        val receiptEmail = ReceiptEmail(email_cb.isEnabled==true)
        val apiInterface = retIn.updateReceiptEmail(token = "Bearer ${MainActivity.ACCESS_TOKEN}",receiptEmail)
//        mProgress.show()

        apiInterface.enqueue(object: Callback<UserResponse> {
            override fun onResponse(
                call: Call<UserResponse>,
                response: Response<UserResponse>
            ) {
                if (response.code() == 200){
                    UserData = response
                    mProgress.dismiss()
                    Toast.makeText(context,"Update Done",Toast.LENGTH_SHORT).show()
                }
            }

            override fun onFailure(call: Call<UserResponse>, t: Throwable) {
                mProgress.dismiss()
                Toast.makeText(context,"Update Failed due to some error", Toast.LENGTH_SHORT).show()
            }
        })
    }

    fun updateUserEmailData(context: Context?, email: EmailUpdate){
        val retIn = RemoteDataSource.getRetrofitInstance().create(ApiInterface::class.java)
//        val receiptEmail = ReceiptEmail(email_cb.isEnabled==true)
        val apiInterface = retIn.updateEmail(token = "Bearer ${MainActivity.ACCESS_TOKEN}",email)
//        mProgress.show()
        apiInterface.enqueue(object: Callback<UserResponse> {
            override fun onResponse(
                call: Call<UserResponse>,
                response: Response<UserResponse>
            ) {
                if (response.code() == 200){
                    UserData = response
                    mProgress.dismiss()
                    Toast.makeText(context,"Update Done",Toast.LENGTH_SHORT).show()
                }
            }

            override fun onFailure(call: Call<UserResponse>, t: Throwable) {
                mProgress.dismiss()
                Toast.makeText(context,"Update Failed due to some error", Toast.LENGTH_SHORT).show()
            }
        })
    }

    fun processPayment(context: Context, amount: String, tax: String){

        val retIn = RemoteDataSource.getRetrofitInstance().create(ApiInterface::class.java)

        val registerInfo = com.tech.mpos.models.processPayment(amount,tax)

        val apiInterface = retIn.processPayment(token = "Bearer ${MainActivity.ACCESS_TOKEN}",registerInfo)



    }

}