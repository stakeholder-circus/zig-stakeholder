const std = @import("std");
const app = @import("app.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var args_iter = try std.process.argsWithAllocator(allocator);
    defer args_iter.deinit();

    var args = try std.ArrayList([]const u8).initCapacity(allocator, 0);
    defer args.deinit(allocator);

    while (args_iter.next()) |arg| {
        try args.append(allocator, arg);
    }

    const stdout = std.fs.File.stdout().deprecatedWriter();
    const stderr = std.fs.File.stderr().deprecatedWriter();
    const exit_code = try app.execute(allocator, stdout, stderr, args.items[1..]);
    if (exit_code != 0) std.process.exit(exit_code);
}
