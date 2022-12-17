const std = @import("std");
// const input = @embedFile("4ex.txt");
const input = @embedFile("4.txt");

pub fn main() !void {
    var inputiter = std.mem.tokenize(u8, input, "\n,-");
    var nums: [4]u32 = undefined;
    var pairs: u32 = 0;
    while (inputiter.next()) |first| {
        nums[0] = std.fmt.parseInt(u32, first, 10) catch unreachable;
        var i: u8 = 1;
        while (i < 4) : (i += 1) {
            const next = inputiter.next() orelse unreachable;
            nums[i] = std.fmt.parseInt(u32, next, 10) catch unreachable;
        }
        if ((nums[2] >= nums[0] and nums[2] <= nums[1]) or (nums[3] >= nums[0] and nums[3] <= nums[1]) or (nums[0] >= nums[2] and nums[0] <= nums[3]) or (nums[1] >= nums[2] and nums[1] <= nums[3]))
            pairs += 1;
    }
    std.debug.print("{}", .{pairs});
}
