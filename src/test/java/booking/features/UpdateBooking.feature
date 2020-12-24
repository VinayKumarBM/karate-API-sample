@updateBooking
Feature: Update booking details in Restful-Booker

  Background: 
    * url baseUrl
    * def signIn = call read('classpath:booking/features/reuse/GetToken.feature') { userName: '#(appId)', password: '#(appSecret)' }
    * def authToken = signIn.token

  @fullUpdateJSON
  Scenario Outline: To update a booking present in the Restful-Booker using request from JSON
    Given path 'booking',<ID>
    * def requestBody = read('classpath:booking/data/json/updateBooking.json')
    And request requestBody.<requestIndex>
    And header Accept = 'application/json'
    And header Cookie = 'token='+authToken
    When method PUT
    Then status 200
    And match response == requestBody.<requestIndex>

    Examples: 
      | ID | requestIndex  |
      |  1 | firstrequest  |
      |  2 | secondrequest |

  @fullUpdateCSV
  Scenario Outline: To update a booking present in the Restful-Booker using request from CSV
    * def data = __row
    Given path 'booking','<ID>'
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
    And header Cookie = 'token='+authToken
    When method PUT
    Then status 200
    And match response ==
      """
      {
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
      """
		And match response == requestBody
    Examples: 
      | read('classpath:booking/data/csv/updateBooking.csv') |

  @partialUpdate
  Scenario Outline: To partially update a booking present in the Restful-Booker
    Given path 'booking',<ID>
    And request { firstname: '<firstName>', lastname: '<lastName>'}
    And header Accept = 'application/json'
    And header Cookie = 'token='+authToken
    When method PATCH
    Then status 200
    And match response.firstname == '<firstName>'
    And match response.lastname == '<lastName>'

    Examples: 
      | ID | firstName | lastName |
      |  1 | Didier    | Drogba   |
