# Create a vector that will keep track of the states
# It's of length T + 1 (+1 for t=0)
# T is not a good name in R, because of T/F, so we use TT
TT <- 200
z <- numeric(TT + 1)
# Standard deviation of the process variation
sdp <- 10
# Set the seed, so we can reproduce the results
set.seed(553)
# For-loop that simulates the state through time, using i instead of t,
for (i in 1:TT)
{
	# This is the process equation
	z[i + 1] <- z[i] + rnorm(1, 0, sdp)
	# Note that this index is shifted compared to equation in text, # because we assume the first value to be at time 0
}

plot(0:TT, z,
	pch = 19, cex = 0.7, col = "red", ty = "o",
	xlab = "t", ylab = expression(z[t]), las = 1
)

# Create a vector that will keep track of the observations # It's of length T
y <- numeric(TT)
# Standard deviation of the observation error
sdo <- 0.1
# For t=1, ... T, add measurement error # Remember that z[1] is t=0
y <- z[2:(TT + 1)] + rnorm(TT, 0, sdo)

plot(1:TT, y,
	pch = 3, cex = 0.8, col = "blue", ty = "o", lty = 3,
	xlab = "t", ylab = expression(z[t]),
	xlim = c(0, TT), ylim = c(min(y), max(y) + max(y) / 5),
	las = 1
)
points(0:TT, z,
	pch = 19, cex = 0.7, col = "red", ty = "o"
)
legend("top",
	legend = c("Obs.", "True states"),
	pch = c(3, 19),
	col = c("blue", "red"),
	lty = c(3, 1),
	horiz = TRUE, bty = "n", cex = 0.9
)

