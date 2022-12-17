const std = @import("std");
// const input = @embedFile("2ex.txt");
const input = @embedFile("2.txt");

pub fn main() !void {
    var inputiter = std.mem.tokenize(u8, input, "\n");
    var score: u32 = 0;
    while (inputiter.next()) |s| {
        const them = s[0];
        const us = s[2];
        score += switch ((us - them) % 3) {
            2 => 3,
            0 => 6,
            1 => 0,
            else => unreachable,
        };
        score += switch (us) {
            'X' => 1,
            'Y' => 2,
            'Z' => 3,
            else => unreachable,
        };
    }

    std.debug.print("{}", .{score});
}
