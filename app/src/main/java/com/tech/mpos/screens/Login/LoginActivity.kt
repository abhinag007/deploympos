package com.tech.mpos.screens.Login

import android.content.Intent
import android.os.Bundle
import android.text.Editable
import android.text.Html
import android.text.TextWatcher
import android.view.View
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import androidx.constraintlayout.widget.ConstraintLayout
import com.google.android.material.button.MaterialButton
import com.google.android.material.textfield.TextInputEditText
import com.tech.mpos.LoginActivity
import com.tech.mpos.R
import com.tech.mpos.screens.Introduction.IntroActivity
import kotlinx.android.synthetic.main.activity_login.*


class LoginActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_login)
        val startButton = findViewById<Button>(R.id.startBtn)
        val textInput = findViewById<TextInputEditText>(R.id.mobile_number)
        val otpButton = findViewById<MaterialButton>(R.id.get_otp_btn)
        val constraintBox = findViewById<ConstraintLayout>(R.id.mobile_number_box)
        val otpBox = findViewById<ConstraintLayout>(R.id.otp_box)

        startButton.visibility = View.VISIBLE
        constraintBox.visibility = View.GONE
        otpBox.visibility = View.GONE

        startButton.setOnClickListener {
            startButton.visibility = View.GONE
            constraintBox.visibility = View.VISIBLE
        }

        textInput.addTextChangedListener(object: TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {
                otpButton.isEnabled = false
            }

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
//                textInput.text = s as Editable?
//                otpButton.isEnabled = textInput.text?.isBlank() != true
            }

            override fun afterTextChanged(s: Editable?) {
                otpButton.isEnabled = s.toString().isEmpty() != true
            }

        })

        otpButton.setOnClickListener {
            val intent = Intent(this, LoginActivity::class.java)
            startActivity(intent)
            finish()

//            constraintBox.visibility = View.GONE
//            otpBox.visibility = View.VISIBLE

        }
        val sourceString = "Enter 4 digt OTP sent on " + "<b>" + "xxxxxxxx7905" + "</b> "
        text_number.setText(Html.fromHtml(sourceString))

    }
}