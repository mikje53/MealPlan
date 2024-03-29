package com.example.mealplan

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.example.mealplan.ui.main.CameraFragment

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.main_activity)
        if (savedInstanceState == null) {
            supportFragmentManager.beginTransaction()
                .replace(R.id.container, CameraFragment.newInstance())
                .commitNow()
        }
    }

}
