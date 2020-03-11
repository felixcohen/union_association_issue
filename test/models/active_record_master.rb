# frozen_string_literal: true

require "bundler/inline"

gemfile(true) do
  source "https://rubygems.org"

  git_source(:github) { |repo| "https://github.com/#{repo}.git" }

  gem "rails", github: "rails/rails"
  gem "sqlite3"
end

require "active_record"
require "minitest/autorun"
require "logger"

# This connection will do for database-independent bug reports.
ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Schema.define do
  create_table :authors, force: true do |t|
    t.string :name
  end

  create_table :articles, force: true do |t|
    t.integer :author_id
    t.integer :co_author_id
  end
end

class Author < ActiveRecord::Base
  has_many :articles
  has_many :co_authored_articles, class_name: 'Article', foreign_key: :co_author_id
end

class Article < ActiveRecord::Base
  belongs_to :author
  belongs_to :co_author, class_name: 'Author', optional: true
end

class BugTest < Minitest::Test
  def test_association_stuff
    author_1 = Author.create!(name: "author_1")
    author_2 = Author.create!(name: "author_2")
    article_1 = Article.create!(author: author_1, co_author: author_2)
    article_2 = Article.create!(author: author_2, co_author: author_1)
    # author_1_articles = author_1.articles.or(author_1.co_authored_articles)
    # author_1_names = author_1_articles.map { |article| article.author.name }

    # assert_equal author_1_names, ["author_1","author_1"]

    # author_1_articles.each { |article| article.reload }
    # author_1_names = author_1_articles.map { |article| article.author.name }

    # assert_equal author_1_names, ["author_1","author_2"]  
  end
end