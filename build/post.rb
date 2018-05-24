require 'redcarpet'

class Post
  attr_reader :content

  def initialize(filename)
    @content = File.read(filename).gsub(/\A---(.|\n)*?---/, '')
  end

  def html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(@content)
  end
end
