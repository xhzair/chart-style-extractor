#!/usr/bin/env Rscript
# generate_preview.R — Generate preview charts from extracted styles
# Usage: Rscript generate_preview.R <theme_file> <colors_file> <chart_type> <output_path>

suppressPackageStartupMessages({
  library(ggplot2)
})

# --- Argument parsing --------------------------------------------------------

args <- commandArgs(trailingOnly = TRUE)

generate_preview <- function(theme_code = NULL, colors = NULL,
                             chart_type = c("bar", "line", "scatter"),
                             output_path = "preview.png",
                             source_theme_file = NULL,
                             source_colors_file = NULL,
                             width = 8, height = 5, dpi = 300) {
  chart_type <- match.arg(chart_type)

  # --- Load theme ------------------------------------------------------------
  if (!is.null(source_theme_file) && file.exists(source_theme_file)) {
    env <- new.env(parent = globalenv())
    sys.source(source_theme_file, envir = env)
    theme_obj <- get("theme_extracted", envir = env, mode = "any")
    if (is.null(theme_obj)) {
      theme_obj <- ls(env, all.names = TRUE)
      theme_obj <- theme_obj[sapply(theme_obj, function(n) inherits(get(n, envir = env), "theme"))]
      if (length(theme_obj) > 0) {
        theme_obj <- get(theme_obj[1], envir = env)
      } else {
        warning("No theme object found in ", source_theme_file, "; using fallback.")
        theme_obj <- theme_classic(base_size = 8)
      }
    }
  } else {
    theme_obj <- theme_classic(base_size = 8)
  }

  # --- Load colors -----------------------------------------------------------
  if (!is.null(source_colors_file) && file.exists(source_colors_file)) {
    env <- new.env(parent = globalenv())
    sys.source(source_colors_file, envir = env)
    colors_obj <- get("colors_extracted", envir = env, mode = "any")
    if (is.null(colors_obj)) {
      colors_obj <- c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3")
    }
  } else if (!is.null(colors) && is.character(colors)) {
    colors_obj <- colors
  } else {
    colors_obj <- c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3")
  }

  # --- Generate mock data ----------------------------------------------------
  set.seed(42)
  n <- 30

  if (chart_type == "bar") {
    groups <- c("Control", "Low", "Medium", "High")
    df <- data.frame(
      treatment = factor(rep(groups, each = 5),
                         levels = groups),
      value = rnorm(20, mean = rep(c(10, 14, 18, 22), each = 5), sd = 3),
      category = rep(c("Group A", "Group B"), times = 10)
    )
    p <- ggplot(df, aes(x = treatment, y = value, fill = category)) +
      geom_col(position = position_dodge(width = 0.8), width = 0.7) +
      scale_fill_manual(values = colors_obj) +
      labs(title = "Preview: Bar Chart", x = "Treatment", y = "Value", fill = "Category")

  } else if (chart_type == "line") {
    time <- 1:10
    conditions <- c("Control", "Treatment")
    df <- data.frame(
      time = rep(time, 2),
      value = c(cumsum(rnorm(10, 0, 2)) + 20,
                cumsum(rnorm(10, 0, 2)) + 25),
      condition = rep(factor(conditions, levels = conditions), each = 10)
    )
    p <- ggplot(df, aes(x = time, y = value, color = condition)) +
      geom_line(linewidth = 1) +
      geom_point(size = 2.5) +
      scale_color_manual(values = colors_obj) +
      labs(title = "Preview: Line Chart", x = "Time", y = "Value", color = "Condition")

  } else if (chart_type == "scatter") {
    n <- 50
    df <- data.frame(
      x = rnorm(n, 5, 2),
      group = rep(c("Group A", "Group B", "Group C"), length.out = n)
    )
    df$y <- df$x * 1.5 + rnorm(n, 0, 3) + ifelse(df$group == "Group B", 5, 0)
    p <- ggplot(df, aes(x = x, y = y, color = group)) +
      geom_point(size = 2.5, alpha = 0.8) +
      geom_smooth(method = "lm", se = FALSE, linewidth = 0.6) +
      scale_color_manual(values = colors_obj) +
      labs(title = "Preview: Scatter Plot", x = "X", y = "Y", color = "Group")
  }

  # --- Apply theme and save --------------------------------------------------
  p <- p + theme_obj

  ggsave(output_path, plot = p, width = width, height = height, dpi = dpi)
  message("Preview saved: ", output_path)
  return(invisible(p))
}

# --- CLI entry point ---------------------------------------------------------

if (sys.nframe() == 0) {
  if (length(args) < 4) {
    cat("Usage: Rscript generate_preview.R <theme_file> <colors_file> <chart_type> <output_path>\n")
    cat("  chart_type: bar | line | scatter\n")
    quit(status = 1)
  }

  theme_file <- args[1]
  colors_file <- args[2]
  chart_type <- args[3]
  output_path <- args[4]

  generate_preview(source_theme_file = theme_file,
                   source_colors_file = colors_file,
                   chart_type = chart_type,
                   output_path = output_path)
}
