@auth
Feature: Create a Authorization token in Restful-Booker

	Background:
	* url baseUrl
	
  @createToken
  Scenario Outline: To create a Authorization token
    Given path 'auth'
    #And header Accept = 'application/json'
    And request {username: '<userName>', password: '<password>'}
   	When method POST
   	Then status <statusCode>
   	And match response == <responseBody>
#   	* def token = response.token
#   	And print 'token:-->'+ token
   
   Examples:
		|userName	|password			|statusCode	|responseBody									|		
		|admin		|password123	|200				|{token: "#notnull"}					|
		|admin		|password321	|200				|{reason: "Bad credentials"}	|