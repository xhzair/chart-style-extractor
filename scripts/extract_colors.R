#!/usr/bin/env Rscript
# extract_colors.R — Extract dominant colors from an image using K-means clustering
# Usage: Rscript extract_colors.R <image_path> <n_colors> <output_json>
#
# Dependencies: imager, jsonlite

suppressPackageStartupMessages({
  library(imager)
  library(jsonlite)
})

args <- commandArgs(trailingOnly = TRUE)

if (length(args) < 3) {
  cat("Usage: Rscript extract_colors.R <image_path> <n_colors> <output_json>\n")
  cat("  image_path:  path to image file (png, jpg, etc.)\n")
  cat("  n_colors:    number of dominant colors to extract (default 4)\n")
  cat("  output_json: path to write color JSON output\n")
  quit(status = 1)
}

image_path <- args[1]
n_colors   <- as.integer(args[2])
output_json <- args[3]

if (!file.exists(image_path)) {
  stop("Image not found: ", image_path)
}

extract_colors <- function(image_path, n_colors = 4) {
  img <- load.image(image_path)

  if (dim(img)[3] < 3) {
    stop("Image must have at least 3 color channels (RGB).")
  }

  r <- as.numeric(img[, , 1, 1])
  g <- as.numeric(img[, , 1, 2])
  b <- as.numeric(img[, , 1, 3])

  # Remove near-white and near-black pixels to focus on chart colors
  brightness <- (r + g + b) / 3
  saturation <- apply(cbind(r, g, b), 1, max) - apply(cbind(r, g, b), 1, min)
  keep <- brightness > 0.05 & brightness < 0.97 & saturation > 0.05

  if (sum(keep) < n_colors * 10) {
    # Fall back to all pixels if filtering removes too many
    keep <- rep(TRUE, length(r))
  }

  rgb_matrix <- cbind(r[keep], g[keep], b[keep])

  set.seed(42)
  km <- kmeans(rgb_matrix, centers = min(n_colors, nrow(rgb_matrix)), nstart = 10, iter.max = 50)

  centers <- km$centers
  sizes <- km$size

  # Order by cluster size (largest first)
  ord <- order(sizes, decreasing = TRUE)
  centers <- centers[ord, ]
  sizes <- sizes[ord]

  # Convert to hex
  hex_colors <- sprintf("#%02X%02X%02X",
                        round(centers[, 1] * 255),
                        round(centers[, 2] * 255),
                        round(centers[, 3] * 255))

  list(
    hex      = hex_colors,
    rgb      = lapply(seq_len(nrow(centers)), function(i) {
      list(r = round(centers[i, 1] * 255),
           g = round(centers[i, 2] * 255),
           b = round(centers[i, 3] * 255))
    }),
    sizes    = as.integer(sizes),
    n_total  = as.integer(sum(sizes)),
    n_image  = as.integer(dim(img)[1] * dim(img)[2])
  )
}

result <- extract_colors(image_path, n_colors)
write_json(result, output_json, auto_unbox = TRUE, pretty = TRUE)
cat("Colors extracted -> ", output_json, "\n")
cat("Dominant colors:", paste(result$hex, collapse = ", "), "\n")
