package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"

RAW_INPUT := #load("puzzle-day2.txt")

main :: proc () {
    hor, depth, aim: i64
    input := strings.split_lines(string(RAW_INPUT))
    defer delete(input)

    for line in input {
        words := strings.split(line, " ")
        defer delete(words)
        
        units, ok := strconv.parse_i64(words[1])
        if !ok {
            fmt.eprintln("couldn't parse int")
            os.exit(1)
        }
        
        switch words[0] {
            case "down":
                aim += units
            case "up":
                aim -= units
            case "forward":
                hor += units
                depth += aim * units
        }
    }

    fmt.println(hor * depth)
}