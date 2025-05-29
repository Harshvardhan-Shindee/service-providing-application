package models;

public class Provider {

    int provider_id;
    String name, email, password, phone, aadhar;

    public Provider(int provider_id, String name, String email, String password, String phone, String aadhar) {
        this.provider_id = provider_id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.aadhar = aadhar;
    }

    public Provider(String name, String email, String password, String phone, String aadhar) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.aadhar = aadhar;
    }

    public int getProvider_id() {
        return provider_id;
    }

    public void setProvider_id(int providerId) {
        this.provider_id = providerId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAadhar() {
        return aadhar;
    }

    public void setAadhar(String aadhar) {
        this.aadhar = aadhar;
    }

}
