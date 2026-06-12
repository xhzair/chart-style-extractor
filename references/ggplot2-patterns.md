# Comprehensive ggplot2 Style Patterns Reference

## 1. Theme Templates

### Academic Journal Themes

#### Nature Journal Theme
```r
theme_nature <- theme_bw() +
  theme(
    text = element_text(family = "Times New Roman", size = 8),
    axis.title = element_text(size = 9, face = "bold"),
    axis.text = element_text(size = 7),
    plot.title = element_text(size = 10, face = "bold", hjust = 0),
    legend.title = element_text(size = 8),
    legend.text = element_text(size = 7),
    panel.grid.major = element_line(color = "grey90", linewidth = 0.2),
    panel.grid.minor = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, linewidth = 0.5),
    strip.background = element_rect(fill = "grey95", color = "black"),
    strip.text = element_text(size = 8, face = "bold")
  )
```

#### Science Journal Theme
```r
theme_science <- theme_bw() +
  theme(
    text = element_text(family = "Arial", size = 8),
    axis.title = element_text(size = 9, face = "bold"),
    axis.text = element_text(size = 7),
    plot.title = element_text(size = 10, face = "bold", hjust = 0),
    legend.title = element_text(size = 8),
    legend.text = element_text(size = 7),
    panel.grid.major = element_line(color = "grey85", linewidth = 0.3),
    panel.grid.minor = element_line(color = "grey95", linewidth = 0.1),
    panel.border = element_rect(color = "black", fill = NA, linewidth = 0.8),
    axis.line = element_line(color = "black", linewidth = 0.3),
    axis.ticks = element_line(color = "black", linewidth = 0.3),
    strip.background = element_rect(fill = "grey90", color = "black"),
    strip.text = element_text(size = 8, face = "bold")
  )
```

#### APA Style Theme
```r
theme_apa <- theme_minimal() +
  theme(
    text = element_text(family = "Times New Roman", size = 12),
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
    legend.title = element_text(size = 11, face = "bold"),
    legend.text = element_text(size = 10),
    panel.grid.major = element_line(color = "grey80", linewidth = 0.3),
    panel.grid.minor = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, linewidth = 0.5),
    strip.background = element_rect(fill = "grey90"),
    strip.text = element_text(size = 11, face = "bold"),
    plot.margin = margin(10, 10, 10, 10)
  )
```

#### PLOS ONE Theme
```r
theme_plos <- theme_bw() +
  theme(
    text = element_text(family = "Arial", size = 8),
    axis.title = element_text(size = 9, face = "bold"),
    axis.text = element_text(size = 7),
    plot.title = element_text(size = 10, face = "bold", hjust = 0),
    legend.title = element_text(size = 8),
    legend.text = element_text(size = 7),
    panel.grid.major = element_line(color = "grey90", linewidth = 0.2),
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill = "white"),
    strip.background = element_rect(fill = "grey95"),
    strip.text = element_text(size = 8, face = "bold")
  )
```

#### JAMA Theme
```r
theme_jama <- theme_classic() +
  theme(
    text = element_text(family = "Times New Roman", size = 10),
    axis.title = element_text(size = 11, face = "bold"),
    axis.text = element_text(size = 9),
    plot.title = element_text(size = 12, face = "bold", hjust = 0),
    legend.title = element_text(size = 10, face = "bold"),
    legend.text = element_text(size = 9),
    axis.line = element_line(color = "black", linewidth = 0.5),
    axis.ticks = element_line(color = "black", linewidth = 0.3),
    strip.background = element_rect(fill = "grey90", color = "black"),
    strip.text = element_text(size = 10, face = "bold"),
    plot.margin = margin(10, 10, 10, 10)
  )
```

### Minimalist Themes

#### Clean White Theme
```r
theme_clean <- theme_bw() +
  theme(
    panel.grid = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, linewidth = 0.5),
    axis.line = element_line(color = "black", linewidth = 0.3),
    axis.ticks = element_line(color = "black", linewidth = 0.3),
    text = element_text(family = "sans", size = 10),
    plot.title = element_text(size = 12, face = "bold", hjust = 0)
  )
```

#### Minimal Grid Theme
```r
theme_minimal_grid <- theme_minimal() +
  theme(
    panel.grid.major = element_line(color = "grey90", linewidth = 0.2),
    panel.grid.minor = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, linewidth = 0.3),
    text = element_text(family = "sans", size = 10),
    plot.title = element_text(size = 12, face = "bold", hjust = 0)
  )
```

### Presentation Themes

#### Dark Background Theme
```r
theme_dark_presentation <- theme_dark() +
  theme(
    text = element_text(family = "sans", color = "white", size = 12),
    axis.title = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 11),
    plot.title = element_text(size = 16, face = "bold", hjust = 0),
    legend.title = element_text(size = 12, face = "bold"),
    legend.text = element_text(size = 11),
    panel.grid.major = element_line(color = "grey30", linewidth = 0.3),
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill = "grey20"),
    strip.background = element_rect(fill = "grey30"),
    strip.text = element_text(size = 12, face = "bold", color = "white")
  )
```

## 2. Color Palette Patterns

### Academic Journal Palettes

#### Nature Palette (Extended)
```r
nature_colors <- c(
  "#E64B35",  # Red
  "#4DBBD5",  # Cyan
  "#00A087",  # Teal
  "#3C5488",  # Blue
  "#F39B7F",  # Light orange
  "#8491B4",  # Gray-blue
  "#91D1C2",  # Light teal
  "#DC0000",  # Dark red
  "#7E6148",  # Brown
  "#B09C85",  # Light brown
  "#58A6A1",  # Medium teal
  "#D6A756",  # Gold
  "#C4796B",  # Salmon
  "#8DB5A0",  # Sage
  "#C28D49",  # Dark gold
  "#855C7A",  # Purple
  "#6A9FD5",  # Light blue
  "#9A9A4D",  # Olive
  "#D9A8B3",  # Pink
  "#8E7CC3"   # Lavender
)
```

#### Science Palette (Extended)
```r
science_colors <- c(
  "#3B4992",  # Dark blue
  "#EE0000",  # Red
  "#008B45",  # Green
  "#631879",  # Purple
  "#008280",  # Teal
  "#BB0021",  # Dark red
  "#5F559B",  # Muted purple
  "#A20056",  # Magenta
  "#0077BB",  # Medium blue
  "#EE7733",  # Orange
  "#009988",  # Teal-green
  "#CC3311",  # Rust
  "#33BBEE",  # Cyan
  "#EE3377",  # Pink
  "#BBBBBB",  # Gray
  "#004488"   # Navy
)
```

#### JAMA Palette (Extended)
```r
jama_colors <- c(
  "#374E55",  # Dark teal
  "#DF8F44",  # Orange
  "#00A1D5",  # Blue
  "#B24745",  # Red
  "#79AF12",  # Green
  "#6A6599",  # Purple
  "#80796B",  # Brown
  "#0AB398",  # Teal
  "#E7B844",  # Gold
  "#D95F02",  # Dark orange
  "#7570B3",  # Slate blue
  "#E7298A",  # Magenta
  "#66A61E",  # Lime
  "#E6AB02",  # Yellow
  "#A6761D",  # Olive
  "#666666"   # Gray
)
```

#### Lancet Palette
```r
lancet_colors <- c(
  "#00468B",  # Dark blue
  "#ED0000",  # Red
  "#42B540",  # Green
  "#0099B4",  # Teal
  "#925E9F",  # Purple
  "#FDAF91",  # Peach
  "#AEAEAE",  # Gray
  "#F39B7F",  # Light orange
  "#8491B4",  # Gray-blue
  "#91D1C2",  # Light teal
  "#DC0000",  # Dark red
  "#7E6148",  # Brown
  "#B09C85",  # Light brown
  "#58A6A1",  # Medium teal
  "#D6A756",  # Gold
  "#C4796B",  # Salmon
  "#8DB5A0",  # Sage
  "#C28D49",  # Dark gold
  "#855C7A",  # Purple
  "#6A9FD5"   # Light blue
)
```

### Viridis Color Scales

#### Viridis Family
```r
# Viridis (default)
scale_color_viridis_c(option = "viridis")
scale_fill_viridis_c(option = "viridis")

# Magma
scale_color_viridis_c(option = "magma")
scale_fill_viridis_c(option = "magma")

# Plasma
scale_color_viridis_c(option = "plasma")
scale_fill_viridis_c(option = "plasma")

# Inferno
scale_color_viridis_c(option = "inferno")
scale_fill_viridis_c(option = "inferno")

# Cividis
scale_color_viridis_c(option = "cividis")
scale_fill_viridis_c(option = "cividis")
```

#### Viridis for Discrete Data
```r
# Discrete viridis
scale_color_viridis_d(option = "viridis")
scale_fill_viridis_d(option = "viridis")

# With custom palette
scale_color_viridis_d(option = "plasma", direction = -1)
scale_fill_viridis_d(option = "magma", begin = 0.2, end = 0.8)
```

### Tableau Color Palettes

#### Tableau 10
```r
tableau10 <- c(
  "#4E79A7",  # Blue
  "#F28E2B",  # Orange
  "#E15759",  # Red
  "#76B7B2",  # Teal
  "#59A14F",  # Green
  "#EDC948",  # Yellow
  "#B07AA1",  # Purple
  "#FF9DA7",  # Pink
  "#9C755F",  # Brown
  "#BAB0AC"   # Gray
)
```

#### Tableau 20
```r
tableau20 <- c(
  "#4E79A7", "#A0CBE8",  # Blues
  "#F28E2B", "#FFBE7D",  # Oranges
  "#E15759", "#FF9D9A",  # Reds
  "#76B7B2", "#8CD17D",  # Teal-Green
  "#59A14F", "#B6992D",  # Green-Yellow
  "#EDC948", "#F1CE63",  # Yellows
  "#B07AA1", "#D4A6C8",  # Purples
  "#FF9DA7", "#FECFEF",  # Pinks
  "#9C755F", "#CAB9AF",  # Browns
  "#BAB0AC", "#A0A0A0"   # Grays
)
```

#### Tableau Color Blind Safe
```r
tableau_cb <- c(
  "#0072B2",  # Blue
  "#E69F00",  # Orange
  "#009E73",  # Green
  "#F0E442",  # Yellow
  "#56B4E9",  # Light blue
  "#D55E00",  # Vermillion
  "#CC79A7"   # Reddish purple
)
```

### Scientific Color Palettes

#### Color Brewer Qualitative
```r
# Set1
brewer_set1 <- c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", 
                 "#FF7F00", "#FFFF33", "#A65628", "#F781BF")

# Set2
brewer_set2 <- c("#66C2A5", "#FC8D62", "#8DA0CB", "#E78AC3", 
                 "#A6D854", "#FFD92F", "#E5C494", "#B3B3B3")

# Set3
brewer_set3 <- c("#8DD3C7", "#FFFFB3", "#BEBADA", "#FB8072", 
                 "#80B1D3", "#FDB462", "#B3DE69", "#FCCDE5")
```

#### Okabe-Ito Color Blind Safe
```r
okabe_ito <- c(
  "#E69F00",  # Orange
  "#56B4E9",  # Sky blue
  "#009E73",  # Bluish green
  "#F0E442",  # Yellow
  "#0072B2",  # Blue
  "#D55E00",  # Vermillion
  "#CC79A7"   # Reddish purple
)
```

### Monochromatic Palettes

#### Blue Gradient
```r
blue_gradient <- c(
  "#DEEBF7",  # Lightest
  "#C6DBEF",
  "#9ECAE1",
  "#6BAED6",
  "#4292C6",
  "#2171B5",
  "#08519C",
  "#08306B"   # Darkest
)
```

#### Red Gradient
```r
red_gradient <- c(
  "#FFF5F0",  # Lightest
  "#FEE0D2",
  "#FCBBA1",
  "#FC9272",
  "#FB6A4A",
  "#EF3B2C",
  "#CB181D",
  "#67000D"   # Darkest
)
```

## 3. Common Layout Patterns

### Grouped Bar Chart
```r
# Basic grouped bar chart
ggplot(data, aes(x = category, y = value, fill = group)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.7) +
  scale_fill_manual(values = nature_colors[1:3]) +
  theme_nature +
  labs(x = "Category", y = "Value", fill = "Group")

# With error bars
ggplot(data, aes(x = category, y = value, fill = group)) +
  geom_col(position = position_dodge(width = 0.8), width = 0.7) +
  geom_errorbar(aes(ymin = value - se, ymax = value + se),
                position = position_dodge(width = 0.8),
                width = 0.2) +
  scale_fill_manual(values = nature_colors[1:3]) +
  theme_nature +
  labs(x = "Category", y = "Mean Value", fill = "Group")
```

### Stacked Bar Chart
```r
# Basic stacked bar chart
ggplot(data, aes(x = category, y = value, fill = group)) +
  geom_col(position = "fill", width = 0.7) +
  scale_fill_manual(values = nature_colors[1:3]) +
  scale_y_continuous(labels = scales::percent) +
  theme_nature +
  labs(x = "Category", y = "Proportion", fill = "Group")

# Stacked with counts
ggplot(data, aes(x = category, y = value, fill = group)) +
  geom_col(width = 0.7) +
  scale_fill_manual(values = nature_colors[1:3]) +
  theme_nature +
  labs(x = "Category", y = "Count", fill = "Group")
```

### Line Chart with Points
```r
# Basic line chart
ggplot(data, aes(x = time, y = value, color = group)) +
  geom_line(linewidth = 0.8) +
  geom_point(size = 2) +
  scale_color_manual(values = nature_colors[1:3]) +
  theme_nature +
  labs(x = "Time", y = "Value", color = "Group")

# With confidence bands
ggplot(data, aes(x = time, y = value, color = group, fill = group)) +
  geom_line(linewidth = 0.8) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.2, color = NA) +
  geom_point(size = 2) +
  scale_color_manual(values = nature_colors[1:3]) +
  scale_fill_manual(values = nature_colors[1:3]) +
  theme_nature +
  labs(x = "Time", y = "Value", color = "Group", fill = "Group")
```

### Scatter Plot
```r
# Basic scatter plot
ggplot(data, aes(x = x_var, y = y_var, color = group)) +
  geom_point(size = 2, alpha = 0.7) +
  geom_smooth(method = "lm", se = TRUE, linewidth = 0.5) +
  scale_color_manual(values = nature_colors[1:3]) +
  theme_nature +
  labs(x = "X Variable", y = "Y Variable", color = "Group")

# With regression lines
ggplot(data, aes(x = x_var, y = y_var, color = group)) +
  geom_point(size = 2, alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, linewidth = 0.8) +
  scale_color_manual(values = nature_colors[1:3]) +
  theme_nature +
  labs(x = "X Variable", y = "Y Variable", color = "Group")
```

### Box Plot
```r
# Basic box plot
ggplot(data, aes(x = group, y = value, fill = group)) +
  geom_boxplot(outlier.shape = NA, alpha = 0.7) +
  geom_jitter(width = 0.1, size = 1, alpha = 0.5) +
  scale_fill_manual(values = nature_colors[1:3]) +
  theme_nature +
  labs(x = "Group", y = "Value", fill = "Group")

# Violin + box plot combination
ggplot(data, aes(x = group, y = value, fill = group)) +
  geom_violin(alpha = 0.3) +
  geom_boxplot(width = 0.1, fill = "white", alpha = 0.7) +
  geom_jitter(width = 0.05, size = 1, alpha = 0.5) +
  scale_fill_manual(values = nature_colors[1:3]) +
  theme_nature +
  labs(x = "Group", y = "Value", fill = "Group")
```

### Heatmap
```r
# Basic heatmap
ggplot(data, aes(x = x_var, y = y_var, fill = value)) +
  geom_tile(color = "white", linewidth = 0.5) +
  scale_fill_viridis_c(option = "plasma") +
  theme_nature +
  labs(x = "X Variable", y = "Y Variable", fill = "Value")

# With text annotations
ggplot(data, aes(x = x_var, y = y_var, fill = value)) +
  geom_tile(color = "white", linewidth = 0.5) +
  geom_text(aes(label = round(value, 1)), size = 3) +
  scale_fill_viridis_c(option = "plasma") +
  theme_nature +
  labs(x = "X Variable", y = "Y Variable", fill = "Value")
```

### Faceted Plots
```r
# Facet wrap
ggplot(data, aes(x = x_var, y = y_var, color = group)) +
  geom_point(size = 1.5) +
  facet_wrap(~facet_var, nrow = 2, scales = "free") +
  scale_color_manual(values = nature_colors[1:3]) +
  theme_nature +
  labs(x = "X Variable", y = "Y Variable", color = "Group")

# Facet grid
ggplot(data, aes(x = x_var, y = y_var, color = group)) +
  geom_point(size = 1.5) +
  facet_grid(row_var ~ col_var, scales = "free") +
  scale_color_manual(values = nature_colors[1:3]) +
  theme_nature +
  labs(x = "X Variable", y = "Y Variable", color = "Group")
```

### Density Plot
```r
# Basic density plot
ggplot(data, aes(x = value, fill = group)) +
  geom_density(alpha = 0.5) +
  scale_fill_manual(values = nature_colors[1:3]) +
  theme_nature +
  labs(x = "Value", y = "Density", fill = "Group")

# Overlapping densities
ggplot(data, aes(x = value, fill = group)) +
  geom_density(alpha = 0.3) +
  geom_line(aes(y = after_stat(density), color = group), linewidth = 0.8) +
  scale_fill_manual(values = nature_colors[1:3]) +
  scale_color_manual(values = nature_colors[1:3]) +
  theme_nature +
  labs(x = "Value", y = "Density", fill = "Group", color = "Group")
```

## 4. Typography Patterns

### Font Family Selection

#### Serif Fonts (Traditional Academic)
```r
# Times New Roman (APA, many journals)
theme(text = element_text(family = "Times New Roman"))

# Georgia
theme(text = element_text(family = "Georgia"))

# Palatino
theme(text = element_text(family = "Palatino Linotype"))
```

#### Sans-serif Fonts (Modern Academic)
```r
# Arial (Science, PLOS)
theme(text = element_text(family = "Arial"))

# Helvetica
theme(text = element_text(family = "Helvetica"))

# Calibri
theme(text = element_text(family = "Calibri"))
```

#### Monospace Fonts (Code/Technical)
```r
# Courier
theme(text = element_text(family = "Courier New"))

# Consolas
theme(text = element_text(family = "Consolas"))
```

### Size Hierarchy

#### Publication Standard (8-12pt)
```r
theme(
  text = element_text(size = 8),           # Base text
  axis.title = element_text(size = 9),     # Axis titles
  axis.text = element_text(size = 7),      # Tick labels
  plot.title = element_text(size = 10),    # Plot title
  legend.title = element_text(size = 8),   # Legend title
  legend.text = element_text(size = 7),    # Legend text
  strip.text = element_text(size = 8)      # Facet labels
)
```

#### Presentation Standard (12-16pt)
```r
theme(
  text = element_text(size = 12),          # Base text
  axis.title = element_text(size = 14),    # Axis titles
  axis.text = element_text(size = 11),     # Tick labels
  plot.title = element_text(size = 16),    # Plot title
  legend.title = element_text(size = 12),  # Legend title
  legend.text = element_text(size = 11),   # Legend text
  strip.text = element_text(size = 12)     # Facet labels
)
```

### Text Styling

#### Bold and Italic
```r
theme(
  plot.title = element_text(face = "bold"),
  axis.title = element_text(face = "bold"),
  axis.title.x = element_text(face = "bold.italic"),
  legend.title = element_text(face = "bold"),
  strip.text = element_text(face = "bold.italic")
)
```

#### Color and Opacity
```r
theme(
  text = element_text(color = "black"),
  axis.title = element_text(color = "grey20"),
  axis.text = element_text(color = "grey40"),
  plot.title = element_text(color = "black", face = "bold"),
  legend.text = element_text(color = "grey30")
)
```

### Alignment and Positioning

#### Title Alignment
```r
theme(
  plot.title = element_text(hjust = 0),    # Left aligned
  plot.title = element_text(hjust = 0.5),  # Centered
  plot.title = element_text(hjust = 1)     # Right aligned
)
```

#### Axis Title Position
```r
theme(
  axis.title.x = element_text(margin = margin(t = 10)),
  axis.title.y = element_text(margin = margin(r = 10), angle = 90)
)
```

## 5. Scale Patterns

### Color Scales

#### Manual Color Scales
```r
# For categorical data
scale_color_manual(values = c("#E64B35", "#4DBBD5", "#00A087"))
scale_fill_manual(values = c("#E64B35", "#4DBBD5", "#00A087"))

# With custom labels
scale_color_manual(values = c("red", "blue", "green"),
                   labels = c("Control", "Treatment A", "Treatment B"))
```

#### Gradient Color Scales
```r
# Two-color gradient
scale_color_gradient(low = "blue", high = "red")
scale_fill_gradient(low = "#DEEBF7", high = "#67000D")

# Three-color gradient
scale_color_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0)
scale_fill_gradient2(low = "#2166AC", mid = "white", high = "#B2182B", midpoint = 0)
```

### Continuous Scales

#### Logarithmic Scale
```r
scale_x_continuous(trans = "log10")
scale_y_continuous(trans = "log2")
scale_x_continuous(trans = "log", breaks = scales::log_breaks())
```

#### Percent Scale
```r
scale_y_continuous(labels = scales::percent)
scale_y_continuous(labels = scales::percent_format(accuracy = 0.1))
```

#### Scientific Notation
```r
scale_y_continuous(labels = scales::scientific)
scale_y_continuous(labels = scales::label_number(scale_cut = scales::cut_short_scale()))
```

### Discrete Scales

#### Factor Levels
```r
scale_x_discrete(limits = c("Control", "Low", "Medium", "High"))
scale_fill_discrete(limits = c("Group A", "Group B", "Group C"))
```

#### Custom Labels
```r
scale_x_discrete(labels = c("CTRL" = "Control", 
                            "TRT_A" = "Treatment A",
                            "TRT_B" = "Treatment B"))
```

## 6. Position Adjustments

### Dodging
```r
# For grouped bars
geom_col(position = position_dodge(width = 0.8))

# For error bars
geom_errorbar(position = position_dodge(width = 0.8))
```

### Stacking
```r
# Stacked bars
geom_col(position = "stack")

# Proportional stacking
geom_col(position = "fill")
```

### Jittering
```r
# For scatter plots
geom_jitter(width = 0.1, height = 0.1)

# For box plots
geom_jitter(width = 0.1, size = 1, alpha = 0.5)
```

## 7. Annotation Patterns

### Text Annotations
```r
# Basic text
geom_text(aes(label = round(value, 2)), size = 3)

# Repelled text
ggrepel::geom_text_repel(aes(label = label), size = 3)

# Custom position
annotate("text", x = 2, y = 5, label = "Significant", size = 4)
```

### Line Annotations
```r
# Horizontal line
geom_hline(yintercept = 0, linetype = "dashed", color = "red")

# Vertical line
geom_vline(xintercept = 0, linetype = "dashed", color = "blue")

# Abline
geom_abline(intercept = 0, slope = 1, linetype = "dotted")
```

### Rectangle Annotations
```r
# Shaded region
annotate("rect", xmin = 2, xmax = 4, ymin = -Inf, ymax = Inf,
         alpha = 0.1, fill = "blue")

# Custom rectangle
geom_rect(aes(xmin = 2, xmax = 4, ymin = 0, ymax = 10),
          fill = "blue", alpha = 0.1)
```

## 8. Common Theme Combinations

### Nature-Style Publication
```r
theme_nature publication <- theme_bw() +
  theme(
    text = element_text(family = "Times New Roman", size = 8),
    axis.title = element_text(size = 9, face = "bold"),
    axis.text = element_text(size = 7),
    plot.title = element_text(size = 10, face = "bold", hjust = 0),
    legend.title = element_text(size = 8),
    legend.text = element_text(size = 7),
    panel.grid.major = element_line(color = "grey90", linewidth = 0.2),
    panel.grid.minor = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, linewidth = 0.5),
    strip.background = element_rect(fill = "grey95", color = "black"),
    strip.text = element_text(size = 8, face = "bold"),
    plot.margin = margin(10, 10, 10, 10)
  )
```

### Science-Style Publication
```r
theme_science publication <- theme_bw() +
  theme(
    text = element_text(family = "Arial", size = 8),
    axis.title = element_text(size = 9, face = "bold"),
    axis.text = element_text(size = 7),
    plot.title = element_text(size = 10, face = "bold", hjust = 0),
    legend.title = element_text(size = 8),
    legend.text = element_text(size = 7),
    panel.grid.major = element_line(color = "grey85", linewidth = 0.3),
    panel.grid.minor = element_line(color = "grey95", linewidth = 0.1),
    panel.border = element_rect(color = "black", fill = NA, linewidth = 0.8),
    axis.line = element_line(color = "black", linewidth = 0.3),
    axis.ticks = element_line(color = "black", linewidth = 0.3),
    strip.background = element_rect(fill = "grey90", color = "black"),
    strip.text = element_text(size = 8, face = "bold"),
    plot.margin = margin(10, 10, 10, 10)
  )
```

### APA-Style Publication
```r
theme_apa publication <- theme_minimal() +
  theme(
    text = element_text(family = "Times New Roman", size = 12),
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
    legend.title = element_text(size = 11, face = "bold"),
    legend.text = element_text(size = 10),
    panel.grid.major = element_line(color = "grey80", linewidth = 0.3),
    panel.grid.minor = element_blank(),
    panel.border = element_rect(color = "black", fill = NA, linewidth = 0.5),
    strip.background = element_rect(fill = "grey90"),
    strip.text = element_text(size = 11, face = "bold"),
    plot.margin = margin(10, 10, 10, 10)
  )
```

## 9. Quick Reference Guide

### Color Palette Selection
| Use Case | Recommended Palette | Package/Source |
|----------|-------------------|----------------|
| General academic | Nature, Science | ggsci |
| Color blind safe | Okabe-Ito, Tableau CB | Manual |
| Continuous data | Viridis family | viridis |
| Discrete categories | Tableau 10, ColorBrewer | scales, RColorBrewer |

### Theme Selection
| Journal/Style | Base Theme | Key Features |
|--------------|------------|--------------|
| Nature | theme_bw() | Times New Roman, minimal grid |
| Science | theme_bw() | Arial, major/minor grid |
| APA | theme_minimal() | Times New Roman, clean |
| PLOS | theme_bw() | Arial, minimal styling |
| Presentation | theme_dark() or theme_bw() | Large fonts, high contrast |

### Typography Guidelines
| Context | Font Family | Size Range |
|---------|-------------|------------|
| Publication | Times New Roman, Arial | 7-10pt |
| Presentation | Sans-serif | 12-16pt |
| Poster | Sans-serif, bold | 14-20pt |
| Web | Sans-serif | 10-14pt |

### Layout Patterns
| Chart Type | Best Practice | Common Issues |
|------------|---------------|---------------|
| Grouped bars | position_dodge(), width=0.8 | Overlapping labels |
| Stacked bars | position="fill" for proportions | Misleading scales |
| Line charts | geom_line() + geom_point() | Too many lines |
| Scatter plots | alpha transparency, geom_smooth() | Overplotting |
| Box plots | Add jitter points, outlier.shape=NA | Hidden distributions |

This reference provides comprehensive ggplot2 style patterns for scientific chart analysis and replication. Use these patterns as templates when extracting styles from chart images or creating new visualizations.