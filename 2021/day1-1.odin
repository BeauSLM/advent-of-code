package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"

RAW_INPUT := #load("puzzle-day1.txt")

main :: proc () {
    input := strings.split_lines(string(RAW_INPUT))
    defer delete(input)

    prev, curr, ok, counter:= max(u64), u64(0), true, u64(0)
    for word in input {
        curr, ok = strconv.parse_u64(word, 10)
        if !ok {
            fmt.eprintln("couldn't parse number")
            os.exit(1)
        }
        if curr > prev do counter += 1
        prev = curr
    }

    fmt.println(counter)
}