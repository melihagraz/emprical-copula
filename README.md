# emprical-copula 

The empirical copula which is obtained from the empirical
cumulative density of the dataset (X, Y) random pairs and (Ri, Si)
associated pairs of ranks, has the following functional form.
$$ C_{n}(u,v)=\frac{1}{n} \sum_{i=1}^{n}I(X_i\leq x_i)(\frac{R_i}{n+1}, \frac{S_i}{n+1}) $$
where I denotes the indicator function of event A, (Ri, Si) is the ith order statistics of x and y.

![equation](<a href="https://www.codecogs.com/eqnedit.php?latex=C_{n}(u,v)=\frac{1}{n}&space;\sum_{i=1}^{n}I(X_i\leq&space;x_i)(\frac{R_i}{n&plus;1},&space;\frac{S_i}{n&plus;1})" target="_blank"><img src="https://latex.codecogs.com/gif.latex?C_{n}(u,v)=\frac{1}{n}&space;\sum_{i=1}^{n}I(X_i\leq&space;x_i)(\frac{R_i}{n&plus;1},&space;\frac{S_i}{n&plus;1})" title="C_{n}(u,v)=\frac{1}{n} \sum_{i=1}^{n}I(X_i\leq x_i)(\frac{R_i}{n+1}, \frac{S_i}{n+1})" /></a>)
