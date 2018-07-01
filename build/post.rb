require 'redcarpet'
require 'yaml'
require 'erb'
require 'ostruct'

class Post
  attr_reader :content, :data

  def initialize(filename)
    @_data = File.read(filename)
    @content = @_data.gsub(/\A---(.|\n)*?---/, '')
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

  def issue_dir
    Dir.pwd + "/" + issue + "/"
  end

#  def post_meta
#    OpenStruct.new({:author => metadata['author'], :title => title, :tag => metadata['tag'], :html => html})
#  end

  def author
    metadata['author']
  end

  def tag
    metadata['tag']
  end

  def render(template)
    @post = self
    ERB.new(template).result(binding)
  end
end
