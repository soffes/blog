EDITOR = 'atom'

desc 'Create a new post'
task :new do
  # Get title
  ARGV.each { |a| task a.to_sym do ; end }
  unless (title = ARGV[1].to_s) && !title.empty?
    abort "\nUsage:\n\n    $ rake new 'My Great Title'\n\n"
  end

  # Get date
  date = Time.now.strftime('%Y-%m-%d')

  # Calculate slug
  slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')

  # Check slug
  Dir['published/*'].each do |published|
    if published.sub(/^published\/\d{4}-\d{2}-\d{2}-/, '') == slug
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
  open path
end

desc 'Edit the most recent post'
task :recent do
  open Dir['published/**/*.markdown'].last
end

desc 'Publish the blog posts'
task :publish do
  # For me only :P
  system 'git push'
  system 'heroku run "rake import" --app soffes-blog'
end

private

def open(path)
  editor = `which #{EDITOR}`.empty? ? '$EDITOR' : EDITOR
  system "#{editor} '#{File.expand_path(path)}'"
end
