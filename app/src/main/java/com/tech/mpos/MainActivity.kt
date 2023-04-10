package com.tech.mpos

import FirstFragment
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.Menu
import android.view.View
import androidx.fragment.app.Fragment
import com.google.android.material.appbar.AppBarLayout
import com.google.android.material.bottomnavigation.BottomNavigationView
import com.tech.mpos.loginResponse.LoginResponse
import com.tech.mpos.screens.Transactions.WalletTransactionFragment
import com.tech.mpos.transactionResponse.TransactionResponse
import com.tech.mpos.userResponse.UserResponse
import kotlinx.android.synthetic.main.activity_main.*
import retrofit2.Response

class MainActivity : AppCompatActivity() {
    private val homeFragment=FirstFragment()
    private val accountFragment=AccountFragment()
    private val businessDetailsFragment=BusinessDetailsFragment()
    private val paymentSetupFragment=PaymentSetupFragment()
    private val walletTransactionFragment= WalletTransactionFragment()
    private val transactionDetailsFragment=TransactionDetailsFragment()
    private val recentTransactionFragment=recentTransactionDetails()

    companion object {
        lateinit var responseBody: Response<LoginResponse>
        lateinit var transactionData: Response<TransactionResponse>
        lateinit var UserData: Response<UserResponse>
        lateinit var ACCESS_TOKEN: String
        lateinit var AMOUNT: String
        var POSITION = -1
        lateinit var CVV: String
//        var TRANSACTION_ID:String = ""
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        val intent = getIntent();
        val position = intent.getStringExtra("position")
        val appBar = findViewById<AppBarLayout>(R.id.appBarLayout)
        val bottom = findViewById<BottomNavigationView>(R.id.bottomNavigationView)
        if (position?.toInt()!! == -2){
            finish()
//            replaceFragment(walletTransactionFragment)
        }
        else if(position.toInt() ==-3){
            bottom.visibility = View.GONE
            replaceFragment(recentTransactionFragment)
        }
        else if(position.toInt()!! >=0){
            appBar.visibility = View.GONE
            POSITION = position.toInt()
            replaceFragment(transactionDetailsFragment)
        }
        else
            replaceFragment(homeFragment)
//            replaceFragment(recentTransactionFragment)
        setSupportActionBar(findViewById(R.id.toolbar))
        supportActionBar?.title = ""


        val bottomNavigationView = findViewById<BottomNavigationView>(R.id.bottomNavigationView)
        bottomNavigationView.setOnNavigationItemSelectedListener {
            when(it.itemId){
                R.id.home -> {
                    appBar.visibility = View.VISIBLE
                    replaceFragment(homeFragment)
                }
                R.id.person -> {
                    appBar.visibility = View.VISIBLE
                    replaceFragment(accountFragment)
                }
                R.id.paymb_button -> {
                    appBar.visibility = View.VISIBLE
                    replaceFragment(paymentSetupFragment)
                }
                R.id.business_details -> {
                    appBar.visibility = View.VISIBLE
                    replaceFragment(businessDetailsFragment)
                }
                R.id.wallet -> {
                    bottom.visibility = View.GONE
                    toolbar.setNavigationIcon(R.drawable.back_arrow)
                    toolbar.setNavigationOnClickListener {
                        toolbar.navigationIcon = null
                        bottom.visibility = View.VISIBLE
                        replaceFragment(homeFragment)
                    }
                    replaceFragment(walletTransactionFragment)
                }
//                R.id.wallet -> {
//                    val intent = Intent(this,TransactionsActivity::class.java)
//                    startActivity(intent)
//                }
            }
            true
        }
    }

    fun replaceFragment(fragment: Fragment){
        val transaction = supportFragmentManager.beginTransaction()
        transaction.replace(R.id.flFragment,fragment)
        transaction.commit()
    }

    override fun onCreateOptionsMenu(menu: Menu?): Boolean {
        menuInflater.inflate(R.menu.action_bar, menu)
        return super.onCreateOptionsMenu(menu)
    }

}

