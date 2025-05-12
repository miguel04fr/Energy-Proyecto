package es.energy.converters;

import java.sql.Time;

import org.apache.commons.beanutils.Converter;

public class TimeConverter implements Converter {
    @Override
    public Object convert(Class type, Object value) {
        if (value == null) {
            return null;
        }
        
        if (value instanceof Time) {
            return value;
        }
        
        if (value instanceof String) {
            String timeStr = (String) value;
            // Si la cadena ya tiene el formato correcto HH:mm:ss, usarla directamente
            if (timeStr.matches("\\d{2}:\\d{2}:\\d{2}")) {
                return Time.valueOf(timeStr);
            }
            // Si tiene formato HH:mm, añadir :00
            if (timeStr.matches("\\d{2}:\\d{2}")) {
                return Time.valueOf(timeStr + ":00");
            }
        }
        
        return null;
    }
} 