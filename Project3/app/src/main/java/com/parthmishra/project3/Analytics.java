package com.parthmishra.project3;

import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;

import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import android.view.View;
import android.widget.ProgressBar;
import android.widget.TextView;

public class Analytics extends AppCompatActivity {

    String summoner;
    String region;
    TextView responseView;
    ProgressBar progressBar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_analytics);

        responseView = (TextView) findViewById(R.id.responseView);
        progressBar = (ProgressBar) findViewById(R.id.progressBar);
        // get data
        summoner = (String)getIntent().getExtras().get("summoner");
        region = (String)getIntent().getExtras().get("region");

        // make API calls and store JSON response
        // JSONObject jsonRootObject = new JSONObject();

        new Challenger().execute();

    }

    // code from http://www.androidauthority.com/android-app-permissions-explained-642452/
    class Challenger extends AsyncTask<Void, Void, String> {

        private Exception exception;

        String challengerID = "https://na.api.pvp.net/api/lol/na/v2.5/league/challenger?type=RANKED_SOLO_5x5&api_key=4bf388db-f2aa-4d18-9d76-b70b3186a3b9";

        protected void onPreExecute() {
            progressBar.setVisibility(View.VISIBLE);
            responseView.setText("");
        }

        // create list of challenger player ids
        protected String doInBackground(Void... urls) {
            // Do some validation here

            try {
                URL url = new URL(challengerID);
                HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
                try {
                    BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
                    StringBuilder stringBuilder = new StringBuilder();
                    String line;
                    while ((line = bufferedReader.readLine()) != null) {
                        stringBuilder.append(line).append("\n");
                    }
                    bufferedReader.close();
                    return stringBuilder.toString();
                }
                finally{
                    urlConnection.disconnect();
                }
            }
            catch(Exception e) {
                Log.e("ERROR", e.getMessage(), e);
                return null;
            }
        }


        protected void onPostExecute(String response) {
            if(response == null) {
                response = "THERE WAS AN ERROR";
            }
            // progressBar.setVisibility(View.GONE);
            Log.i("INFO", response);
            responseView.setText(response);
            // TODO: check this.exception
            // TODO: do something with the feed

//            try {
//                JSONObject object = (JSONObject) new JSONTokener(response).nextValue();
//                String requestID = object.getString("requestId");
//                int likelihood = object.getInt("likelihood");
//                JSONArray photos = object.getJSONArray("photos");
//                .
//                .
//                .
//                .
//            } catch (JSONException e) {
//                e.printStackTrace();
//            }
        }
        // calculate player role


        // calculate average CS per minute

        // calculate average Gold per minute

        // calculate wards placed per game

        // calculate exp per minute

        // create averages based on all challenger players

    }

}

