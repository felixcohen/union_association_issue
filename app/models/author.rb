class Author < ApplicationRecord
  has_many :articles
  has_many :co_authored_articles, class_name: 'Article', foreign_key: :co_author_id
end
