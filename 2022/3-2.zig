const std = @import("std");
// const input = @embedFile("3ex.txt");
const input = @embedFile("3.txt");

pub fn main() void {
    var group = [_][]const u8{ "", "", "" };
    var sum: u32 = 0;
    var inputiter = std.mem.tokenize(u8, input, "\n");
    var i: u32 = 0;
    while (inputiter.next()) |line| {
        group[i] = line;
        if (i != 2) {
            i += 1;
            continue;
        }
        outer: {
            for (group[0]) |a| {
                for (group[1]) |b| {
                    for (group[2]) |c| {
                        if (a != b or a != c) {
                            continue;
                        }
                        var priority: u32 = if (c >= 'a' and c <= 'z') c - 'a' + 1 else c - 'A' + 27;
                        sum += priority;
                        i = 0;
                        break :outer;
                    }
                }
            }
        }
    }
    std.debug.print("{}", .{sum});
}
