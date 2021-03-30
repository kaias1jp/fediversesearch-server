class Site < ApplicationRecord
  belongs_to :software
  validates :uri, uniqueness: { case_sensitive: false }
  def self.search(search)
    result1 = search ? where('uri ILIKE ? OR title ILIKE ? OR short_description ILIKE ? OR description ILIKE ? ', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%").where.not(title: nil) : all
    return result1
  end
    scope :full_text_search, -> (query) {
      where("title &@~ ? OR description &@~ ? OR uri &@~ ?", query, query, query).where.not(title: nil).where.not(title: "")
  }

end
