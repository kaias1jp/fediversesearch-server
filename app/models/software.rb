class Software < ApplicationRecord
  has_many :sites
  
  def self.search(search)
    search ? where('name LIKE ?', "%#{search}%") : all
  end
end
