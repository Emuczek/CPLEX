/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Jakub
 * Creation Date: May 8, 2023 at 10:26:57 PM
 *********************************************/
 
 // WERSJA 3.0 (16/05/2023 15:00 AM)
 
 using CP;
 
 int i_x = 6;
 range r_x = 1..i_x; // długość wektora zmiennych decyzyjnych (nadmiarowy)
 
 int i_k = 3; // ilość kurierów
 range r_k = 1..i_k;
 
 int i_p = 8; // ilość miejsc na mapie         
 range r_p = 1..i_p;
 
 int i_m = 6; // ilość miejsc do odwiedzenia
 range r_m = 1..i_m;
 int m_m[r_m] = [1, 3, 4, 5, 7, 8]; // miejsca do odwiedzenia
 
 int i_s=5; // miejsce z którego startują kurierzy
 
 int m_d[r_p][r_p] =    
[ [0, 84, 301, -1, 104, 236, 252, 257] ,
[84, 0, 94, -1, 292, -1, -1, 89] ,
[301, 94, 0, 155, 207, 202, 259, 282] ,
[-1, -1, 155, 0, 117, 159, -1, -1] ,
[104, 292, 207, 117, 0, 120, 358, 153] ,
[236, -1, 202, 159, 120, 0, 109, -1] ,
[252, -1, 259, -1, 358, 109, 0, 262] ,
[257, 89, 282, -1, 153, -1, 262, 0] ];
												
dvar int x[r_k][r_x] in 1..i_p; // optymalne trasy kurierów zapisane za pomocą sekwencji wierzchołków

minimize sum(i in r_k)( sum(j in 1..i_x-1)( sum(l in r_p) (sum (k in r_p)((x[i][j] == l && x[i][j+1] == k)*m_d[l][k])))) + sum(i in r_k)( sum(j in 1..i_x-1)((x[i][j] !=  x[i][j+1])*j)); // minimalizujemy "koszt" przejazdu wszystkich kurierów
//            ^suma po każdym ruchu każdego kuriera^	 ^zapis odnalezienia odległości pomiędzy kolejnymi węzłami jako mnożenia^  ^kryterium w postaci kary, aby kurier jak najszybciej dotarł do wymaganych miejsc (zatrzymał się dopiero na końcu)^
subject to
{
  forall (i in r_m)( sum(j in r_k)( sum(l in r_x)(x[j][l] == m_m[i]) ) >= 1); // odwiedziliśmy każde miejsce (wszystkie elementy z miejsc są w macierzy kurierów)
  forall (i in r_k, j in 1..i_x-1)( sum(l in r_p)(sum (k in r_p)((x[i][j] == l && x[i][j+1] == k)*m_d[l][k])) >= 0); // węzeł musi mieć ścieżkę do kolejnego węzła, albo kurier stoi w miejscu (=0)
  forall (i in r_k) x[i][1] == i_s; // ścieżka kuriera musi się zaczynać w punkcie startowym
  forall (j in 2..i_x, i in 1..i_k-1) x[i][j] != x[i+1][j]; // dwóch kurierów nie może być w tym samym miejscu na raz
}