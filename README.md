# Задание 2
В данном эксперименте была создана бд, проиндексирована различными индексами, и собран размер этих индексов 

## Результаты размеров индексов
btree_size = 60 MB
two_size = 60 MB
bloom_size = 30 MB
hash_size = 64 MB
gist_size = 120 MB

## Теоретические вычисления 

1) $k = 2^{32}$ 
2) $n = 2,000,000$ 

$P_{happy} = \frac{k!}{(k-n)!} \cdot \frac{1}{k^n} = k \cdot (k - 1) \cdot ... \cdot (k-n + 1) \cdot \frac{1}{k^n} =1 \cdot (1 - \frac{1}{k}) \cdot (1 - \frac{2}{k}) \cdot . \cdot (1 - \frac{n-1}{k})$
Прологарифмируем
$\ln⁡(P_{happy})=\ln⁡(1)+\ln⁡(1−\frac{1}{k})+\ln⁡(1−\frac{2}{k})+ ... +\ln⁡(1−\frac{n-1}{k})$ $\ln⁡(P_{happy})=\sum_{i=1}^{n - 1}{\ln⁡(1−\frac{i}{k})}$
При малых x верна оценка : $\ln⁡(1−x)≈−x$

Тогда:
$\ln⁡(P_{happy})≈−\sum_{i=1}^{n - 1}{\frac{i}{k}}$ 
Посмотрим на сумму арифм прогрессии $\sum_{i=1}^{n−1}i = {\frac{(n−1)\cdot n}{2}}$, далее подставим $\ln⁡(P_{happy})≈\frac{−n\cdot (n−1)}{2k}$
$P_{happy}≈\exp{\frac{−n\cdot (n−1)}{2k}}$
 
Приблизим для больших k и n:
$P_{collide} \approx 1 - e^{-\frac{n(n-1)}{2k}}$
 
Теперь можно подсчитать, подставив необходимые значения: $P_{collide} \approx 1 - e^{-\frac{2,000,000 \cdot 1,999,999}{2 \cdot 2^{32}}}$ $\approx 1 - e^{-0.465}$ $\approx 0.465$
 
Ответ: 46.5%.
