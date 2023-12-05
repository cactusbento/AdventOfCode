const std = @import("std");

pub fn cube1(allocator: std.mem.Allocator, src: []const u8) ![]const u64 {
    var line_iter = std.mem.tokenizeScalar(u8, src, '\n');

    var id_list = std.ArrayList(u64).init(allocator);
    defer id_list.deinit();

    while (line_iter.next()) |line| {
        var game_iter = std.mem.splitScalar(u8, line, ':');

        // "Game #"
        const game_id = game_iter.next().?;
        var id_iter = std.mem.tokenizeScalar(u8, game_id, ' ');
        _ = id_iter.next(); // Skip "Game"

        const id = try std.fmt.parseInt(u64, id_iter.next().?, 10);

        // " 3 blue, 4 red; ..."
        const picks = std.mem.trim(u8, game_iter.next().?, &std.ascii.whitespace);

        // "3 blue, 4 red"
        var picks_iter = std.mem.tokenizeSequence(u8, picks, "; ");

        var isPossible = true;
        check_set: while (picks_iter.next()) |set| {
            // "3 blue"
            var pick_iter = std.mem.tokenizeSequence(u8, set, ", ");

            while (pick_iter.next()) |pick| {
                var item_iter = std.mem.tokenizeScalar(u8, pick, ' ');
                const num_cubes = try std.fmt.parseInt(u64, item_iter.next().?, 10);
                const color = std.meta.stringToEnum(enum { red, green, blue }, item_iter.next().?).?;

                if (num_cubes > @as(u64, switch (color) {
                    .red => 12,
                    .green => 13,
                    .blue => 14,
                })) {
                    isPossible = false;
                    break :check_set;
                }
            }
        }

        if (isPossible) {
            try id_list.append(id);
        }
    }

    return id_list.toOwnedSlice();
}

pub fn cube2(allocator: std.mem.Allocator, src: []const u8) ![]const u64 {
    var line_iter = std.mem.tokenizeScalar(u8, src, '\n');

    var powers = std.ArrayList(u64).init(allocator);
    defer powers.deinit();

    while (line_iter.next()) |line| {
        var game_iter = std.mem.splitScalar(u8, line, ':');

        var red: u64 = 0;
        var green: u64 = 0;
        var blue: u64 = 0;

        // "Game #"
        const game_id = game_iter.next().?;
        var id_iter = std.mem.tokenizeScalar(u8, game_id, ' ');
        _ = id_iter.next(); // Skip "Game"

        const id = try std.fmt.parseInt(u64, id_iter.next().?, 10);
        _ = id;

        // " 3 blue, 4 red; ..."
        const picks = std.mem.trim(u8, game_iter.next().?, &std.ascii.whitespace);

        // "3 blue, 4 red"
        var picks_iter = std.mem.tokenizeSequence(u8, picks, "; ");

        while (picks_iter.next()) |set| {
            // "3 blue"
            var pick_iter = std.mem.tokenizeSequence(u8, set, ", ");

            while (pick_iter.next()) |pick| {
                var item_iter = std.mem.tokenizeScalar(u8, pick, ' ');
                const num_cubes = try std.fmt.parseInt(u64, item_iter.next().?, 10);
                const color = std.meta.stringToEnum(enum { red, green, blue }, item_iter.next().?).?;

                switch (color) {
                    .red => red = @max(red, num_cubes),
                    .green => green = @max(green, num_cubes),
                    .blue => blue = @max(blue, num_cubes),
                }
            }
        }

        try powers.append(red * green * blue);
    }

    return powers.toOwnedSlice();
}
