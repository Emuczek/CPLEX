/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Jakub
 * Creation Date: Apr 17, 2023 at 8:01:31 PM
 
Zadanie 2
 
Problem rozmieszczenia w dwuwymiarowej przestrzeni Euklidesowej
Parametry problemu: parametry takie same jak w problemie 1
Problem: Należy wybrać lokalizacje ze zbioru L dla wszystkich P obiektów w taki sposób,
aby suma odległości pomiędzy każdą wybraną lokalizacją dla obiektu a punktami
referencyjnymi, które zostały do niego przypisane, była jak najmniejsza.

 *********************************************/

 int p_i = 3; // ilość punktów do rozmieszczenia

 int n_l = 6; // ilość lokacji
 range l_r = 1..n_l;
 
 int n_r = 4; // ilość puntków referencyjnych
 range r_r = 1..n_r;


 range t_r = 1..2; // range do współrzędnych
 
 int l_i[l_r][t_r] = [[0, 0], [0, 5], [0, 2], [3, 0], [3, 2], [3, 4]]; // współrzędne lokacji
 int r_i[r_r][t_r] = [[1, 0], [1, 1], [1, 2], [3, 0]]; // współrzędne punktów
 
 dvar boolean x_b[l_r];
 
 
 minimize sum(i in l_r) (sum(j in r_r) (x_b[i]*(abs(l_i[i][1]-r_i[j][1])) + (abs(l_i[i][2]-r_i[j][2])))); // zminimalizuj sumę minimów odległości
 
 subject to
 {	   
 	 sum(i in l_r)x_b[i] == p_i;   	   
 }