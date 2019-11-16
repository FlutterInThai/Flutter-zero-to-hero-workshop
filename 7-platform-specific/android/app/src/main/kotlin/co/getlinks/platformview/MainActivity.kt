package co.getlinks.platformview

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
  private lateinit var channel:MethodChannel
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    channel = MethodChannel(flutterView, CHANNEL)
    channel.setMethodCallHandler { call, result ->
      if(call.method == "showEditText") {
        val intent = Intent(this, EditTextActivity::class.java)
        startActivityForResult(intent,EditTextActivity.REQUEST_GET_DATA)
        result.success(true)
      }
      result.notImplemented()
    }
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
    super.onActivityResult(requestCode, resultCode, data)
    if(resultCode== Activity.RESULT_OK) {
      if(requestCode==EditTextActivity.REQUEST_GET_DATA) {
        val stringData =  data!!.getStringExtra("DATA")
        channel.invokeMethod("message",stringData,object :MethodChannel.Result{
          override fun notImplemented() {

          }

          override fun error(p0: String?, p1: String?, p2: Any?) {

          }

          override fun success(p0: Any?) {

          }

        })
        Log.d("DATA",stringData)
      }
    }
  }

  companion object {
    const val CHANNEL = "co.getlinks.platform.channel"
  }
}
