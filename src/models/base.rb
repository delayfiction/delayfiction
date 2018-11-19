require 'yaml'
require 'redcarpet'

class Base
  attr_reader :id, :content

  def self.set_source_dir(src)
    @@source_dir = src
  end

  def self.set_host(host)
    @@host = host
  end

  def self.set_dest_dir(dest)
    @@dest_dir = dest
  end

  def self.source_dir
    @@source_dir
  end

  def self.dest_dir
    @@dest_dir
  end

  def host
    @@host
  end

  def asset_loc
    @@host + '/assets'
  end

  def art
    '/' + id + '.png'
  end

  def title
    metadata['title'] || 'delay fiction'
  end

  def opener
    metadata['opener'] || 'craft en route'
  end

  def self.all(directory)
    Dir.entries(directory).map do |filename|
      self.new(File.join(directory,filename)) if filename[-3..-1] == '.md'
    end.compact
  end

  def self.find(filename)
    begin
      self.new(filename)
    rescue Errno::ENOENT => e
      nil
    end
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
end

