# Licensed to Elasticsearch B.V. under one or more contributor
# license agreements. See the NOTICE file distributed with
# this work for additional information regarding copyright
# ownership. Elasticsearch B.V. licenses this file to you under
# the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#	http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

# @todo: Is it necessary to have the timeouts so high?
# @todo: The Ruby client doesn't have a per-request timeout option
#Feature: Request timeout overrides
#
#  Specify a ping timeout or request time out globally, or override per request.
#
#  Scenario: Overriding the request timeout on a per request basis.
#
#    Given a cluster with 10 nodes
#    And nodes 1 to 9 are unhealthy and respond to requests after 10 seconds
#    And node 10 is healthy
#    And client uses a static node connection pool seeded with 10 nodes
#    And client pings are disabled
#    And client requests timeout after 20 seconds
#
#    When the client makes an API call
#    Then an API request is made to node 1
#    And an unhealthy API response is received from node 1
#    And node 1 is removed from the connection pool
#    And an API request is made to node 2
#    And an unhealthy API response is received from node 2
#    And node 2 is removed from the connection pool
#    And the client indicates maximum timeout reached
#
#    When the client makes an API call with request timeout set to 80 seconds
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

# @todo: The Ruby client doesn't have a per-request timeout option
#  Scenario: Overriding ping timeouts on a per request basis.
#
#    Given a cluster with 10 nodes
#    And all nodes respond to pings after 20 seconds
#    And client pings timeout after 10 seconds
#    And client uses a static node connection pool seeded with 10 nodes
#
#    When the client makes an API call
#    Then a ping request is made to node 1
#    And ping request timeout for node 1 is reached
#    And the client indicates maximum timeout reached
#
#    When the client makes another API call with ping timeout set to 2 seconds
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
