# Mikroislemciler1donemodevi
8086 Assembly Array Processing ProjectBu proje, 8086 Assembly dili kullanılarak bir tam sayı dizisi üzerinde istatistiksel analizler yapan bir alt seviye programlama çalışmasıdır.
Program; dizi içerisindeki pozitif/negatif sayıları, sıfırları, toplamları ve ekstrem değerleri (min/max) hesaplamak üzere tasarlanmıştır.

🛠 Teknik Kısıtlar ve KurallarProjenin geliştirilmesinde aşağıdaki mimari ve sözdizimi kurallarına sadık kalınmıştır:
Mimari: 8086 Gerçek Kip (Real Mode) mantığı.
Sözdizimi: Microsoft Macro Assembler (MASM) syntax.
Bağımlılıklar: Herhangi bir dış kütüphane (Irvine32 vb.) kullanılmadan, saf Assembly komutları ile yazılmıştır.Register 

Kullanımı:CX: Döngü sayacı (Counter).SI/BX: Dizi üzerinde ilerleme (Indexing).Kontrol Akışı:Karşılaştırmalar için CMP komutu.En az üç farklı koşullu dallanma (JG, JL, JE, JNE vb.).Döngü kontrolü için LOOP komutu.
📊 Veri Kümesi ve DeğişkenlerProgram, işaretli (signed) byte türünde tanımlanmış aşağıdaki veri seti üzerinde çalışır:

Kod snippet:

inumbers       DB 12, 0, 0, 8, 3, 15, -9, -3, 4, -1
positiveCount DB 0
negativeCount DB 0
zeroCount     DB 0
positiveSum   DB 0
negativeSum   DB 0
maxValue      DB ?
minValue      DB ?
Beklenen İstatistiksel Sonuçlar İşlem Beklenen Sonuç

Pozitif Sayı Adedi 5
Negatif Sayı Adedi 3
Sıfır Adedi 2
Pozitif Toplam 42
Negatif Toplam -13
En Büyük Sayı 15
En Küçük Sayı -9

🚀 Program Akışı 
Segment Initialization: Veri segmenti ayarlanır.Pointer & Counter: SI register'ı dizinin başına yönlendirilir, CX eleman sayısı ile yüklenir.
Bootstrap: Dizinin ilk elemanı karşılaştırma başlatmak üzere başlangıçta hem maxValue hem de minValue kabul edilir.
Ana Döngü:Elemanın işareti (Pozitif, Negatif veya Sıfır) kontrol edilir ve ilgili sayaç/toplam güncellenir.
Mevcut eleman maxValue ve minValue ile karşılaştırılarak uç değerler güncellenir.
Iteration: Bir sonraki bellek adresine geçilir ve LOOP ile döngü sürdürülür.Termination: Tüm sonuçlar belleğe yazıldıktan sonra program güvenli bir şekilde sonlandırılır.
