# Chart Style Extractor Skill

A skill for extracting visual styles from scientific chart screenshots and generating ggplot2 code templates.

## Directory Structure

```
chart-style-extractor/
├── SKILL.md                    # Skill definition and workflow
├── README.md                   # This file
├── scripts/                    # R scripts for color extraction & orchestration
│   ├── analyze_chart.R         # Main orchestrator (entry point)
│   ├── extract_colors.R        # K-means color extraction from images
│   └── generate_preview.R      # Preview chart generation
├── references/                 # Reference materials
│   └── ggplot2-patterns.md    # Common ggplot2 style patterns
└── assets/                     # Templates and resources
    └── template.R              # R template for generated code
```

## Usage

1. Upload a scientific chart image
2. Ask to "extract style from this figure"
3. The skill will analyze the chart and generate ggplot2 code

## Generated Files

When a chart is analyzed, the skill produces:
- `theme.R` - Custom ggplot2 theme
- `colors.R` - Color palette
- `example.R` - Working example with mock data
- `README.md` - Documentation

## References

- `references/ggplot2-patterns.md` - Common style patterns for Nature, Science, PLOS, JAMA journals
- `assets/template.R` - Base template for generated code
