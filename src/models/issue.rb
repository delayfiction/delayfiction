require_relative 'base.rb'
require_relative 'post.rb'
require 'erb'

class Issue < Base
  attr_reader :data

  def html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(@content)
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

  def month
    id[-2..-1]
  end

  def next_issue_month
    case month
    when '02'
      '05'
    when '05'
      '08'
    when '08'
      '11'
    when '11'
      '12'
    else
      nil
    end
  end

  def prev_issue_month
    case month
    when '05'
      '02'
    when '08'
      '05'
    when '11'
      '08'
    when '12'
      '11'
    else
      nil
    end
  end

  def next_entry
    Issue.find(File.join(@@source_dir, 'data', 'issues', ('2018-' + next_issue_month + '.md')))
  end

  def prev_entry
    Issue.find(File.join(@@source_dir, 'data', 'issues', ('2018-' + prev_issue_month + '.md')))
  end

  def next_entry_slug
    '2018-' + next_issue_month + '.html'
  end

  def prev_entry_slug
    '2018-' + prev_issue_month + '.html'
  end

  def stories
    Post.all(File.join(@@source_dir, 'data', 'posts', (id + '/'))).sort_by! { |story| story.issue_order }
  end

  def render(name)
    @issue = self
    template = File.read(File.join(@@source_dir, "templates", (name + '.html.erb')))
    ERB.new(template).result(binding)
  end
end
