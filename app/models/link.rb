class Link < ActiveRecord::Base
  belongs_to :user

  validates :target_url, presence: true
  validates :slug, presence: true

  def standardize_target_url!
  target_url.gsub!("http://", "")
  target_url.gsub!("https://", "")
  end

  def generate_slug!
    str = ""
    type = ["lowercase", "uppercase", "number"]
    7.times do
      index = rand(0..2)
      if type[index] == "lowercase"
        char = (0...1).map { ('a'..'z').to_a[rand(26)] }.join
        str = str + char
      elsif type[index] == "uppercase"
        char = (0...1).map { ('A'..'Z').to_a[rand(26)] }.join
        str = str + char
      elsif type[index] == "number"
        char = rand(0..2).to_s
        str = str + char
      end
    end
    self.slug = str
  end

end
