# Resize a folder of images to a maximum size.
#
# Basically, it just runs the following command on a folder:
#
#     $ magick INPUT -resize "2048x2048>" -auto-orient OUTPUT
#
# Dependencies:
#     $ brew install imagemagick

require "pathname"

INPUT_DIRECTORY = "~/Desktop/2024"
OUTPUT_DIRECTORY = "~/Developer/soffes/blog/drafts/2024-12-31-2024"
DIMENSION = 2048

# Loop through all files in input directory. This assumes they are all images.
Dir[File.expand_path(File.join(INPUT_DIRECTORY, "*"))].each do |input|
  # Construct output path. Specifying `jpg` as the extension will cause them to be converted while resizing.
  output = File.expand_path(File.join(OUTPUT_DIRECTORY, Pathname(input).sub_ext(".jpg").basename.to_s))

  # Skip if it already exists
  next if File.exist?(output)

  # Resize so the longest edge is <= `DIMENSION` and remove orientation
  `magick #{input} -resize "#{DIMENSION}x#{DIMENSION}>" -auto-orient #{output}`
end
