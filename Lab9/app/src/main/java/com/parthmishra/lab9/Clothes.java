package com.parthmishra.lab9;

/**
 * Created by parthmishra on 4/20/16.
 */
public class Clothes {
    private String name;
    private int imageResourceID;

    private Clothes(String newname, int newID) {
        this.name = newname;
        this.imageResourceID = newID;
    }

    public static final Clothes[]jeans = {
            new Clothes("Acid", R.drawable.jeans_acid),
            new Clothes("Bastion", R.drawable.jeans_bastion),
            new Clothes("Black", R.drawable.jeans_black),
            new Clothes("Blue", R.drawable.jeans_blue),
            new Clothes("Caraway", R.drawable.jeans_caraway)
    };

    public static final Clothes[]shirts = {
            new Clothes("Flannel", R.drawable.shirt_flannel),
            new Clothes("Henley", R.drawable.shirt_henley),
            new Clothes("OCDB Blue", R.drawable.shirt_ocdb_blue),
            new Clothes("OCDB White", R.drawable.shirt_ocdb_white)
    };

    public static final Clothes[]watches = {
            new Clothes("Monochrome", R.drawable.watch_band_monochrome),
            new Clothes("Timex", R.drawable.watch_band_timex),
    };

    public String getName() {
        return name;
    }

    public int getImageResourceID() {
        return imageResourceID;
    }

    public String toString() {
        return this.name;
    }

}
