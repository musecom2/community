package net.musecom.community.dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class Users {
  private int id;
  private String userid;
  private String userpass;
  private String username;
  private String useremail;
  private String usertel;
  private int zipcode;
  private String address;
  private String detailAddress;
  private String extraAddress;
  private String userimg;
  private String userprofile;
  private Timestamp createAt;
  private Timestamp editAt;
  private String userip;
  private int grade;
  private String role;
}
