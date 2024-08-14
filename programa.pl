%%%%%%%%%%%%%%%%%%%%%%%%%%% Who you gonna call? %%%%%%%%%%%%%%%%%%%%%%

herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

tarea(Tarea):-
    herramientasRequeridas(Tarea, _).

%%%%%%%%%%%%%%%%%%%% Punto 1

tiene(egon, aspiradora(200)).
tiene(egon, trapeador).
tiene(peter, trapeador).
tiene(winston, varitaNeutrones).

%%%%%%%%%%%%%%%%%%%% Punto 2

laTiene(Persona, Herramienta):-
    tiene(Persona, Herramienta).

laTiene(Persona, aspiradora(PotenciaMin)):-
    tiene(Persona, aspiradora(Potencia)),
    Potencia >= PotenciaMin.

%%%%%%%%%%%%%%%%%%%% Punto 3

realizaTarea(Persona, Tarea):-
    tarea(Tarea),
    tiene(Persona, varitaNeutrones).

realizaTarea(Persona, Tarea) :-
    herramientasRequeridas(Tarea, Herramientas),
    tiene(Persona, _),
    forall(member(Herramienta, Herramientas), laTiene(Persona, Herramienta)).

%%%%%%%%%%%%%%%%%%%% Punto 4

tareaPedida(carla, encerarPisos, 18). 
tareaPedida(carla, cortarPasto, 40). 
tareaPedida(carla, limpiarTecho, 8).  
tareaPedida(carla, limpiarBanio, 22).
tareaPedida(ricardo, ordenarCuarto, 20).  
tareaPedida(ricardo, limpiarBanio, 12).
tareaPedida(maria, limpiarTecho, 5).
tareaPedida(maria, cortarPasto, 30). 
tareaPedida(maria, encerarPisos, 25). 
tareaPedida(ana, ordenarCuarto, 15). 
 
precio(ordenarCuarto, 4). 
precio(encerarPisos, 7).  
precio(cortarPasto, 3).  
precio(limpiarTecho, 8).  
precio(limpiarBanio, 6).  

cuantoCobrar(Cliente, Monto):-
    tareaPedida(Cliente, _, _),
    findall(Costo, costoXTarea(Cliente, Costo), Costos),
    sumlist(Costos, Monto).
    
costoXTarea(Cliente, Costo) :-
    tareaPedida(Cliente, Tarea, CantMetros),
    precio(Tarea, PrecioPorMetro),
    Costo is CantMetros * PrecioPorMetro.

%%%%%%%%%%%%%%%%%%%% Punto 5

quienAcepta(Cliente, CazaPolvo):-
    tareaPedida(Cliente, _, _),
    forall(tareaPedida(Cliente, Tarea, _), realizaTarea(CazaPolvo, Tarea)), 
    dispuestoAHacerlo(Cliente, CazaPolvo).

dispuestoAHacerlo(Cliente, ray):-
    not(tareaPedida(Cliente, limpiarTecho, _)).

dispuestoAHacerlo(Cliente, winston):-
    cuantoCobrar(Cliente, Monto),
    Monto > 500.

dispuestoAHacerlo(Cliente, peter):-
    tareaPedida(Cliente, _, _).

dispuestoAHacerlo(Cliente, egon):-
    not((tareaPedida(Cliente, Tarea, _), esCompleja(Tarea))).

esCompleja(limpiarTecho).
esCompleja(Tarea):-
    herramientasRequeridas(Tarea, Herramientas),
    length(Herramientas, Cant),
    Cant > 2.

%%%%%%%%%%%%%%%%%%%% Punto 6

