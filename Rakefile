# frozen_string_literal: true

EDITOR = 'atom'

desc 'Create a new post'
task :new do
  # Get title
  unless (title = ARGV[1].to_s) && !title.empty?
    abort "\nUsage:\n\n    $ rake new 'My Great Title'\n\n"
  end

  # Get date
  date = Time.now.strftime('%Y-%m-%d')

  # Calculate slug
  slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')

  # Check slug
  Dir['published/*'].each do |published|
    if published.sub(%r{^published/\d{4}-\d{2}-\d{2}-}, '') == slug
      abort "\nError: '#{slug}' is already in use.\n\nPick a different title.\n\n"
    end
  end

  # Create directory
  dir = "published/#{date}-#{slug}"
  system "mkdir #{dir}"

  # Create markdown file
  path = "#{dir}/#{slug}.markdown"
  File.open(path, 'w') do |f|
    f.write("# #{title}\n\n")
  end

  # Open in editor
  _open path
end

desc 'Edit the most recent post'
task :recent do
  _open Dir['published/**/*.markdown'].last
end

desc 'Publish the blog posts'
task :publish do
  # For me only :P
  system 'git push'
  system 'heroku run "rake import" --app soffes-blog'
end

namespace :lint do
  desc 'Lint Markdown'
  task :markdown do
    system 'bundle exec mdl -i .'
  end

  desc 'Lint Ruby'
  task :ruby do
    system 'bundle exec rubocop --parallel --config .rubocop.yml'
  end

  desc 'Lint YAML'
  task :yaml do
    if `which yamllint`.chomp.empty?
      abort 'yamllint is not installed. Install it with `pip3 install yamllint`.'
    end

    system 'yamllint -c .yamllint.yml .'
  end
end

desc 'Run all linters'
task lint: %i[lint:markdown lint:ruby lint:yaml]

private

def _open(path)
  editor = `which #{EDITOR}`.empty? ? '$EDITOR' : EDITOR
  system "#{editor} '#{File.expand_path(path)}'"
end
