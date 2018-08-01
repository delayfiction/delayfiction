require 'redcarpet'
require 'yaml'
require 'erb'
require 'ostruct'

class Post
  attr_reader :content, :data

  def self.all(directory)
    Dir.entries(directory).map do |filename|
      self.new(File.join(directory,filename)) if filename[-3..-1] == '.md'
    end.compact
  end

  def initialize(filename)
    @_data = File.read(filename)
    @content = @_data.gsub(/\A---(.|\n)*?---/, '')
    @_filename = filename
  end

  def id
    @_filename.gsub(/.+\//, '')[0...-3]
  end

  def html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(@content)
  end

  def metadata
    @metadata ||= YAML.load(@_data)
  end

  def issue
    metadata['issue']
  end

  def title
    metadata['title']
  end

  def has_title?
    metadata.has_key? 'title'
  end

  def has_author?
    metadata.has_key? 'author'
  end

  def issue_dir
    Dir.pwd + "/" + issue + "/"
  end

  def author
    metadata['author']
  end

  def tag
    metadata['tag']
  end

  def logo
    File.read(Dir.pwd + "/build/taphandle.svg")
  end

  def render(template)
    @post = self
    ERB.new(template).result(binding)
  end
end
