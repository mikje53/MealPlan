package com.example.mealplan.ui.main

import android.Manifest
import android.content.pm.PackageManager
import android.os.Bundle
import android.view.LayoutInflater
import android.view.SurfaceHolder
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProviders
import com.example.mealplan.R
import com.google.android.gms.vision.CameraSource
import com.google.android.gms.vision.text.TextRecognizer
import kotlinx.android.synthetic.main.camera_fragment.view.*
import java.lang.Exception
import kotlin.properties.Delegates

class CameraFragment : Fragment() {

    companion object {
        fun newInstance() = CameraFragment()
    }

    private lateinit var viewModel: MainViewModel
    private var mCameraSource by Delegates.notNull<CameraSource>()
    private var mTextRecognizer by Delegates.notNull<TextRecognizer>()
    private var mCameraPermissionRequestId = 10

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mTextRecognizer = TextRecognizer.Builder(activity).build()
        mCameraSource = CameraSource.Builder(activity, mTextRecognizer)
            .setFacing(CameraSource.CAMERA_FACING_BACK)
            .setAutoFocusEnabled(true)
            .setRequestedPreviewSize(1920, 1080)
            .setRequestedFps(1.0f)
            .build()

    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        val cameraView = inflater.inflate(R.layout.camera_fragment, container, false)

        startCamera(cameraView)

        return cameraView
    }

    private fun startCamera(cameraView: View) {
        cameraView.camera_preview.holder.addCallback(object : SurfaceHolder.Callback {
            override fun surfaceChanged(p0: SurfaceHolder?, p1: Int, p2: Int, p3: Int) {}

            override fun surfaceDestroyed(p0: SurfaceHolder?) {
                mCameraSource.stop()
            }

            override fun surfaceCreated(p0: SurfaceHolder?) {
                try {
                    if (isCameraPermissionGranted()) {
                        mCameraSource.start(cameraView.camera_preview.holder)
                    } else {
                        requestCameraPermission()
                    }
                } catch (e: Exception) {
                    Toast.makeText(activity, "", Toast.LENGTH_SHORT).show()
                }
            }
        })
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        viewModel = ViewModelProviders.of(this).get(MainViewModel::class.java)
        // TODO: Use the ViewModel
    }

    fun isCameraPermissionGranted(): Boolean {

        return ActivityCompat.checkSelfPermission(requireContext(), Manifest.permission.CAMERA) ==
                PackageManager.PERMISSION_GRANTED
    }

    private fun requestCameraPermission() {
        this.requestPermissions(arrayOf(Manifest.permission.CAMERA),mCameraPermissionRequestId)
    }

}
