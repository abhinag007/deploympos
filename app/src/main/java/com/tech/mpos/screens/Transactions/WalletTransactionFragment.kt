package com.tech.mpos.screens.Transactions

import android.app.DatePickerDialog
import android.app.Dialog
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.Fragment
import androidx.recyclerview.widget.LinearLayoutManager
import com.google.android.material.bottomsheet.BottomSheetDialog
import com.google.android.material.button.MaterialButton
import com.google.android.material.radiobutton.MaterialRadioButton
import com.google.android.material.slider.Slider
import com.tech.mpos.DateSelected
import com.tech.mpos.MainActivity
import com.tech.mpos.MainActivity.Companion.transactionData
import com.tech.mpos.R
import com.tech.mpos.adapter_transaction_list.ListAdapter
import com.tech.mpos.apiServices.ApiInterface
import com.tech.mpos.apiServices.RemoteDataSource
import com.tech.mpos.databinding.FragmentWalletTransactionBinding
import com.tech.mpos.transactionResponse.TransactionResponse
import kotlinx.android.synthetic.main.fragment_wallet_transaction.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.text.SimpleDateFormat
import java.util.*

class WalletTransactionFragment : Fragment(R.layout.fragment_wallet_transaction), DateSelected {
    private var _binding: FragmentWalletTransactionBinding?=null
    private val binding get() = _binding!!
    lateinit var adapter: ListAdapter
    var bottomSheetDialog: BottomSheetDialog? = null


    companion object {
        var year1:Int = 0
        var year2:Int = 0
        var month1:Int = 0
        var month2:Int = 0
        var dayOfMonth1:Int = 0
        var dayOfMonth2:Int = 0
        val calendar1 = GregorianCalendar()
        val calendar2 = GregorianCalendar()
        var all:Boolean = true
        var paid:Boolean = false
        var cancelled:Boolean = false
        var amount:Double = 0.0
    }


    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentWalletTransactionBinding.inflate(inflater,container,false)
        getTransaction()
        var check = false

        binding.settingIcon.setOnClickListener {
            check = !check
            if(check) {
                binding.horzontalScroll.visibility = View.VISIBLE
            }
            else{
                binding.horzontalScroll.visibility = View.GONE
            }
        }


        binding.periodBtn.setOnClickListener {
            bottomSheetDialog = context?.let { it1 -> BottomSheetDialog(it1,
                R.style.BottomSheetDialogTheme
            ) }
            val bottomSheetView = LayoutInflater.from(context).inflate(
                R.layout.layout_bottom_sheet_transaction_period,binding.root.findViewById<LinearLayout>(
                    R.id.bottomSheet
                ))

            bottomSheetView.findViewById<MaterialButton>(R.id.from_date).setOnClickListener {
                showDatePicker(true)
            }

            bottomSheetView.findViewById<MaterialButton>(R.id.to_date).setOnClickListener {
                showDatePicker(false)
            }


            bottomSheetView.findViewById<ImageView>(R.id.closeButton).setOnClickListener {
                    bottomSheetDialog?.dismiss()

            }

            bottomSheetView.findViewById<MaterialButton>(R.id.apply_btn).setOnClickListener{
                if(year1 == 0 || year2 == 0){
                    Toast.makeText(context,"Invalid Date",Toast.LENGTH_SHORT).show()
                }
                else{
                    bottomSheetDialog?.dismiss()
                    getTransaction()
                }
            }

            bottomSheetView.findViewById<TextView>(R.id.clear_text_btn).setOnClickListener {
                year1 = 0
                year2 = 0
                month1 = 0
                month2 = 0
                dayOfMonth1 = 0
                dayOfMonth2 = 0
                bottomSheetDialog?.findViewById<MaterialButton>(R.id.to_date)?.text = "To"
                bottomSheetDialog?.findViewById<MaterialButton>(R.id.from_date)?.text = "From"
                bottomSheetDialog?.findViewById<MaterialButton>(R.id.to_date)?.isEnabled = false

                getTransaction()
                bottomSheetDialog?.dismiss()

            }

            bottomSheetDialog?.setContentView(bottomSheetView)
            bottomSheetDialog?.show()
        }

        binding.statusBtn.setOnClickListener {
            val bottomSheetDialog = context?.let { it1 -> BottomSheetDialog(it1,
                R.style.BottomSheetDialogTheme
            ) }
            val bottomSheetView = LayoutInflater.from(context).inflate(
                R.layout.layout_bottom_sheet_status,binding.root.findViewById<LinearLayout>(R.id.bottomSheet))

            bottomSheetView.findViewById<ImageView>(R.id.closeButton).setOnClickListener {
                    bottomSheetDialog?.dismiss()

            }
            bottomSheetView.findViewById<MaterialRadioButton>(R.id.paid_radioBtn).setOnClickListener{
                paid = true
                all = false
                cancelled = false

                bottomSheetView.findViewById<MaterialRadioButton>(R.id.paid_radioBtn).isChecked = paid
                bottomSheetView.findViewById<MaterialRadioButton>(R.id.cancelled_radioBtn).isChecked = cancelled
                bottomSheetView.findViewById<MaterialRadioButton>(R.id.all_radioBtn).isChecked = all
            }
            bottomSheetView.findViewById<MaterialRadioButton>(R.id.cancelled_radioBtn).setOnClickListener{
                paid = false
                all = false
                cancelled = true

                bottomSheetView.findViewById<MaterialRadioButton>(R.id.paid_radioBtn).isChecked = paid
                bottomSheetView.findViewById<MaterialRadioButton>(R.id.cancelled_radioBtn).isChecked = cancelled
                bottomSheetView.findViewById<MaterialRadioButton>(R.id.all_radioBtn).isChecked = all
            }
            bottomSheetView.findViewById<MaterialRadioButton>(R.id.all_radioBtn).setOnClickListener{
                paid = false
                all = true
                cancelled = false

                bottomSheetView.findViewById<MaterialRadioButton>(R.id.paid_radioBtn).isChecked = paid
                bottomSheetView.findViewById<MaterialRadioButton>(R.id.cancelled_radioBtn).isChecked = cancelled
                bottomSheetView.findViewById<MaterialRadioButton>(R.id.all_radioBtn).isChecked = all
            }

            bottomSheetView.findViewById<MaterialButton>(R.id.apply_status_btn).setOnClickListener{
                getTransaction()
                bottomSheetDialog?.dismiss()
            }

            bottomSheetView.findViewById<TextView>(R.id.clear_status_btn).setOnClickListener{
                paid = false
                all = false
                cancelled = false

                bottomSheetView.findViewById<MaterialRadioButton>(R.id.paid_radioBtn).isChecked = paid
                bottomSheetView.findViewById<MaterialRadioButton>(R.id.cancelled_radioBtn).isChecked = cancelled
                bottomSheetView.findViewById<MaterialRadioButton>(R.id.all_radioBtn).isChecked = all

                getTransaction()
                bottomSheetDialog?.dismiss()
            }

            bottomSheetDialog?.setContentView(bottomSheetView)
            bottomSheetDialog?.show()
        }

        binding.amountBtn.setOnClickListener{
            val bottomSheetDialog = context?.let { it1 -> BottomSheetDialog(it1,
                R.style.BottomSheetDialogTheme
            ) }
            val bottomSheetView = LayoutInflater.from(context).inflate(
                R.layout.layout_bottom_sheet_amount,binding.root.findViewById<LinearLayout>(R.id.bottomSheet))

            bottomSheetView.findViewById<ImageView>(R.id.closeButton).setOnClickListener {
                    bottomSheetDialog?.dismiss()
            }

            bottomSheetView.findViewById<MaterialButton>(R.id.apply_amount_btn).setOnClickListener{
                amount = bottomSheetView.findViewById<Slider>(R.id.amount_value).value.toDouble()
                getTransaction()
                bottomSheetDialog?.dismiss()
            }

            bottomSheetView.findViewById<TextView>(R.id.clear_amount_btn).setOnClickListener{
                amount = 0.0
                getTransaction()
                bottomSheetDialog?.dismiss()
            }

            bottomSheetDialog?.setContentView(bottomSheetView)
            bottomSheetDialog?.show()
        }



        return binding.root
    }

    private fun showDatePicker(b: Boolean) {
        val datePickerFragment = DatePickerFragment(this,b)
        datePickerFragment.show(fragmentManager!!,"datePicker")
    }

    private fun getTransaction() {
        val retIn = RemoteDataSource.getRetrofitInstance().create(ApiInterface::class.java)
        Log.d("Access Token: ", MainActivity.ACCESS_TOKEN)
        val apiInterface = retIn.transactionsData(token = "Bearer ${MainActivity.ACCESS_TOKEN}")

        apiInterface.enqueue( object : Callback<TransactionResponse> {

            override fun onResponse(
                call: Call<TransactionResponse>,
                response: Response<TransactionResponse>,
            ) {
                transactionData = response
                val transaction = response.body()

                if(transaction?.totalTransaction!=0){
                    textView16.visibility = View.GONE
                    progressBar.visibility = View.GONE
                    transactionBackground_ctl.visibility = View.VISIBLE
                    adapter = ListAdapter(context,transaction!!.transactions)
                    listOfTransactions_rv.adapter = adapter
                    listOfTransactions_rv.layoutManager = LinearLayoutManager(context)
                }
                else{
                    textView16.visibility = View.VISIBLE
                    progressBar.visibility = View.GONE
                }
            }

            override fun onFailure(call: Call<TransactionResponse>, t: Throwable) {
                t.message?.let { Log.d("data: ", it) }
//                Toast.makeText(this@FirstFragment, "Data: ${ t.message }", Toast.LENGTH_SHORT).show()
            }

        })
    }

    class DatePickerFragment(val dateSelected: DateSelected, var check: Boolean) : DialogFragment(), DatePickerDialog.OnDateSetListener {
        override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {

            val calendar = Calendar.getInstance()
            val year = calendar.get(Calendar.YEAR)
            val month = calendar.get(Calendar.MONTH)
            val dayOfMonth = calendar.get(Calendar.DAY_OF_MONTH)
            val datePickerDialog = DatePickerDialog(context!!,this,year, month, dayOfMonth)
            if(!check) {
                datePickerDialog.datePicker.minDate = calendar1.timeInMillis
            }

            return datePickerDialog
        }

        override fun onDateSet(view: DatePicker?, year: Int, month: Int, dayOfMonth: Int) {
            if(check){
                dateSelected.receiveStartDate(year,month, dayOfMonth)
                dateSelected.receiveEndDate(0,0,0)
            }
            else {
                Log.d("time","${calendar1.time}")
                dateSelected.receiveEndDate(year,month, dayOfMonth)
            }
        }
    }

    override fun receiveStartDate(year: Int, month: Int, dayOfMonth: Int) {
        calendar1.set(Calendar.DAY_OF_MONTH,dayOfMonth)
        calendar1.set(Calendar.MONTH,month)
        calendar1.set(Calendar.YEAR,year)

        val viewFormatter = SimpleDateFormat("dd-MMM-YYYY")
        val viewFormattedDate = viewFormatter.format(calendar1.time)


        bottomSheetDialog?.findViewById<MaterialButton>(R.id.from_date)?.text = viewFormattedDate
        year1 = year
        month1 = month+1
        dayOfMonth1 = dayOfMonth
        bottomSheetDialog?.findViewById<MaterialButton>(R.id.to_date)?.isEnabled = true
    }

    override fun receiveEndDate(year: Int, month: Int, dayOfMonth: Int) {
        year2 = year
        month2 = month+1
        dayOfMonth2 = dayOfMonth

        if(year == 0){
            bottomSheetDialog?.findViewById<MaterialButton>(R.id.to_date)?.text = "To"
            return
        }

        calendar2.set(Calendar.DAY_OF_MONTH,dayOfMonth)
        calendar2.set(Calendar.MONTH,month)
        calendar2.set(Calendar.YEAR,year)

        val viewFormatter = SimpleDateFormat("dd-MMM-YYYY")
        val viewFormattedDate = viewFormatter.format(calendar2.time)

        bottomSheetDialog?.findViewById<MaterialButton>(R.id.to_date)?.text = viewFormattedDate
    }
}