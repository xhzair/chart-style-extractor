---
name: chart-style-extractor
description: "Extract visual styles from scientific chart screenshots and generate ggplot2 code templates. Use when user uploads a chart image and wants to replicate its style, or asks to extract colors/fonts/layout from a figure."
---

# Chart Style Extractor

## When to Use

- User uploads a scientific chart screenshot/image
- User asks to "extract style from this figure"
- User wants to replicate a chart's look in ggplot2/matplotlib
- User mentions "match this style" or "similar to this paper"
- User has Excel charts they want to convert to R/Python
- User has Visio/draw.io diagrams they want to replicate

## Supported Input Formats

### Images (Primary)
- PNG, JPG, JPEG, TIFF, BMP, SVG
- Screenshots from papers, websites, presentations

### Excel Charts
- .xlsx, .xls files with embedded charts
- Extract chart type, data, colors, styles
- Convert to ggplot2/matplotlib code

### Visio Files
- .vsd, .vsdx files
- Extract diagram structure and styles
- Convert to ggplot2 (for data charts) or SVG

### Draw.io Files
- .drawio, .xml files
- Extract diagram structure
- Convert to ggplot2 (for data charts) or SVG

## Workflow

1. **Upload File**: User provides chart image, Excel, Visio, or draw.io file
2. **Detect Format**: Identify input type and extract data/styles
3. **AI Vision Analysis**: Use current AI's vision capabilities to analyze the chart
4. **Extract Style**: Identify chart type, colors, fonts, layout, theme
5. **Generate Code**: Create both R (ggplot2) and Python (matplotlib/seaborn) versions
6. **Apply to Data**: Help user apply extracted style to their own data
7. **Output**: Save code templates + customization guide + preview image

## Format-Specific Handling

### For Images (PNG, JPG, etc.)
- Use AI vision to analyze directly
- Extract colors via k-means or AI analysis
- Identify chart type, fonts, layout

### For Excel Files (.xlsx, .xls)
```r
# R approach
library(readxl)
library(ggplot2)

# Read Excel file
wb <- load_workbook("chart.xlsx")

# Extract chart data (if available)
# Or read data ranges directly
df <- read_excel("chart.xlsx", sheet = "Sheet1")

# Generate ggplot2 code from data
ggplot(df, aes(x = col1, y = col2)) + geom_col()
```

```python
# Python approach
import openpyxl
import pandas as pd

# Load workbook
wb = openpyxl.load_workbook("chart.xlsx")

# Extract chart data
for sheet in wb.sheetnames:
    ws = wb[sheet]
    # Read data range
    data = ws.values
```

### For Visio Files (.vsd, .vsdx)
```r
# R approach - convert to image first
library(rvest)
library(xml2)

# Visio files are XML-based
# Extract shapes and connections
# Convert to SVG or image for AI analysis
```

```python
# Python approach
import zipfile
import xml.etree.ElementTree as ET

# Visio files are ZIP archives with XML
with zipfile.ZipFile("diagram.vsdx", 'r') as z:
    with z.open("visio/vlm1.xml") as f:
        tree = ET.parse(f)
        root = tree.getroot()
        # Extract shapes and styles
```

### For Draw.io Files (.drawio, .xml)
```r
# R approach - parse XML
library(xml2)

# Draw.io files are XML
doc <- read_xml("diagram.drawio")
shapes <- xml_find_all(doc, "//mxGraphModel/root/mxCell")
```

```python
# Python approach
import xml.etree.ElementTree as ET

# Parse draw.io XML
tree = ET.parse("diagram.drawio")
root = tree.getroot()
shapes = root.findall(".//mxCell")
```

## Apply to User's Data

After extracting style, offer to apply it to the user's data:

### Step 1: Get User's Data

```r
# Ask user to provide data file
df <- read.csv("user_data.csv")

# Show data summary
cat("Columns:", paste(names(df), collapse = ", "), "\n")
cat("Rows:", nrow(df), "\n")
head(df)
```

### Step 2: Map Variables

Help user map their data to the chart:

```r
# Ask user which columns to use
# X axis: [user selects column]
# Y axis: [user selects column]
# Color/Group: [user selects column] (optional)
```

### Step 3: Generate Customized Code

```r
# Apply extracted style to user's data
library(ggplot2)
source("theme_extracted.R")
source("colors_extracted.R")

# User's data
df <- read.csv("user_data.csv")

# Generate plot with user's data + extracted style
ggplot(df, aes(x = user_x_col, y = user_y_col, color = user_group_col)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "loess", se = FALSE) +
  theme_extracted +
  scale_color_extracted
```

## When to Suggest Other Skills

After basic style application, suggest advanced skills if:

| Need | Suggest |
|------|---------|
| Multi-panel figures | `nature-figure` skill |
| Statistical annotations | `nature-figure` skill |
| Complex layouts | `nature-figure` skill |
| Journal-specific formatting | `nature-figure` skill |

**Don't suggest unless user asks for advanced features.**

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
- **Legend labels must be descriptive** (e.g., "Treatment", "Control") not numbered ("Color 1", "Color 2")

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

Based on AI analysis, generate both R and Python code:

### R Version (ggplot2)

See R output format below.

### Python Version (matplotlib/seaborn)

```python
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd
import numpy as np

# Set style
plt.rcParams.update({
    'font.family': 'sans-serif',
    'font.sans-serif': ['Arial', 'Helvetica'],
    'font.size': 10,
    'axes.linewidth': 0.5,
    'axes.grid': False
})

# Colors
colors = ['#E07A5F', '#81B29A']

# Create figure
fig, ax = plt.subplots(figsize=(10, 6))

# Plot data
ax.plot(x, y, color=colors[0], marker='o', label='Group 1')

# Customize
ax.set_xlabel('X Label', fontsize=11)
ax.set_ylabel('Y Label', fontsize=11)
ax.legend()
plt.tight_layout()
plt.savefig('chart.png', dpi=300, bbox_inches='tight')
plt.savefig('chart.pdf', bbox_inches='tight')
```

## Output Format

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

### README.md
- Source image description
- Extracted style summary (colors, fonts, theme)
- File structure overview
- Quick start instructions

### theme.R
```r
# Extracted theme from [source description]
library(ggplot2)

theme_extracted <- theme_classic(base_size = 8) +
  theme(
    axis.line = element_line(linewidth = 0.35, colour = "black"),
    axis.ticks = element_line(linewidth = 0.35, colour = "black"),
    axis.title = element_text(size = 7),
    axis.text = element_text(size = 6, color = "black"),
    panel.grid = element_blank(),
    legend.position = "none"
  )
```

### colors.R
```r
# Extracted color palette from [source description]
colors_extracted <- c("Natural Language" = "#E07A5F", "Code Grounding" = "#81B29A")

scale_fill_extracted <- scale_fill_manual(values = colors_extracted)
scale_color_extracted <- scale_color_manual(values = colors_extracted)
```

### example.R
```r
# R example with ggplot2
library(ggplot2)
source("theme.R")
source("colors.R")

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

### example.py
```python
# Python example with matplotlib
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

# Colors
colors = ['#E07A5F', '#81B29A']

# Mock data
np.random.seed(42)
df = pd.DataFrame({
    'x': np.random.randn(100),
    'y': np.random.randn(100),
    'group': np.tile(['A', 'B'], 50)
})

# Plot
fig, ax = plt.subplots(figsize=(10, 6))
for i, group in enumerate(['A', 'B']):
    subset = df[df['group'] == group]
    ax.scatter(subset['x'], subset['y'], c=colors[i], label=group, alpha=0.6, s=40)

ax.set_xlabel('X Label')
ax.set_ylabel('Y Label')
ax.legend()
plt.tight_layout()
plt.savefig('chart.png', dpi=300, bbox_inches='tight')
```

### CUSTOMIZATION.md
- How to change input data
- How to modify colors
- How to change grouping variables
- How to adjust font sizes
- How to modify layout
- R and Python specific instructions
