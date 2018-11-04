require_relative 'base.rb'
require_relative 'post.rb'
require_relative 'issue.rb'
require 'erb'

class Volume < Base
  attr_reader :data

  def html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(@content)
  end

  def author
    'none'
  end

  def title
    'literally magazine'
  end

  def issues
    Issue.all(File.join(@@source_dir, 'data', 'issues/')).reverse
  end

  def render(name)
    @volume = self
    template = File.read(File.join(@@source_dir, "templates", (name + '.html.erb')))
    ERB.new(template).result(binding)
  end
end
