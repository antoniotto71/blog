class Article < ApplicationRecord
  validates :title, :body, presence: true
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :comments

  scope :published, -> { where.not(published_at: nil ) }
  scope :draft, -> { where(published_at: nil) }
  scope :recent, -> { published.where('published_at > ?', 2.weeks.ago.to_date) } #correction from book
  scope :where_title, -> (term) { where('title LIKE ?', "%#{term}%")}
  def long_title
    "#{title} - #{published_at}"
  end
  def published?
    published_at.present?
  end
end
