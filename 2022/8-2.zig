const std = @import("std");
const print = std.debug.print;

// const input = @embedFile("8ex.txt");
const input = @embedFile("8.txt");
const NUM_COLS = blk: {
    var i = 0;
    while (input[i] != '\n') i += 1;
    break :blk i;
};

const NUM_ROWS = input.len / (NUM_COLS + 1);

pub fn main() void {
    var highest: u64 = 0;

    const forest: [NUM_ROWS][NUM_COLS]u8 = blk: {
        var result: [NUM_ROWS][NUM_COLS]u8 = undefined;
        var iter = std.mem.tokenize(u8, input, "\n");
        var i: u16 = 0;
        while (iter.next()) |line| : (i += 1) {
            std.mem.copy(u8, &result[i], line[0..NUM_COLS]);
        }
        break :blk result;
    };

    for (forest[1..NUM_ROWS - 1]) |line, i| {
        for (line[1..NUM_COLS - 1]) |_, j| {
            var score = visscore(forest, i + 1, j + 1);
            if (score > highest) highest = score;
        }
    }

    print("{}", .{highest});
}

fn visscore(f: [NUM_ROWS][NUM_COLS]u8, i: usize, j: usize) u64 {
    const tree = f[i][j];
    var temp: u64 = 0;
    var result: u64 = 1;
    var num = i;

    while (num > 0) : (num -= 1) {
        temp += 1;
        if (f[num - 1][j] >= tree) break;
    }
    result *= temp;
    temp = 0;

    num = i;
    while (num < NUM_ROWS - 1) : (num += 1) {
        temp += 1;
        if (f[num + 1][j] >= tree) break;
    }
    result *= temp;
    temp = 0;
    num = j;
    while (num > 0) : (num -= 1) {
        temp += 1;
        if (f[i][num - 1] >= tree) break;
    }
    result *= temp;
    temp = 0;
    num = j;
    while (num < NUM_COLS - 1) : (num += 1) {
        temp += 1;
        if (f[i][num + 1] >= tree) break;
    }
    result *= temp;
    temp = 0;

    return result;
}

fn print_forest(f: [NUM_ROWS][NUM_COLS]u8) void {
    for (f) |line| {
        for (line) |tree| {
            print("{} ", .{tree - '0'});
        }
        print("\n", .{});
    }
}
