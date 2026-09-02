// Creating an object (an instance) from a class.
public class Car {
    // Member variables(Attributes)
    public String model;
    public Integer year;
    public String colour;
    
    // Constructor (Method is called when Object is created).
    public Car(String m, Integer y, String c){
        this.model = m;
        this.year  = y;
        this.colour = c;
    }

    // Method to display details 
    public void displayDetails(){
        System.debug('Car Model: ' + model + ',year :' + year + ',colour:' +colour);
    }
}