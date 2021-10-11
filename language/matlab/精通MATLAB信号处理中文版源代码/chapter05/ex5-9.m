clear all; 
close all; clc;
h1 = [-4,2,-2,-2,5,7,5,-2,-2,2,-4];
h2 = [-4,2,-2,-2,5,7,7,5,-2,-2,2,-4];
h3 = [-4,2,-2,-2,5,0,-5,2,2,-2,4];
h4= [-4,2,-2,-2,5,7,-7,-5,2,2,-2,4];
subplot(2,2,1);
zplane(h1,1);
title('I型零极点');
subplot(2,2,2); 
zplane(h2,1);title('II型零极点');
subplot(2,2,3); 
zplane(h3,1);
title('III-型零极点');
subplot(2,2,4);
zplane(h4,1);
title('IV型零极点');
