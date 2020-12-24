package runners;

import com.intuit.karate.junit5.Karate;

class TestRunner {
	
	@Karate.Test
	Karate runScenario() {
		return Karate.run("classpath:booking/features").tags("@createCSV");
	}
}
