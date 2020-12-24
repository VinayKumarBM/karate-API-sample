function pause(sec) {
			karate.log("Pausing the test execution for ", sec, " seconds");
			java.lang.Thread.sleep(sec * 1000);
		//	return true;
}