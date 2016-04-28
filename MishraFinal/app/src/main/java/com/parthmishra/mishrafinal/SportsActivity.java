package com.parthmishra.mishrafinal;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.ArrayAdapter;


public class SportsActivity extends Activity {

    private String workouttype;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sports);

        workouttype = (String)getIntent().getExtras().get("workouttype");


        AdapterView.OnItemClickListener itemClickListener = new AdapterView.OnItemClickListener() {
            public void onItemClick(AdapterView<?> listView, View view, int position, long id) {
                        Intent intent = new Intent(SportsActivity.this, DetailActivity.class);
                        intent.putExtra("workoutid", (int) id);
                        intent.putExtra("workouttype", workouttype);
                        startActivity(intent);
                    }
        };



        ArrayAdapter<Workout> listAdapter;

        switch(workouttype) {
            case "Cardio":
                listAdapter = new ArrayAdapter<Workout>(this, android.R.layout.simple_list_item_1, Workout.cardio);
                break;
            case "Strength":
                listAdapter = new ArrayAdapter<Workout>(this, android.R.layout.simple_list_item_1, Workout.strength);
                break;
            case "Flexibility":
                listAdapter = new ArrayAdapter<Workout>(this, android.R.layout.simple_list_item_1, Workout.flexiblity);
                break;
            default: listAdapter = new ArrayAdapter<Workout>(this, android.R.layout.simple_list_item_1, Workout.strength);
        }

        ListView sportListView = (ListView)findViewById(R.id.sportsListView);
        sportListView.setAdapter(listAdapter);
        sportListView.setOnItemClickListener(itemClickListener);

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem menuItem) {
        switch(menuItem.getItemId()) {
            case R.id.sign_up:
                Intent intent = new Intent(this, SignUpActivity.class);
                startActivity(intent);
                return true;
            default:
                return super.onOptionsItemSelected(menuItem);
        }
    }



}
