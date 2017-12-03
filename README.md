# Komodo Board Examples
------------

The Komodo debugger was created in the University of Manchester in order to mainly serve educational purposes along with two ARM FPGA boards designed for the same purpose.

This repository includes some simple examples that I came up with while experimenting with the board during my MSc thesis in August 2015. Some general information is provided below and more details about the specific examples are available in their respective readme files.

## LEDs
The wiring order of the LEDs is a little illogical, the following table should help:

| LED control word bit | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
|----------------------|---|---|---|---|---|---|---|---|
| LED number           | 5 | 8 | 7 | 6 | 1 | 4 | 3 | 2 |

## More information
These example were developed and tested on the ARM board v2.

[More information on Komodo and the boards](http://studentnet.cs.manchester.ac.uk/resources/software/komodo/ "More information on Komodo and the boards")
