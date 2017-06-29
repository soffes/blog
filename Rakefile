EDITOR = 'subl'

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
  system "touch #{path}"

  # Open in editor
  system "#{EDITOR} #{path}"
end
