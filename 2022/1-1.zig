const std = @import("std");
const fmt = std.fmt;
// const input = @embedFile("1ex.txt");
const input = @embedFile("1.txt");

pub fn main() !void {
    var ix: u32 = 0;
    var ex: u32 = 0;
    var curr: u32 = 0;
    var greatest: u32 = 0;
    while (ix < input.len) {
        while (input[ex] >= '0' and input[ex] <= '9') : (ex += 1) {}
        if (ix == ex) {
            if (curr > greatest) greatest = curr;
            curr = 0;
        } else {
            // catch unreachable ig could work here
            curr += try fmt.parseInt(u32, input[ix..ex], 10);
        }

        ex += 1;
        ix = ex;
    }
    std.debug.print("{any}", .{greatest});
}
