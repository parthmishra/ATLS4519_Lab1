package com.parthmishra.lab9;

import android.app.ListActivity;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;


public class ClothesCategoryActivity extends ListActivity {

    private String clothestype;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Intent i = getIntent();
        clothestype = i.getStringExtra("clothestype");

        //get the list view
        ListView listClothes = getListView();

        //define an array adapter
        ArrayAdapter<Clothes> listAdapter;

        //initialize the array adapter with the right list of bulbs
        switch (clothestype) {
            case "Jeans":
                listAdapter = new ArrayAdapter<Clothes>(this, android.R.layout.simple_list_item_1, Clothes.jeans);
                break;
            case "Shirts":
                listAdapter = new ArrayAdapter<Clothes>(this, android.R.layout.simple_list_item_1, Clothes.shirts);
                break;
            case "Watches":
                listAdapter = new ArrayAdapter<Clothes>(this, android.R.layout.simple_list_item_1, Clothes.watches);
                break;
            default:
                listAdapter = new ArrayAdapter<Clothes>(this, android.R.layout.simple_list_item_1, Clothes.jeans);
        }

        //set the array adapter on the list view
        listClothes.setAdapter(listAdapter);
    }

    @Override
    public void onListItemClick(ListView listView, View view, int position, long id){
        Intent intent = new Intent(ClothesCategoryActivity.this, ClothesActivity.class);
        intent.putExtra("clothesid", (int) id);
        intent.putExtra("clothestype", clothestype);
        startActivity(intent);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu){
        //inflate menu to add items to the action bar
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        //get the ID of the item on the action bar that was clicked
        switch (item.getItemId()){
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
