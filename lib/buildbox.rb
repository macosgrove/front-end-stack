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

  def fetch_branch_builds(branch)

  end

  def check_connection
    response = self.class.get("v1/user?api_key=#{@key}")
    response.body
  end

end