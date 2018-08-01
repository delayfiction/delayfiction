require_relative 'post.rb'
require 'redcarpet'
require 'yaml'
require 'erb'

class Issue
  attr_reader :content, :data

  def initialize(filename)
    @_data = File.read(filename)
    @content = @_data.gsub(/\A---(.|\n)*?---/, '')
    @_name = filename.to_s[-11..-4]
    @_dir = filename
  end

  def html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(@content)
  end

  def metadata
    @metadata ||= YAML.load(@_data)
  end

  def directory
    Dir.pwd + @_name + "/"
  end

  def method_missing(name)
    metadata[name.to_s] || super
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

  def logo
    File.read(Dir.pwd + "/build/taphandle.svg")
  end

  def stories
    Post.all(Dir.pwd + '/src/posts/' + @_name + "/")
  end

  def render(template)
    @issue = self
    ERB.new(template).result(binding)
  end
end
