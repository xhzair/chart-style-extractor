# matplotlib/seaborn Style Patterns Reference

## 1. Style Setup

### Base Configuration
```python
import matplotlib.pyplot as plt
import matplotlib as mpl

# Publication-quality settings
mpl.rcParams.update({
    'font.family': 'sans-serif',
    'font.sans-serif': ['Arial', 'Helvetica', 'DejaVu Sans'],
    'font.size': 10,
    'axes.linewidth': 0.5,
    'axes.labelsize': 11,
    'axes.titlesize': 12,
    'xtick.labelsize': 9,
    'ytick.labelsize': 9,
    'legend.fontsize': 9,
    'figure.dpi': 300,
    'savefig.dpi': 300,
    'savefig.bbox': 'tight'
})
```

### Style Presets
```python
# Clean style (like theme_classic)
plt.style.use('seaborn-v0_8-whitegrid')

# Minimal style
plt.style.use('seaborn-v0_8-white')

# Dark style
plt.style.use('seaborn-v0_8-dark')
```

## 2. Color Palettes

### Custom Palettes
```python
# Nature palette
nature_colors = ['#E64B35', '#4DBBD5', '#00A087', '#3C5488']

# Custom palette
custom_colors = ['#E07A5F', '#81B29A', '#F2CC8F', '#3D405B']

# Using in plots
plt.bar(x, y, color=custom_colors[0])
plt.plot(x, y, color=custom_colors[1])
```

### Seaborn Palettes
```python
import seaborn as sns

# Built-in palettes
sns.color_palette("Set1")
sns.color_palette("Set2")
sns.color_palette("Paired")
sns.color_palette("Dark2")

# Viridis (colorblind-safe)
sns.color_palette("viridis")
sns.color_palette("viridis", as_cmap=True)
```

## 3. Common Plot Patterns

### Scatter Plot
```python
fig, ax = plt.subplots(figsize=(8, 6))
ax.scatter(x, y, c=color, alpha=0.6, s=50, edgecolors='white', linewidth=0.5)
ax.set_xlabel('X Label')
ax.set_ylabel('Y Label')
```

### Line Plot
```python
fig, ax = plt.subplots(figsize=(8, 6))
ax.plot(x, y, color='#E07A5F', linewidth=2, marker='o', markersize=6, label='Series 1')
ax.legend()
```

### Bar Chart
```python
fig, ax = plt.subplots(figsize=(8, 6))
bars = ax.bar(x, y, color=colors, edgecolor='black', linewidth=0.5)
ax.set_xticks(x)
ax.set_xticklabels(labels, rotation=45, ha='right')
```

### Grouped Bar Chart
```python
fig, ax = plt.subplots(figsize=(10, 6))
x = np.arange(len(categories))
width = 0.35
ax.bar(x - width/2, values1, width, label='Group 1', color=colors[0])
ax.bar(x + width/2, values2, width, label='Group 2', color=colors[1])
ax.set_xticks(x)
ax.set_xticklabels(categories)
ax.legend()
```

## 4. Layout & Styling

### Axis Customization
```python
# Remove top/right spines
ax.spines['top'].set_visible(False)
ax.spines['right'].set_visible(False)

# Custom spines
ax.spines['left'].set_linewidth(0.5)
ax.spines['bottom'].set_linewidth(0.5)
```

### Grid Lines
```python
ax.grid(True, axis='y', linestyle='--', alpha=0.3)
ax.grid(False)  # Remove grid
```

### Legend
```python
ax.legend(loc='upper right', frameon=False)
ax.legend(title='Legend Title', title_fontsize=10)
```

### Save Figures
```python
plt.savefig('figure.png', dpi=300, bbox_inches='tight')
plt.savefig('figure.pdf', bbox_inches='tight')
plt.savefig('figure.svg', bbox_inches='tight')
```

## 5. Seaborn Integration

### Statistical Plots
```python
import seaborn as sns

# Box plot
sns.boxplot(data=df, x='group', y='value', palette=colors)

# Violin plot
sns.violinplot(data=df, x='group', y='value', palette=colors)

# Heatmap
sns.heatmap(data, annot=True, cmap='viridis', fmt='.2f')
```

### Regression Plots
```python
# Scatter with regression line
sns.regplot(data=df, x='x', y='y', scatter_kws={'alpha': 0.6})

# Pair plot
sns.pairplot(df, hue='group', palette=colors)
```
