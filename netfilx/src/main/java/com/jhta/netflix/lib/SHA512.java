package com.jhta.netflix.lib;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

public class SHA512 {
	public static String get_SHA_512_SecurePassword(String passwordToHash, String   salt){
		String generatedPassword = null;
		    try {
		         MessageDigest md = MessageDigest.getInstance("SHA-512");
		         md.update(salt.getBytes(StandardCharsets.UTF_8));
		         byte[] bytes = md.digest(passwordToHash.getBytes(StandardCharsets.UTF_8));
		         StringBuilder sb = new StringBuilder();
		         for(int i=0; i< bytes.length ;i++){
		            sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
		         }
		         String pass2 = sb.toString();
		         byte[] bytes1 = md.digest(pass2.getBytes(StandardCharsets.UTF_8));
		         StringBuilder sb1 = new StringBuilder();
		         for(int i=0; i< bytes1.length ;i++){
		            sb1.append(Integer.toString((bytes1[i] & 0xff) + 0x100, 16).substring(1));
		         }
		         generatedPassword = sb1.toString();
		        } 
		       catch (NoSuchAlgorithmException e){
		        e.printStackTrace();
		       }
		    return generatedPassword;
	}
	
	public static String generateSalt() {
        Random random = new Random();
        byte[] salt = new byte[8];
        random.nextBytes(salt);
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < salt.length; i++) {
            sb.append(String.format("%02x",salt[i]));
        }
        return sb.toString();
    }
	
	
}
