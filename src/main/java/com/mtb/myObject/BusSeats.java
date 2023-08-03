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

    public void addMultiPosFromInput(String input) {
        String[] l = input.split(",");

        int minX = 0, minY = 0;
        int diffX, diffY;
        int i = 0;

        for (String pair : l) {
            String[] numStr = pair.split("_");
            int x = Integer.parseInt(numStr[0]);
            int y = Integer.parseInt(numStr[1]);

            if (i == 0) {
                minX = x;
                minY = y;
                i++;
            } else {
                if (minX > x)
                    minX = x;
                if (minY > y)
                    minY = y;
            }

            this.addPos(x, y);
        }

        diffX = minX - 1;
        diffY = minY - 1;

        this.array.forEach(p -> {
            p.x -= diffX;
            p.y -= diffY;
        });
    }

    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    @Getter
    @Setter
    public class Pos {
        private int x;
        private int y;
        private boolean available;

        // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
        public Pos() {
        }

        public Pos(int x, int y) {
            this.x = x;
            this.y = y;
        }

        public Pos(int x, int y, boolean available) {
            this.x = x;
            this.y = y;
            this.available = available;
        }

        @Override
        public String toString() {
            return x + "_" + y;
        }
        // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    }
}
