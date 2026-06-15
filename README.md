# chart-style-extractor

Extract visual styles from scientific chart screenshots and generate ggplot2 code templates.

## What it does

Upload a scientific chart image → AI analyzes the style → generates reusable ggplot2 code.

## Features

- **Color Extraction**: K-means clustering to extract dominant colors from charts
- **Style Analysis**: Identify chart type, fonts, layout patterns
- **Code Generation**: Generate ggplot2 theme + scale functions
- **Preview**: Create example charts with mock data
- **Journal Templates**: Nature, Science, APA, JAMA styles

## Installation

```bash
npx skills add xhzair/chart-style-extractor
```

## Usage

1. Upload a chart screenshot
2. AI analyzes the visual style
3. Get ggplot2 code template:

```r
# Extracted theme
theme_extracted <- theme_classic(base_size = 8) +
  theme(
    axis.line = element_line(linewidth = 0.35, colour = "black"),
    axis.ticks = element_line(linewidth = 0.35, colour = "black"),
    panel.grid = element_blank()
  )

# Extracted colors
colors_extracted <- c("#5B9BD5", "#E74C3C")
scale_fill_extracted <- scale_fill_manual(values = colors_extracted)
```

## File Structure

```
chart-style-extractor/
├── SKILL.md                    # Skill instructions
├── scripts/
│   ├── extract_colors.R        # Color extraction (k-means)
│   ├── generate_preview.R      # Preview generation
│   └── analyze_chart.R         # Main orchestrator
├── references/
│   └── ggplot2-patterns.md     # Style patterns reference
└── assets/
    └── template.R              # Code template
```

## Example

Input: Partial residual plot from a psychology paper

Output:
- Blue (#5B9BD5) and Red (#E74C3C) color palette
- Classic theme with serif fonts
- Scatter plot with loess smoothing
- Ready-to-use ggplot2 code

## Requirements

- R with ggplot2, imager packages
- AI with vision capabilities (Claude, GPT-4V, etc.)

## License

MIT
