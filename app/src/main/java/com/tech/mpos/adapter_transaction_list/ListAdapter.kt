package com.tech.mpos.adapter_transaction_list

import android.content.Context
import android.content.Intent
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.cardview.widget.CardView
import androidx.recyclerview.widget.RecyclerView
import com.tech.mpos.MainActivity
import com.tech.mpos.R
import com.tech.mpos.screens.Transactions.WalletTransactionFragment.Companion.all
import com.tech.mpos.screens.Transactions.WalletTransactionFragment.Companion.amount
import com.tech.mpos.screens.Transactions.WalletTransactionFragment.Companion.cancelled
import com.tech.mpos.screens.Transactions.WalletTransactionFragment.Companion.dayOfMonth1
import com.tech.mpos.screens.Transactions.WalletTransactionFragment.Companion.dayOfMonth2
import com.tech.mpos.screens.Transactions.WalletTransactionFragment.Companion.month1
import com.tech.mpos.screens.Transactions.WalletTransactionFragment.Companion.month2
import com.tech.mpos.screens.Transactions.WalletTransactionFragment.Companion.paid
import com.tech.mpos.screens.Transactions.WalletTransactionFragment.Companion.year1
import com.tech.mpos.screens.Transactions.WalletTransactionFragment.Companion.year2
import com.tech.mpos.transactionResponse.Transaction
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter


class ListAdapter(
    private val context: Context?,
    private val transactionList: List<Transaction>,
) : RecyclerView.Adapter<ListAdapter.TransactionViewHolder>() {
    lateinit var date: LocalDateTime

    class TransactionViewHolder(transactionView: View) : RecyclerView.ViewHolder(transactionView) {
        var status = transactionView.findViewById<TextView>(R.id.title_tv);
//        var statusColor = transactionView.findViewById<ImageView>(R.id.transactionStatus_iv);
        var date = transactionView.findViewById<TextView>(R.id.transactionDateList_tv);
        var layout = transactionView.findViewById<CardView>(R.id.transactionCard);
//        var icon = transactionView.findViewById<ImageView>(R.id.statusImage_iv);
        var transactionAmount =
            transactionView.findViewById<TextView>(R.id.transactionAmountList_tv);
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): TransactionViewHolder {
        val view = LayoutInflater.from(context).inflate(R.layout.transaction, parent, false)
        return TransactionViewHolder(view)
    }

    override fun onBindViewHolder(holder: TransactionViewHolder, position: Int) {
        val transaction = transactionList[position]

        val secondApiFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        val dateTimeFormatter = DateTimeFormatter.ofPattern("hh:mm a")

        date = LocalDateTime.parse(transaction.createdAt, secondApiFormat)

        if(year1 == 0 || ((date.monthValue>= month1 && date.dayOfMonth >= dayOfMonth1 && date.year >= year1)
            &&
            (date.monthValue <= month2 && date.dayOfMonth <= dayOfMonth2 && date.year >= year2))) {

            if (all || (!all && !paid && !cancelled)) {

                if(amount == 0.0 || transaction.amount<=amount){

                holder.date.text =
                    "${date.dayOfMonth} ${date.month}, ${date.format(dateTimeFormatter)}"
                holder.transactionAmount.text = transaction.amount.toString()

                if (transaction.status.equals("success")) {
                    holder.status.text =
                        "Success From XXXX ${transaction.customer.cardNo.substring(transaction.customer.cardNo.length - 4)}"
                } else {
                    holder.status.text =
                        "Failed From XXXX ${transaction.customer.cardNo.substring(transaction.customer.cardNo.length - 4)}"
                }

                holder.itemView.setOnClickListener {
                    val intent = Intent(context, MainActivity::class.java)
                    intent.putExtra("position", "$position")
                    context?.startActivity(intent)
                }
            }
                else{
                    holder.layout.visibility = View.GONE
                }
        }
            else if(paid) {
                if(amount == 0.0 || transaction.amount<=amount){

                    if (transaction.status.equals("success")) {

                    holder.date.text =
                        "${date.dayOfMonth} ${date.month}, ${date.format(dateTimeFormatter)}"
                    holder.transactionAmount.text = transaction.amount.toString()

                    holder.status.text =
                        "Success From XXXX ${transaction.customer.cardNo.substring(transaction.customer.cardNo.length - 4)}"


                    holder.itemView.setOnClickListener {
                        val intent = Intent(context, MainActivity::class.java)
                        intent.putExtra("position", "$position")
                        context?.startActivity(intent)
                    }

                } else {
                    holder.layout.visibility = View.GONE
                }
            }
                else{
                    holder.layout.visibility = View.GONE
                }
            }
            else {
                if(amount == 0.0 || transaction.amount<=amount){

                    if (transaction.status.equals("failed")) {

                    holder.date.text =
                        "${date.dayOfMonth} ${date.month}, ${date.format(dateTimeFormatter)}"
                    holder.transactionAmount.text = transaction.amount.toString()


                    holder.status.text =
                        "Failed From XXXX ${transaction.customer.cardNo.substring(transaction.customer.cardNo.length - 4)}"


                    holder.itemView.setOnClickListener {
                        val intent = Intent(context, MainActivity::class.java)
                        intent.putExtra("position", "$position")
                        context?.startActivity(intent)
                    }

                } else {
                    holder.layout.visibility = View.GONE
                }
            }
                else{
                    holder.layout.visibility = View.GONE
                }
            }
        }
        else{
            holder.layout.visibility = View.GONE
        }

    }

    override fun getItemCount(): Int {
//        if((date.monthValue>= month1 && date.dayOfMonth >= dayOfMonth1 && date.year >= year1)
//                    &&
//                    (date.monthValue <= month2 && date.dayOfMonth <= dayOfMonth2 && date.year >= year2)) {
//        }
        return transactionList.size
    }

}
