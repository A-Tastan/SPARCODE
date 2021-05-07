# Sparsity-aware Robust Community Detection (SPARCODE)
We proposed SPARCODE, a community detection method that uses spectral partitioning based on estimating a robust and sparse graph model. The method begins with a densely connected
graph and produces a preliminary sparsity-improved graph. Then, undesired and negligible edges are removed from the sparsity-improved graph model and the graph construction is 
performed in a robust manner by detecting the outliers. Finally, fast spectral partitioning is performed on the estimated outlier-free vertices of the robust sparse graph model. 
The number of communities is estimated using modularity optimization on partitions.

For details, see:

[1] A. Tastan, Michael Muma, and Abdelhak M. Zoubir,"Sparsity-aware Robust Community Detection (SPARCODE)", Signal Processing. (accepted)

The codes can be freely used for non-commercial use only. Please make appropriate references to our article.

NOTE : This code uses an additional function that is named "LassoShooting". The all "LassoShooting" function implementations use the same default parameters as follows: 
maxIt=100, Tol=1e-3, standardize=false. The "LassoShooting" function is available in:

http://publish.illinois.edu/xiaohuichen/code/graphical-lasso/

or

https://sourceforge.net/projects/sparsemodels/files/Group%20Lasso%20Shooting/



![All_Steps_Sparcode](https://user-images.githubusercontent.com/83693413/117464885-64020d80-af51-11eb-868d-88da132aa71c.png)


