# 🐍 Snake Game Emulator (ARM Assembly)

This project is a classic Snake game developed entirely in **ARM Assembly** language. It is designed to be executed at the microprocessor level using the [CPULator](https://cpulator.01xz.net/) web-based emulator.

The project demonstrates a deep understanding of computer architecture, low-level memory management, and hardware interactions without the abstraction of high-level programming languages.

## ⚙️ Technical Concepts & Architecture

* **Memory-Mapped I/O:** Handled direct memory manipulation to read keyboard inputs and update the display matrix in real-time.
* **Register Management:** Efficiently utilized ARM registers for game state calculations, coordinate tracking, and collision detection.
* **System Calls & Interrupts:** Managed low-level execution flows and hardware timers to maintain a consistent game loop.
* **Logic Design:** Translated high-level game logic (array shifting for snake body, random apple generation, boundary checks) directly into CPU instructions.

## 🚀 How to Play

1. Copy the source code from the `.s` file.
2. Open the [CPULator ARMv7 Emulator](https://cpulator.01xz.net/?sys=arm-de1soc).
3. Paste the code into the editor.
4. Compile and Load the program.
5. Open the **VGA Pixel Buffer** to see the game screen and use the **PS/2 Keyboard** interface to control the snake (W, A, S, D).
