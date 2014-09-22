require 'httparty'

class BuildBox
  include HTTParty
  base_uri 'https://api.buildbox.io'

  def initialize(account=nil, key=nil)
    @account ||= ENV['BUILDBOX_ACCOUNT']
    @key ||= ENV['BUILDBOX_API_KEY']
    raise "Missing Buildbox API key" unless @key
    raise "Missing Buildbox account" unless @account
  end

  def fetch_branch_builds(project, branch)
    self.class.get("/v1/accounts/#{@account}/projects/#{project}/builds?branch=#{branch}&api_key=#{@key}")
  end

  def check_connection
    self.class.get("/v1/user?api_key=#{@key}")
  end

end