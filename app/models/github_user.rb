class GithubUser
  attr_reader :handle, :url

  def initialize(attributes)
    @handle = attributes[:login]
    @url = attributes[:url]
  end
end