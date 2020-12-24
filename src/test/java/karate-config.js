function fn() {
	var env = karate.env; // get java system property 'karate.env'
	karate.log('karate.env system property was:', env);
	if (!env) {
		env = 'dev'; // a custom 'intelligent' default
	}
	var config = { // base config JSON
		appId: 'admin',
		appSecret: 'password123',
		baseUrl: 'https://restful-booker.herokuapp.com',
	//	token: 'null',
	};
	if (env == 'stage') {
		// over-ride only those that need to be
		config.baseUrl = 'https://stage-host/v1/auth';
	} else if (env == 'e2e') {
		config.baseUrl = 'https://e2e-host/v1/auth';
	};
	/*
	var credentials = { userName: config.appId, password: config.appSecret };
	var result = karate.callSingle('classpath:booking/features/reuse/GetToken.feature', credentials);
	config.token = result.token;
	*/
	// don't waste time waiting for a connection or if servers don't respond within 5 seconds
	karate.configure('connectTimeout', 5000);
	karate.configure('readTimeout', 5000);
	karate.configure('logPrettyRequest', true);
	karate.configure('logPrettyResponse', true);
	karate.configure('report', { showLog: true, showAllSteps: false });
	karate.configure('responseHeaders', { 'Content-Type': 'application/json', Accept: 'application/json' });
	return config;
}