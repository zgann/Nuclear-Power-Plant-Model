$TITLE Nuclear Uranium Supply Model

Set
i  'Uranium Supplying Countries'  /Australia, Canada, Kazakhstan, Malawi, Namibia, Niger, Russia, SouthAfrica, Uzbekistan, UnitedStates/

j  'U.S. Domestic Nuclear Power Plants' /AL, AR, AZ, CA, CT, FL, GA, IA, IL, KS, LA, MA, MD, MI, MN, MO, MS, NC, NE, NH, NJ, NY, OH, PA, SC, TN, TX, VA, WA, WI/
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


b(j)  'Demand by nuclear power plant j in thousands of pounds'
/AL        2569.846079
AR        923.1416888
AZ        1999.344718
CA        1137.549446
CT        1060.257024
FL        1813.985099
GA        2062.316205
IA        305.4117129
IL        5879.403998
KS        622.0973533
LA        1083.160363
MA        343.9055736
MD        867.2798857
MI        2092.176878
MN        841.4818893
MO        604.3231432
MS        711.4762383
NC        2598.894216
NE        391.0326221
NH        634.3361665
NJ        2086.133647
NY        2737.583839
OH        1083.718981
PA        4975.255323
SC        3339.621726
TN        2296.783428
TX        2518.859488
VA        1811.95376
WA        597.7212937
WI        605.9482138/

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

 d(j,i) 'Distance from i to j in';

$call GDXXRW GannEBGN632Data.xlsx  trace=3 par=d rng=Sheet7!a1:k31 rdim=1 cdim=1
$GDXIN GannEBGN632Data.gdx
$LOAD d
$GDXIN

Scalar f 'shipping cost' /1000/;

Parameter
c(i,j) 'Cost of shipping from j to i' ;
     c(i,j) = f * d(j,i) ;

Variables
x(i,j) Shipments form i to j
z      Objective fuction ;

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
