require 'redcarpet'
require 'yaml'
require 'erb'

class Issue
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

  def directory
    Dir.pwd + @_dir + "/"
  end
end
