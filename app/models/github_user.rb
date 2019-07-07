class GithubUser
  attr_reader :handle,
              :url
  def initialize(attributes)
    @handle = attributes[:login]
    @url = attributes[:url]
  end

  def our_user?
    User.where(github_handle: @handle).any?
  end
end 
