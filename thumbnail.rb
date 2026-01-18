require "fileutils"
require "pathname"

widths = [1024, 512, 256]

# Everything is in the context of the `published` directory
input_directory = "published"

output_directory = "tmp/thumbnails"
FileUtils.mkdir_p(output_directory)

Dir[File.join(input_directory, "*")].each do |post_directory|
  Dir[File.join(post_directory, "*.{jpg,jpeg,JPG,JPEG}")].each do |input|
    # Copy original
    path = Pathname(input.delete_prefix(input_directory)).sub_ext(".jpg").to_s
    output = File.join(output_directory, path)
    unless File.exist?(output)
      FileUtils.cp(input, output)
    end

    widths.each do |width|
      # Construct output path. Specifying `jpg` as the extension will cause them to be converted while resizing.
      path = Pathname(input.delete_prefix(input_directory)).sub_ext("-#{width}.jpg").to_s
      output = File.join(output_directory, path)

      # Skip if it already exists
      next if File.exist?(output)

      # Make sure the source is on disk
      unless File.exist?(input)
        puts "error: #{input} is missing"
        next
      end

      # Resize so the longest edge is <= `dimension` and remove orientation
      command = %(./resize.swift "#{input}" "#{output}" #{width})
      log = `#{command}`
      unless $?.success?
        puts "Failed to thumbnail #{output}:"
        puts log
      end

      puts path
    end
  end
end
