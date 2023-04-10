package com.tech.mpos

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.tech.mpos.MainActivity.Companion.UserData
import com.tech.mpos.MainActivity.Companion.responseBody
import com.tech.mpos.databinding.FragmentAccountBinding
import com.tech.mpos.databinding.FragmentBusinessDetailsBinding
import com.tech.mpos.models.EmailUpdate
import com.tech.mpos.models.ReceiptEmail
import kotlinx.android.synthetic.main.fragment_account.*
import kotlinx.android.synthetic.main.fragment_business_details.*

class BusinessDetailsFragment : Fragment() {
    private var _binding: FragmentBusinessDetailsBinding?=null
    private val binding get() = _binding!!

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        _binding = FragmentBusinessDetailsBinding.inflate(inflater,container,false)
        binding.businessNameTil.editText?.setText(UserData.body()?.businessName)
        binding.phoneNumberTil.editText?.setText(UserData.body()?.mobileNumber)
        binding.emailAddressTil.editText?.setText(UserData.body()?.email)

        binding.updateBtn.setOnClickListener{
            FetchTransactionData().updateUserEmailData(context,
                EmailUpdate(binding.emailTied.text.toString()))
        }
        return binding.root
    }

}