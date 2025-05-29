package models;

import java.sql.Timestamp;

public class WorkRequest {
    int request_id,user_id,provider_id,service_id;
    String status;
    Timestamp request_date;
    
//    public WorkRequest(int request_id, int user_id, int provider_id, int service_id, String status, Timestamp request_date){
//        this.request_id=request_id;
//        this.user_id=user_id;
//        this.provider_id=provider_id;
//        this.service_id=service_id;
//        this.status=status;
//        this.request_date=request_date;
//    }

    public int getRequest_id() {
        return request_id;
    }

    public void setRequest_id(int request_id) {
        this.request_id = request_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getProvider_id() {
        return provider_id;
    }

    public void setProvider_id(int provider_id) {
        this.provider_id = provider_id;
    }

    public int getService_id() {
        return service_id;
    }

    public void setService_id(int service_id) {
        this.service_id = service_id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getRequest_date() {
        return request_date;
    }

    public void setRequest_date(Timestamp request_date) {
        this.request_date = request_date;
    }
    
    
}