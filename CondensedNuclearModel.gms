$TITLE Condensed Nuclear Uranium Supply Model

Set
i  'Uranium Supplying Countries'  /Australia, Canada, Kazakhstan, Malawi, Namibia, Niger, Russia, SouthAfrica, Uzbekistan, UnitedStates/

j  'U.S. Region' /West, Midwest, South, Northeast/
;

Parameter
a(i) 'Available uranium for sell to the United States in country i in thousands of pounds'
 /  Australia        10511
       Canada        16876
   Kazakhstan        12032
       Malawi        1514
      Namibia        4603
        Niger        1971
       Russia        9063
 SouthAfrica        1169
   Uzbekistan        2540
UnitedStates        5424 /


b(j)  'Demand by region j in thousands of pounds'
/West        6382.617278
Midwest        12371.20571
South        24162.10885
Northeast        7640.574301
/

p(i) ' Price set by country i per thousand pounds'
/ Australia        43050
Canada        43220
Kazakhstan        39910
Malawi        41380
Namibia        44300
Niger        44120
Russia        43850
SouthAfrica        43750
Uzbekistan        39180
UnitedStates        43920 /
 ;
Table d(i,j) 'Distance from i to j in'
                  West          Midwest       South         Northeast
Australia        8097.64       9684.94       10239.31       10263.62
Canada              0             0              0              0
Kazakhstan       6632.6        6206.14        6453.36        5932.53
Malawi         10098.16        8558.73        8117.06        7941.78
Namibia         9675.46        8095.96        7516.39        7506.76
Niger           7378.76        5880.81        5532.96        5272.3
Russia          5157.91        5187.67        5639.11        5132.51
SouthAfrica    10274.95        8704.64        8116.44        8118.23
Uzbekistan      7043.06        6569.59        6781.54        6265.65
UnitedStates       0              0              0              0





;



Scalar f 'shipping cost' /1000/;

Parameter
c(i,j) 'Cost of shipping from i to j' ;
     c(i,j) = f * d(i,j) ;

Variables
x(i,j) Shipments from i to j
z      Objective fuction ;
Positive Variables x;

Equations
cost 'costs for each plant'
supply(i) 'supply limit at country i'
demand(j) 'satisfy demand at plant i';

cost.. z =e=  sum((i,j), (p(i)+c(i,j))*x(i,j));

supply(i)..  sum(j, x(i,j)) =l= a(i);

demand(j).. sum(i, x(i,j)) =g= b(j);

Model NuclearSupply / all /;

solve NuclearSupply using lp minimizing z;

display x.l, x.m;
