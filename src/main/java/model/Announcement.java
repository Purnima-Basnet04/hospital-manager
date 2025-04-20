package model;

import java.sql.Date;

public class Announcement {
    private int id;
    private String title;
    private String content;
    private Date postDate;
    private Date eventDate;
    private String venue;
    private int postedBy;
    private boolean active;
    
    // Constructors
    public Announcement() {}
    
    public Announcement(int id, String title, String content, Date postDate, 
                       Date eventDate, String venue, int postedBy, boolean active) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.postDate = postDate;
        this.eventDate = eventDate;
        this.venue = venue;
        this.postedBy = postedBy;
        this.active = active;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getTitle() {
        return title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    public String getContent() {
        return content;
    }
    
    public void setContent(String content) {
        this.content = content;
    }
    
    public Date getPostDate() {
        return postDate;
    }
    
    public void setPostDate(Date postDate) {
        this.postDate = postDate;
    }
    
    public Date getEventDate() {
        return eventDate;
    }
    
    public void setEventDate(Date eventDate) {
        this.eventDate = eventDate;
    }
    
    public String getVenue() {
        return venue;
    }
    
    public void setVenue(String venue) {
        this.venue = venue;
    }
    
    public int getPostedBy() {
        return postedBy;
    }
    
    public void setPostedBy(int postedBy) {
        this.postedBy = postedBy;
    }
    
    public boolean isActive() {
        return active;
    }
    
    public void setActive(boolean active) {
        this.active = active;
    }
}