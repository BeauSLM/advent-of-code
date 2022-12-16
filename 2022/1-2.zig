const std = @import("std");
const fmt = std.fmt;
// const input = @embedFile("1ex.txt");
const input = @embedFile("1.txt");

pub fn main() !void {
    var ix: u32 = 0;
    var curr: u32 = 0;
    var nums = std.ArrayList(u32).init(std.heap.page_allocator);
    defer nums.deinit();
    while (ix < input.len) {
        var ex: u32 = ix;
        while (input[ex] >= '0' and input[ex] <= '9') : (ex += 1) {}
        if (ix == ex) {
            try nums.append(curr);
            curr = 0;
        } else {
            // catch unreachable ig could work here
            curr += try fmt.parseInt(u32, input[ix..ex], 10);
        }

        ix = ex + 1;
    }
    insertionsort(nums.items);
    std.debug.print("{}", .{nums.items[0] +
        nums.items[1] +
        nums.items[2]});
}

fn insertionsort(arr: []u32) void {
    var i: i32 = 1;
    while (i < arr.len) : (i += 1) {
        const item = arr[@intCast(u32, i)];
        var j: i32 = i - 1;
        while (j >= 0 and arr[@intCast(u32, j)] < item) : (j -= 1) {
            arr[@intCast(u32, j) + 1] = arr[@intCast(u32, j)];
        }
        arr[@intCast(u32, j + 1)] = item;
    }
}

test "insertion sort works" {
    var a = [_]u32{ 0, 1, 2, 3, 4 };
    insertionsort(&a);
    for (a) |item, i| {
        try std.testing.expect(item == 4 - i);
    }
}
