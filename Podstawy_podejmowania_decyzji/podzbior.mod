/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Jakub
 * Creation Date: Mar 7, 2023 at 8:22:40 AM
 *********************************************/
 
 int c[1..6] = [3, 5, 7, 2, 1, 9];
 int N = 8;

 dvar boolean x[1..6];
 
 
minimize N - sum(i in 1..6)c[i]*x[i];
 
 subject to
 {
   N - sum(i in 1..6)c[i]*x[i] >= 0;
 }
