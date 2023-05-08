/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Jakub
 * Creation Date: May 8, 2023 at 10:26:57 PM
 *********************************************/
 
 // WERSJA 1.0 (09/05/2023 01:21 AM)
 
 range r_x = 1..100; // długość wektora zmiennych decyzyjnych (nadmiarowy)
 
 int i_k = 3; // ilość kuriersów
 range r_k = 1..i_k;
 
 int i_p = 10; // ilość miejsc na mapie
 range r_p = 1..i_p;
 
 int i_m = 7; // ilość miejsc do odwiedzenia
 range r_m = 1..i_m;
 int m_m[r_m] = [2, 3, 5, 6, 7, 8, 9]; // miejsca do odwiedzenia
 
 int i_s = 5; // miejsce startu kuriersów
 
 int m_d[r_p][r_p] =    [ [0, 256, 366, 0, 280, 259, 0, 157, 181, 34] , //macierz odległości
						[256, 0, 372, 0, 259, 0, 202, 0, 59, 295] ,
						[366, 372, 0, 131, 166, 128, 0, 124, 250, 289] ,
						[0, 0, 131, 0, 239, 106, 234, 266, 321, 167] ,
						[280, 259, 166, 239, 0, 68, 233, 203, 34, 0] ,
						[259, 0, 128, 106, 68, 0, 0, 96, 194, 261] ,
						[0, 202, 0, 234, 233, 0, 0, 0, 147, 98] ,
						[157, 0, 124, 266, 203, 96, 0, 0, 184, 188] ,
						[181, 59, 250, 321, 34, 194, 147, 184, 0, 0] ,
						[34, 295, 289, 167, 0, 261, 98, 188, 0, 0] ];
						
dvar int x[r_k][r_x];

minimize sum(i in r_k)( sum(j in 1..i_k-1) m_d[x[i][j]][x[i][j+1]]); // minimalizujemy "koszt" przejazdu wszystkich kuriersów
						
subject to
{
  forall (i in r_m)( sum(j in r_k)( sum(l in r_x)(x[j][l] == m_m[i]) ) >= 1); // odwiedziliśmy każde miejsce (wszystkie elementy z miejsc są w macierzy kurierów)
  forall (i in r_k, j in r_x) m_d[x[i][j]][x[i][j+1]] != 0; // węzeł musi mieć ścieżkę do kolejnego węzła
  forall (i in r_k) x[i][1] == i_s; // ścieżka kuriera musi się zaczynać w punkcie startowym
  if (x[i][j] != 0) {         // w przypadku zera (brak ruchu) nie sprawdzaj (przecierz wtedy kurier nie sprawdzi, że tam może już ktoś czekać)
      x[i][j] != x[i][j+1];   // aaaaaaaaaaaa
   } else {
      true;
   }
  forall (j in r_k, i in r_x) x[i][j] != x[i][j+1]; // dwóch kurierów nie może być w tym samym czasie w jednym węźle 
}