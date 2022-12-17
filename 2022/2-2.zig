const std = @import("std");
// const input = @embedFile("2ex.txt");
const input = @embedFile("2.txt");

pub fn main() !void {
    var inputiter = std.mem.tokenize(u8, input, "\n");
    var score: u32 = 0;
    while (inputiter.next()) |s| {
        const them = s[0] - 'A';
        const result = s[2] - 'X';
        const us = (them + ((result + 2) % 3)) % 3;
        score += result * 3 + us + 1;
    }

    std.debug.print("{}", .{score});
}
