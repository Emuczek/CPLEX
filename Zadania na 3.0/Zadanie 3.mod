/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Jakub
 * Creation Date: Apr 17, 2023 at 7:02:25 PM
 
 Zadanie 3
 
Parametry problemu:
• zbiór liczb całkowitych 𝑍,
• zbiór 𝑛 plecaków, gdzie każdy plecak ma pojemność 𝑝1, 𝑝2, … , 𝑝𝑛,
• zbiór 𝑛 mnożników wartości 𝑚1, 𝑚2, … , 𝑚𝑛 (tzn. liczba ze zbioru 𝑍 umieszczona w 
plecaku o pojemności 𝑝1 jest mnożona razy 𝑚1; mnożnik mniejsza objętość plecaka),
• 𝑝𝑖 ∈ ℕ+, 𝑚𝑖 ∈ ℕ+.
Problem: Należy zminimalizować sumę liczb, które nie zostały umieszczone w plecakach.

 *********************************************/

 range z_r = 1..12;
 int z_i[z_r] = [30, 30, 2, 3, 9, 1, 2, 3, 5, 100, 26, 4]; // zbiór liczb
 
 int n_i = 2; // ilość plecaków
 range n_r = 1..n_i;
 int p_i[n_r] = [30, 40]; // pojemości plecaków
 int m_i[n_r] = [2, 1]; // mnożniki plecaków
 
 dvar boolean x_b[n_r][z_r];
 
 maximize sum(i in n_r) (sum(j in z_r) (x_b[i][j])); // maksymalizujemy sumę wybranych liczb
 
 subject to
 {
   forall(i in n_r) (sum(j in z_r) (x_b[i][j]*z_i[j]*m_i[i])) <= p_i[i]; // nie można przekroczyć objętości plecaka
   forall(i in z_r) sum(j in n_r)x_b[j][i] <= 1; // przedmiot można wybrać tylko raz
 }