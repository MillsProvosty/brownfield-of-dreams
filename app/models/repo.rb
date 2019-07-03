class Repo
  attr_reader :name, :url

  def initialize(attributes_hash)
    @name = attributes_hash[:name]
    @url = attributes_hash[:html_url]
  end
end
