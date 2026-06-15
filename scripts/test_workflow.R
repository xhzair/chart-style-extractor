#!/usr/bin/env Rscript
# test_workflow.R — End-to-end test for chart style extraction workflow
# Creates a test chart, runs analyze_chart.R, and verifies outputs

suppressPackageStartupMessages({
  library(ggplot2)
  library(jsonlite)
})

cat("========================================\n")
cat("Chart Style Extractor — End-to-End Test\n")
cat("========================================\n\n")

# Setup directories
test_dir <- file.path(tempdir(), "chart_test_e2e")
dir.create(test_dir, recursive = TRUE, showWarnings = FALSE)
output_dir <- file.path(test_dir, "output")
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
test_image <- file.path(test_dir, "test_chart.png")

# Find analyze_chart.R relative to this script
cmd <- commandArgs(trailingOnly = FALSE)
file_arg <- grep("^--file=", cmd, value = TRUE)
script_dir <- if (length(file_arg) > 0) {
  dirname(normalizePath(sub("^--file=", "", file_arg[1])))
} else {
  getwd()
}
analyze_script <- file.path(script_dir, "analyze_chart.R")

cat("Test image:", test_image, "\n")
cat("Output dir:", output_dir, "\n\n")

# Step 1: Create test chart with known colors
cat("Step 1: Creating test chart with known colors...\n")
known_colors <- c("#FF0000", "#00FF00", "#0000FF", "#FFFF00")

set.seed(123)
df <- data.frame(
  x = rep(1:4, each = 10),
  y = rnorm(40, mean = rep(c(10, 20, 15, 25), each = 10), sd = 2),
  group = factor(rep(c("A", "B", "C", "D"), each = 10))
)

p <- ggplot(df, aes(x = factor(x), y = y, fill = group)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.7) +
  scale_fill_manual(values = known_colors) +
  theme_bw() +
  labs(title = "Test Chart", x = "Category", y = "Value", fill = "Group")

ggsave(test_image, plot = p, width = 8, height = 5, dpi = 100)
cat("  Created:", test_image, "\n\n")

# Step 2: Run analyze_chart.R
cat("Step 2: Running analyze_chart.R...\n")

run_cmd <- paste("Rscript", shQuote(analyze_script),
                 shQuote(test_image), shQuote(output_dir), "4", "bar")
result <- system(run_cmd, intern = TRUE)
cat(paste(result, collapse = "\n"), "\n\n")

# Step 3: Verify output files exist
cat("Step 3: Verifying output files exist...\n")
expected_files <- c("theme.R", "colors.R", "example.R", "README.md", "colors.json")
all_pass <- TRUE

for (f in expected_files) {
  path <- file.path(output_dir, f)
  exists <- file.exists(path)
  status <- if (exists) "OK" else "MISSING"
  cat(sprintf("  %-15s %s\n", f, status))
  if (!exists) all_pass <- FALSE
}
cat("\n")

# Step 4: Verify colors extracted correctly
cat("Step 4: Verifying extracted colors...\n")
colors_json_path <- file.path(output_dir, "colors.json")
if (file.exists(colors_json_path)) {
  extracted <- read_json(colors_json_path)
  extracted_hex <- toupper(extracted$hex)
  known_upper <- toupper(known_colors)

  cat("  Extracted:", paste(extracted_hex, collapse = ", "), "\n")
  cat("  Expected: ", paste(known_upper, collapse = ", "), "\n")

  match_count <- sum(extracted_hex %in% known_upper)
  if (match_count >= 2) {
    cat("  Color match: PASS (", match_count, "of", length(known_upper), "known colors found)\n")
  } else {
    cat("  Color match: FAIL (only", match_count, "of", length(known_upper), "known colors found)\n")
    all_pass <- FALSE
  }
} else {
  cat("  FAIL: colors.json not found\n")
  all_pass <- FALSE
}
cat("\n")

# Step 5: Verify R syntax of generated files
cat("Step 5: Verifying R file syntax...\n")
for (f in c("theme.R", "colors.R", "example.R")) {
  path <- file.path(output_dir, f)
  if (file.exists(path)) {
    parse_result <- tryCatch(parse(file = path), error = function(e) NULL)
    status <- if (!is.null(parse_result)) "VALID" else "SYNTAX ERROR"
    cat(sprintf("  %-15s %s\n", f, status))
    if (is.null(parse_result)) all_pass <- FALSE
  }
}
cat("\n")

# Cleanup
unlink(test_dir, recursive = TRUE)

# Summary
cat("========================================\n")
if (all_pass) {
  cat("TEST RESULT: PASS\n")
  quit(status = 0)
} else {
  cat("TEST RESULT: FAIL\n")
  quit(status = 1)
}
cat("========================================\n")
