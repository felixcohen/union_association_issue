require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "Author attribute after or on scopes is broken without reload" do
    author = Author.find_by_name('one')
    articles = author.articles.or(author.co_authored_articles)
    author_names = articles.map { |article| article.author.name }
    assert_equal(["one", "one"], author_names)
  end

  test "Author attributes after or on scopes is correct with reload" do
    author = Author.find_by_name('one')
    articles = author.articles.or(author.co_authored_articles)
    articles.each { |article| article.reload }
    author_names = articles.map { |article| article.author.name }
    assert_equal(["two", "one"], author_names)
  end
end
