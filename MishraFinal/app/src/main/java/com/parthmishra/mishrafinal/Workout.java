package com.parthmishra.mishrafinal;

/**
 * Created by parthmishra on 4/28/16.
 */

public class Workout {
    private String name;
    private int imageResourceID;

    //constructor
    private Workout(String newname, int newID){
        this.name = newname;
        this.imageResourceID = newID;
    }

    public static final Workout[] cardio = {
           new Workout("Cycling", R.drawable.cardio),
            new Workout("Running", R.drawable.cardio),
            new Workout("Jogging", R.drawable.cardio)
    };

    public static final Workout[] strength = {
            new Workout("Squat", R.drawable.strength),
            new Workout("Push Up", R.drawable.strength),
            new Workout("Bench Press", R.drawable.strength)
    };

    public static final Workout[] flexiblity = {
            new Workout("Yoga", R.drawable.flexibility),
            new Workout("Pilates", R.drawable.flexibility)
    };



    public String getName(){
        return name;
    }

    public int getImageResourceID(){
        return imageResourceID;
    }

    //the string representation of a tulip is its name
    public String toString(){
        return this.name;
    }


}
