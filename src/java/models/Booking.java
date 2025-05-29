package models;

import java.sql.Timestamp;

public class Booking {
    int booking_id,user_id,service_id;
    String status;
    Timestamp booking_date;
    
//    public Booking(int booking_id, int user_id, int service_id,Timestamp booking_date){
//        this.booking_id=booking_id;
//        this.user_id=user_id;
//        this.service_id=service_id;
//        this.booking_date=booking_date;
//    }

    public int getBooking_id() {
        return booking_id;
    }

    public void setBooking_id(int booking_id) {
        this.booking_id = booking_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getService_id() {
        return service_id;
    }

    public void setService_id(int service_id) {
        this.service_id = service_id;
    }

    public Timestamp getBooking_date() {
        return booking_date;
    }

    public void setBooking_date(Timestamp booking_date) {
        this.booking_date = booking_date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    
}