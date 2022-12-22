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
    const exterior = 2 * (NUM_ROWS + NUM_COLS) - 4;
    var interior: u64 = 0;

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
            if (visible(forest, i + 1, j + 1)) interior += 1;
        }
    }

    print("{}, {}\n", .{interior, exterior});
    print("{}\n", .{interior + exterior});
}

fn visible(f: [NUM_ROWS][NUM_COLS]u8, i: usize, j: usize) bool {
    const tree = f[i][j];
    const row = f[i];
    for (f[0..i]) |line| {
        if (line[j] >= tree) break;
    } else
        return true;
    for (f[i + 1..NUM_ROWS]) |line| {
        if (line[j] >= tree) break;
    } else
        return true;

    for (row[0..j]) |neighbor| {
        if (neighbor >= tree) break;
    } else
        return true;
    for (row[j + 1..NUM_COLS]) |neighbor| {
        if (neighbor >= tree) break;
    } else
        return true;

    return false;
}

fn print_forest(f: [NUM_ROWS][NUM_COLS]u8) void {
    for (f) |line| {
        for (line) |tree| {
            print("{} ", .{tree - '0'});
        }
        print("\n", .{});
    }
}
