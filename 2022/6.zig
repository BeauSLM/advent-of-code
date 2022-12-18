const std = @import("std");
// const input = @embedFile("6ex0.txt");
const input = @embedFile("6.txt");

// const packet_size = 4;  // day 1
const packet_size = 14; // day 2

pub fn main() !void {
    var lastfour = std.ArrayList(u8).init(std.heap.page_allocator);
    var i: u32 = 0;
    while (i < packet_size) : (i += 1)
        try lastfour.append(input[i]);

    if (check(lastfour.items))
        std.debug.print("{}\n", .{i});

    while (i < input.len) : (i += 1) {
        _ = lastfour.orderedRemove(0);
        try lastfour.append(input[i]);
        if (check(lastfour.items)) {
            std.debug.print("{}\n", .{i + 1});
            std.os.exit(0);
        }
    }
    unreachable;
}

fn check(arr: []u8) bool {
    std.debug.assert(arr.len == packet_size);
    var i: u8 = 0;
    while (i < packet_size) : (i += 1) {
        var j: u8 = i + 1;
        while (j < packet_size) : (j += 1)
            if (arr[i] == arr[j]) return false;
    }
    return true;
}
