# Licensed to Elasticsearch B.V under one or more agreements.
# Elasticsearch B.V licenses this file to you under the Apache 2.0 License.
# See the LICENSE file in the project root for more information

Feature: Maximum retries per request
#  @todo: Ruby client doesn't have the ability to set maximum retries per request. It's a client setting.
#
#  Retries occur as many times as there are available nodes, whilst still respecting the request timeout settings.
#
#  Scenario: Maximum retries can be set per request
#
#		# Cluster configuration
#    Given a cluster with 10 nodes
#    And nodes 1 to 9 are unhealthy
#    And node 10 is healthy
#
#		# Client configuration
#    Given client configuration specifies 10 nodes
#    And pings are disabled
#
#    When the client is created
#    And client makes an API call with 2 request retries
#
#    Then an API request is made to node 1
#    And an unhealthy API response is received from node 1
#    And node 1 is removed from the connection pool
#    And an API request is made to node 2
#    And an unhealthy API response is received from node 2
#    And node 2 is removed from the connection pool
#    And an API request is made to node 3
#    And an unhealthy API response is received from node 3
#    And node 3 is removed from the connection pool
#    And the client indicates maximum retries reached

  Scenario: Maximum retries can be set globally

		# Cluster configuration
    Given a cluster with 10 nodes
    And nodes 1 to 9 are unhealthy
    And node 10 is healthy

		# Client configuration
    Given client configuration specifies 10 nodes
    And pings are disabled
    And 5 maximum retries

    When the client is created
    And client makes an API call

    Then an API request is made to node 1
    And an unhealthy API response is received from node 1
    And node 1 is removed from the connection pool
    And an API request is made to node 2
    And an unhealthy API response is received from node 2
    And node 2 is removed from the connection pool
    And an API request is made to node 3
    And an unhealthy API response is received from node 3
    And node 3 is removed from the connection pool
    And an API request is made to node 4
    And an unhealthy API response is received from node 4
    And node 4 is removed from the connection pool
    And an API request is made to node 5
    And an unhealthy API response is received from node 5
    And node 5 is removed from the connection pool
    And an API request is made to node 6
    And an unhealthy API response is received from node 6
    And node 6 is removed from the connection pool
    And the client indicates maximum retries reached

  Scenario: Single node connection pools do not utilise retry settings
  # @todo: The Ruby client connection pool has the same size as the number of nodes in the cluster so this fails.

		# Cluster configuration
    Given a cluster with 10 nodes
    And all nodes are unhealthy

		# Client configuration
    Given client configuration specifies 10 nodes
    And pings are disabled
    And 10 maximum retries

    When the client is created
    And client makes an API call

    Then an API request is made to node 1
    And an unhealthy API response is received from node 1
    And node 1 is removed from the connection pool
    And the client indicates all nodes failed