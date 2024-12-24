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
  File.write(path, "# #{title}\n\n")

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
    system 'bundle exec mdl -i published'
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

  desc 'Lint posts'
  task :posts do
    require "nokogiri"
    require "redcarpet"
    require "yaml"

    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    errors = []

    # Loop through post directories
    (Dir["published/*"] + Dir["drafts/*"]).each do |directory|
      next unless File.directory?(directory)

      Dir.chdir(directory) do
        # Markdown path
        md_path = File.basename(directory).sub(/^\d{4}-\d{2}-\d{2}-(.*)$/, '\1.md')
        unless File.exist?(md_path)
          errors << "error: #{File.join(directory, md_path)} doesn't exist"
          next
        end

        # Find images in Markdown
        md = File.read(md_path)
        html = renderer.render(md)
        doc = Nokogiri::HTML(html)
        used_images = doc.css("img").map { |i| i["src"] }

        # Find front matter image
        sections = md.split("---\n")
        if sections.length >= 3
          begin
            front_matter = YAML.parse(sections[1])
            used_images << front_matter.to_ruby["cover_image"]
          rescue
            # Ignore front matter parse errors since this is a really bad way to parse front matter.
            # I should make sure the front matter is at the beginning of the document, etc.
          end
        end

        # Filter to relative images
        used_images.filter! { |u| u && u.match(/https?:\/\//) == nil }

        # Find images on disk
        disk_images = Dir["*.jpg"]

        # Add errors for unused images
        (disk_images - used_images).each do |image|
          errors << "error: #{File.join(directory, image)} is unused"
        end
      end
    end

    exit 0 if errors.empty?

    errors.each do |error|
      puts error
    end

    exit 1
  end
end

desc 'Run all linters'
task lint: %i[lint:markdown lint:ruby lint:yaml lint:posts]

private

def _open(path)
  editor = `which #{EDITOR}`.empty? ? '$EDITOR' : EDITOR
  system "#{editor} '#{File.expand_path(path)}'"
end
