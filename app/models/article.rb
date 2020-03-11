class Article < ApplicationRecord
  belongs_to :author
  belongs_to :co_author, class_name: 'Author', optional: true
end
