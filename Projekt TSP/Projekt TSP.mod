/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Jakub
 * Creation Date: May 8, 2023 at 10:26:57 PM
 *********************************************/
 
 // WERSJA 3.0 (16/05/2023 15:00 AM)
 
 int i_x = 4;
 range r_x = 1..i_x; // długość wektora zmiennych decyzyjnych (nadmiarowy)
 
 int i_k = 2; // ilość kurierów
 range r_k = 1..i_k;
 
 int i_p = 6; // ilość miejsc na mapie         
 range r_p = 1..i_p;
 
 int i_m = 5; // ilość miejsc do odwiedzenia
 range r_m = 1..i_m;
 int m_m[r_m] = [1, 2, 3, 4, 6]; // miejsca do odwiedzenia
 
int i_s=5; // miejsce z którego startują kurierzy
 
 int m_d[r_p][r_p] =    [ [0,   151,  -1,   356,  -1,   254] ,
						  [151, 0,    -1,   265,  197,  -1] ,
						  [-1,  -1,   0,    23,   353,  167] ,
						  [356, 265,  23,   0,    33,   146] ,
						  [-1,  197,  353,  33,   0,    232] ,
						  [254, -1,   167,  146,  232,  0] ];
												
dvar int x[r_k][r_x] in 1..i_p; // optymalne trasy kurierów zapisane za pomocą sekwencji wierzchołków

minimize sum(i in r_k)( sum(j in 1..i_x-1)( sum(l in r_p) (sum (k in r_p)((x[i][j] == l && x[i][j+1] == k)*m_d[l][k])))) + sum(i in r_k)( sum(j in 1..i_x-1)((x[i][j] !=  x[i][j+1])*j)); // minimalizujemy "koszt" przejazdu wszystkich kuriersów
//            ^suma po każdym ruchu każdego kuriera^	 ^zapis odnalezienia odległości pomiędzy kolejnymi węzłami jako mnożenia^  ^kryterium w postaci kary, aby kurier jak najszybciej dotarł do wymaganych miejsc (zatrzymał się dopiero na końcu)^
subject to
{
  forall (i in r_m)( sum(j in r_k)( sum(l in r_x)(x[j][l] == m_m[i]) ) >= 1); // odwiedziliśmy każde miejsce (wszystkie elementy z miejsc są w macierzy kurierów)
  forall (i in r_k, j in 1..i_x-1)( sum(l in r_p)(sum (k in r_p)((x[i][j] == l && x[i][j+1] == k)*m_d[l][k])) >= 0); // węzeł musi mieć ścieżkę do kolejnego węzła
  forall (i in r_k) x[i][1] == i_s; // ścieżka kuriera musi się zaczynać w punkcie startowym
  forall (j in 2..i_x, i in 1..i_k-1) x[i][j] != x[i+1][j]; // dwóch kurierów nie może być w tym samym miejscu na raz
}