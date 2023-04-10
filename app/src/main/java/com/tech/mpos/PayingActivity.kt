package com.tech.mpos

import android.app.AlertDialog
import android.content.DialogInterface
import android.content.Intent
import android.os.Bundle
import android.text.InputType
import android.util.Log
import android.widget.EditText
import android.widget.ImageView
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.marginLeft
import androidx.core.view.setPadding
import com.tech.mpos.MainActivity.Companion.CVV
import com.tech.mpos.nfcService.NfcActivity

class PayingActivity : NfcActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_paying)
        val amount=intent.getStringExtra("totalAmount")

        val textView = findViewById<TextView>(R.id.textView2)
        textView.text = "CAD $amount"

        val close = findViewById<ImageView>(R.id.closeScreen_iv)
//        val nfcButton = findViewById<ImageView>(R.id.imageView3)
        close.setOnClickListener {
            this.finish()
        }
//        var i = Intent(this, NfcActivity::class.java)
//        startActivity(i)

     /*   nfcButton.setOnClickListener {
            showdialog()
        }*/

    }

    fun showdialog(){
        val builder: AlertDialog.Builder = android.app.AlertDialog.Builder(this)
        builder.setTitle("Enter CVV")

        val input = EditText(this)
        input.setHint("Enter CVV Here...")
        input.inputType = InputType.TYPE_CLASS_NUMBER
        input.setPadding(70)
        builder.setView(input)
        builder.setPositiveButton("OK", DialogInterface.OnClickListener { dialog, which ->
//            CVV = input.text.toString()
        })
        builder.setNegativeButton("Cancel", DialogInterface.OnClickListener { dialog, which -> { dialog.cancel() } })

        builder.show()
    }
}