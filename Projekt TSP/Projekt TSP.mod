/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Jakub
 * Creation Date: May 8, 2023 at 10:26:57 PM
 *********************************************/
 
 // WERSJA 1.0 (09/05/2023 01:21 AM)
 
 int i_x = 4;
 range r_x = 1..i_x; // długość wektora zmiennych decyzyjnych (nadmiarowy)
 
 int i_k = 2; // ilość kuriersów
 range r_k = 1..i_k;
 
 int i_p = 5; // ilość miejsc na mapie
 range r_p = 1..i_p;
 
 int i_m = 4; // ilość miejsc do odwiedzenia
 range r_m = 1..i_m;
 int m_m[r_m] = [2, 3, 4, 1]; // miejsca do odwiedzenia
 
 int i_s = 5; // miejsce startu kuriersów
 
 int m_d[r_p][r_p] =    [ [0,   -1,   228, 319,  219] ,
						  [-1,   0,   185, 83,   180] ,
						  [228, 185, 0,   94,   -1] ,
						  [319, 83,  94,  0,    255] ,
						  [219, 180, -1,   255,  0] ];
												
dvar int x[r_k][r_x] in 1..i_p;

minimize sum(i in r_k)( sum(j in 1..i_x-1)( sum(l in r_p) (sum (k in r_p)((x[i][j] == l && x[i][j+1] == k)*m_d[l][k])))); // minimalizujemy "koszt" przejazdu wszystkich kuriersów
					
subject to
{
  forall (i in r_m)( sum(j in r_k)( sum(l in r_x)(x[j][l] == m_m[i]) ) >= 1); // odwiedziliśmy każde miejsce (wszystkie elementy z miejsc są w macierzy kurierów)
  forall (i in r_k, j in 1..i_x-1) sum(l in r_p)(sum (k in r_p)((x[i][j] == l && x[i][j+1] == k)*m_d[l][k])) >= 0; // węzeł musi mieć ścieżkę do kolejnego węzła
  forall (i in r_k) x[i][1] == i_s; // ścieżka kuriera musi się zaczynać w punkcie startowym
}
