require 'yaml'
require 'redcarpet'

class Base
  attr_reader :id, :content

  def self.set_source_dir(src)
    @@source_dir = src
  end

  def self.source_dir
    @@source_dir
  end

  def self.set_dest_dir(dest)
    @@dest_dir = dest
  end

  def self.dest_dir
    @@dest_dir
  end

  def self.all(directory)
    Dir.entries(directory).map do |filename|
      self.new(File.join(directory,filename)) if filename[-3..-1] == '.md'
    end.compact
  end

  def initialize(filename)
    @_dir = filename
    @id = filename.gsub(/.+\//, '')[0...-3]

    @_data = File.read(filename)
    @content = @_data.gsub(/\A---(.|\n)*?---/, '')
  end

  def method_missing(name)
    metadata[name.to_s] || super
  end

  def metadata
    @metadata ||= YAML.load(@_data)
  end

  def html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(@content)
  end

  def logo
    @_logo ||= File.read(File.join(@@source_dir, 'assets', 'taphandle.svg'))
  end
end

