% corpo(Nome, GravidadeRelativa, TemAtmosfera, Tipo)
corpo(terra, alto, sim, planeta).
corpo(lua, baixo, nao, satelite).
corpo(marte, medio, fina, planeta).
corpo(jupiter, altissimo, sim, planeta).
corpo(europa, baixo, nao, satelite).
corpo(venus, alto, densa, planeta).
corpo(saturno, altissimo, sim, planeta).
corpo(titan, baixo, sim, satelite).

% delta_v(Origem, Destino, DeltaV)
delta_v(terra, lua,     3.9).
delta_v(terra, marte,   5.6).
delta_v(terra, venus,   5.2).
delta_v(terra, jupiter, 8.8).
delta_v(terra, saturno, 10.3).
delta_v(terra, titan, 12.1).
delta_v(terra, europa, 10.8).

delta_v(lua, marte,   2.1).
delta_v(lua, terra, 0.8).
delta_v(lua, venus, 2.0).
delta_v(lua, jupiter, 5.2).
delta_v(lua, saturno, 6.1).
delta_v(lua, europa, 6.2).
delta_v(lua, titan, 7.1).

delta_v(marte, terra,   1.5).
delta_v(marte, lua,     2.2).
delta_v(marte, venus,   2.7).
delta_v(marte, jupiter, 3.5).
delta_v(marte, europa,  5.5).
delta_v(marte, saturno, 4.9).
delta_v(marte, titan,   6.7).

delta_v(jupiter, europa, 2.0).
delta_v(jupiter, terra,   6.3).
delta_v(jupiter, marte,   5.0).
delta_v(jupiter, saturno, 2.8).
delta_v(jupiter, titan,  4.6).
delta_v(jupiter, lua, 5.6).
delta_v(jupiter, venus, 7.7).

delta_v(saturno, titan,  1.8).
delta_v(saturno, terra,  7.3).
delta_v(saturno, jupiter, 3.2).
delta_v(saturno, marte, 5.8).
delta_v(saturno, lua, 6.5).
delta_v(saturno, venus, 12.5).
delta_v(saturno, europa, 5.2).

delta_v(venus, terra,   1.3).  
delta_v(venus, lua,     2.6).
delta_v(venus, marte,   3.2).
delta_v(venus, jupiter, 6.0).
delta_v(venus, saturno, 7.5).
delta_v(venus, europa,  8.0).  
delta_v(venus, titan,   9.3).

delta_v(europa, jupiter, 2.0).  
delta_v(europa, terra,   8.3).  
delta_v(europa, lua,     7.6).  
delta_v(europa, marte,   7.0). 
delta_v(europa, saturno, 4.8). 
delta_v(europa, titan,   6.6). 
delta_v(europa, venus,   9.7).

delta_v(titan, saturno, 1.8).   
delta_v(titan, terra,   9.1).   
delta_v(titan, lua,     8.3).  
delta_v(titan, marte,   7.6).   
delta_v(titan, jupiter, 5.0).  
delta_v(titan, europa,  7.0).  
delta_v(titan, venus,   14.3).

% foguete(Nome, CargaMaxKg, DeltaVKms, TripulacaoMax, Status)
foguete(falcon9,   22500,  8.0, 7,   operacional).
foguete(new_glenn, 45000,  9.0, 0,   operacional).
foguete(falconheavy, 63800, 11.0, 0, operacional).
foguete(sls,       95000,  6.8, 4,   operacional).
foguete(starship,  150000, 19.0, 100, desenvolvimento).

% duracao(Origem, Destino, Dias)
orbita(terra, lua, 3).
orbita(lua, terra, 3).
orbita(jupiter, europa, 30).
orbita(europa, jupiter, 30).
orbita(saturno, titan, 25).
orbita(titan, saturno, 25).

viagem_base(terra, marte, 259).
viagem_base(terra, venus, 110).
viagem_base(terra, jupiter, 600).
viagem_base(terra, saturno, 1200).

viagem_base(marte, jupiter, 1000).
viagem_base(marte, terra, 259).
viagem_base(marte, venus, 218).
viagem_base(marte, saturno, 2389).

viagem_base(venus, marte, 218).
viagem_base(venus, terra, 110).
viagem_base(venus, jupiter, 931).
viagem_base(venus, saturno, 2135).

viagem_base(jupiter, marte, 1000).
viagem_base(jupiter, terra, 600).
viagem_base(jupiter, saturno, 3672).
viagem_base(jupiter, venus, 931).

viagem_base(saturno, terra, 1200).
viagem_base(saturno, marte, 2389).
viagem_base(saturno, jupiter, 3672).
viagem_base(saturno, venus, 2135).

duracao(Origem, Destino, TempoTotal) :-
    viagem_base(Origem, Destino, TempoTotal).

duracao(Origem, Destino, TempoTotal) :-
    orbita(Origem, Destino, TempoTotal).

duracao(Origem, Satelite, TempoTotal) :-
    orbita(PlanetaDono, Satelite, TempoLocal),
    viagem_base(Origem, PlanetaDono, TempoAtePlaneta),
    TempoTotal is TempoAtePlaneta + TempoLocal.

duracao(Satelite, Destino, TempoTotal) :-
    orbita(PlanetaDono, Satelite, TempoLocal),
    viagem_base(PlanetaDono, Destino, TempoAteDestino),
    TempoTotal is TempoLocal + TempoAteDestino.

duracao(Sat1, Sat2, TempoTotal) :-
    orbita(Dono1, Sat1, TempoLocal1),
    orbita(Dono2, Sat2, TempoLocal2),
    viagem_base(Dono1, Dono2, TempoEntrePlanetas),
    TempoTotal is TempoLocal1 + TempoEntrePlanetas + TempoLocal2.

etapas(terra, lua, [
    'Lancamento para orbita baixa (LEO)',
    'Injecao trans-lunar (TLI)',
    'Captura orbital lunar (LOI)',
    'Descida e pouso'
]).

etapas(terra, marte, [
    'Lancamento para orbita baixa (LEO)',
    'Injecao trans-Marte (TMI)',
    'Cruceiro interplanetario (~259 dias)',
    'Captura orbital em Marte (MOI)',
    'Entrada, descida e pouso (EDL)'
]).

etapas(terra, venus, [
    'Lancamento para orbita baixa (LEO)',
    'Injecao trans-Venus (TVI)',
    'Cruceiro interplanetario (~110 dias)',
    'Captura orbital em Venus',
    'Missao orbital ou atmosferica'
]).

etapas(terra, jupiter, [
    'Lancamento para orbita baixa (LEO)',
    'Manobra gravitacional em Venus ou Terra',
    'Cruceiro interplanetario (~600 dias)',
    'Captura orbital em Jupiter'
]).

etapas(terra, saturno, [
    'Lancamento para orbita baixa (LEO)',
    'Multiplas manobras gravitacionais',
    'Cruceiro interplanetario (~1200 dias)',
    'Captura orbital em Saturno'
]).

etapas(jupiter, europa, [
    'Saida da orbita de Jupiter',
    'Transferencia para Europa',
    'Captura orbital em Europa',
    'Missao de superficie ou orbita'
]).


etapas(_, _, [
    'Lancamento e saida da orbita de origem',
    'Cruceiro interplanetario',
    'Captura orbital no destino',
    'Operacoes no destino'
]).

alerta(_, jupiter,  'ALERTA: Radiacao intensa proxima a Jupiter — protecao extra necessaria.').
alerta(_, europa,   'ALERTA: Superficie de gelo — equipamentos especiais para perfuracao.').
alerta(_, venus,    'ALERTA: Pressao e temperatura extremas na superficie de Venus.').
alerta(_, saturno,  'ALERTA: Missao de longa duracao — suprimentos para mais de 3 anos.').
alerta(_, marte,    'AVISO: Tempestades de poeira em Marte podem durar meses.').
alerta(Foguete, _, 'AVISO: Foguete em desenvolvimento — risco adicional.') :-
    foguete(Foguete, _, _, _, desenvolvimento).

% Escolhe o menor foguete que atende todos os requisitos
selecionar_foguete(Origem, Carga, Tripulacao, Destino, Foguete) :-
    delta_v(Origem, Destino, DVNecessario),
    foguete(Foguete, CargaMax, DVFoguete, TripMax, _),
    Carga =< CargaMax,
    Tripulacao =< TripMax,
    DVFoguete >= DVNecessario.

% Missao sem tripulacao (sonda)
selecionar_foguete(Origem, Carga, 0, Destino, Foguete) :-
    delta_v(Origem, Destino, DVNecessario),
    foguete(Foguete, CargaMax, DVFoguete, _, _),
    Carga =< CargaMax,
    DVFoguete >= DVNecessario.

missao_viavel(Origem, Destino, Carga, Tripulacao) :-
    delta_v(Origem, Destino, _),
    selecionar_foguete(Origem, Carga, Tripulacao, Destino, _).

diagnostico_inviavel(Origem, Destino, _, _) :-
    \+ delta_v(Origem, Destino, _),
    write('  >> Destino desconhecido ou sem rota mapeada.'), nl.

diagnostico_inviavel(Origem, Destino, Carga, Tripulacao) :-
    delta_v(Origem, Destino, DVNecessario),
    \+ (foguete(_, CargaMax, DVFoguete, TripMax, _),
        Carga =< CargaMax,
        Tripulacao =< TripMax,
        DVFoguete >= DVNecessario),
    write('  >> Nenhum foguete disponivel atende todos os requisitos:'), nl,
    write('     - Verifique se a carga nao excede a capacidade maxima.'), nl,
    write('     - Verifique se ha foguete com tripulacao suficiente.'), nl,
    format('     - Delta-v necessario: ~w km/s~n', [DVNecessario]).


exibir_alertas(Foguete, Destino) :-
    forall(
        alerta(Foguete, Destino, Msg),
        (write('  '), write(Msg), nl)
    ).


exibir_etapas([], _).
exibir_etapas([H|T], N) :-
    format('    Etapa ~w: ~w~n', [N, H]),
    N1 is N + 1,
    exibir_etapas(T, N1).


% planejar_missao(+Origem, +Destino, +CargaKg, +Tripulacao)
planejar_missao(Origem, Destino, Carga, Tripulacao) :-
    nl,
    write('============================================'), nl,
    write('     PLANEJADOR DE MISSOES ESPACIAIS        '), nl,
    write('============================================'), nl,
    format('  Origem:      ~w~n', [Origem]),
    format('  Destino:     ~w~n', [Destino]),
    format('  Carga:       ~w kg~n', [Carga]),
    format('  Tripulacao:  ~w pessoas~n', [Tripulacao]),
    write('--------------------------------------------'), nl,
    (   missao_viavel(Origem, Destino, Carga, Tripulacao)
    ->  % VIAVEL
        selecionar_foguete(Origem, Carga, Tripulacao, Destino, Foguete),
        delta_v(Origem, Destino, DV),
        duracao(Origem, Destino, Dias),
        etapas(Origem, Destino, Etapas),
        write('  STATUS: MISSAO VIAVEL'), nl,
        write('--------------------------------------------'), nl,
        format('  Foguete selecionado: ~w~n', [Foguete]),
        format('  Delta-v necessario:  ~w km/s~n', [DV]),
        format('  Duracao estimada:    ~w dias~n', [Dias]),
        write('--------------------------------------------'), nl,
        write('  ETAPAS DA MISSAO:'), nl,
        exibir_etapas(Etapas, 1),
        write('--------------------------------------------'), nl,
        write('  ALERTAS:'), nl,
        exibir_alertas(Foguete, Destino)
    ;   % INVIAVEL
        write('  STATUS: MISSAO INVIAVEL'), nl,
        write('--------------------------------------------'), nl,
        write('  MOTIVO:'), nl,
        diagnostico_inviavel(Origem, Destino, Carga, Tripulacao)
    ),
    write('============================================'), nl, nl.


destinos_disponiveis :-
    nl,
    write('Destinos disponiveis a partir da Terra:'), nl,
    forall(
        delta_v(terra, Destino, DV),
        format('  -> ~w  (delta-v: ~w km/s)~n', [Destino, DV])
    ), nl.

foguetes_disponiveis :-
    nl,
    write('Foguetes disponiveis:'), nl,
    forall(
        foguete(Nome, Carga, DV, Trip, Status),
        format('  ~w | carga: ~w kg | delta-v: ~w km/s | tripulacao: ~w | status: ~w~n',
               [Nome, Carga, DV, Trip, Status])
    ), nl.


demo :-
    write('=== DEMO: MISSOES DE EXEMPLO ==='), nl,
    planejar_missao(terra, lua,     5000,  3),
    planejar_missao(terra, marte,   10000, 4),
    planejar_missao(terra, jupiter, 3000,  0),
    planejar_missao(terra, marte,   200000, 6).  