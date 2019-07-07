class GithubUser
  attr_reader :handle,
              :url
  def initialize(attributes)
    @handle = attributes[:login]
    # TO DO: fix on master!
    @url = attributes[:html_url]
  end

  def our_user?
    User.where(github_handle: @handle).any?
  end
end 
