package model;

public class Department {
    private int id;
    private String name;
    private String description;
    private String location;
    private int headDoctorId;
    private boolean active;

    // Reference to the head doctor
    private User headDoctor;

    // Constructors
    public Department() {}

    public Department(int id, String name, String description, String location, int headDoctorId, boolean active) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.location = location;
        this.headDoctorId = headDoctorId;
        this.active = active;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getHeadDoctorId() {
        return headDoctorId;
    }

    public void setHeadDoctorId(int headDoctorId) {
        this.headDoctorId = headDoctorId;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public User getHeadDoctor() {
        return headDoctor;
    }

    public void setHeadDoctor(User headDoctor) {
        this.headDoctor = headDoctor;
    }
}