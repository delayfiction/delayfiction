require_relative 'base.rb'
require 'erb'

class Static < Base
  attr_reader :data

  def title
    metadata['title'] || 'none'
  end

  def author
    metadata['author'] || 'none'
  end

  def render(name)
    @page = self
    template = File.read File.join(@@source_dir, "templates", (name + '.html.erb'))
    ERB.new(template).result(binding)
  end
end
