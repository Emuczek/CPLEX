/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Jakub
 * Creation Date: May 8, 2023 at 10:26:57 PM
 *********************************************/
 
 // WERSJA 2.0 (16/05/2023 01:19 AM)
 
 int i_x = 3;
 range r_x = 1..i_x; // długość wektora zmiennych decyzyjnych (nadmiarowy)
 
 int i_k = 3; // ilość kuriersów
 range r_k = 1..i_k;
 
 int i_p = 6; // ilość miejsc na mapie          33+23+  197+
 range r_p = 1..i_p;
 
 int i_m = 5; // ilość miejsc do odwiedzenia
 range r_m = 1..i_m;
 int m_m[r_m] = [1, 2, 3, 4, 5]; // miejsca do odwiedzenia
 
 int i_s = 5; // miejsce startu kuriersów
 
 int m_d[r_p][r_p] =    [ [0,   151,  -1,   356,  -1,   254] ,
						  [151, 0,    -1,   265,  197,  -1] ,
						  [-1,  -1,   0,    23,   353,  167] ,
						  [356, 265,  23,   0,    33,   146] ,
						  [-1,  197,  353,  33,   0,    232] ,
						  [254, -1,   167,  146,  232,  0] ];
												
dvar int x[r_k][r_x] in 1..i_p;

minimize sum(i in r_k)( sum(j in 1..i_x-1)( sum(l in r_p) (sum (k in r_p)((x[i][j] == l && x[i][j+1] == k)*m_d[l][k])))); // minimalizujemy "koszt" przejazdu wszystkich kuriersów
					
subject to
{
  forall (i in r_m)( sum(j in r_k)( sum(l in r_x)(x[j][l] == m_m[i]) ) >= 1); // odwiedziliśmy każde miejsce (wszystkie elementy z miejsc są w macierzy kurierów)
  forall (i in r_k, j in 1..i_x-1)( sum(l in r_p)(sum (k in r_p)((x[i][j] == l && x[i][j+1] == k)*m_d[l][k])) >= 0); // węzeł musi mieć ścieżkę do kolejnego węzła
  forall (i in r_k) x[i][1] == i_s; // ścieżka kuriera musi się zaczynać w punkcie startowym
}