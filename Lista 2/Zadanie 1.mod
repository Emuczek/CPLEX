/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Jakub
 * Creation Date: Apr 17, 2023 at 9:38:06 PM
 
Zadanie 2

Najkrótsza ścieżka pomiędzy dwoma węzłami w grafie
Parametry problemu: graf G; długości ścieżek pomiędzy wszystkimi wierzchołkami grafu;
początkowy wierzchołek grafu P oraz końcowy wierzchołek grafu K
Problem: Należy znaleźć najkrótszą ścieżkę w grafie pomiędzy dwoma węzłami P i K.

 *********************************************/

 int n_i = 5; // rozmiar grafu
 range n_r = 1..n_i;
 
 int o_i[n_r][n_r] = [[999,   4,  10, 999, 999],
                      [999, 999,   4, 999, 999],
                      [999, 999, 999,   4,   7],
                      [999, 999, 999, 999,   4],
                      [999, 999, 999, 999, 999]]; // macierz odległości
                        
 int start = 1; // początkowy wierzchołek
 int stop = 4; // docelowy wierzchołek
 
 dvar boolean x_b[1..5][1..5];
 
 minimize sum(i in n_r) (sum(j in n_r) (x_b[i][j]*o_i[i][j]));
 
 subject to
 { 
 	sum (j in n_r) x_b[start][j] == 1;
    sum (j in n_r) x_b[j][stop] == 1;
    forall(i, j in n_r) x_b[i][j] + x_b[j][i] <= 1;
    forall(i in n_r: i not in {start, stop}) sum(j in n_r) x_b[i][j] == sum(j in n_r) x_b[j][i];
 }