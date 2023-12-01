const std = @import("std");

pub fn main() !void {
    std.debug.print("The AOC Solutions are in the tests! Do `zig build test`!");
}

test "Day 1: Trebuchet?!" {
    const input_example =
        \\1abc2
        \\pqr3stu8vwx
        \\a1b2c3d4e5f
        \\treb7uchet
    ;

    const allocator = std.testing.allocator;

    const example_slice = try trebuchet(allocator, input_example);
    defer allocator.free(example_slice);

    try std.testing.expectEqualSlices(u32, &.{ 12, 38, 15, 77 }, example_slice);
}

pub fn trebuchet(allocator: std.mem.Allocator, src: []const u8) ![]const u32 {
    var iter = std.mem.tokenizeAny(u8, src, &std.ascii.whitespace);

    var char_buffer = std.ArrayList(u8).init(allocator);
    defer char_buffer.deinit();

    var int_buffer = std.ArrayList(u32).init(allocator);
    defer int_buffer.deinit();

    while (iter.next()) |line| {
        defer char_buffer.clearRetainingCapacity();

        for (line) |char| {
            if (std.ascii.isDigit(char)) {
                try char_buffer.append(char);
            }
        }

        const ltc: [2]u8 = .{ char_buffer.items[0], char_buffer.items[char_buffer.items.len -| 1] };
        const read_int = try std.fmt.parseInt(u32, &ltc, 10);

        try int_buffer.append(read_int);
    }

    return int_buffer.toOwnedSlice();
}