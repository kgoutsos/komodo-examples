# Serial
------------

This is an example of serial communication between the board and the debugger using the Terminal feature.

The terminal can be found in the "Terminal" tab after clicking "Features". Data output from the board appears in the terminal while data input is performed by clicking on the terminal and typing (the keyboard input does not appear but is via the serial port).

The example can be simply compiled with the _make_ command which will produce two separate binary files, `kmd_serial_tx` and `kmd_serial_rx` which can be loaded to the board through the debugger.

**kmd_serial_tx**: The board repeatedly puts the word "komodo" on the serial line.

**kmd_serial_rx**: The board reads single digit integers from the serial line and turns on the LED at the corresponding position. See the [top level readme](../README.md) for details on the LED order.
