/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package es.energy.models;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 *
 * @author migue
 */
public class Utils {

    public static String md5(String input) {
        if (input == null) {
            throw new IllegalArgumentException("El valor de entrada no puede ser null");
        }
        
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(input.getBytes()); // Aquí ya no lanzará excepción de null
            StringBuilder hexString = new StringBuilder();

            for (byte b : messageDigest) {
                hexString.append(String.format("%02x", b));
            }

            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("No se pudo generar el hash MD5", e);
        }
    }
}

