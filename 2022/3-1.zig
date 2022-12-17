const std = @import("std");
// const input = @embedFile("3ex.txt");
const input = @embedFile("3.txt");

pub fn main() void {
    var sum: u32 = 0;
    var inputiter = std.mem.tokenize(u8, input, "\n");
    while (inputiter.next()) |line| {
        const mid = line.len / 2;
        const first = line[0..mid];
        const second = line[mid..line.len];
        // could use a hash set or someth but eh
        outer: {
            for (first) |c| {
                for (second) |s| {
                    if (c != s) {
                        continue;
                    }
                    var priority: u32 = if (c >= 'a' and c <= 'z') c - 'a' + 1 else c - 'A' + 27;
                    sum += priority;
                    break :outer;
                }
            }
            unreachable;
        }
    }
    std.debug.print("{}", .{sum});
}
