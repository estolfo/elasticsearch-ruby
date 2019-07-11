# Licensed to Elasticsearch B.V under one or more agreements.
# Elasticsearch B.V licenses this file to you under the Apache 2.0 License.
# See the LICENSE file in the project root for more information

# @todo: The Ruby client doesn't have a per-request timeout option
#Feature: Request timeout overrides
#
#  Specify a ping timeout or request time out globally, or override per request.
#
#  Scenario: Overriding the request timeout on a per request basis.
#
#		# Cluster configuration
#    Given a cluster with 10 nodes
#    And nodes 1 to 9 are unhealthy and respond to requests after 10 seconds
#    And node 10 is healthy
#
#		# Client configuration
#    Given client configuration specifies 10 nodes
#    And pings are disabled
#    And requests timeout after 20 seconds
#
#    When the client is created
#    And client makes an API call
#
#    Then an API request is made to node 1
#    And an unhealthy API response is received from node 1
#    And node 1 is removed from the connection pool
#    And an API request is made to node 2
#    And an unhealthy API response is received from node 2
#    And node 2 is removed from the connection pool
#    And the client indicates maximum timeout reached
#
#    When client makes an API call with request timeout set to 80 seconds
#
#    Then an API request is made to node 3
#    And an unhealthy API response is received from node 3
#    And node 3 is removed from the connection pool
#    And an API request is made to node 4
#    And an unhealthy API response is received from node 4
#    And node 4 is removed from the connection pool
#    And an API request is made to node 5
#    And an unhealthy API response is received from node 5
#    And node 5 is removed from the connection pool
#    And an API request is made to node 6
#    And an unhealthy API response is received from node 6
#    And node 6 is removed from the connection pool
#    And an API request is made to node 7
#    And an unhealthy API response is received from node 7
#    And node 7 is removed from the connection pool
#    And an API request is made to node 8
#    And an unhealthy API response is received from node 8
#    And node 8 is removed from the connection pool
#    And an API request is made to node 9
#    And an unhealthy API response is received from node 9
#    And node 9 is removed from the connection pool
#    And an API request is made to node 10
#    And a healthy API response is received from node 10
#
#  Scenario: Overriding ping timeouts on a per request basis.
#
#		# Cluster configuration
#    Given a cluster with 10 nodes
#    And all nodes respond to pings after 20 seconds
#
#		# Client configuration
#    Given client configuration specifies 10 nodes
#    And pings timeout after 10 seconds
#
#    When the client is created
#    And client makes an API call
#
#    Then a ping request is made to node 1
#    And ping request timeout for node 1 is reached
#    And the client indicates maximum timeout reached
#
#    When client makes another API call with ping timeout set to 2 seconds
#
#    Then a ping request is made to node 3
#    And ping request timeout for node 3 is reached
#    And a ping request is made to node 4
#    And ping request timeout for node 4 is reached
#    And a ping request is made to node 5
#    And ping request timeout for node 5 is reached
#    And a ping request is made to node 6
#    And ping request timeout for node 6 is reached
#    And a ping request is made to node 7
#    And ping request timeout for node 7 is reached
#    And the client indicates maximum timeout reached