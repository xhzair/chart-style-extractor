# Customization Guide

This guide explains how to modify the generated code to fit your specific needs.

## R (ggplot2) Customization

### Change Input Data

```r
# Replace mock data with your data
df <- read.csv("your_data.csv")

# Or create manually
df <- data.frame(
  x = c(1, 2, 3, 4, 5),
  y = c(10, 25, 18, 30, 22),
  group = c("A", "B", "A", "B", "A")
)
```

### Modify Colors

```r
# Change color palette
colors_extracted <- c("Your Label 1" = "#YOUR_COLOR_1",
                      "Your Label 2" = "#YOUR_COLOR_2")

# Use color picker: https://www.color-hex.com/
# Or use RColorBrewer
library(RColorBrewer)
display.brewer.all()  # See all palettes
colors <- brewer.pal(5, "Set1")
```

### Change Grouping Variable

```r
# Map different column to color/fill
ggplot(df, aes(x = x_var, y = y_var, color = your_group_column)) +
  geom_point()
```

### Adjust Font Sizes

```r
theme_extracted <- theme_classic(base_size = 12) +  # Change base size
  theme(
    axis.title = element_text(size = 10),  # Axis labels
    axis.text = element_text(size = 8),    # Tick labels
    plot.title = element_text(size = 14),  # Title
    legend.text = element_text(size = 9)   # Legend
  )
```

### Modify Layout

```r
# Change legend position
theme(legend.position = "bottom")  # or "top", "left", "right"

# Add grid lines
theme(panel.grid.major = element_line(color = "grey90"))

# Remove axis lines
theme(axis.line = element_blank())
```

### Change Chart Type

```r
# From scatter to bar
geom_col(position = "dodge")

# From bar to line
geom_line(aes(group = group)) + geom_point()

# Add error bars
geom_errorbar(aes(ymin = y - se, ymax = y + se), width = 0.2)
```

## Python (matplotlib) Customization

### Change Input Data

```python
import pandas as pd

# From CSV
df = pd.read_csv('your_data.csv')

# From lists
df = pd.DataFrame({
    'x': [1, 2, 3, 4, 5],
    'y': [10, 25, 18, 30, 22],
    'group': ['A', 'B', 'A', 'B', 'A']
})
```

### Modify Colors

```python
# Change colors
colors = ['#YOUR_COLOR_1', '#YOUR_COLOR_2']

# Use seaborn palettes
import seaborn as sns
palette = sns.color_palette("husl", 3)  # 3 colors

# Color picker: https://www.color-hex.com/
```

### Change Grouping Variable

```python
# Different column for color
for group in df['your_group_column'].unique():
    subset = df[df['your_group_column'] == group]
    ax.scatter(subset['x'], subset['y'], label=group)
```

### Adjust Font Sizes

```python
plt.rcParams.update({
    'font.size': 12,          # Base size
    'axes.labelsize': 10,     # Axis labels
    'xtick.labelsize': 8,     # X tick labels
    'ytick.labelsize': 8,     # Y tick labels
    'axes.titlesize': 14,     # Title
    'legend.fontsize': 9      # Legend
})
```

### Modify Layout

```python
# Legend position
ax.legend(loc='upper right')  # or 'lower left', 'center', etc.

# Grid lines
ax.grid(True, axis='y', alpha=0.3)

# Remove spines
ax.spines['top'].set_visible(False)
ax.spines['right'].set_visible(False)
```

### Change Chart Type

```python
# From scatter to bar
ax.bar(x, y, color=colors)

# From bar to line
ax.plot(x, y, marker='o')

# Add error bars
ax.errorbar(x, y, yerr=se, fmt='o', capsize=5)
```

## Common Tasks

### Add Statistical Annotations

**R:**
```r
library(ggpubr)
stat_compare_means(method = "t.test", comparisons = list(c("A", "B")))
```

**Python:**
```python
from scipy import stats
t_stat, p_val = stats.ttest_ind(group_a, group_b)
ax.text(0.5, 0.9, f'p = {p_val:.3f}', transform=ax.transAxes)
```

### Export High-Quality Figures

**R:**
```r
ggsave("figure.pdf", width = 7, height = 5, dpi = 300)
ggsave("figure.png", width = 7, height = 5, dpi = 600)
```

**Python:**
```python
plt.savefig('figure.pdf', dpi=300, bbox_inches='tight')
plt.savefig('figure.png', dpi=600, bbox_inches='tight')
```

### Create Multi-Panel Figures

**R:**
```r
library(patchwork)
p1 + p2 + plot_layout(ncol = 2)
```

**Python:**
```python
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 5))
# Plot on ax1 and ax2
plt.tight_layout()
```
