class Article < ApplicationRecord

  #validations
  validates :title, presence: true, length: { maximum: 40 }
  validates :content, presence: true
  validates :author, presence: true
  validates :category, presence: true
  validates :published_at, presence: true
  #scope for order in desc
  scope :published_at_desc, ->{ order(published_at: :desc)}

  def public_attributes
    {'id': id,
    'title': title,
    'content':content,
    'author':author,
    'category':category,
    'published_at': published_at
   }
  end
end
