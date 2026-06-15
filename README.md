# chart-style-extractor

Extract visual styles from scientific charts and generate R (ggplot2) and Python (matplotlib/seaborn) code templates.

## What it does

Upload a chart (image, Excel, Visio, or draw.io) → AI analyzes the style → generates reusable code in both R and Python.

## Features

- **Multi-format Input**: Support for images, Excel, Visio, and draw.io files
- **AI Vision Analysis**: Holistic style extraction (colors, fonts, layout, chart type)
- **Dual Language Output**: Generate both R (ggplot2) and Python (matplotlib/seaborn) code
- **Color Extraction**: K-means clustering + AI analysis
- **Journal Templates**: Nature, Science, APA, JAMA, ggthemes styles
- **Apply to Data**: Help users apply extracted style to their own data
- **Customization Guide**: Detailed instructions for modifying outputs

## Supported Input Formats

| Format | Extensions | Method |
|--------|------------|--------|
| **Images** | PNG, JPG, TIFF, BMP, SVG | AI vision analysis |
| **Excel** | .xlsx, .xls | Extract chart data and styles |
| **Visio** | .vsd, .vsdx | Parse XML for shapes and styles |
| **Draw.io** | .drawio, .xml | Parse XML for diagram structure |

## Installation

```bash
npx skills add xhzair/chart-style-extractor
```

## Usage

### Basic Workflow

1. Upload a chart (screenshot, Excel, Visio, or draw.io)
2. AI analyzes the visual style
3. Get code templates in both R and Python

### Example Output

**R (ggplot2):**
```r
library(ggplot2)

# Extracted theme
theme_extracted <- theme_classic(base_size = 8) +
  theme(
    axis.line = element_line(linewidth = 0.35, colour = "black"),
    axis.ticks = element_line(linewidth = 0.35, colour = "black"),
    panel.grid = element_blank()
  )

# Extracted colors
colors_extracted <- c("Group A" = "#5B9BD5", "Group B" = "#E74C3C")
scale_color_extracted <- scale_color_manual(values = colors_extracted)
```

**Python (matplotlib):**
```python
import matplotlib.pyplot as plt

# Colors
colors = ['#5B9BD5', '#E74C3C']

# Style settings
plt.rcParams.update({
    'font.family': 'sans-serif',
    'axes.linewidth': 0.5,
    'axes.grid': False
})
```

### Apply to Your Data

After extracting style, apply it to your own data:

```r
# Load your data
df <- read.csv("your_data.csv")

# Apply extracted style
ggplot(df, aes(x = your_x, y = your_y, color = your_group)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "loess", se = FALSE) +
  theme_extracted +
  scale_color_extracted
```

## File Structure

```
chart-style-extractor/
├── SKILL.md                        # Skill instructions
├── scripts/
│   ├── extract_colors.R            # Color extraction (k-means)
│   ├── generate_preview.R          # Preview generation
│   └── analyze_chart.R             # Main orchestrator
├── references/
│   ├── ggplot2-patterns.md         # R style patterns (879 lines)
│   ├── python-patterns.md          # Python style patterns
│   └── customization-guide.md      # How to modify outputs
└── assets/
    └── template.R                  # Code template
```

## Supported Chart Types

- Scatter plots
- Line charts
- Bar charts (grouped/stacked)
- Box plots
- Violin plots
- Heatmaps
- Multi-panel figures
- Error bar charts

## Journal Templates

- **Nature**: Classic theme, serif fonts, minimal grid
- **Science**: Black-white theme, clean lines
- **APA**: Minimal style, bottom legend
- **JAMA**: Classic with bold titles
- **ggthemes**: Economist, WSJ, FiveThirtyEight, Tufte, Stata

## Customization

See `references/customization-guide.md` for:
- Changing input data
- Modifying colors
- Adjusting font sizes
- Changing chart types
- Adding statistical annotations

## Requirements

- R with ggplot2, imager packages (for R output)
- Python with matplotlib, seaborn (for Python output)
- AI with vision capabilities (Claude, GPT-4V, etc.)

## License

MIT
