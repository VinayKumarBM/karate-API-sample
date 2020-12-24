@deleteBooking
Feature: Delete the booking details in Restful-Booker

  Background: 
    * url  baseUrl
    * def credentials = read('classpath:booking/data/json/credentials.json')
    * def login = read('classpath:booking/features/reuse/GetToken.feature')
    * def signIn = call login credentials
    * def authToken = signIn.token
    * def pause = read('classpath:booking/js/utils/DelayUtil.js');

	@createAndDeleteBooking
	Scenario: Create a booking in Restful-Booker and delete it
		* def booking = call read('classpath:booking/features/CreateBooking.feature@createBookingUsingCalling')
		* call pause(2)
		Given path 'booking',booking.bookingid
    And header Accept = 'application/json'
    And header Cookie = 'token='+authToken
    When method DELETE
    Then status 201
    And match response == 'Created'

	@deleteBookingByID
	@parallel=false
  Scenario Outline: To delete a booking present in the Restful-Booker
    Given path 'booking',<ID>
    And header Accept = 'application/json'
    And header Cookie = 'token='+authToken
    * if (<statusCode> == 201) karate.call('classpath:booking/js/utils/DelayUtil.js', 10)
    When method DELETE
    Then status <statusCode>
    And match response == '<message>'
    * def msg = <statusCode> == 201 ? 'Booking was deleted' : 'There was no booking to delete'
    * print msg

    Examples: 
      | ID |statusCode|message						|
      |  1 |201				|Created						|
      |111 |405				|Method Not Allowed	|