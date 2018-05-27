require 'redcarpet'
require 'yaml'

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

  def issue_folder
    Dir.pwd + "/" + issue + "/"
  end
end
