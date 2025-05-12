/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package es.energy.models;

import org.apache.commons.beanutils.ConversionException;
import org.apache.commons.beanutils.Converter;

/**
 *
 * @author migue
 */

/**
 *
 * @author jesus
 */
public class EnumConverter implements Converter {

 @Override
    public Object convert(Class type, Object o) {
        if (o instanceof String) {
            try {
                return Enum.valueOf(type, ((String) o).toUpperCase());
            } catch (IllegalArgumentException e) {
                throw new ConversionException("Invalid value for enum: " + o);
            }
        }
        return null;
    }

    
}