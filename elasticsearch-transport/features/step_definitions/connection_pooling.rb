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

module MaxRetryWorld
  def all_connections
    @client.transport.connections.all
  end
end

World(MaxRetryWorld)

Given("a cluster with {int} nodes") do |int|
  hosts = int.times.collect do |i|
    { host: i }
  end

  @client = Elasticsearch::Client.new(hosts: hosts, retry_on_failure: 5)
end

Given("nodes {int} to {int} are unhealthy") do |int, int2|
  (int..int2).to_a.each do |host|
    connection = double("connection-#{host}", headers: {})
    allow(connection).to receive(:run_request).and_raise(::Faraday::Error::ConnectionFailed.new(''))
    allow(all_connections[host.to_i-1]).to receive(:connection).and_return(connection)
  end
end

Given("node {int} is healthy") do |int|
  connection = double("connection-#{int}", headers: {})
  allow(connection).to receive(:run_request).and_return(
      double('response', status: 200, body: {}, headers: nil))
  allow(all_connections[int-1]).to receive(:connection).and_return(connection)
end

Given("client uses a static node connection pool seeded with {int} nodes") do |int|
end

Given("client pings are disabled") do
end

When("the client makes an API call") do
  @result = begin; @client.search; rescue; end
end

Then("an API request is made to node {int}") do |int|
end

Then("an unhealthy API response is received from node {int}") do |int|
  expect(all_connections[int-1].connection).to have_received(:run_request)
end

Then("a healthy API response is received from node {int}") do |int|
  expect(all_connections[int-1].connection).to have_received(:run_request)
end

Then("node {int} is removed from the connection pool") do |int|
  expect(all_connections[int-1].dead?).to eq(true)
end

Given("client retries requests {int} times") do |int|
  @client.transport.instance_variable_set(:@max_retries, int)
end

Then("the client indicates maximum retries reached") do
  expect(@result).to be_nil
end
