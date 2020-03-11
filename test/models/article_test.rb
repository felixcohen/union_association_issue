require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "Author attributes after or on scopes is broken" do
    author = Author.find_by_name('one')
    articles = author.articles.or(author.co_authored_articles)
    author_names = articles.map { |article| article.author.name }
    assert_equal(["one", "one"], author_names)
  end
end
