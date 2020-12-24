package booking.java.utils;

import java.util.Random;

import org.apache.commons.lang3.RandomUtils;

public class RandomData {

	private Random random = new Random();
	
	public static boolean generateBooleanValue() {
		boolean value = RandomUtils.nextBoolean();
		System.out.println(value);
		return value;
	}

	public String generateStringValue(int lenght) {
		String values = "abcdefghijklmnopqrstuvwxyz";
		StringBuffer randomString = new StringBuffer();		
		randomString.append(values.toUpperCase().charAt(random.nextInt(26)));
		for (int i = 1; i < lenght; i++) {
			randomString.append(values.charAt(random.nextInt(26)));
		}
		return randomString.toString();
	}
	
	public String generateAdditionalNeeds() {
		String []additionalNeeds = {"Dinner", "Lunch", "Breakfast", "Supper", "Snacks", "High Tea"};
		return additionalNeeds[random.nextInt(additionalNeeds.length)];
	}

}
