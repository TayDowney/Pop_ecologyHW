library(deSolve)
log.growth.theta <- function(t, y, p) {
  N <- y[1]
  with(as.list(p), {
    dN.dt <- r * N * (1 - (N / K)^theta)
    return(list(dN.dt))
  })
}

## specify parameter values and initial conditions for tomatoes
p <- c('r' = 0.2, 'K' = 1.05, 'theta' = 1.05)
y0 <- c('N' = 0.01)
t <- 0:100

sim <- ode(y = y0, times = t, func = log.growth.theta, parms = p, method = 'lsoda')

sim <- as.data.frame(sim)

## basic plot
plot(N ~ time, data = sim, type = 'l', lwd = 2, bty = 'l', col = 'red')

## change theta for grapes
p.2 <- c('r' = 0.28, 'K' = 0.75, 'theta' = 1.25)
sim.2 <- ode(y = y0, times = t, func = log.growth.theta, parms = p.2, method = 'lsoda')
sim.2 <- as.data.frame(sim.2)

points(N ~ time, data = sim.2, type = 'l', lwd = 2, bty = 'l', lty = 2, col = 'purple')

## change theta for peaches
p.3 <- c('r' = 0.15, 'K' = 1, 'theta' = 1)
sim.3 <- ode(y = y0, times = t, func = log.growth.theta, parms = p.3, method = 'lsoda')
sim.3 <- as.data.frame(sim.3)

points(N ~ time, data = sim.3, type = 'l', lwd = 2, bty = 'l', lty = 3, col = 'black')

sim$deriv <- c(diff(sim$N), NA)
plot(deriv ~ N, data = sim, type = 'l', col = 'red', ylim = c(0, 0.28), bty = 'l')

sim.2$deriv <- c(diff(sim.2$N), NA)
points(deriv ~ N, data = sim.2, type = 'l', col = 'purple')

sim.3$deriv <- c(diff(sim.3$N), NA)
points(deriv ~ N, data = sim.3, type = 'l', col = 'black')





max.Ns <- c(sim$N[which(sim$deriv == max(sim$deriv, na.rm = TRUE))],
            sim.2$N[which(sim.2$deriv == max(sim.2$deriv, na.rm = TRUE))],
            sim.3$N[which(sim.3$deriv == max(sim.3$deriv, na.rm = TRUE))])

thetas <- c(p['theta'], p.2['theta'], p.3['theta'])
plot(max.Ns ~ thetas, pch = 21, bg = 'skyblue', type = 'b', lty = 2)
            

price<- c(p=1.3,p=2,p=1.5)
plot(max.Ns ~ price, pch = 21, bg = 'skyblue', type = 'b', lty = 2)

