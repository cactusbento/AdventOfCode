const std = @import("std");
const config = @import("config");
const day01 = @import("day01.zig");
const day02 = @import("day02.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var input_dir = try std.fs.cwd().openDir(config.inputdir, .{});
    defer input_dir.close();

    try day01fn(allocator, input_dir);
    try day02fn(allocator, input_dir);
}

pub fn day01fn(allocator: std.mem.Allocator, in_dir: std.fs.Dir) !void {
    std.debug.print("=== Day 01 ===\n", .{});
    const in_file = try in_dir.openFile("./day01_input", .{});
    defer in_file.close();

    const file_content = try in_file.readToEndAlloc(allocator, std.math.maxInt(u64));
    defer allocator.free(file_content);

    const p1sol = try day01.trebuchet1(allocator, file_content);
    defer allocator.free(p1sol);

    var sum_p1: usize = 0;
    for (p1sol) |i| {
        sum_p1 += i;
    }

    std.debug.print("    Part 1 Answer: {d}\n", .{sum_p1});

    const p2sol = try day01.trebuchet2(allocator, file_content);
    defer allocator.free(p2sol);

    var sum_p2: usize = 0;
    for (p2sol) |i| {
        sum_p2 += i;
    }

    std.debug.print("    Part 2 Answer: {d}\n", .{sum_p2});
}

pub fn day02fn(allocator: std.mem.Allocator, in_dir: std.fs.Dir) !void {
    std.debug.print("=== Day 02 ===\n", .{});
    const in_file = try in_dir.openFile("./day02_input", .{});
    defer in_file.close();

    const file_content = try in_file.readToEndAlloc(allocator, std.math.maxInt(u64));
    defer allocator.free(file_content);

    const p1sol = try day02.cube1(allocator, file_content);
    defer allocator.free(p1sol);

    var sum_p1: usize = 0;
    for (p1sol) |i| {
        sum_p1 += i;
    }

    std.debug.print("    Part 1 Answer: {d}\n", .{sum_p1});

    const p2sol = try day02.cube2(allocator, file_content);
    defer allocator.free(p2sol);

    var sum_p2: usize = 0;
    for (p2sol) |i| {
        sum_p2 += i;
    }

    std.debug.print("    Part 2 Answer: {d}\n", .{sum_p2});
}

test "Day 1: Trebuchet?!" {
    const allocator = std.testing.allocator;

    const part1_example =
        \\1abc2
        \\pqr3stu8vwx
        \\a1b2c3d4e5f
        \\treb7uchet
    ;

    const p1es = try day01.trebuchet1(allocator, part1_example);
    defer allocator.free(p1es);

    try std.testing.expectEqualSlices(u32, &.{ 12, 38, 15, 77 }, p1es);

    const part2_example =
        \\two1nine
        \\eightwothree
        \\abcone2threexyz
        \\xtwone3four
        \\4nineeightseven2
        \\zoneight234
        \\7pqrstsixteen
    ;
    const p2es = try day01.trebuchet2(allocator, part2_example);
    defer allocator.free(p2es);
    try std.testing.expectEqualSlices(u32, &.{ 29, 83, 13, 24, 42, 14, 76 }, p2es);
}

test "Day 2: Cube Conundrum" {
    const allocator = std.testing.allocator;

    const example =
        \\Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
        \\Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
        \\Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
        \\Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
        \\Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    ;

    const p1es = try day02.cube1(allocator, example);
    defer allocator.free(p1es);

    try std.testing.expectEqualSlices(u64, &.{ 1, 2, 5 }, p1es);

    const p2es = try day02.cube2(allocator, example);
    defer allocator.free(p2es);

    try std.testing.expectEqualSlices(u64, &.{ 48, 12, 1560, 630, 36 }, p2es);
}

test "Day 3: Gear Ratios" {
    const allocator = std.testing.allocator;

    const part1_example = 
        \\467..114..
        \\...*......
        \\..35..633.
        \\......#...
        \\617*......
        \\.....+.58.
        \\..592.....
        \\......755.
        \\...$.*....
        \\.664.598..
    ;

    try std.testing.expectEqualSlices()
}
