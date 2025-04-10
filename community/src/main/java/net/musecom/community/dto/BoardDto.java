package net.musecom.community.dto;

import java.sql.Timestamp;

import lombok.Data;
@Data
public class BoardDto {
   private long id;
   private int bbsid;
   private long ref;
   private int step;
   private int depth;
   private String writer;
   private String userid;
   private String password;
   private String title;
   private String content;
   private int comment;
   private byte sec;
   private String category;
   private int hit;
   private Timestamp wdate;
}
