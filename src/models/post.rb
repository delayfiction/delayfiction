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

  def this_issue
    issue_id = metadata['issue']
    Issue.find(File.join(@@source_dir, 'data', 'issues', (issue_id + '.md')))
  end

  def next_entry
    next_post_ordinal = issue_order
    next_entry = this_issue.stories[next_post_ordinal]
  end

  def prev_entry
    prev_post_ordinal = issue_order - 2
    if prev_post_ordinal >= 0
      prev_entry = this_issue.stories[prev_post_ordinal]
    end
  end

  def next_entry_slug
    this_issue.id + '/' + next_entry.id + '.html'
  end

  def prev_entry_slug
    this_issue.id + '/' + prev_entry.id + '.html'
  end

  def render(name)
    @post = self
    template = File.read(File.join(@@source_dir, "templates", (name + '.html.erb')))
    ERB.new(template).result(binding)
  end
end
