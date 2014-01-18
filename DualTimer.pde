int count3 = 0;
int count4 = 0;

// We'll use timers 3 and 4
HardwareTimer timer3(3);
HardwareTimer timer4(4);

void setup() {
    // Set up the button for input
    pinMode(BOARD_BUTTON_PIN, INPUT_PULLUP);

    // Set up timers to add 1 to their counts each time
    // their interrupts fire.
    timer3.setMode(TIMER_CH1, TIMER_OUTPUT_COMPARE);
    timer4.setMode(TIMER_CH1, TIMER_OUTPUT_COMPARE);
    timer3.pause();
    timer4.pause();
    timer3.setCount(0);
    timer4.setCount(0);
    timer3.setOverflow(60000);
    timer4.setOverflow(60000);
    timer3.setCompare(TIMER_CH1, 3000);   // somewhere in the middle
    timer4.setCompare(TIMER_CH1, 3000);
    timer3.attachInterrupt(TIMER_CH1, handler3);
    timer4.attachInterrupt(TIMER_CH1, handler4);
    timer3.refresh();
    timer4.refresh();
    timer3.resume();
    timer4.resume();
}

void loop() {
    // Display the running counts
    SerialUSB.print("Count 3: ");
    SerialUSB.print(count3);
    SerialUSB.print("\t\tCount 4: ");
    SerialUSB.println(count4);

    // While the button is held down, pause timer 4
    for (int i = 0; i < 1000; i++) {
        if (digitalRead(BOARD_BUTTON_PIN)) {
            timer4.pause();
        } else {
            timer4.resume();
        }
        delay(1);
    }
}

void handler3(void) {
    count3++;
}

void handler4(void) {
    count4++;
}
