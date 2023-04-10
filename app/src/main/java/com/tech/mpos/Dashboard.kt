import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import androidx.fragment.app.Fragment
import com.tech.mpos.MainActivity
import com.tech.mpos.MainActivity.Companion.responseBody
import com.tech.mpos.MainActivity.Companion.transactionData
import com.tech.mpos.PaymentSetupFragment
import com.tech.mpos.R
import com.tech.mpos.databinding.FragmentDashboardBinding

class FirstFragment:Fragment(R.layout.fragment_dashboard) {
     private var _binding: FragmentDashboardBinding?=null
     private val binding get() = _binding!!
    private val paymentSetupFragment= PaymentSetupFragment()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        _binding = FragmentDashboardBinding.inflate(inflater,container,false)
        val volume = resources.getStringArray(R.array.volume)
        val arrayAdapter = ArrayAdapter(requireContext(), R.layout.dropdown_item, volume)
        binding.autoCompleteTextView.setAdapter(arrayAdapter)
        binding.welcomeNameTv.text = "Welcome ${responseBody.body()?.data?.businessName?.capitalize()}"
        binding.textView4.text = "CAD ${transactionData.body()?.walletBalance}"
        binding.tapBoxLl.setOnClickListener {
            (activity as MainActivity?)?.replaceFragment(paymentSetupFragment)
            
        }

        return binding.root
    }

    override fun onDestroy() {
        super.onDestroy()
        _binding = null
    }
}