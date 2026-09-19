# Dungeon Forge Mobile UI Architecture

## Teknoloji
- Godot 4.x
- GDScript
- Mobil hedef: iOS + Android
- Ana yön: landscape
- Referans viewport: 1920x1080
- Stretch: canvas_items

## Neden bu yapı?
Konsept görseli tek bir arka plan olarak kullanılmıyor. Her etkileşimli parça bağımsız bir Control bileşeni veya ekran modülü.

## Ortak bileşenler
- GameButton: normal / hover / pressed / disabled / active
- GamePanel: altın-bronz çerçeveli panel
- StatBar: HP, mana, XP, dayanıklılık
- InventorySlot: eşya slotu
- ThemeFactory: renkler, border, gölge ve durum stilleri

## Bağımsız ekranlar
- MainMenuScreen
- CharacterCreateScreen
- InventoryScreen
- QuestScreen
- HudScreen
- WorldMapScreen
- CombatScreen
- DialogueScreen

## Kurallar
1. Görsel metin içine gömülmez; gerçek Label kullanılır.
2. Butonlar görselin parçası değildir; gerçek Button node'dur.
3. Can/mana barları ProgressBar'dır.
4. Envanter slotları tek tek butondur.
5. Harita noktaları ayrı etkileşimli node'lardır.
6. Tüm ekranlar App yöneticisi üzerinden değiştirilir.
7. Daha sonra çizilecek PNG/SVG parçaları yalnızca dekorasyon ve ikon katmanıdır; fonksiyon kodda kalır.

## Sonraki asset katmanı
- Logo
- panel köşe ornamentleri
- buton yüzeyi / 9-patch
- ikon seti
- karakter portre çerçevesi
- mini-map frame
- item rarity frame
- tooltip frame
- class/race portraits
- combat skill icons
