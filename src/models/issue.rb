require_relative 'base.rb'
require_relative 'post.rb'
require 'erb'

class Issue < Base
  attr_reader :data

  def html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(@content)
  end

  def author
    'none'
  end

  def has_title
    metadata.has_key? 'title'
  end

  def has_author
    metadata.has_key? 'author'
  end

  def stories
    Post.all(File.join(@@source_dir, 'data', 'posts', (id + '/')))
  end

  def render(name)
    @issue = self
    template = File.read(File.join(@@source_dir, "templates", (name + '.html.erb')))
    ERB.new(template).result(binding)
  end
end
