package co.getlinks.platformview

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import kotlinx.android.synthetic.main.activity_edit_text.*

class EditTextActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_edit_text)

        btnSendData.setOnClickListener {
            val intent = Intent()
            intent.putExtra("DATA",etDataToSend.text.toString())
            setResult(Activity.RESULT_OK,intent)
            finish()
        }
    }

    companion object {
        const val REQUEST_GET_DATA = 100
    }
}