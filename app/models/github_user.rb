class GithubUser
  attr_reader :handle,
              :url
  def initialize(attributes)
    @handle = attributes[:login]
    @url = attributes[:url]
  end

  def could_be_a_friend?
    User.find_by(github_handle: @handle) != nil
  end
end
