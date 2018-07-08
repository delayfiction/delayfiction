require 'redcarpet'
require 'yaml'
require 'erb'

class Static
  attr_reader :content, :data

  def initialize(filename)
    @_data = File.read(filename)
    @content = @_data.gsub(/\A---(.|\n)*?---/, '')
    @_dir = filename.to_s[-11..-4]
  end

  def html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(@content)
  end

  def metadata
    @metadata ||= YAML.load(@_data)
  end

  def title
    metadata['title'] || 'none'
  end

  def author
    metadata['author'] || 'none'
  end

  def logo
    File.read(Dir.pwd + "/build/taphandle.svg")
  end

  def render(template)
    @page = self
    ERB.new(template).result(binding)
  end
end
