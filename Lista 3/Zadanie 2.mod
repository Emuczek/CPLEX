/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Jakub
 * Creation Date: Apr 17, 2023 at 9:27:12 PM
 
2. Dwuwymiarowy problem pokrycia prostokątów
 
Parametry problemu: prostokąt o wymiarach G × W; zbiór Z zawierający n prostokątów o
różnych wymiarach
Problem: Należy zweryfikować, czy istnieje podzbiór prostokątów w zbiorze Z, który idealnie
pokrywa prostokąt o wymiarach G × W.

 *********************************************/

using CP;
int n = 8;
int G = 5;
int W = 5;
int Z[1..n][1..2] = [[1,1],[2,2],[5,1],[3,1],[2,1],[3,2],[3,2],[2,3]];


dvar boolean x[1..n];
dvar int y[1..G][1..W] in 1..n;


subject to{
  forall(i in 1..n)count(all(j in 1..G, k in 1..W) y[j][k], i) == x[i]*Z[i][1]*Z[i][2];
  forall(i in 1..n)sum(k in 1..W)sum(j in 1..G-Z[i][1]+1)(count(all(z in j..Z[i][1]+j-1) y[z][k], i)==Z[i][1])==x[i]*Z[i][2];
  forall(i in 1..n)sum(k in 1..G)sum(j in 1..W-Z[i][2]+1)(count(all(z in j..Z[i][2]+j-1) y[k][z], i)==Z[i][2])==x[i]*Z[i][1];
  sum(i in 1..n)x[i]*(Z[i][1]*Z[i][2])==G*W;
}