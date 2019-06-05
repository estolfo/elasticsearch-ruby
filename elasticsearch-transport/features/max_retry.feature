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

Feature: First usage

  By default, a client will retry a request as many times as there are known nodes in the cluster.

  Retries will respect the request timeout; for example, if you have a 100 node cluster and a request timeout of 20 seconds, the client will retry as many times as it can within 20 seconds.

  Scenario: Retry for every known node in the cluster, the client will automatically fail over to each node for a single API call.

    Given a cluster with 5 nodes
    And nodes 1 to 4 are unhealthy
    And node 5 is healthy
    And client uses a static node connection pool seeded with 5 nodes
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
    And a healthy API response is received from node 5