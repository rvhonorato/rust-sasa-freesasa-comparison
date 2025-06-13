# Read the CSV file
data <- read.csv("sasa_comparison.csv")

# Remove any rows with ERROR values
data <- data[data$rust.sasa != "ERROR" & data$freesasa != "ERROR", ]

# Convert to numeric (in case they're read as strings)
data$rust.sasa <- as.numeric(data$rust.sasa)
data$freesasa <- as.numeric(data$freesasa)

# Calculate correlation
correlation <- cor(data$rust.sasa, data$freesasa)
cat("Pearson correlation coefficient:", correlation, "\n")

# Calculate R-squared
r_squared <- correlation^2
cat("R-squared:", r_squared, "\n")

# Basic statistics
cat("\nSummary statistics:\n")
cat("Rust-SASA - Mean:", mean(data$rust.sasa), "SD:", sd(data$rust.sasa), "\n")
cat("FreeSASA - Mean:", mean(data$freesasa), "SD:", sd(data$freesasa), "\n")

# Linear regression
model <- lm(freesasa ~ rust.sasa, data = data)
cat("\nLinear regression (FreeSASA ~ Rust-SASA):\n")
print(summary(model))

# Create plots
png("sasa_correlation.png", width = 800, height = 600)
plot(data$rust.sasa, data$freesasa, 
     xlab = "Rust-SASA", ylab = "FreeSASA",
     main = paste("SASA Correlation (r =", round(correlation, 3), ")"),
     pch = 16, col = "blue")
abline(model, col = "red", lwd = 2)
abline(0, 1, col = "gray", lty = 2, lwd = 1)  # Perfect correlation line
dev.off()

cat("\nPlot saved as 'sasa_correlation.png'\n")
