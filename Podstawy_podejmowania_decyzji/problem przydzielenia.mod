/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Jakub
 * Creation Date: Mar 7, 2023 at 12:18:00 PM
 *********************************************/
 
 int n = 10;
 range rang = 1..n;
 int Z[rang] = [4, 7, 6, 8, 5, 3, 9, 6, 5, 4];
 range dubel = 1..2;

 dvar boolean x[dubel][rang];
 
 minimize abs(sum(j in rang)x[1][j]*Z[j] - sum(j in rang)x[2][j]*Z[j]);
 
 subject to
 {
   sum(i in dubel)sum(j in rang)x[i][j] == n;
   forall(i in rang) x[1][i]+x[2][i] == 1;
 }