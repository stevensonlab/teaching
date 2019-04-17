
## Simulate an integrate-and-fire neuron

# Parameters...
tau <-  10       # membrane time constant (ms)
R   <-  10       # membrane resistance (MOhms)
E_L <- -65       # resting potential for the leak (mV)
Vthresh <- -50   # spike threshold (mV)
Vreset  <- -65   # reset potential (mV)

T <- 5000 # simulation time (ms)

# a step current (nA)...
V <- vector(length = T)
I <- vector(length = T)
I[200:4800] <- 1

# a random current
mu <- 1.5
st <- 1
I <- mu + st*rnorm(T)

V[1] <- -65.0001   # initial membrane potential (mV)
for (t in 2:T) {      # ms timesteps
  # Integrate...
  V[t] <- V[t-1] + (I[t]*R - (V[t-1]-E_L))/tau

  # Fire...
  if (V[t]>Vthresh) {
    V[t] <- Vreset
  }
}

par(mfrow=c(2,1))
plot(V+(V==Vreset)*65,type='l',ylab = 'Membrane Potential (mV)')
plot(I,type='l',ylab='Current (nA)',xlab='Time (ms)')

isis <- diff(which(V==Vreset))
cv <- sd(isis)/mean(isis)


