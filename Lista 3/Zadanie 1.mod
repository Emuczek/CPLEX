/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Jakub
 * Creation Date: Apr 17, 2023 at 9:24:35 PM
 
1. Problem trójpodziału
 
Parametry problemu: zbiór liczb całkowitych Z o rozmiarze 3n, gdzie n jest dodatnią liczbą
całkowitą; liczba całkowita W
Problem: Należy zweryfikować, czy istnieją trzyelementowe podzbiory zbioru Z takie,
że wszystkie elementy każdego trzyelementowego podzbioru sumują się do liczby W oraz suma
wszystkich trzyelementowych podzbiorów jest równoważna zbiorowi Z.

 *********************************************/

 int n = 2;
 int W = 18;
 range range_Z = 1..n*3;
 int col_Z[range_Z] = [1, 6, 7, 5, 8, 9]; //[5, 6, 7, 1, 8, 9]

 dvar boolean x[1..n][range_Z];
 
 maximize  sum(i in 1..n)sum(j in range_Z)x[i][j]*col_Z[j];
 
 subject to
 {
   forall(i in range_Z) sum(j in 1..n)x[j][i] == 1;
   forall(i in 1..n) sum(j in range_Z)x[i][j]*col_Z[j] == W;
   forall(i in 1..n) sum(j in range_Z)x[i][j] == 3;
 }