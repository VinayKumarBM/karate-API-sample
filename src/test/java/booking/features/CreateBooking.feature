@createBooking
Feature: Create a Authorization token in Restful-Booker

  Background: 
    * url  baseUrl
    * def requestJSONArray = read('classpath:booking/data/json/createBookingArray.json')
	
	@createJSONArray
  Scenario Outline: To create a booking in the Restful-Booker using request from JSON Array
    Given path 'booking'
    And header Accept = 'application/json'
    * def requestBody =
    """
    {
      firstname: '#(firstname)',
      lastname: '#(lastname)',
      totalprice: #(totalprice),
      depositpaid: #(depositpaid),
      bookingdates: {
      checkin: '#(checkin)',
      checkout: '#(checkout)'
      },
      additionalneeds: '#(additionalneeds)'
      }
    """
    And request requestBody
    When method POST
    Then status 200
    And match response.bookingid == '#number'
    And match response.booking == requestBody

    Examples: 
      | requestJSONArray  |
	
	
	
  @createBookingUsingCalling
  Scenario: To create a booking in the Restful-Booker using Java and JavaScript
    Given path 'booking'
    * def randomPrice = function(){return Math.floor((Math.random() * 10000) + 1);}
    * def DateUtil = Java.type('booking.java.utils.DateUtil')
    * def Data = Java.type('booking.java.utils.RandomData')
    * def data = new Data();
    * def requestBody =
      """
      {
      firstname: '#(data.generateStringValue(5))',
      lastname: '#(data.generateStringValue(8))',
      totalprice: '#(~~randomPrice())',
      depositpaid: '#(Data.generateBooleanValue() == true)',
      bookingdates: {
      checkin: '#(DateUtil.getTodaysDate())',
      checkout: '#(DateUtil.modifyTodaysDate(1,1,1))'
      },
      additionalneeds: '#(data.generateAdditionalNeeds())'
      }
      """
    And header Accept = 'application/json'
    And request requestBody
    When method POST
    Then status 200
    And match response.bookingid == '#number'
    And assert response.booking.totalprice == requestBody.totalprice
    * def bookingid = response.bookingid    
    
  @createJSON
  Scenario Outline: To create a booking in the Restful-Booker using request from JSON
    Given path 'booking'
    * def requestBody = read('classpath:booking/data/json/createBooking.json')
    And header Accept = 'application/json'
    And request requestBody.<requestIndex>
    When method POST
    Then status 200
    And match response.bookingid == '#number'
    And match response.booking == requestBody.<requestIndex>

    Examples: 
      | requestIndex  |
      | firstrequest  |
      | secondrequest |

  @createCSV
  Scenario Outline: To create a booking present in the Restful-Booker using request from csv
    * def data = __row
    Given path 'booking'
    * def requestBody =
      """
      {
      firstname: '#(firstname)',
      lastname: '#(lastname)',
      totalprice: '#(~~totalprice)',
      depositpaid: '#(depositpaid == \'true\')',
      bookingdates: {
      checkin: '#(checkin)',
      checkout: '#(checkout)'
      },
      additionalneeds: '#(additionalneeds)'
      }
      """
    And request requestBody
    And header Accept = 'application/json'
    When method POST
    Then status 200
    And match response ==
      """
      {
      bookingid: '#number',
      booking: {
        firstname: '#string',
        lastname: '##string',
        totalprice: '#number',
        depositpaid: '#boolean',
        bookingdates: {
        checkin: '#string',
        checkout: '#string'
        },
        additionalneeds: '#string'
        }
        }
      """
    And match response.booking == requestBody

    Examples: 
      | read('classpath:booking/data/csv/createBooking.csv') |