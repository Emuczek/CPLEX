/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Jakub
 * Creation Date: Mar 7, 2023 at 11:53:50 AM
 *********************************************/
 
 int ilo = 6;
 int p = 1000;
 
 range rang = 1..ilo;
 
 int waga[rang] = [4, 5, 7, 2, 4, 9];
 int wartosc[rang] = [4, 5, 9, 2, 2, 4];

 dvar int+ x[rang];
 
 maximize sum(i in rang)wartosc[i]*x[i];
 
 subject to
 {
   sum(i in rang)waga[i]*x[i] <= p;
 }
