%airport(Name, ICAO, Country)
airport('Aeroporto Francisco Sá Carneiro', 'LPPR', 'Portugal').
airport('Aeroporto Humberto Delgado', 'LPPT', 'Portugal').
airport('Aeropuerto Adolfo Suárez Madrid-Barajas', 'LEMD', 'Spain').
airport('Aéroport de Pairs-Charles-de-Gaulle Roissy Airport', 'LFPG', 'France').
airport('Aeroporto Internazionale di Roma-Fiumcino - Leonardo da Vinci', 'LIRF', 'Italy').

%company(ICAO, Name, Year, Country)
company('TAP', 'TAP Air Portugal', 1945, 'Portugal').
company('RYR', 'Ryanair', 1984, 'Ireland').
company('AFR', 'Société Air France, S.A', 1933, 'France').
company('BAW', 'British Airways', 1974, 'United Kingdom').

%flight(Designation, Origin, Destination, DepartureTime, Duration, Company)
flight('TP1923', 'LPPR', 'LPPT', 1115, 55, 'TAP').
flight('TP1968', 'LPPT', 'LPPR', 2235, 55, 'TAP').
flight('TP842', 'LPPT', 'LIRF', 1450, 195, 'TAP').
flight('TP843', 'LIRF', 'LPPT', 1935, 195, 'TAP').
flight('TP5483', 'LPPR', 'LEMD', 630, 105, 'RYR').
flight('TP5484', 'LEMD', 'LPPR', 1935, 105, 'RYR').
flight('AF1024', 'LFPG', 'LPPT', 940, 155, 'AFR').
flight('AF1025', 'LPPT', 'LFPG', 1310, 155, 'AFR').

%question 1

short(Flight) :-
flight(Flight, _, _, _, Duration, _),
Duration < 90.

%question 2
shorter(Flight1, Flight2, ShorterFlight) :-
flight(Flight1, _, _, _, Duration1, _),
flight(Flight2, _, _, _, Duration2, _),
compare(Flight1, Duration1, Flight2, Duration2, ShorterFlight).


compare(Flight1, Duration1, _, Duration2, ShorterFlight) :-
Duration1 < Duration2,
ShorterFlight = Flight1.

compare(_, Duration1, Flight2, Duration2, ShorterFlight) :-
Duration1 > Duration2,
ShorterFlight = Flight2.

%question 3
arrivalTime(Flight, ArrivalTime) :-
flight(Flight, _, _, StartTime, Duration, _),
concatateTime(StartTime, Duration, ArrivalTime).

concatateTime(StartTime, Duration, ArrivalTime) :-
StartHours is StartTime // 100,
StartMinutes is mod(StartTime, 100),

Minutes is (mod(Duration, 60) + StartMinutes),
MinutesConcatation is mod(Minutes, 60),

HoursDuration is Duration//60 + Minutes//60,
HoursConcatation is (HoursDuration + StartHours)* 100,

ArrivalTime is HoursConcatation + MinutesConcatation.

%question 4
countries(AirLine, List) :-
countriesCycle(AirLine, [], List).

countriesCycle(AirLine, OldList, NewList) :-
operates(AirLine, Country),
\+member(Country, OldList),
append(OldList, [Country], OldListNew), !,
countriesCycle(AirLine, OldListNew, NewList).

countriesCycle(_, OldList, OldList).

operates(AirLine, Country) :-
flight(_, Airport_Begin, _, _, _, AirLine),
airport(_, Airport_Begin, Country).

operates(AirLine, Country) :-
flight(_, _, Airport_End, _, _, AirLine),
airport(_, Airport_End, Country).

operates(_, _) :- !.

%question 5

pairableFlights :-
flight(ID1, _, Airport_Scale, _, _, _),
flight(ID2, Airport_Scale, _, DepartureTime, _, _),
arrivalTime(ID1, ArrivalTime),
differance(ArrivalTime, DepartureTime),
write(Airport_Scale), write(' - '), write(ID1), write(' \\ '), write(ID2), nl,
fail.

pairableFlights :- true.

differance(ArrivalTime, DepartureTime) :-
ArrivalInMinutes is (ArrivalTime//100)*60 + mod(ArrivalTime, 100),
DepartureInMinutes is (DepartureTime//100)*60 + mod(DepartureTime, 100),
DiffMinutes is DepartureInMinutes - ArrivalInMinutes,
DiffMinutes >= 30, DiffMinutes =< 90.

pairableFlights(ArrivalTime, DepartureTime, 0) :-
ArrivalInMinutes is (ArrivalTime//100)*60 + mod(ArrivalTime, 100),
DepartureInMinutes is (DepartureTime//100)*60 + mod(DepartureTime, 100),
DiffMinutes is DepartureInMinutes - ArrivalInMinutes,
DiffMinutes >= 30.

pairableFlights(ArrivalTime, DepartureTime, 1) :-
ArrivalInMinutes is (ArrivalTime//100)*60 + mod(ArrivalTime, 100),
DepartureInMinutes is (DepartureTime//100)*60 + mod(DepartureTime, 100),
DiffMinutes is DepartureInMinutes - ArrivalInMinutes,
DiffMinutes < 0.

%question 6
tripDays([_], _, [], 1).

tripDays([Ori, Dest | Tail], Time, [DepartureTime | FlightTimes], Days) :-
airport(_, IDOri, Ori),
airport(_, IDdest, Dest),
flight(Flight, IDOri, IDdest, DepartureTime, _, _),
arrivalTime(Flight, ArrivalTime),
pairableFlights(Time, DepartureTime, N),
tripDays([Dest | Tail], ArrivalTime, FlightTimes, NewDays),
Days is NewDays + N.

%question 7

:-use_module(library(lists)).

avgFlightLengthFromAirport(Airport, AvgLength):-
    findall(Duration, (airport(_, Airport, _), flight(_, Airport, _, _, Duration, _)), Durations),
    sumlist(Durations, Sum),
    length(Durations, L),
    AvgLength is Sum / L.

