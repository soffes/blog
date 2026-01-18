#!/usr/bin/env swift

import Foundation
import CoreImage
import ImageIO
import CoreGraphics
import UniformTypeIdentifiers

// Extension for private API option
extension CIImageRepresentationOption {
    static var hdrGainMapImage: Self {
        .init(rawValue: "kCIImageRepresentationHDRGainMapImage")
    }
}

func resizeHDRImageWithCoreImage(inputPath: String, outputPath: String, maxSize: Int) -> Bool {
    let inputURL = URL(fileURLWithPath: inputPath)
    let outputURL = URL(fileURLWithPath: outputPath)

    // Load the SDR version
    guard let sdrImage = CIImage(contentsOf: inputURL, options: [.applyOrientationProperty: true]) else {
        print("Error: Could not create CIImage")
        return false
    }

    let width = Int(sdrImage.extent.width)
    let height = Int(sdrImage.extent.height)

    // Calculate new dimensions
    let scale = min(Double(maxSize) / Double(width), Double(maxSize) / Double(height), 1.0)

    // If image is already smaller or equal, just copy it
    if scale >= 1.0 {
        print("Image is already \(width)x\(height), no resize needed")
        do {
            try FileManager.default.copyItem(at: inputURL, to: outputURL)
            print("Copied to \(outputPath)")
            return true
        } catch {
            print("Error copying file: \(error)")
            return false
        }
    }

    let newWidth = Int(Double(width) * scale)
    let newHeight = Int(Double(height) * scale)

    print("Original: \(width)x\(height), New: \(newWidth)x\(newHeight), Scale: \(scale)")

    // Try to load the gain map (may not exist for non-HDR images)
    let gainMapImage = CIImage(contentsOf: inputURL, options: [
        .auxiliaryHDRGainMap: true,
        .applyOrientationProperty: true
    ])

    // Apply scale transform
    let scaleTransform = CGAffineTransform(scaleX: scale, y: scale)
    let scaledSDR = sdrImage.transformed(by: scaleTransform)

    // Create context
    let colorSpace = CGColorSpace(name: CGColorSpace.displayP3)!
    let context = CIContext(options: [
        .workingColorSpace: colorSpace,
        .outputColorSpace: colorSpace,
        .useSoftwareRenderer: false
    ])

    // Prepare write options
    var writeOptions: [CIImageRepresentationOption: Any] = [
        kCGImageDestinationLossyCompressionQuality as CIImageRepresentationOption: 0.95
    ]

    // Add gain map if it exists
    if let gainMapImage = gainMapImage {
        print("HDR gain map detected - preserving HDR")
        let scaledGainMap = gainMapImage.transformed(by: scaleTransform)
        writeOptions[.hdrGainMapImage] = scaledGainMap
    } else {
        print("No HDR gain map found - processing as standard image")
    }

    // Write JPEG
    do {
        try context.writeJPEGRepresentation(
            of: scaledSDR,
            to: outputURL,
            colorSpace: colorSpace,
            options: writeOptions
        )
        print("Successfully wrote image to \(outputPath)")
        return true
    } catch {
        print("Error writing image: \(error)")
        return false
    }
}

// Main
let args = CommandLine.arguments

if args.count != 4 {
    print("Usage: \(args[0]) <input.jpg> <output.jpg> <max-size>")
    print("Example: \(args[0]) input.jpg output.jpg 2048")
    exit(1)
}

let inputPath = args[1]
let outputPath = args[2]

guard let maxSize = Int(args[3]) else {
    print("Error: max-size must be an integer")
    exit(1)
}

if !FileManager.default.fileExists(atPath: inputPath) {
    print("Error: Input file does not exist: \(inputPath)")
    exit(1)
}

// Create output directory if it doesn't exist
let outputDir = (outputPath as NSString).deletingLastPathComponent
if !outputDir.isEmpty && !FileManager.default.fileExists(atPath: outputDir) {
    do {
        try FileManager.default.createDirectory(atPath: outputDir, withIntermediateDirectories: true)
    } catch {
        print("Error: Could not create output directory: \(error)")
        exit(1)
    }
}

let success = resizeHDRImageWithCoreImage(inputPath: inputPath, outputPath: outputPath, maxSize: maxSize)
exit(success ? 0 : 1)
