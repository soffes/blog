# Resize a folder of images to a maximum size.
#
# Basically, it just runs the following command on a folder:
#
#     $ magick INPUT -resize "2048x2048>" -auto-orient OUTPUT
#
# Dependencies:
#     $ brew install imagemagick

require "pathname"

unless (input_directory = ARGV[0]) && (output_directory = ARGV[1])
  puts "Usage: ruby convert.rb INPUT_DIRECTORY OUTPUT_DIRECTORY"
  exit 1
end

DIMENSION = 2048

# Loop through all files in input directory. This assumes they are all images.
Dir[File.expand_path(File.join(input_directory, "*"))].each do |input|
  # Construct output path. Specifying `jpg` as the extension will cause them to be converted while resizing.
  output = File.expand_path(File.join(output_directory, Pathname(input).sub_ext(".jpg").basename.to_s))

  # Skip if it already exists
  next if File.exist?(output)

  # Resize so the longest edge is <= `DIMENSION` and remove orientation
  `magick #{input} -resize "#{DIMENSION}x#{DIMENSION}>" -auto-orient #{output}`
  puts File.basename(output)
end
