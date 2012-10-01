require 'spec_helper'

describe 'Builds' do
  before { Scenario.default }

  let(:repo)    { Repository.by_slug('svenfuchs/minimal').first }
  let(:build)   { repo.builds.first }
  let(:headers) { { 'HTTP_ACCEPT' => 'application/vnd.travis-ci.1+json' } }

  it 'GET /builds?repository_id=1' do
    response = get '/builds', { repository_id: repo.id }, headers
    response.should deliver_json_for(repo.builds.was_started, version: 'v1')
  end

  it 'GET /builds/1' do
    response = get "/builds/#{build.id}", {}, headers
    response.should deliver_json_for(build, version: 'v1')
  end

  it 'GET /builds/1?repository_id=1' do
    response = get "/builds/#{build.id}", { repository_id: repo.id }, headers
    response.should deliver_json_for(build, version: 'v1')
  end

  xit 'GET /svenfuchs/minimal/builds' do
    response = get '/svenfuchs/minimal/builds', {}, headers
    response.should deliver_json_for(repo.builds, version: 'v1')
  end

  xit 'GET /svenfuchs/minimal/builds/1' do
    response = get "/svenfuchs/minimal/builds/#{build.id}", {}, headers
    response.should deliver_json_for(build, version: 'v1')
  end
end
