package com.tech.mpos

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.tech.mpos.MainActivity.Companion.POSITION
import com.tech.mpos.MainActivity.Companion.transactionData
import com.tech.mpos.databinding.FragmentTransactionDetailsBinding
import java.util.*


class TransactionDetailsFragment : Fragment(R.layout.fragment_transaction_details) {
    private var _binding: FragmentTransactionDetailsBinding?=null
    private val binding get() = _binding!!

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?,
    ): View? {
        _binding = FragmentTransactionDetailsBinding.inflate(inflater,container,false)

        if(POSITION >= 0){
            var transaction = transactionData.body()?.transactions?.get(POSITION)
            binding.statusTextTv.text = transaction?.status?.replaceFirstChar {
                if (it.isLowerCase()) it.titlecase(
                    Locale.getDefault()
                ) else it.toString()
            }
            binding.transactionDateTv.text = transaction?.createdAt?.substring(0,transaction.createdAt.indexOf('T'))
            binding.transactionIdTv.text = transaction?.id
            binding.transactionAmountTv.text = "CAD ${transaction?.amount}"

            if(transaction?.status.equals("success")){
                binding.circleColorIv.setBackgroundResource(R.drawable.paying_curve_shape_green)
                binding.statusTextTv.setTextColor(android.graphics.Color.parseColor("#ff266342"))
                binding.imageView6.setBackgroundResource(R.drawable.dashboard_curve_green)
                binding.statusIconIv.setBackgroundResource(R.drawable.check_icon)
            }
            else {
                binding.transactionDetailsBaground.setBackgroundColor(android.graphics.Color.parseColor("#FFF0F0"))
                binding.circleColorIv.setBackgroundResource(R.drawable.paying_curve_shape_red)
                binding.statusTextTv.setTextColor(android.graphics.Color.parseColor("#FF0000"))
                binding.imageView6.setBackgroundResource(R.drawable.dashboard_curve_red)
                binding.statusIconIv.setBackgroundResource(R.drawable.ic_close)
            }
        }

        binding.transactionHistoryBtn.setOnClickListener {
            val intent = Intent(context, MainActivity::class.java)
            intent.putExtra("position","${-2}")
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            context?.startActivity(intent)
        }

        return binding.root
    }


}