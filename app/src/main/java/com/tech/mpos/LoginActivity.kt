package com.tech.mpos

import android.app.ProgressDialog
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import android.widget.Toast
import com.tech.mpos.MainActivity.Companion.ACCESS_TOKEN
import com.tech.mpos.MainActivity.Companion.responseBody
import com.tech.mpos.apiServices.ApiInterface
import com.tech.mpos.apiServices.RemoteDataSource
import com.tech.mpos.models.SignInBody
import com.tech.mpos.loginResponse.LoginResponse
import kotlinx.android.synthetic.main.activity_login2.*
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class LoginActivity : AppCompatActivity() {

    companion object{
        lateinit var mProgress:ProgressDialog
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_login2)

        val email = findViewById<EditText>(R.id.email_phone_et)
        val password = findViewById<EditText>(R.id.password_et)

        val signin = findViewById<Button>(R.id.signIn_btn)
        val signup = findViewById<TextView>(R.id.signup_tv)

        mProgress = ProgressDialog(this);
        mProgress.setTitle("Login...");
        mProgress.setMessage("Please wait...");
        mProgress.setCancelable(false);
        mProgress.setIndeterminate(true);


        signin.setOnClickListener {
            mProgress.show()
//            signin("1","1")
            signin(email.text.toString(),password.text.toString())
        }

        signup.setOnClickListener {
            val intent = Intent(this@LoginActivity, SignupActivity::class.java)
            startActivity(intent)
            finish()
        }

    }

    private fun signin(username: String, password: String){
        val retIn = RemoteDataSource.getRetrofitInstance().create(ApiInterface::class.java)
        val signInInfo = SignInBody(username, password)
        retIn.signin(signInInfo).enqueue(object : Callback<LoginResponse> {
            override fun onFailure(call: Call<LoginResponse>, t: Throwable) {
                mProgress.dismiss()
                Toast.makeText(
                    this@LoginActivity,
                    t.message,
                    Toast.LENGTH_SHORT
                ).show()
            }
            override fun onResponse(call: Call<LoginResponse>, response: Response<LoginResponse>) {
                if (response.code() == 200) {
                    email_phone_et.setText("")
                    password_et.setText("")
                    responseBody = response
                    ACCESS_TOKEN = responseBody.body()?.accessToken.toString()
                    GlobalScope.launch {
                        suspend {
//                            FetchTransactionData().getTransactionData(this@LoginActivity)
                            FetchTransactionData().getUserData(this@LoginActivity)
                        }.invoke()
                    }

                } else {
                    mProgress.dismiss()

                    Toast.makeText(this@LoginActivity, "Login failed!", Toast.LENGTH_SHORT).show()
                }
            }
        })
    }
}