const std = @import("std");
const config = @import("config");
const day01 = @import("day01.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var input_dir = try std.fs.cwd().openDir(config.inputdir, .{});
    defer input_dir.close();

    try day01fn(allocator, input_dir);
}
pub fn day01fn(allocator: std.mem.Allocator, in_dir: std.fs.Dir) !void {
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

    std.debug.print("Part 1 Answer: {d}\n", .{sum_p1});

    const p2sol = try day01.trebuchet2(allocator, file_content);
    defer allocator.free(p2sol);

    var sum_p2: usize = 0;
    for (p2sol) |i| {
        sum_p2 += i;
    }

    std.debug.print("Part 2 Answer: {d}\n", .{sum_p2});
}

test "Day 1: Trebuchet?!" {
    // Boilerplate for all parts.
    const allocator = std.testing.allocator;

    const in_file = try std.fs.cwd().openFile("./input/day01_input", .{});
    defer in_file.close();

    const file_content = try in_file.readToEndAlloc(allocator, std.math.maxInt(u64));
    defer allocator.free(file_content);

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
