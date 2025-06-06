# 🛠️ SystemVerilog Digital Design Modules

This repository contains a collection of basic digital design components implemented in **SystemVerilog**, along with their corresponding **testbenches**. Each module demonstrates a key concept in digital logic design and can serve as a valuable learning or teaching resource for students and engineers alike.

---

## 📂 Repository Contents

| Module                              | Description                                           |
|-------------------------------------|-------------------------------------------------------|
| `AsynchronousUpCounter4Bit.sv`      | 4-bit asynchronous (ripple) up counter.               |
| `AsyncCounter_TestBench.sv`         | Testbench to verify the 4-bit async counter.          |
| `FibonacciSeries.sv`                | Computes the Fibonacci series using sequential logic. |
| `Fibonacci_TestBench.sv`            | Testbench for the Fibonacci generator.                |
| `FourBitParallelAdder.sv`           | 4-bit parallel adder using full-adder logic.          |
| `FourBitParallelAdder_TestBench.sv` | Testbench for the 4-bit adder.                        |
| `MUX2x1.sv`                         | 2-to-1 multiplexer design.                            |
| `MUX2x1_TestBench.sv`               | Testbench to simulate the 2:1 MUX.                    |
| `Register8Bits.sv`                  | 8-bit register with load and reset control.           |
| `Register8Bit_TestBench.sv`         | Testbench for the 8-bit register.                     |

---

## 🧪 Simulation and Testing

Each module comes with a separate testbench designed to:

- Simulate expected behavior.
- Verify functional correctness through waveform inspection.
- Demonstrate edge case handling (e.g., resets, overflows).

### ✅ Example Simulation (using iverilog)
```bash
iverilog -g2012 -o counter_tb.vvp AsynchronousUpCounter4Bit.sv AsyncCounter_TestBench.sv
vvp counter_tb.vvp
