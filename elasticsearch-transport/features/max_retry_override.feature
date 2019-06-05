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


Feature: Maximum retries per request

    Retries occur as many times as there are available nodes, whilst still respecting the request timeout settings.

# @todo: The Ruby client cannot set retries per request
#
#    Scenario: Maximum retries can be set per request
#
#        Given a cluster with 10 nodes
#        And nodes 1 to 9 are unhealthy
#        And node 10 is healthy
#        And client uses a static node connection pool seeded with 10 nodes
#        And client pings are disabled
#
#        When the client makes an API call with 2 request retries
#        Then an API request is made to node 1
#        And an unhealthy API response is received from node 1
#        And node 1 is removed from the connection pool
#        And an API request is made to node 2
#        And an unhealthy API response is received from node 2
#        And node 2 is removed from the connection pool
#        And an API request is made to node 3
#        And an unhealthy API response is received from node 3
#        And node 3 is removed from the connection pool
#        And the client indicates maximum retries reached

    Scenario: Maximum retries can be set globally

        Given a cluster with 10 nodes
        # @todo Move the following line to here
        And client retries requests 5 times
        And nodes 1 to 9 are unhealthy
        And node 10 is healthy
        And client uses a static node connection pool seeded with 10 nodes
        And client pings are disabled

        When the client makes an API call
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

# @todo: The Ruby client connection pool has the same size as the number of nodes in the cluster
#
#    Scenario: Single node connection pools do not utilise retry settings
#
#        Given a cluster with 10 nodes
#        And all nodes are unhealthy
#        And client uses a single node connection pool seeded with 10 nodes
#        And client pings are disabled
#        And client retries requests 10 times
#
#        When the client makes an API call
#        Then an API request is made to node 1
#        And an unhealthy API response is received from node 1
#        And node 1 is removed from the connection pool
#        And the client indicates all nodes failed
