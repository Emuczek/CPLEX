/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Jakub
 * Creation Date: Jun 15, 2023 at 2:23:54 PM
 *********************************************/
 
 
 int i_p = 8; // wymiar macierzy odzwierciedlającej planszę gry, tymsamym ilość liczb występującej w grze (1 .. p)
 range r_p = 1..i_p;
 
 
 int m_d[r_p][r_p] =    
[   [4, 8, 1, 6, 3, 2, 5, 7] ,
	[3, 6, 7, 2, 1, 6, 5, 4] ,
	[2, 3, 4, 8, 2, 8, 6, 1] ,
	[4, 1, 6, 5, 7, 7, 3, 5] ,
	[7, 2, 3, 1, 8, 1, 1, 2] ,
	[3, 5, 6, 7, 3, 1, 8, 4] ,
	[6, 4, 2, 3, 5, 4, 7, 8] ,
	[8, 7, 1, 4, 2, 3, 5, 6] ];

		
dvar boolean x_d[r_p][r_p]; // miejsca czarnych pól zapisane w binarnej macierzy odzwierciedlającą poszczególne kratki planszy gry (0 czarne 1 pozostawiona liczba)
minimize sum(i in r_p) ( sum(j in r_p) (x_d[i][j])); // maksymalizujemy ilość czarnych pól

subject to
{
  forall (i in r_p) forall(j in r_p) (sum(k in r_p) (m_d[i][j] == x_d[i][k]*m_d[i][k])  <= 1); // w każdym wierszu maks 1 powtórzenie danej liczby
  forall (i in r_p) forall(j in r_p) (sum(k in r_p) (m_d[j][i] == x_d[j][k]*m_d[j][k]) <= 1); // w każdej kolumnie maks 1 powtórzenie danej liczby
  forall (i in 1 .. i_p-1) forall(j in r_p) x_d[i][j] + x_d[i+1][j] >= 1; // czarne pola nie moga sie stykać bokami (porównuje kolejne wiersze)
  forall (i in 1 .. i_p-1) forall(j in r_p) x_d[j][i] + x_d[j][i+1] >= 1; // czarne pola nie moga sie stykać bokami (porównuje kolejne kolumny)
  forall (i in 2 .. i_p-1) forall(j in 2 .. i_p-1) x_d[j][i+1] + x_d[j][i-1] + x_d[j+1][i] + x_d[j-1][i] >= 1 ; // wyeliminowanie obudowanych czarnymi polami liczb w srodku (conajmniej jeden sąsiad)
  forall (i in 2 .. i_p-1) x_d[1][i-1] + x_d[1][i+1] + x_d[2][i] != 0; // wyeliminowanie obudowania górny wiersz (conajmiej jeden sąsiad)
  forall (i in 2 .. i_p-1) x_d[i_p][i-1] + x_d[i_p][i+1] + x_d[i_p-1][i] != 0; // wyeliminowanie obudowania dolny wiersz (conajmiej jeden sąsiad)
  forall (i in 2 .. i_p-1) x_d[i-1][1] + x_d[i+1][1] + x_d[i][2] != 0; // wyeliminowanie obudowania górna kolumna
  forall (i in 2 .. i_p-1) x_d[i-1][i_p] + x_d[i+1][i_p] + x_d[i][i_p-1] != 0; // wyeliminowanie obudowania dolna kolumna
  forall (i in 2 .. i_p) sum (j in 0 .. i-1) (x_d[1+j][i-j]) != 0; // eliminacja przekątnych oddzielających liczby (od prawy górny)
  forall (i in 1 .. i_p-1) sum (j in 0 .. i) (x_d[1+j][(i_p-i)+j]) != 0; // eliminacja przekątnych oddzielających liczby (od lewy górny)
  forall (i in 2 .. i_p) sum (j in 0 .. i-1) (x_d[i_p-j][i-j]) != 0; // eliminacja przekątnych oddzielających liczby (od prawy dolny)
  forall (i in 1 .. i_p-1) sum (j in 0 .. i-1) (x_d[i_p-j][(i_p-i)+j]) != 0; // eliminacja przekątnych oddzielających liczby (od lewy dolny)
}
