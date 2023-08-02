package com.mtb.myObject;

import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BusSeats {
    private int col;
    private int row;
    private List<Pos> array;

    public BusSeats() {
        array = new ArrayList<>();
    }

    public BusSeats(int col, int row, List<Pos> array) {
        this.col = col;
        this.row = row;
        this.array = array;
    }

    public void addPos(int x, int y) {
        this.array.add(new Pos(x, y));
    }

    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    @Getter
    @Setter
    public class Pos {
        private int x;
        private int y;
        private boolean available;

        // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        public Pos(int x, int y) {
            this.x = x;
            this.y = y;
        }

        public Pos(int x, int y, boolean available) {
            this.x = x;
            this.y = y;
            this.available = available;
        }
        // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    }
}
