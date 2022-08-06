package main

import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

// debug against example
// RAW_INPUT :: #load("puzzle3-sample.txt")
// NUM_BITS :: 5

// the real thing
RAW_INPUT :: #load("puzzle-day3.txt")
NUM_BITS :: 12

bit_counts : [NUM_BITS]u64

main :: proc() {
    lines := strings.split_lines(string(RAW_INPUT))
    defer delete(lines)

    for line in lines {
        num, ok := strconv.parse_u64(line, 2)
        if !ok {
            fmt.eprintln("cannot parse number")
            os.exit(1)
        }
        for i in u64(0)..<NUM_BITS {
            bit_counts[i] += u64(num & (1 << i) != 0)
        }
    }
    fmt.println(bit_counts)

    gamma: u64
    for i in u64(0)..<NUM_BITS {
        if bit_counts[i] > u64(len(lines) / 2) {
            gamma |= 1 << i
        }
    }

    epsilon := gamma ~ 0xFFF
    // epsilon := gamma ~ 0b11111
    // fmt.printf("%5b\n%5b\n",gamma, epsilon)
    fmt.println(gamma * epsilon)
}
