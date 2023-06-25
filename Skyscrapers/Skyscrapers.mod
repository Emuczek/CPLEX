/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Jakub
 * Creation Date: 25 Jun 2023 at 21:37:52
 *********************************************/
 
 
int rozmiar = 4; // rozmiar siatki
range r = 1..rozmiar; 
 
int widocznosc[r][r] = [[3, 2, 1, 2], // północ
					    [2, 2, 1, 3], // wschód
					    [1, 3, 2, 2], // południe
					    [2, 2, 3, 1]];// zachód

		
dvar int xdvar[r][r] in r; // rozmieszczenie wieżowców
minimize 0;

subject to
{
  forall (i in r) forall(j in r) (sum(k in r) (xdvar[i][j] == xdvar[i][k]) <= 1); // w każdym wierszu maks 1 powtórzenie danej liczby
  forall (i in r) forall(j in r) (sum(k in r) (xdvar[j][i] == xdvar[k][i]) <= 1); // w każdej kolumnie maks 1 powtórzenie danej liczby
  forall (i in r) sum(j in r) ((sum(k in 1 .. j) (xdvar[j][i] <= xdvar[k][i])) <= 1) == widocznosc[1][i]; // wymagania widoku z północy
  forall (i in rozmiar .. 1) sum(j in rozmiar .. 1) ((sum(k in j .. 1) (xdvar[i][j] <= xdvar[i][k])) <= 1) == widocznosc[2][i]; // wymagania widoku ze wschodu
  forall (i in rozmiar .. 1) sum(j in rozmiar .. 1) ((sum(k in j .. 1) (xdvar[j][i] <= xdvar[k][i])) <= 1) == widocznosc[3][i]; // wymagania widoku z południa
  forall (i in r) sum(j in r) ((sum(k in 1 .. j) (xdvar[i][j] <= xdvar[i][k])) <= 1) == widocznosc[4][i]; // wymagania widoku z zachodu
}
 