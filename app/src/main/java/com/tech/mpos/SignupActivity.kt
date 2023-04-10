package com.tech.mpos

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import android.widget.Toast
import com.tech.mpos.apiServices.ApiInterface
import com.tech.mpos.apiServices.RemoteDataSource
import com.tech.mpos.models.UserBody
import okhttp3.ResponseBody
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class SignupActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_signup)

        val orgName = findViewById<EditText>(R.id.organization_et)
        val mobileNumber = findViewById<EditText>(R.id.phone_number_et)
        val email = findViewById<EditText>(R.id.email_et)
        val password = findViewById<EditText>(R.id.password_et)

        val signUpBtn = findViewById<Button>(R.id.signup_btn)
        val signin = findViewById<TextView>(R.id.signin_tv)

        signUpBtn.setOnClickListener {
            signup(orgName.text.toString(),mobileNumber.text.toString(), email.text.toString(), password.text.toString())
        }
        signin.setOnClickListener {
            val intent = Intent(this@SignupActivity, LoginActivity::class.java)
            startActivity(intent)
            finish()
        }
    }

    private fun signup(orgName: String, phoneNumber: String, email: String,
                       password: String){
        val retIn = RemoteDataSource.getRetrofitInstance().create(ApiInterface::class.java)
        val registerInfo = UserBody(orgName,phoneNumber,email,password)

        retIn.registerUser(registerInfo).enqueue(object :
            Callback<ResponseBody> {
            override fun onFailure(call: Call<ResponseBody>, t: Throwable) {
                Toast.makeText(
                    this@SignupActivity,
                    t.message,
                    Toast.LENGTH_SHORT
                ).show()
            }
            override fun onResponse(call: Call<ResponseBody>, response: Response<ResponseBody>) {
                if (response.code() == 200) {
                    val intent = Intent(this@SignupActivity, LoginActivity::class.java)
                    startActivity(intent)
                    finish()
                }
                else{
                    Toast.makeText(this@SignupActivity, "${response.code()}", Toast.LENGTH_SHORT)
                        .show()
                }
            }
        })
    }
}

// version name change every time