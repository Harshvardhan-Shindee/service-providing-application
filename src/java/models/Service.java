package models;

public class Service {
    int service_id,provider_id;
    String category,description,providerName;
    double price;
    
//    public Service(int service_id, int provider_id, String name, String description, double price){
//        this.service_id=service_id;
//        this.provider_id=provider_id;
//        this.name=name;
//        this.description=description;
//        this.price=price;
//    }

    public int getService_id() {
        return service_id;
    }

    public void setService_id(int service_id) {
        this.service_id = service_id;
    }

    public int getProvider_id() {
        return provider_id;
    }

    public void setProvider_id(int provider_id) {
        this.provider_id = provider_id;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String name) {
        this.category = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getProviderName() {
        return providerName;
    }

    public void setProviderName(String providerName) {
        this.providerName = providerName;
    }
    
    

    
}