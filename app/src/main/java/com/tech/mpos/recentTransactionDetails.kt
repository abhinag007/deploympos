package com.tech.mpos

import android.content.Intent
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.tech.mpos.MainActivity.Companion.AMOUNT
import com.tech.mpos.databinding.FragmentRecentTransactionDetailsBinding
import com.tech.mpos.databinding.FragmentTransactionDetailsBinding

class recentTransactionDetails : Fragment() {
    private var _binding: FragmentRecentTransactionDetailsBinding?=null
    private val binding get() = _binding!!

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        _binding = FragmentRecentTransactionDetailsBinding.inflate(inflater,container,false)
        binding.transactionAmountTv.text = AMOUNT
        binding.transactionHistoryBtn.setOnClickListener {
            val intent = Intent(context, MainActivity::class.java)
            intent.putExtra("position","${-20}")
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            context?.startActivity(intent)
        }
        return binding.root
    }
}