require_relative 'base.rb'
require_relative 'issue.rb'
require 'erb'

class Issues < Base
  attr_reader :data

  def html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(@content)
  end

  def author
    'none'
  end

  def title
    'issues'
  end

  def issues
    Issue.all(File.join(@@source_dir, 'data/issues'))
  end

  def render(name)
    @mag = self
    template = File.read(File.join(@@source_dir, "templates", (name + '.html.erb')))
    ERB.new(template).result(binding)
  end
end
