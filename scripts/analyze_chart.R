#!/usr/bin/env Rscript
# analyze_chart.R — Main orchestrator for chart style extraction
# Usage: Rscript analyze_chart.R <image_path> <output_dir> [n_colors] [chart_type]
#
# Workflow:
#   1. extract_colors.R -> dominant color palette
#   2. Generate theme.R   (ggplot2 theme template for AI to customize)
#   3. Generate colors.R  (extracted color palette)
#   4. Generate example.R (working example with mock data)
#   5. Generate README.md (documentation)
#
# The theme.R template contains TODO markers for AI-driven customization.
# AI agents should read the image, fill in the theme details, and
# re-write theme.R before the user runs example.R.

suppressPackageStartupMessages({
  library(jsonlite)
})

args <- commandArgs(trailingOnly = TRUE)

if (length(args) < 2) {
  cat("Usage: Rscript analyze_chart.R <image_path> <output_dir> [n_colors] [chart_type]\n")
  cat("  image_path:  path to chart image\n")
  cat("  output_dir:  directory to write extracted files\n")
  cat("  n_colors:    number of colors to extract (default 4)\n")
  cat("  chart_type:  bar | line | scatter | box (default: bar)\n")
  quit(status = 1)
}

image_path <- normalizePath(args[1], mustWork = TRUE)
output_dir <- normalizePath(args[2], mustWork = FALSE)
n_colors   <- if (length(args) >= 3) as.integer(args[3]) else 4L
chart_type <- if (length(args) >= 4) args[4] else "bar"

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

# --- Locate sibling scripts ---------------------------------------------------

script_dir <- dirname(sys.frame(1)$ofile %||% {
  # Fallback when sourced interactively
  cmd <- commandArgs(trailingOnly = FALSE)
  file_arg <- grep("^--file=", cmd, value = TRUE)
  if (length(file_arg) > 0) {
    dirname(normalizePath(sub("^--file=", "", file_arg[1])))
  } else {
    getwd()
  }
})

if (!exists("%||%", mode = "function")) {
  `%||%` <- function(x, y) if (is.null(x)) y else x
}

extract_script <- file.path(script_dir, "extract_colors.R")
preview_script <- file.path(script_dir, "generate_preview.R")

if (!file.exists(extract_script)) {
  stop("extract_colors.R not found at: ", extract_script)
}

# --- Step 1: Extract colors ---------------------------------------------------

colors_json <- file.path(output_dir, "colors.json")

cat("=== Step 1: Extracting colors ===\n")
system2("Rscript", c(extract_script, shQuote(image_path), n_colors, shQuote(colors_json)))

if (!file.exists(colors_json)) {
  stop("Color extraction failed — colors.json not created.")
}

colors_data <- read_json(colors_json)
hex_colors <- colors_data$hex

cat("  Extracted:", paste(hex_colors, collapse = ", "), "\n")

# --- Step 2: Write colors.R --------------------------------------------------

cat("=== Step 2: Writing colors.R ===\n")

colors_r <- file.path(output_dir, "colors.R")

colors_lines <- c(
  "# colors.R — Extracted color palette",
  sprintf("# Source image: %s", basename(image_path)),
  sprintf("# Extracted at: %s", Sys.time()),
  "",
  sprintf("colors_extracted <- c(%s)", paste(sprintf('"%s"', hex_colors), collapse = ", ")),
  "",
  "scale_fill_extracted   <- scale_fill_manual(values = colors_extracted)",
  "scale_color_extracted  <- scale_color_manual(values = colors_extracted)",
  "",
  "cat(\"Colors loaded:\", paste(colors_extracted, collapse = \", \"), \"\\n\")"
)

writeLines(colors_lines, colors_r)
cat("  -> ", colors_r, "\n")

# --- Step 3: Write theme.R (template for AI) ---------------------------------

cat("=== Step 3: Writing theme.R (template) ===\n")

theme_r <- file.path(output_dir, "theme.R")

# Base theme heuristic: academic charts typically use theme_bw or theme_classic
base_theme <- "theme_bw"

theme_lines <- c(
  "# theme.R — ggplot2 theme extracted from chart style",
  sprintf("# Source image: %s", basename(image_path)),
  sprintf("# Generated: %s", Sys.time()),
  "# NOTE: This is a template. An AI agent should customize the",
  "#       element_* calls based on visual inspection of the source image.",
  "",
  "library(ggplot2)",
  "",
  "theme_extracted <- theme_bw(base_size = 10) +",
  "  theme(",
  "    # === AI TODO: Adjust font family based on source chart ===",
  "    text = element_text(family = \"sans\"),",
  "",
  "    # === AI TODO: Adjust title size/weight from source ===",
  "    plot.title = element_text(size = 12, face = \"bold\", hjust = 0),",
  "    plot.subtitle = element_text(size = 10, color = \"grey40\"),",
  "",
  "    # === AI TODO: Adjust axis label sizes from source ===",
  "    axis.title = element_text(size = 10),",
  "    axis.text  = element_text(size = 8),",
  "",
  "    # === AI TODO: Match grid lines (color, linewidth, presence) ===",
  "    panel.grid.major = element_line(color = \"grey90\", linewidth = 0.2),",
  "    panel.grid.minor = element_blank(),",
  "    panel.background = element_rect(fill = \"white\", color = NA),",
  "    panel.border = element_rect(color = \"black\", fill = NA, linewidth = 0.5),",
  "",
  "    # === AI TODO: Match axis lines ===",
  "    axis.line  = element_line(color = \"black\", linewidth = 0.3),",
  "    axis.ticks = element_line(color = \"black\", linewidth = 0.3),",
  "",
  "    # === AI TODO: Match legend position/style ===",
  "    legend.position = \"top\",",
  "    legend.title = element_text(size = 9),",
  "    legend.text  = element_text(size = 8),",
  "",
  "    # === AI TODO: Match strip (facet) styling ===",
  "    strip.background = element_rect(fill = \"grey95\"),",
  "    strip.text = element_text(size = 9, face = \"bold\")",
  "  )"
)

writeLines(theme_lines, theme_r)
cat("  -> ", theme_r, "\n")

# --- Step 4: Write example.R -------------------------------------------------

cat("=== Step 4: Writing example.R ===\n")

example_r <- file.path(output_dir, "example.R")

example_lines <- c(
  "# example.R — Working example using extracted chart style",
  sprintf("# Source image: %s", basename(image_path)),
  sprintf("# Chart type: %s", chart_type),
  "",
  "library(ggplot2)",
  "source(\"colors.R\")",
  "source(\"theme.R\")",
  "",
  "# --- Mock data ---------------------------------------------------------------",
  "set.seed(42)"
)

if (chart_type == "bar") {
  example_lines <- c(example_lines,
    "df <- data.frame(",
    "  treatment = factor(rep(c(\"Control\", \"Low\", \"Medium\", \"High\"), each = 5),",
    "                     levels = c(\"Control\", \"Low\", \"Medium\", \"High\")),",
    "  value = rnorm(20, mean = rep(c(10, 14, 18, 22), each = 5), sd = 3),",
    "  group = rep(c(\"Group A\", \"Group B\"), times = 10)",
    ")",
    "",
    "p <- ggplot(df, aes(x = treatment, y = value, fill = group)) +",
    "  geom_col(position = position_dodge(width = 0.8), width = 0.7) +",
    "  scale_fill_extracted +",
    "  theme_extracted +",
    "  labs(title = \"Extracted Style Demo\", x = \"Treatment\", y = \"Value\", fill = \"Group\")"
  )
} else if (chart_type == "line") {
  example_lines <- c(example_lines,
    "time <- 1:10",
    "df <- data.frame(",
    "  time = rep(time, 2),",
    "  value = c(cumsum(rnorm(10, 0, 2)) + 20, cumsum(rnorm(10, 0, 2)) + 25),",
    "  condition = factor(rep(c(\"Control\", \"Treatment\"), each = 10))",
    ")",
    "",
    "p <- ggplot(df, aes(x = time, y = value, color = condition)) +",
    "  geom_line(linewidth = 1) +",
    "  geom_point(size = 2.5) +",
    "  scale_color_extracted +",
    "  theme_extracted +",
    "  labs(title = \"Extracted Style Demo\", x = \"Time\", y = \"Value\", color = \"Condition\")"
  )
} else if (chart_type == "scatter") {
  example_lines <- c(example_lines,
    "n <- 50",
    "df <- data.frame(",
    "  x = rnorm(n, 5, 2),",
    "  group = rep(c(\"Group A\", \"Group B\", \"Group C\"), length.out = n)",
    ")",
    "df$y <- df$x * 1.5 + rnorm(n, 0, 3) + ifelse(df$group == \"Group B\", 5, 0)",
    "",
    "p <- ggplot(df, aes(x = x, y = y, color = group)) +",
    "  geom_point(size = 2.5, alpha = 0.8) +",
    "  geom_smooth(method = \"lm\", se = FALSE, linewidth = 0.6) +",
    "  scale_color_extracted +",
    "  theme_extracted +",
    "  labs(title = \"Extracted Style Demo\", x = \"X\", y = \"Y\", color = \"Group\")"
  )
} else {
  example_lines <- c(example_lines,
    "df <- data.frame(",
    "  category = rep(c(\"A\", \"B\", \"C\"), each = 10),",
    "  value = rnorm(30, mean = rep(c(10, 15, 20), each = 10), sd = 3)",
    ")",
    "",
    "p <- ggplot(df, aes(x = category, y = value, fill = category)) +",
    "  geom_boxplot() +",
    "  scale_fill_extracted +",
    "  theme_extracted +",
    "  labs(title = \"Extracted Style Demo\", x = \"Category\", y = \"Value\")"
  )
}

example_lines <- c(example_lines,
  "",
  "print(p)",
  "",
  "output_path <- \"example_preview.png\"",
  "ggsave(output_path, p, width = 8, height = 5, dpi = 300)",
  "cat(\"Preview saved:\", output_path, \"\\n\")"
)

writeLines(example_lines, example_r)
cat("  -> ", example_r, "\n")

# --- Step 5: Write README.md -------------------------------------------------

cat("=== Step 5: Writing README.md ===\n")

readme <- file.path(output_dir, "README.md")

readme_lines <- c(
  sprintf("# Chart Style: %s", tools::file_path_sans_ext(basename(image_path))),
  "",
  "## Source",
  sprintf("- **Image:** `%s`", basename(image_path)),
  sprintf("- **Colors extracted:** %d", n_colors),
  sprintf("- **Chart type detected:** %s", chart_type),
  sprintf("- **Generated:** %s", Sys.time()),
  "",
  "## Extracted Colors",
  "",
  "| Index | Hex | RGB |",
  "|-------|-----|-----|"
)

for (i in seq_along(hex_colors)) {
  rgb <- colors_data$rgb[[i]]
  readme_lines <- c(readme_lines,
    sprintf("| %d | `%s` | rgb(%d, %d, %d) |",
            i, hex_colors[i], rgb$r, rgb$g, rgb$b))
}

readme_lines <- c(readme_lines,
  "",
  "## Files",
  "",
  "| File | Description |",
  "|------|-------------|",
  "| `theme.R` | ggplot2 theme (AI-customized template) |",
  "| `colors.R` | Color palette and scale functions |",
  "| `example.R` | Working example with mock data |",
  "| `colors.json` | Raw extracted color data |",
  "| `README.md` | This file |",
  "",
  "## Usage",
  "",
  "```r",
  "setwd(\"<output_dir>\")",
  "source(\"example.R\")",
  "```",
  "",
  "Or customize `theme.R` and `colors.R` before running.",
  "",
  "## Customization Tips",
  "",
  "1. **Font family**: Change `family = \"sans\"` in theme.R to match the source",
  "2. **Grid lines**: Adjust `panel.grid.major` color and linewidth",
  "3. **Legend position**: Change `legend.position` to \"right\", \"bottom\", or \"none\"",
  "4. **Add more colors**: Extend the `colors_extracted` vector in colors.R",
  "5. **Base theme**: Swap `theme_bw()` for `theme_classic()`, `theme_minimal()`, etc."
)

writeLines(readme_lines, readme)
cat("  -> ", readme, "\n")

# --- Step 6: Optional preview generation --------------------------------------

if (file.exists(preview_script)) {
  cat("=== Step 6: Generating preview ===\n")
  preview_out <- file.path(output_dir, "preview.png")
  system2("Rscript", c(preview_script,
                       shQuote(theme_r),
                       shQuote(colors_r),
                       chart_type,
                       shQuote(preview_out)))
  if (file.exists(preview_out)) {
    cat("  -> ", preview_out, "\n")
  }
}

# --- Summary -----------------------------------------------------------------

cat("\n========================================\n")
cat("Analysis complete!\n")
cat("Output directory: ", output_dir, "\n")
cat("Files created:\n")
for (f in list.files(output_dir, full.names = FALSE)) {
  cat("  - ", f, "\n")
}
cat("========================================\n")
