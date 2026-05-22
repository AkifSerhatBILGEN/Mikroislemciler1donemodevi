; ��renci No: 252114003 
; Ders: Mikroi�lemciler
; �dev Konusu: Dizi i�erisindeki elemanlar� tek tek kar��la�t�rarak en b�y�k (Maksimum) ve en k���k (Minimum) de�erleri, Dizideki her bir say�n�n s�f�ra g�re durumunu (s�f�ra e�it, s�f�rdan b�y�k veya s�f�rdan k���k) kontrol eder; pozitif say�lar�n, negatif say�lar�n ve s�f�rlar�n adedini hesaplar , Pozitif ve negatif say�lar� kendi i�lerinde toplayarak dizinin pozitif ve negatif toplam de�erlerini hesaplar ve bu sonu�lar� bellekte onlar i�in olu�turulan de�i�kenlerde saklar.

.model small            ; 16-bit 8086 i�in standart bellek modeli (1 Data, 1 Code segmenti)
.stack 100h             ; Y���n (Stack) boyutu

.data                   
    numbers DB 12, 0, 0, 8, 3, 15, -9, -3, 4, -1 ; 10 elemanl�, 8-bitlik (byte) say�lar dizisi.
    positiveCount DB 0              ; Pozitif say�lar�n adedini tutacak de�i�ken.
    negativeCount DB 0              ; Negatif say�lar�n adedini tutacak de�i�ken.
    zeroCount DB 0                  ; S�f�rlar�n adedini tutacak de�i�ken.
    positiveSum DB 0                ; Pozitif say�lar�n toplam�n� tutacak de�i�ken.
    negativeSum DB 0                ; Negatif say�lar�n toplam�n� tutacak de�i�ken.
    maxValue DB ?                   ; Dizideki en b�y�k de�eri tutacak de�i�ken.
    minValue DB ?                   ; Dizideki en k���k de�eri tutacak de�i�ken.

.code                   
main PROC               
    ; Derleyiciye de�i�kenlerin DS �zerinden eri�ilece�ini bildiriyoruz:
    ASSUME DS:@data     
    
    ; --- Veri Segmentini (DS) Ba�latma (8086 Ger�ek Kip Zorunlulu�u) ---
    MOV AX, @data                   
    MOV DS, AX

    LEA SI, numbers                 ; 'numbers' dizisinin bellek adresini SI (Source Index) yazmac�na y�kler.
    XOR CX, CX                      ; CX (Counter) yazmac�n� s�f�rlar.
    MOV CX, 10                      ; D�ng� i�in CX yazmac�na 10 de�erini atar.
    
    MOV AL, [SI]                    ; Dizinin ilk eleman�n� AL yazmac�na kopyalar.
    MOV maxValue, AL                ; �lk eleman� �imdilik 'maxValue' olarak kabul eder.
    MOV minValue, AL                ; �lk eleman� �imdilik 'minValue' olarak kabul eder.

CHECK_LOOP:                         
    MOV AL, [SI]                    ; SI'nin i�aret etti�i g�ncel dizi eleman�n� AL'ye al�r.
    
    CMP AL, maxValue                ; G�ncel eleman� (AL), maxValue ile kar��la�t�r�r.
    JLE CHECK_MIN                   ; AL <= maxValue ise CHECK_MIN'e atlar.
    MOV maxValue, AL                ; AL > maxValue ise, maxValue'yu g�nceller.

CHECK_MIN:                          
    CMP AL, minValue                ; G�ncel eleman� (AL), minValue ile kar��la�t�r�r.
    JGE CHECK_SIGN                  ; AL >= minValue ise CHECK_SIGN'e atlar.
    MOV minValue, AL                ; AL < minValue ise, minValue'yu g�nceller.

CHECK_SIGN:                         
    CMP AL, 0                       ; G�ncel eleman� 0 ile kar��la�t�r�r.
    JE IS_ZERO                      ; E�itse IS_ZERO'ya atlar.
    JG IS_POSITIVE                  ; B�y�kse IS_POSITIVE'e atlar.
    JL IS_NEGATIVE                  ; K���kse IS_NEGATIVE'e atlar.

IS_ZERO:                            
    INC zeroCount                   ; zeroCount de�erini 1 art�r�r.
    JMP NEXT_ELEMENT                ; Sonraki elemana ge�er.

IS_POSITIVE:                        
    INC positiveCount               ; positiveCount de�erini 1 art�r�r.
    ADD positiveSum, AL             ; AL'deki pozitif de�eri positiveSum'a ekler.
    JMP NEXT_ELEMENT                ; Sonraki elemana ge�er.

IS_NEGATIVE:                        
    INC negativeCount               ; negativeCount de�erini 1 art�r�r.
    ADD negativeSum, AL             ; AL'deki negatif de�eri negativeSum'a ekler.

NEXT_ELEMENT:                       
    INC SI                          ; SI i�aret�isini 1 art�r�r (bir sonraki bayta ge�mek i�in).
    LOOP CHECK_LOOP                 ; CX'i 1 azalt�r. CX 0 de�ilse CHECK_LOOP'a d�ner.

    ; --- DOS'a D�n�� / Program� Sonland�rma (8086 Kesmesi) ---
    MOV AH, 4Ch                     
    INT 21h                         
    ; ---------------------------------------------------------

main ENDP                           
END main