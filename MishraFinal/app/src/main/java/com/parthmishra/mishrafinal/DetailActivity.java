package com.parthmishra.mishrafinal;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ImageView;
import android.widget.TextView;
import android.app.Activity;

import org.w3c.dom.Text;

public class DetailActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);

        int workoutnum = (int)getIntent().getExtras().get("workoutid");
        String type = (String)getIntent().getExtras().get("workouttype");

        Workout workout;

        switch (type){
            case "Cardio":
                workout = Workout.cardio[workoutnum];
                break;
            case "Strength":
                workout = Workout.strength[workoutnum];
                break;
            case "Flexibility":
                workout = Workout.flexiblity[workoutnum];
                break;
            default: workout = Workout.cardio[workoutnum];
        }


        ImageView sportImage = (ImageView)findViewById(R.id.sportImage);
        sportImage.setImageResource(workout.getImageResourceID());

        TextView sportName = (TextView)findViewById(R.id.sport_name);
        sportName.setText(workout.getName());

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
