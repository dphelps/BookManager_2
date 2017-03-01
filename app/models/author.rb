class Author < ActiveRecord::Base
  # Relationships
  has_many :book_authors
  has_many :books, through: :book_authors
  
  # Validations
  validates :first_name, :last_name, presence: true
  
  # Scopes
  scope :alphabetical, -> { order('last_name, first_name') }
  scope :active, -> { where(active: true) }
  
  # Methods
  def name
    "#{last_name}, #{first_name}"
  end
end
