@ignore
Feature: Create a Authorization token in Restful-Booker

	Background:
	* url baseUrl
	
  Scenario: To create a Authorization token
    Given path 'auth'
    #And header Accept = 'application/json'
    And request {username: '#(userName)', password: '#(password)'}
   	When method POST
   	Then status 200
   	And match response == {token: "#notnull"}
   	* def token = response.token
   	And print 'token:-->'+ token