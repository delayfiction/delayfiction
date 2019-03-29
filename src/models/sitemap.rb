require 'rubygems'
require 'sitemap_generator'
require_relative 'issue.rb'
require_relative 'post.rb'

Base.set_source_dir(File.join(Dir.pwd, 'src'))

SitemapGenerator::Sitemap.default_host = 'https://delayfiction.org'
SitemapGenerator::Sitemap.public_path = 'docs/'
SitemapGenerator::Sitemap.create do
    add '/', :changefreq => 'monthly', :priority => 0.9
    add '/submit', :changefreq => 'monthly'
    add '/about', :changefreq => 'monthly'
    add '/subscribe', :changefreq => 'monthly'
    Issue.all(File.join(Dir.pwd, 'src', 'data', 'issues')).each do |issue|
      issue_url = '/' + issue.id
      add issue_url, :changefreq => 'monthly'

      issue.stories.each do |story|
        story_url = File.join issue_url, story.id
        add story_url, :changefreq => 'monthly'
      end
    end
end
SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks,
