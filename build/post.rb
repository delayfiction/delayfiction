require 'redcarpet'
require 'yaml'
require 'erb'

class Post
  attr_reader :content, :data

  def initialize(filename)
    @_data = File.read(filename)
    @content = @_data.gsub(/\A---(.|\n)*?---/, '')
    @template = File.read(Dir.pwd + "/build/show-post.html.erb")
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

  def renderer
    @post = self
    ERB.new(@template).result(binding)
  end
end
