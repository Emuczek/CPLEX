/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Jakub
 * Creation Date: Apr 18, 2023 at 12:29:40 AM
 
 2. Problem komiwojażera
 
Parametry problemu: graf G; długości ścieżek pomiędzy wszystkimi wierzchołkami grafu
Problem: Należy znaleźć najkrótszą ścieżkę w grafie, która przechodzi przez wszystkie jego
wierzchołki.
 
 *********************************************/

 int n = 6;
 int graf[1..n][1..n] = [[999,  2,999,  1,999,999],
                         [  2,999,  3,  5,999,999],
 						 [999,  3,999,999,  1,999],
 						 [  1,  5,999,999,  3,  8],
 						 [999,999,  1,  3,999,  2],
 						 [999,999,999,  8,  2,999]];

 dvar boolean x[1..n][1..n];


 minimize sum(i in 1..n, j in 1..n) x[i][j]*graf[i][j];

 subject to{
   forall(i in 1..n) sum(j in 1..n) x[i][j] == 1;
   forall(i in 1..n) sum(j in 1..n) x[j][i] == 1;
   forall(i,j in 1..n) x[i][j] + x[j][i] <= 1;
 }