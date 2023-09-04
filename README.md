# Multi stage path for delay measurements

## Project Details

- **Language**: Verilog
- **Description**: 
    Verilog coding for cascaded not gates connected as a ring oscillator. After running the flow it is observed that the synthesizer does not support combinatorial feedback and that it collapsed several cascaded not gates into buffers. The original purpose for the ring oscillator will not be achieved but it is observed that synthesized circuit is still useful for measuring some gate delays that can be compared to theoretical calculations for educational purposes.

## How It Works

The `ui_in` signals first two bits are used to control the transmission of the input signal through the gates all the way to the several external outputs that are taps to different gate stages as to measure different stage delays for educational purposes.

## How to Test

One can put a square wave generator in the inputs and use a scope to measure the delay of the gates. The delay can be compared with theoretical calculations.

## Inputs

- EN (ui_in[0])
- EN_2 (ui_in[1])
- none
- none
- none
- none
- none
- none

## Outputs

- Tap 1 (uo_out[0])
- Tap 2 (uo_out[1])
- Tap 3 (uo_out[2])
- none
- none
- none
- none
- none

## Bidirectional

- none
- none
- none
- none
- none
- none
- none
- none
