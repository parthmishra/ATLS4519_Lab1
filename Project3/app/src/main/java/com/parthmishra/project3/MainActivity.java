package com.parthmishra.project3;

import android.os.Bundle;
import android.text.Editable;
import android.widget.EdgeEffect;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Adapter;
import android.widget.AdapterView;
import android.view.View;
import android.app.Activity;
import android.util.Log;
import android.widget.Button;
import android.content.Intent;

import android.widget.ArrayAdapter;

public class MainActivity extends Activity implements AdapterView.OnItemSelectedListener {

    String region;
    String summoner;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Spinner spinner = (Spinner) findViewById(R.id.regions_spinner);
        // Create an ArrayAdapter using the string array and a default spinner layout
        ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(this,
                R.array.regions, android.R.layout.simple_spinner_item);
        // Specify the layout to use when the list of choices appears
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        // Apply the adapter to the spinner
        spinner.setAdapter(adapter);

        spinner.setOnItemSelectedListener((AdapterView.OnItemSelectedListener) this);

        final Button submitButton = (Button) findViewById(R.id.submit_button);
        final EditText nameEdit = (EditText)findViewById(R.id.editText);
        submitButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                // perform action on click
                summoner = nameEdit.getText().toString();
                Intent intent = new Intent(getApplicationContext(), Analytics.class);
                intent.putExtra("region", region);
                intent.putExtra("summoner", summoner);
                startActivity(intent);

            }
        });

    }

    public void onItemSelected(AdapterView<?> parent, View view, int pos, long id) {
        // An item was selected. You can retrieve the selected item using
        region = parent.getItemAtPosition(pos).toString();

    }

    public void onNothingSelected(AdapterView<?> parent) {
        // Another interface callback
    }

}
