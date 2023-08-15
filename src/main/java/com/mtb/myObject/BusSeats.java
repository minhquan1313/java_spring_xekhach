package com.mtb.myObject;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
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

    public void addPos(int x, int y, boolean available) {
        this.array.add(new Pos(x, y, available));
    }

    public void addPos(int id, int x, int y, boolean available) {
        this.array.add(new Pos(id, x, y, available));
    }

    public void addPos(int id, int x, int y, boolean available, boolean userChosen) {
        this.array.add(new Pos(id, x, y, available, userChosen));
    }

    public void addMultiPosFromInput(String input) {
        String[] l = input.split(",");

        int minX = 0, minY = 0;
        int diffX, diffY;
        boolean isFirstTime = true;

        for (String pair : l) {
            String[] numStr = pair.split("_");
            int x = Integer.parseInt(numStr[0]);
            int y = Integer.parseInt(numStr[1]);

            if (isFirstTime) {
                minX = x;
                minY = y;
                isFirstTime = false;
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

    public void addMultiPosFromInputFull(String input) {
        String[] l = input.split(",");

        int minX = 0, minY = 0;
        int diffX, diffY;
        boolean isFirsTime = true;

        for (String pair : l) {
            String[] numStr = pair.split("_");
            int i = 0;
            int id = Integer.parseInt(numStr[i++]);
            int x = Integer.parseInt(numStr[i++]);
            int y = Integer.parseInt(numStr[i++]);
            String disabled = numStr[i++];
            String userChosen = numStr[i++];

            if (isFirsTime) {
                minX = x;
                minY = y;
                isFirsTime = false;
            } else {
                if (minX > x)
                    minX = x;
                if (minY > y)
                    minY = y;
            }

            this.addPos(id, x, y, !(disabled.equals("true")), !!(userChosen.equals("true")));
        }

        diffX = minX - 1;
        diffY = minY - 1;

        this.array.forEach(p -> {
            p.x -= diffX;
            p.y -= diffY;
        });
    }

    // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    @Data
    public class Pos {
        private Integer id;
        private int x;
        private int y;
        private boolean available;
        private boolean userChosen;

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

        public Pos(Integer id, int x, int y, boolean available) {
            this.id = id;
            this.x = x;
            this.y = y;
            this.available = available;
        }

        public Pos(Integer id, int x, int y, boolean available, boolean userChosen) {
            this.id = id;
            this.x = x;
            this.y = y;
            this.available = available;
            this.userChosen = userChosen;
        }

        @Override
        public String toString() {
            return id + "_" + x + "_" + y + "_" + available + "_" + userChosen;
        }
        // -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    }
}
