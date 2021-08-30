
/*----------------------- Data --------------------------*/
/* Data block: defines the objects that will be inputted as data */
data {
	int TT; // Length of state and observation time series
	vector[TT] y; // Observations
	real z0; // Initial state value
}

/*----------------------- Parameters --------------------------*/
/* Parameter block: defines the variables that will be sampled */
parameters {
	real<lower = 0> sdp; // Standard deviation of the process equation
	real<lower = 0> sdo; // Standard deviation of the observation equation
	vector[TT] z; // State time series
}

/*----------------------- Model --------------------------*/
/* Model block: defines the model */
model {
	// Prior distributions
	sdo ~ normal(0, 1);
	sdp ~ normal(0, 1);
	
	// Distribution for the first state (diffuse initialisation)
	target += normal_lpdf(z[1] | z0, sdp);

	// Distributions for all other states
	target += normal_lpdf(z[2:TT] | z[1:(TT - 1)], sdp);

	// Distributions for the observations
	target += normal_lpdf(y | z[1:TT], sdo);
}
