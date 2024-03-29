/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Jakub
 * Creation Date: 25 Jun 2023 at 21:37:52
 *********************************************/
 
 
int rozmiar = 6; // rozmiar siatki
range r = 1..rozmiar; 
 
int widocznosc[1..4][r] = [[2, 1, 0, 2, 2, 3], // północ
					       [3, 2, 3, 6, 2, 1], // wschód
					       [2, 0, 3, 3, 2, 1], // południe
					       [2, 4, 2, 1, 4, 2]];// zachód
					    
int czy_widocznosc[1..4][r] = [[1, 1, 0, 1, 1, 1], // północ
					      	   [1, 1, 1, 1, 1, 1], // wschód
					           [1, 0, 1, 1, 1, 1], // południe
					           [1, 1, 1, 1, 1, 1]];// zachód

		
dvar int xdvar[r][r] in r; // rozmieszczenie wieżowców
minimize 0;

subject to
{
  forall (i in r) forall(j in r) (sum(k in r) (xdvar[i][j] == xdvar[i][k]) <= 1); // w każdym wierszu maks 1 powtórzenie danej liczby
  forall (i in r) forall(j in r) (sum(k in r) (xdvar[j][i] == xdvar[k][i]) <= 1); // w każdej kolumnie maks 1 powtórzenie danej liczby
  forall (i in r) sum(j in r) ((sum(k in 1 .. j) (xdvar[j][i] <= xdvar[k][i])) <= 1)*czy_widocznosc[1][i] == widocznosc[1][i]*czy_widocznosc[1][i]; // wymagania widoku z północy
  forall (i in r) sum(j in r) ((sum(k in 1 .. j) (xdvar[i][j] <= xdvar[i][k])) <= 1)*czy_widocznosc[4][i] == widocznosc[4][i]*czy_widocznosc[4][i]; // wymagania widoku z zachodu
  forall (i in r) sum(j in r) ((sum(k in 1 .. j) (xdvar[i][rozmiar+1 - j] <= xdvar[i][rozmiar+1 - k])) <= 1)*czy_widocznosc[2][i] == widocznosc[2][i]*czy_widocznosc[2][i]; // wymagania widoku ze wschodu
  forall (i in r) sum(j in r) ((sum(k in 1 .. j) (xdvar[rozmiar+1 - j][i] <= xdvar[rozmiar+1 - k][i])) <= 1)*czy_widocznosc[3][i] == widocznosc[3][i]*czy_widocznosc[3][i]; // wymagania widoku z południa
}