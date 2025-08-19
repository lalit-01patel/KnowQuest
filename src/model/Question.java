package model;

import java.sql.Timestamp;

public class Question {
    private int id;
    private int userId;
    private String title;
    private String content;
    private String subject;
    private Timestamp createdAt;
    private String askedByName;

    public int getId(){ return id; }
    public void setId(int id){ this.id = id; }
    public int getUserId(){ return userId; }
    public void setUserId(int userId){ this.userId = userId; }
    public String getTitle(){ return title; }
    public void setTitle(String title){ this.title = title; }
    public String getContent(){ return content; }
    public void setContent(String content){ this.content = content; }
    public String getSubject(){ return subject; }
    public void setSubject(String subject){ this.subject = subject; }
    public Timestamp getCreatedAt(){ return createdAt; }
    public void setCreatedAt(Timestamp createdAt){ this.createdAt = createdAt; }
    public String getAskedByName(){ return askedByName; }
    public void setAskedByName(String askedByName){ this.askedByName = askedByName; }

}