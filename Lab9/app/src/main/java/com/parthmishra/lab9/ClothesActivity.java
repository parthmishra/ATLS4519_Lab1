package com.parthmishra.lab9;

import android.app.Activity;
import android.os.Bundle;
import android.widget.ImageView;
import android.widget.TextView;
import android.view.Menu;
import android.view.MenuItem;
import android.content.Intent;

public class ClothesActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_clothes);

        int clothesnum = (Integer) getIntent().getExtras().get("clothesid");
        String type = (String) getIntent().getExtras().get("clothestype");

        Clothes clothes;

        switch (type) {
            case "Jeans":
                clothes = Clothes.jeans[clothesnum];
                break;
            case "Shirts":
                clothes = Clothes.shirts[clothesnum];
                break;
            case "Watches":
                clothes = Clothes.watches[clothesnum];
                break;
            default:
                clothes = Clothes.jeans[clothesnum];
        }

        //populate image
        ImageView clothesImage = (ImageView) findViewById(R.id.clothesImageView);
        clothesImage.setImageResource(clothes.getImageResourceID());

        //populate name
        TextView clothesName = (TextView) findViewById(R.id.clothes_name);
        clothesName.setText(clothes.getName());
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        //inflate menu to add items to the action bar
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        //get the ID of the item on the action bar that was clicked
        switch (item.getItemId()) {
            case R.id.create_order:
                //start order activity
                Intent intent = new Intent(this, OrderActivity.class);
                startActivity(intent);
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }
}