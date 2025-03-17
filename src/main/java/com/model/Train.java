package com.model;



public class Train {
    private int trainNo;
    private String trainName;
    private String fromStation;
    private String toStation;
    private int availableSeats;
    private int fare;
    
    public Train() {};
    
    public Train(String trainName,String fromStation,String toStation,int availableSeats,int fare){
    	this.trainName=trainName;
    	this.fromStation=fromStation;
    	this.toStation=toStation;
    	this.availableSeats=availableSeats;
    	this.fare=fare;
    	
    };

    // Getters and Setters
    public int getTrainNo() {
        return trainNo;
    }

    public void setTrainNo(int trainNo) {
        this.trainNo = trainNo;
    }

    public String getTrainName() {
        return trainName;
    }

    public void setTrainName(String trainName) {
        this.trainName = trainName;
    }

    public String getFromStation() {
        return fromStation;
    }

    public void setFromStation(String fromStation) {
        this.fromStation = fromStation;
    }

    public String getToStation() {
        return toStation;
    }

    public void setToStation(String toStation) {
        this.toStation = toStation;
    }

    public int getAvailableSeats() {
        return availableSeats;
    }

    public void setAvailableSeats(int availableSeats) {
        this.availableSeats = availableSeats;
    }

    public int getFare() {
        return fare;
    }

    public void setFare(int fare) {
        this.fare = fare;
    }
    @Override
    public String toString() {
        return "Train{" +
                "trainNo=" + trainNo +
                ", trainName='" + trainName + '\'' +
                ", fromStation='" + fromStation + '\'' +
                ", toStation='" + toStation + '\'' +
                ", availableSeats=" + availableSeats +
                ", fare=" + fare +
                '}';
    }
}
