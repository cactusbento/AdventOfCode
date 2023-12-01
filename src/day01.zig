const std = @import("std");

pub fn trebuchet1(allocator: std.mem.Allocator, src: []const u8) ![]const u32 {
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

pub fn trebuchet2(allocator: std.mem.Allocator, src: []const u8) ![]const u32 {
    var iter = std.mem.tokenizeAny(u8, src, &std.ascii.whitespace);

    const digits: []const []const u8 = &.{
        "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "zero",
    };

    var char_buffer = std.ArrayList(u8).init(allocator);
    defer char_buffer.deinit();

    var int_buffer = std.ArrayList(u32).init(allocator);
    defer int_buffer.deinit();

    while (iter.next()) |line| {
        defer char_buffer.clearRetainingCapacity();

        for (line, 0..) |char, ci| {
            if (std.ascii.isDigit(char)) {
                try char_buffer.append(char);
            } else {
                f2: for (digits, 0..) |word, di| {
                    if (ci + word.len > line.len) continue :f2;
                    if (std.mem.eql(u8, line[ci .. ci + word.len], word)) {
                        try char_buffer.append(switch (di) {
                            0 => '1',
                            1 => '2',
                            2 => '3',
                            3 => '4',
                            4 => '5',
                            5 => '6',
                            6 => '7',
                            7 => '8',
                            8 => '9',
                            9 => '0',
                            else => unreachable,
                        });
                    }
                }
            }
        }

        const ltc: [2]u8 = .{ char_buffer.items[0], char_buffer.items[char_buffer.items.len -| 1] };
        const read_int = try std.fmt.parseInt(u32, &ltc, 10);

        try int_buffer.append(read_int);
    }

    return int_buffer.toOwnedSlice();
}
