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

1. **Upload Image**: User provides chart screenshot (drag-drop or path)
2. **AI Vision Analysis**: Use current AI's vision capabilities to analyze the chart
3. **Extract Style**: Identify chart type, colors, fonts, layout, theme
4. **Generate Code**: Create ggplot2 theme + scale functions (with ggthemes options)
5. **Create Preview**: Generate example chart with mock data
6. **Output**: Save code template + documentation + preview image

## AI Vision Analysis (Primary Method)

**Use the AI's built-in vision capabilities** to analyze the chart image holistically.

### What to Analyze

When the user uploads a chart image, analyze and extract:

#### 1. Chart Type & Structure
- Scatter plot, bar chart, line chart, box plot, violin, heatmap, etc.
- Number of panels (facets)
- Grouping variables
- Error bars type (SE, CI, SD)

#### 2. Color Palette
- Extract 2-5 dominant colors as hex codes
- Identify: data colors, background, text, grid lines
- Map to ggplot2 scales

#### 3. Typography
- Font family (serif like Times New Roman, sans-serif like Arial, or monospace)
- Title: size, weight (bold/normal)
- Axis labels: size
- Tick labels: size

#### 4. Theme Elements
- Grid lines: none, minor, major
- Panel background: white, light gray
- Axis lines: present/absent, thickness
- Legend: position, size
- Border/panel border

#### 5. Layout
- Spacing between panels
- Margin sizes
- Overall proportions

### Analysis Output Format

Return analysis as structured data:

```json
{
  "chart_type": "scatter",
  "colors": {
    "primary": ["#5B9BD5", "#E74C3C"],
    "background": "#FFFFFF",
    "text": "#000000",
    "grid": "#E0E0E0"
  },
  "typography": {
    "font_family": "serif",
    "title_size": 12,
    "axis_label_size": 10,
    "tick_label_size": 8
  },
  "theme": {
    "base": "classic",
    "grid_lines": "none",
    "axis_lines": true,
    "legend_position": "none"
  },
  "layout": {
    "panels": 2,
    "panel_spacing": 15
  }
}
```

## Code Generation

Based on AI analysis, generate ggplot2 code with these components:

### Theme Selection

Choose base theme based on analysis:
- Clean/minimal with no grid → `theme_classic()`
- Light grid lines → `theme_bw()`
- Very minimal → `theme_minimal()`
- Economist style → `ggthemes::theme_economist()`
- Wall Street Journal → `ggthemes::theme_wsj()`
- FiveThirtyEight → `ggthemes::theme_fivethirtyeight()`
- Tufte → `ggthemes::theme_tufte()`

### Color Scales

```r
# Manual colors
scale_fill_manual(values = c("#color1", "#color2"))
scale_color_manual(values = c("#color1", "#color2"))

# Viridis (colorblind-safe)
scale_fill_viridis_d()
scale_color_viridis_d()

# Brewer palettes
scale_fill_brewer(palette = "Set1")
```

## Output Format

Generate these files:

### theme.R
```r
# Extracted theme from [source description]
library(ggplot2)

# Option 1: Custom theme
theme_extracted <- theme_classic(base_size = 8) +
  theme(
    axis.line = element_line(linewidth = 0.35, colour = "black"),
    axis.ticks = element_line(linewidth = 0.35, colour = "black"),
    axis.title = element_text(size = 7),
    axis.text = element_text(size = 6, color = "black"),
    panel.grid = element_blank(),
    legend.position = "none"
  )

# Option 2: Using ggthemes
# library(ggthemes)
# theme_extracted <- theme_economist() +
#   theme(legend.position = "none")
```

### colors.R
```r
# Extracted color palette from [source description]
colors_extracted <- c("#5B9BD5", "#E74C3C")

scale_fill_extracted <- scale_fill_manual(values = colors_extracted)
scale_color_extracted <- scale_color_manual(values = colors_extracted)
```

### example.R
```r
# Example usage with mock data
library(ggplot2)
# library(ggthemes)  # Uncomment if using ggthemes
source("theme.R")
source("colors.R")

# Mock data
df <- data.frame(
  x = rnorm(100),
  y = rnorm(100),
  group = rep(c("A", "B"), 50)
)

ggplot(df, aes(x = x, y = y, color = group)) +
  geom_point(alpha = 0.6, size = 2) +
  geom_smooth(method = "loess", se = FALSE) +
  theme_extracted +
  scale_color_extracted
```

### README.md
- Source image description
- Extracted style summary (colors, fonts, theme)
- Usage instructions
- Customization tips
- ggthemes alternatives
