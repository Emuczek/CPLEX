/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Jakub
 * Creation Date: Apr 17, 2023 at 4:46:38 PM
 
 Zadanie 1
 
Parametry problemu:
• macierz czasów realizacji 𝑝 zadań,
• 𝑚 maszyn, 
• czas realizacji zadania zależy od maszyny (tzn. realizacja zadania 𝑗 na maszynie o 
numerze 1 trwa 3 jednostki czasu, na maszynie o numerze 2 trwa 5 jednostek czasu itp.), 
• ograniczenia czasowe realizacji zadań na maszynach (tzn. maszyna o numerze 1 nie 
może pracować dłużej niż 𝑘 jednostek czasu), ograniczenia czasowe realizacji zadań
(tzn. zadanie musi zakończyć przed terminem 𝑣; np. zadanie musi zakończyć się przed
czternastą jednostką czasu przetwarzania na dowolnej maszynie),
• 𝑝 ∈ ℕ+, 𝑚 ∈ ℕ+, 𝑘 ∈ ℕ+.
Problem: Należy zminimalizować czas pracy najdłużej przetwarzającej maszyny przy 
jednoczesnym zachowaniu wymaganych ograniczeń czasowych realizacji zadań na maszynach.
 
 *********************************************/

 int p_i = 5 ; // ilość zadań
 range p_r = 1..p_i;
 
 int m_i = 2; // ilośc maszyn
 range m_r = 1..m_i;
 
 int z_i[m_r][p_r]=[[1, 2, 1, 2, 1],[10, 1, 6, 8, 1]]; // macierz czasu wykonywania zadań
 
 int k_i[m_r] = [7, 10]; // jak długo może pracować i-ta maszyna
 
 int l_i[p_r] = [20, 2, 20, 20, 20]; // przed jaką jednostką czasu musi wykonać się zadanie
 
 dvar boolean x_b[m_r][p_r]; // gdzie przydzielamy jakie zadanie
 
 float c_f = sum(i in m_r) (sum(j in p_r) (z_i[i][j]/m_i));
 
 minimize sum(i in m_r) (abs(c_f - sum(j in p_r)x_b[i][j]*z_i[i][j]));  // minimalizujemy czas pracowania maszyn
 
 subject to
 {
   	 sum(i in m_r) sum(j in p_r)x_b[i][j] == p_i; // chcemy przydzielić wszystkie zadania
     forall(i in p_r) sum(j in m_r)x_b[j][i] <= 1; // jedno zadanie do jednej maszyny
     forall(i in m_r) sum(j in p_r)x_b[i][j]*z_i[i][j] <= k_i[i]; // maszyna nie może pracować dłużej niż
     forall(i in m_r) forall(j in p_r) sum(l in 1..j)x_b[i][l]*z_i[i][l] <= l_i[j]; // sprawdza czy j-te zadanie może zostać wrzucone na i-tą maszynę w danej chwili
 }
   