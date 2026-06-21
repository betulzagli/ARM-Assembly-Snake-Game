.global _start

_start:



    MOV R3, #0x30         // '0' Karakteri (Yılan ve yemler için)



    // Yemleri Yerleştirme

    LDR R4, =0x10008      // 1. Yem adresi

    STRB R3, [R4]

    LDR R5, =0x10012      // 2. Yem adresi

    STRB R3, [R5]

    LDR R6, =0x1002A      // 3. Yem adresi

    STRB R3, [R6]



    // Yılanın İlk Konumu (Direkt kırmızı noktaların üzerinde doğar)

    LDR R1, =0x10001      // Kafa Adresi

    LDR R2, =0x10000      // Kuyruk Adresi

    STRB R3, [R1]

    STRB R3, [R2]



    MOV R7, #1            // Yön (+1 Sağa)

    MOV R8, #2            // Boyut (2)



OYUN_DONGUSU:

    NOP                   // Duraklama noktası



    // Yem Kontrolleri

    CMP R1, R4

    BEQ YEM1_YENDI

    CMP R1, R5

    BEQ YEM2_YENDI

    CMP R1, R6

    BEQ YEM3_YENDI

    B KUYRUK_SIL



YEM1_YENDI:

    MOV R8, #3

    MOV R4, #0            // Yemi temizle

    B KAFA_ILERLET



YEM2_YENDI:

    MOV R8, #4

    MOV R5, #0

    B KAFA_ILERLET



YEM3_YENDI:

    MOV R8, #5

    MOV R6, #0

    B KAFA_ILERLET



KUYRUK_SIL:

    // 3. satır sonu kontrolü (Yok olma aşaması)

    LDR R9, =0x1002F

    CMP R1, R9

    BNE NORMAL_SILME

    CMP R2, R9

    BEQ OYUN_BITTI

    

    MOV R9, #0x00         // Yılan yok olurken arkasını 0x00 yapar (Kırmızı nokta kalır)

    STRB R9, [R2]

    ADD R2, R2, #1

    B OYUN_DONGUSU



NORMAL_SILME:

    MOV R9, #0x00         // Yılan ilerlerken arkasındaki eski kuyruğu temizler

    STRB R9, [R2]

    

    // Kuyruk yön tayini

    LDR R9, =0x1000F

    CMP R2, R9

    BLE KUYRUK_SAGA

    LDR R9, =0x1001F

    CMP R2, R9

    BLE KUYRUK_SOLA

    B KUYRUK_SAGA



KUYRUK_SAGA:

    LDR R9, =0x1000F

    CMP R2, R9

    ADDEQ R2, R2, #0x10   // Kuyruk 1. satırın sonundaysa (0x1000F), 2. satırın başına (0x1001F) ışınla

    ADDNE R2, R2, #1      // Değilse normal şekilde sağa ilerlemeye devam et

    B KAFA_ILERLET



KUYRUK_SOLA:

    LDR R9, =0x10010

    CMP R2, R9

    ADDEQ R2, R2, #0x10   // Kuyruk 2. satırın sonundaysa (0x10010), 3. satırın başına (0x10020) ışınla

    SUBNE R2, R2, #1      // Değilse normal şekilde sola ilerlemeye devam et



KAFA_ILERLET:

    // 1. Satır Sonu Kontrolü (Kafa ilerlemeden ÖNCE yapılır)

    LDR R9, =0x1000F

    CMP R1, R9

    BNE KONTROL_SATIR2

    LDR R1, =0x1001F      // Alt satırın sonuna ışınla

    MOV R7, #-1           // Yönü sola çevir

    B EKRANA_YAZ



KONTROL_SATIR2:

    // 2. Satır Sonu Kontrolü (Kafa ilerlemeden ÖNCE yapılır)

    LDR R9, =0x10010

    CMP R1, R9

    BNE NORMAL_ILERLE

    LDR R1, =0x10020      // 3. satırın başına ışınla

    MOV R7, #1            // Yönü sağa çevir

    B EKRANA_YAZ



NORMAL_ILERLE:

    ADD R1, R1, R7        // Eğer satır sonu değilse normal şekilde ilerle



EKRANA_YAZ:

    MOV R3, #0x30

    STRB R3, [R1]         // Yeni kafa konumuna '0' yazar

    B OYUN_DONGUSU



OYUN_BITTI:

    MOV R9, #0x00         // Son kalan sıfırı da temizler (Kırmızı nokta kalır)

    STRB R9, [R2]

    B OYUN_BITTI          // Sonsuz döngü