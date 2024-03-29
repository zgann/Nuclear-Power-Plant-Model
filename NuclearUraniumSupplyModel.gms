$TITLE Nuclear Uranium Supply Model

Set
i  'Uranium Supplying Countries'  /Australia, Canada, Kazakhstan, Malawi, Namibia, Niger, Russia, SouthAfrica, Uzbekistan, UnitedStates/

j  'U.S. Domestic Nuclear Power Plants' /ArkansasNuclearOne, BeaverValley, BraidwoodGenerationStation, BrownsFerry, BrunswickNuclear, ByronGeneratingStation, Callaway, CalvertCliffsNuclearPowerPlant, Catawba, ClintonPowerStation,
ColumbiaGeneratingStation, ComanchePeak, CooperNuclearStation, DavisBesse, DiabloCanyon, DonaldCCook, DresdenGeneratingStation, DuaneArnoldEnergyCenter, EdwinIHatch, Fermi, GrandGulf, HBRobinson, Harris, IndianPoint2, IndianPoint3,
JamesAFitzpatrick, JosephMFarley, LaSalleGeneratingStation, Limerick, McGuire, Millstone, MonticelloNuclearFacility, NineMilePointNuclearStation, NorthAnna, Oconee, OysterCreek, Palisades, PaloVerde, PeachBottom, Perry,
PilgrimNuclearPowerStation, PointBeachNuclearPlant, PrairieIsland, PSEGHopeCreekGeneratingStation, PSEGSalemGeneratingStation, QuadCitiesGeneratingStation, REGinnaNuclearPowerPlant, RiverBend, Seabrook, Sequoyah, SouthTexasProject,
StLucie, Surry, TalenEnergySusquehanna, ThreeMileIsland, TurkeyPoint, VCSummer, Vogtle, Waterford3, WattsBarNuclearPlant, WolfCreekGeneratingStation/
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
/  ArkansasNuclearOne        923.1416888
BeaverValley        918.16491
BraidwoodGenerationStation        1186.8094
BrownsFerry        1680.62774
BrunswickNuclear        949.6506536
ByronGeneratingStation        1168.01952
Callaway        604.3231432
CalvertCliffsNuclearPowerPlant        867.2798857
Catawba        1173.199433
ClintonPowerStation        538.3046486
ColumbiaGeneratingStation        597.7212937
ComanchePeak        1218.802978
CooperNuclearStation        391.0326221
DavisBesse        454.0041092
DiabloCanyon        1137.549446
DonaldCCook        1105.555868
DresdenGeneratingStation        912.5787297
DuaneArnoldEnergyCenter        305.4117129
EdwinIHatch        893.2810158
Fermi        579.4392491
GrandGulf        711.4762383
HBRobinson        376.3054194
Harris        473.3018231
IndianPoint2        508.0377079
IndianPoint3        528.808142
JamesAFitzpatrick        432.1672226
JosephMFarley        889.2183393
LaSalleGeneratingStation        1149.94061
Limerick        1138.463548
McGuire        1175.94174
Millstone        1060.257024
MonticelloNuclearFacility        313.3339322
NineMilePointNuclearStation        973.011044
NorthAnna        960.8230142
Oconee        1297.009502
OysterCreek        308.6110707
Palisades        407.1817615
PaloVerde        1999.344718
PeachBottom        1244.39784
Perry        629.7148719
PilgrimNuclearPowerStation        343.9055736
PointBeachNuclearPlant        605.9482138
PrairieIsland        528.1479571
PSEGHopeCreekGeneratingStation        595.1821209
PSEGSalemGeneratingStation        1182.340455
QuadCitiesGeneratingStation        923.7510903
REGinnaNuclearPowerPlant        295.5597221
RiverBend        491.3299504
Seabrook        634.3361665
Sequoyah        1156.694809
SouthTexasProject        1300.05651
StLucie        999.4184418
Surry        851.1307462
TalenEnergySusquehanna        1266.539428
ThreeMileIsland        407.6895961
TurkeyPoint        814.5666569
VCSummer        493.1073715
Vogtle        1169.03519
Waterford3        591.8304127
WattsBarNuclearPlant        1140.088619
WolfCreekGeneratingStation        622.0973533/

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

$call GDXXRW GannEBGN632Data.xlsx  trace=3 par=d rng=Sheet5!a1:k62 rdim=1 cdim=1
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

cost.. z =e=  sum((i,j), c(i,j)*x(i,j));

supply(i)..  sum(j, x(i,j)) =l= a(i);

demand(j).. sum(i, x(i,j)) =g= b(j);

Model NuclearSupply / all /;

solve NuclearSupply using lp minimizing z;

display x.l, x.m;
