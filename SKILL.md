---
name: chart-style-extractor
description: "Extract visual styles from scientific chart screenshots and generate ggplot2 code templates. Use when user uploads a chart image and wants to replicate its style, or asks to extract colors/fonts/layout from a figure."
---

# Chart Style Extractor

## When to Use

- User uploads a scientific chart screenshot/image
- User asks to "extract style from this figure"
- User wants to replicate a chart's look in ggplot2
- User mentions "match this style" or "similar to this paper"

## Workflow

1. **Analyze Image**: User provides chart image (upload or path)
2. **Extract Style**: Identify chart type, colors, fonts, layout
3. **Generate Code**: Create ggplot2 theme + scale functions
4. **Create Preview**: Generate example chart with mock data
5. **Output**: Save code template + documentation + preview image

## AI Analysis Guidelines

When analyzing a chart image, extract:

### Chart Type
- Bar chart (grouped/stacked)
- Line chart
- Scatter plot
- Box plot
- Violin plot
- Heatmap
- Combination

### Color Palette
- Primary colors (2-4 dominant colors)
- Background color
- Text color
- Grid line color
- Map to ggplot2 scale_fill_manual / scale_color_manual

### Typography
- Font family (serif/sans-serif/monospace)
- Title size and weight
- Axis label size
- Tick label size

### Layout
- Grid lines (none/minor/major)
- Panel background
- Legend position
- Axis lines
- Spacing/padding

## Output Format

Generate these files:

### theme.R
```r
# Extracted theme from [source]
theme_extracted <- theme_[classic/bw/minimal]() +
  theme(
    # Extracted customizations
  )
```

### colors.R
```r
# Extracted color palette
colors_extracted <- c("#color1", "#color2", "#color3")
scale_fill_extracted <- scale_fill_manual(values = colors_extracted)
```

### example.R
```r
# Example usage with mock data
library(ggplot2)
source("theme.R")
source("colors.R")

# Mock data
df <- data.frame(
  x = c("A", "B", "C"),
  y = c(10, 25, 15),
  group = c("G1", "G2", "G1")
)

ggplot(df, aes(x = x, y = y, fill = group)) +
  geom_col(position = "dodge") +
  theme_extracted +
  scale_fill_extracted
```

### README.md
- Source image description
- Extracted style summary
- Usage instructions
- Customization tips
