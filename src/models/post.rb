require_relative 'base.rb'
require 'erb'

class Post < Base
  attr_reader :data


  def has_title?
    metadata.has_key? 'title'
  end

  def has_author?
    metadata.has_key? 'author'
  end

  def issue_dir
    Dir.pwd + "/" + issue + "/"
  end

  def render(name)
    @post = self
    template = File.read(File.join(@@source_dir, "templates", (name + '.html.erb')))
    ERB.new(template).result(binding)
  end
end
