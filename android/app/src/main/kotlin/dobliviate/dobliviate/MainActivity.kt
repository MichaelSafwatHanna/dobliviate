package dobliviate.dobliviate

import android.Manifest
import android.content.Context

import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.os.Bundle
import android.provider.MediaStore
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "dobliviate.dobliviate/gallery"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->

            if (call.method == "getImages") {
                val secondsRange: Int? = call.argument("secondsRange")
                val imagesInfoMap = getImages(secondsRange!!)
                if (imagesInfoMap != null) {
                    result.success(imagesInfoMap)
                } else {
                    result.error("UNAVAILABLE", "Error Loading images", null)
                }

            } else if (call.method == "deleteImage") {
                val uri: String? = call.argument("uri")
                val rowsDeleted = deleteImage(uri!!)
                result.success(rowsDeleted)
                if (rowsDeleted == 1) {
                    result.success(rowsDeleted)
                } else {
                    result.error("UNAVAILABLE", "Error deleting image", null)
                }
            } else {
                result.notImplemented()
            }

        }
    }

    private fun getImages(secondsRange: Int): HashMap<String, List<String>> {

        val allImageInfoList = HashMap<String, List<String>>()
        val allImageList = ArrayList<String>()
        val displayNameList = ArrayList<String>()
        val dateAddedList = ArrayList<String>()
        val titleList = ArrayList<String>()

        val projection = arrayOf(
                MediaStore.Images.ImageColumns.DATA,
                MediaStore.Images.ImageColumns.DISPLAY_NAME,
                MediaStore.Images.ImageColumns.DATE_ADDED,
                MediaStore.Images.ImageColumns.TITLE
        )
        val selection = "${MediaStore.Images.Media.DATE_ADDED} >= ?"
        val timeRange = ((System.currentTimeMillis()) / 1000) - secondsRange
        val selectionArgs = arrayOf(timeRange.toString())
        val sortOrder = "${MediaStore.Images.Media.DATE_ADDED} DESC"

        applicationContext.contentResolver.query(
                MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
                projection,
                selection,
                selectionArgs,
                sortOrder
        )?.use { cursor ->
            while (cursor.moveToNext()) {
                allImageList.add(cursor.getString(0))
                displayNameList.add(cursor.getString(1))
                dateAddedList.add(cursor.getString(2))
                titleList.add(cursor.getString(3))
            }
            allImageInfoList["URI"] = allImageList
            allImageInfoList["DISPLAY_NAME"] = displayNameList
            allImageInfoList["DATE_ADDED"] = dateAddedList
            allImageInfoList["TITLE"] = titleList
        }
        return allImageInfoList
    }

    private fun deleteImage(uri: String): Int {
        return contentResolver.delete(
                MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
                MediaStore.Images.ImageColumns.DATA + "= ?", arrayOf(uri)
        )
    }
}
