package com.parthmishra.project3;

import android.graphics.Typeface;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONException;
import org.json.JSONTokener;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import android.widget.TextView;




public class Analytics extends AppCompatActivity implements AsyncResponse {

    String summoner;
    String summonerFixed;
    public String playerID;
    String region;
    List<String> ids = new ArrayList<>();
    List<String> challengerID = new ArrayList<>();

    String playeravgCS;
    String playeravgWardsPlaced;
    String playeravgGoldEarned;

    String challengeravgCS;
    String challengeravgWardsPlaced;
    String challengeravgGoldEarned;

    TextView titleView;
    TextView challengerCS;
    TextView playerCS;
    TextView playerGoldEarned;
    TextView playerWardsPlaced;
    TextView challengerGoldEarned;
    TextView challengerWardsPlaced;

    PlayerID playerIDtask = new PlayerID();


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_analytics);

        // create typefaces
        Typeface beaufortBold = Typeface.createFromAsset(getAssets(), "fonts/beaufortforlol-bold.otf");
        Typeface beaufortRegular = Typeface.createFromAsset(getAssets(), "fonts/beaufortforlol-regular.otf");
        Typeface spiegelotRegular = Typeface.createFromAsset(getAssets(), "fonts/spiegelot-regular.otf");

        // initialize views
        titleView = (TextView) findViewById(R.id.analyticsTitleView);
        titleView.setTypeface(beaufortRegular);
        playerCS = (TextView) findViewById(R.id.playerCS);
        playerCS.setTypeface(spiegelotRegular);
        challengerCS = (TextView) findViewById(R.id.challengerCS);
        challengerCS.setTypeface(spiegelotRegular);
        playerGoldEarned = (TextView) findViewById(R.id.playerGoldEarned);
        playerGoldEarned.setTypeface(spiegelotRegular);
        challengerGoldEarned = (TextView) findViewById(R.id.challengerGoldEarned);
        challengerGoldEarned.setTypeface(spiegelotRegular);
        playerWardsPlaced = (TextView) findViewById(R.id.playerWardsPlaced);
        playerWardsPlaced.setTypeface(spiegelotRegular);
        challengerWardsPlaced = (TextView) findViewById(R.id.challengerWardsPlaced);
        challengerWardsPlaced.setTypeface(spiegelotRegular);


        // get player data
        summoner = (String)getIntent().getExtras().get("summoner");
        summonerFixed = fixSummonerName(summoner);


        region = (String)getIntent().getExtras().get("region");

        // get player ID
        playerIDtask.delegate = this;
        playerIDtask.execute(summonerFixed);


        // calculate player stats
        // Log.i("playerID: ", playerID);
        // new playerStats().execute(playerID);

        // get list of all Challenger players
        // new ChallengerID().execute();

        // aggregate stats for Challenger players
        new ChallengerStats().execute();

    }

    public void processFinish(String output) {
        playerID = output;
        Log.i("PF Player ID", playerID);
    }

    public String fixSummonerName(String name) {

        // 1. Replace Spaces with %20
        // 2. Make everything lowercase
        // name = name.replaceAll(" ","%20");
        name = name.toLowerCase();
        name = name.replaceAll(" ", "%20");
        return name;

    }



    class PlayerID extends AsyncTask<String, Void, String> {

        public AsyncResponse delegate = null;

        protected void onPreExecute() {

        }

        // create list of challenger player ids
        protected String doInBackground(String... summoner) {

            region = region.toLowerCase();
            String playerIDURL = "https://na.api.pvp.net/api/lol/" + region + "/v1.4/summoner/by-name/" + summoner[0] + "?api_key=4bf388db-f2aa-4d18-9d76-b70b3186a3b9";
            //Log.i("Player URL", playerIDURL);

            String playerIDJSON = "";
            // Generate Player ID
            try {

                URL url = new URL(playerIDURL);
                Log.i("PlayerIDURL", url.toString());
                HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
                try {
                    BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
                    StringBuilder stringBuilder = new StringBuilder();
                    String line;
                    while ((line = bufferedReader.readLine()) != null) {
                        stringBuilder.append(line).append("\n");
                    }
                    bufferedReader.close();
                    playerIDJSON = stringBuilder.toString();
                }
                finally {
                    urlConnection.disconnect();
                }
            }
            catch(Exception e) {
                Log.e("ERROR", e.getMessage(), e);
                return null;
            }

            String id = "";
            try {

                JSONObject rootobject = new JSONObject(playerIDJSON);
                // Log.i("rootobject", rootobject.toString());
                summoner[0] = summoner[0].toLowerCase();
                summoner[0] = summoner[0].replaceAll(" ","");
                summoner[0] = summoner[0].replaceAll("%20","");
                JSONObject playerObject = rootobject.getJSONObject(summoner[0]);

                id = playerObject.getString("id");

            } catch (JSONException e) {
                e.printStackTrace();
            }

            // playerID = id;
            Log.i("id", id);
            // return id;
            // Generate Player Stats

            String playerURL = "https://na.api.pvp.net/api/lol/" + region + "/v1.3/game/by-summoner/" + id + "/recent?api_key=4bf388db-f2aa-4d18-9d76-b70b3186a3b9";
            String playerStatsJSON = "";
            Log.i("playerURL", playerURL);
            try {
                URL url = new URL(playerURL);
                HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
                try {
                    BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
                    StringBuilder stringBuilder = new StringBuilder();
                    String line;
                    while ((line = bufferedReader.readLine()) != null) {
                        stringBuilder.append(line).append("\n");
                    }
                    bufferedReader.close();
                    playerStatsJSON = stringBuilder.toString();
                }
                finally {
                    urlConnection.disconnect();
                }
            }
            catch(Exception e) {
                Log.e("ERROR", e.getMessage(), e);
            }

            try {
                JSONObject rootobject = new JSONObject(playerStatsJSON);

                JSONArray gamesObject = rootobject.getJSONArray("games");

                int cs = 0;
                int wardsPlaced = 0;
                int goldEarned = 0;
                for (int i = 0; i < gamesObject.length(); i++) {
                    JSONObject game = gamesObject.getJSONObject(i);
                    JSONObject stats = game.getJSONObject("stats");
                    Log.i("Stats", stats.toString());
                    String tmpCS = stats.getString("minionsKilled");
                    String tmpwardsPlaced = stats.getString("wardPlaced");
                    String tmpGoldEanred = stats.getString("goldEarned");
                    int intcs = Integer.parseInt(tmpCS);
                    int intwardsPlaced = Integer.parseInt(tmpwardsPlaced);
                    int intgoldEarned = Integer.parseInt(tmpGoldEanred);
                    cs += intcs;
                    wardsPlaced += intwardsPlaced;
                    goldEarned += intgoldEarned;

                }

                playeravgCS = playeravgCS.valueOf(cs/10);
                playeravgWardsPlaced = playeravgWardsPlaced.valueOf(wardsPlaced/10);
                playeravgGoldEarned = playeravgGoldEarned.valueOf(goldEarned/10);




            } catch (JSONException e) {
                e.printStackTrace();
            }



            return id;
        }


        protected void onPostExecute(String id) {
            playerCS.setText(playeravgCS);
            playerGoldEarned.setText(playeravgGoldEarned);
            playerWardsPlaced.setText(playeravgWardsPlaced);



        }


    }



    class ChallengerStats extends AsyncTask<Void, Void, String> {

        protected void onPreExecute() {
        }

        protected String doInBackground(Void... id) {
            try {

                URL url = new URL("https://na.api.pvp.net/api/lol/na/v1.3/game/by-summoner/390600/recent?api_key=4bf388db-f2aa-4d18-9d76-b70b3186a3b9");
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
            if (response == null) {
                response = "THERE WAS NO RESPONSE";
            }


            try {
                JSONObject rootobject = new JSONObject(response);

                JSONArray gamesObject = rootobject.getJSONArray("games");


                int cs = 0;
                int wardsPlaced = 0;
                int goldEarned = 0;
                for (int i = 0; i < gamesObject.length(); i++) {
                    JSONObject game = gamesObject.getJSONObject(i);
                    JSONObject stats = game.getJSONObject("stats");
                    String tmpCS = stats.getString("minionsKilled");
                    String tmpwardsPlaced = stats.getString("wardPlaced");
                    String tmpGoldEanred = stats.getString("goldEarned");
                    int intcs = Integer.parseInt(tmpCS);
                    int intwardsPlaced = Integer.parseInt(tmpwardsPlaced);
                    int intgoldEarned = Integer.parseInt(tmpGoldEanred);
                    cs += intcs;
                    wardsPlaced += intwardsPlaced;
                    goldEarned += intgoldEarned;

                }

                challengeravgCS = challengeravgCS.valueOf(cs/10);
                challengeravgWardsPlaced = challengeravgWardsPlaced.valueOf(wardsPlaced/10);
                challengeravgGoldEarned = challengeravgGoldEarned.valueOf(goldEarned/10);

                challengerCS.setText(challengeravgCS);
                challengerWardsPlaced.setText(challengeravgWardsPlaced);
                challengerGoldEarned.setText(challengeravgGoldEarned);



            } catch (JSONException e) {
                e.printStackTrace();
            }

        }


    }

}

