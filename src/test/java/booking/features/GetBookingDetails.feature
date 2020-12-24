@getBookingDetails
Feature: To get the booking details from Restful-Booker

  Background: 
    * url baseUrl

  @getBookingIds
  Scenario: To view all the booking IDs present in the Restful-Booker
    Given path 'booking'
    When method GET
    Then status 200
    Then print 'Response is:-->'+response[0].bookingid
    * def bookingID = response[0].bookingid

	@getBookingDetailsById
  Scenario Outline: To view booking details in Restful-Booker based on booking ID
    Given path 'booking',<ID>
    And header Accept = 'application/json'
    When method get
    Then status 200
    And print 'Frist Name of :-->', response.firstname, 'Last Name of :-->', response.lastname
    * def firstName = response.firstname
    * def lastName = response.lastname

		@getBookingDetailsById1
    Examples: 
      | ID |
      |  1 |
    
    @getBookingDetailsById2
    Examples: 
      | ID |
      |  2 |

  @getBookingDetailsByName
  Scenario: To view booking details in Restful-Booker based on Name
    Given path 'booking/1'
    And header Accept = 'application/json'
    When method get
    Then status 200
    Given path 'booking'
    And params {firstname: '#(response.firstname)', lastname: '#(response.lastname)'}
    When method GET
    Then status 200
    And match response == '#[]? _.length >= 1'
    And match each response contains {bookingid: '#number'}

  @getBookingDetailsByCheckInDates
  Scenario: To view booking details in Restful-Booker based on checkin dates
    Given path 'booking'
    And param checkin = '2020-01-01'
    And param checkout = '2021-12-12'
    When method GET
    Then status 200
    And match response == '#[]? _.length >= 1'
    And match each response contains {bookingid: '#number'}
    
  @getBookingDetailsUsingFeature
  Scenario: To view booking details in Restful-Booker based on Name using other feature
    * def bookingID = call read('GetBookingDetails.feature@getBookingDetailsById1')
    Given path 'booking'
    And params {firstname: '#(bookingID.firstName)', lastname: '#(bookingID.lastName)'}
    When method GET
    Then status 200
    And match response == '#[]? _.length >= 1'
    And match each response contains {bookingid: '#number'}