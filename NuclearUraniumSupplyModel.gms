$TITLE Nuclear Uranium Supply Model

Set
i  "Uranium Supplying Countries"  /Australia, Canada, Kazakhstan, Malawi, Namibia, Niger, Russia, SouthAfrica, Uzbekistan, DomesticUnitedStatesProduction/
j  "U.S. Domestic Nuclear Power Plants";

Parameter
a(i) "Available uranium for sell to the United States in country i"
b(j)  "Demand by nuclear power plant j"
p(i) " Price set by country i"
d(i,j) "Distance from i to j" ;

Scalar f "shipping cost" ;

Parameter
c(i,j) "Cost of shipping from i to j" ;
     c(i,j) = f * d(i,j) ;

Variables
x(i,j) Shipments form i to j
z      Objective fuction ;
