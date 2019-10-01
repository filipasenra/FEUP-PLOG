pilot('Lamb').
pilot('Besenyei').
pilot('Chambliss').
pilot('MacLean').
pilot('Mangold').
pilot('Jones').
pilot('Bonhomme').

team('Breitling', 'Lamb').
team('Red Bull', 'Besenyei').
team('Red Bull', 'Chambliss').
team('Mediterranean Racing Team', 'MacLean').
team('Cobra', 'Mangold').
team('Matador', 'Bonhomme').
team('Matador', 'Jones').

planeFromPilot('Lamb', 'MX2').
planeFromPilot('Besenyei', 'Edge540' ).
planeFromPilot('Chambliss', 'Edge540' ).
planeFromPilot('MacLean', 'Edge540' ).
planeFromPilot('Mangold', 'Edge540' ).
planeFromPilot('Jones', 'Edge540' ).
planeFromPilot('Bonhomme', 'Edge540').

circuit('Istanbul').
circuit('Budapest').
circuit('Porto').

winner('Porto', 'Jones').
winner('Budapest', 'Mangold').
winner('Istanbul', 'Mangold').

numberGates('Istanbul', 9).
numberGates('Budapest', 6).
numberGates('Porto', 5).

winnerTeam(Team, City) :- winner(City, Pilot), team(Team, Pilot).

moreThanOne(Pilot) :- winner(City1, Pilot), winner(City2, Pilot), City1\=City2.

moreThan8Gates(Circuit) :- numberGates(Circuit, Gates), Gates>8.

notEdge540(Pilot) :- planeFromPilot(Pilot, Plane), Plane\='Edge540'.


/*winner('Porto', X).
winnerTeam(Team, 'Porto').
moreThanOne(Pilot).
moreTahn8Gates(Circuit)
notEdge540(Pilot)*/
