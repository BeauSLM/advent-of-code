const std = @import("std");
const print = std.debug.print;

const input = @embedFile("7ex.txt");
// const input = @embedFile("7.txt");

pub fn main() void {
    const arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    var path: []u8 = "";
    print("{s}", .{path});
    // var map = std.AutoHashMap([][]u8, );
}
