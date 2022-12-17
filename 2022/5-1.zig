const std = @import("std");
const print = std.debug.print;
const Queue = std.ArrayList(u8);
// const input = @embedFile("5ex.txt");
const input = @embedFile("5.txt");

const num_stacks = blk: {
    var iter = std.mem.tokenize(u8, input, "\n");
    var linelen = iter.peek().?.len;
    break :blk linelen / 4 + 1;
};

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    var stacks = [_]Queue{Queue.init(allocator)} ** num_stacks;
    var iter = std.mem.tokenize(u8, input, "\n");
    var boxes: []const u8 = undefined;
    var instructions: []const u8 = undefined;
    var boxiter: std.mem.SplitBackwardsIterator(u8) = undefined;
    var initer: std.mem.TokenIterator(u8) = undefined;

    // find split between boxes and instructions - ik it's weird
    while (iter.next()) |line| {
        if (line[1] != '1') continue;
        const split_first = iter.index - line.len - 1;
        boxes = input[0..split_first];
        break;
    }
    instructions = input[iter.index + 2 .. input.len - 1];
    boxiter = std.mem.splitBackwards(u8, boxes, "\n");
    initer = std.mem.tokenize(u8, instructions, "\n");

    // std.debug.print("{s}|\n\n\n", .{boxes});
    // std.debug.print("{s}|\n\n\n", .{instructions});

    while (boxiter.next()) |line| {
        for (line) |char, i| {
            if (char < 'A' or char > 'Z') continue;
            const stacknum = i / 4;
            try stacks[stacknum].append(char);
        }
    }

    while (initer.next()) |line| {
        var numiter = std.mem.tokenize(u8, line, "movefromto \n");
        var move = try std.fmt.parseInt(u8, numiter.next().?, 10);
        const from = try std.fmt.parseInt(u8, numiter.next().?, 10) - 1;
        const to = try std.fmt.parseInt(u8, numiter.next().?, 10) - 1;

        var src = &stacks[from];
        var dest = &stacks[to];
        while (move > 0) : (move -= 1) {
            try dest.append(src.pop());
        }
        // for (stacks) |stack| {
        //     print("{s}\n", .{stack.items});
        // }
        // print("move: {}, from: {}, to: {}\n", .{ move, from, to });
        // print("\n", .{});
    }

    for (stacks) |stack| {
        print("{s}\n", .{stack.items});
    }
}
