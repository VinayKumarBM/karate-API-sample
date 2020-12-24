package booking.java.utils;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {

	private static final DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

	public static String modifyTodaysDate(int days, int months, int years) {
		Date currentDate = new Date();

        // convert date to calendar
        Calendar c = Calendar.getInstance();
        c.setTime(currentDate);

        // manipulate date
        c.add(Calendar.YEAR, days);
        c.add(Calendar.MONTH, months);
        c.add(Calendar.DATE, years); 

        // convert calendar to date
        Date currentDatePlusOne = c.getTime();
        return dateFormat.format(currentDatePlusOne);
	}

	public static String getTodaysDate() {
		Date currentDate = new Date();
		return dateFormat.format(currentDate);
	}
}
