class Repo
  attr_reader :name,
              :url
  def initialize(attributes)
    @name = attributes[:name]
    @url = attributes[:url]
  end
end
