const std = @import("std");

const PaddedString = struct {
    padding: []const u8,
    input: []const u8,
};

fn leftpad(allocator: *const std.mem.Allocator, input: []const u8, pad_char: u8, target_len: usize) !PaddedString {
    const input_len = input.len;
    if (input_len >= target_len) {
        return PaddedString{ .padding = "", .input = input };
    }

    const pad_len = target_len - input_len;
    var padding_buf: [256]u8 = undefined;

    if (pad_len <= 256) {
        std.mem.set(u8, padding_buf[0..pad_len], pad_char);
        return PaddedString{ .padding = padding_buf[0..pad_len], .input = input };
    } else {
        const allocated_padding = try allocator.alloc(u8, pad_len);
        std.mem.set(u8, allocated_padding, pad_char);
        return PaddedString{ .padding = allocated_padding, .input = input };
    }
}

fn fun(allocator: *const std.mem.Allocator, count: usize, input: []const u8, pad_char: u8, target_len: usize) u64 {
    const start = std.time.milliTimestamp();
    var i: usize = 0;
    while (i < count) : (i += 1) {
        _ = leftpad(allocator, input, pad_char, target_len) catch |err| {
            std.debug.print("Error: {}\n", .{err});
            return 0;
        };
    }
    return @intCast(u64, std.time.milliTimestamp() - start);
}

fn testSpeed(allocator: *const std.mem.Allocator, name: []const u8) void {
    const pad_char = ' ';
    const input = "foo";
    const target_lengths = [_]usize{ 10, 100, 1000, 10000 };
    const counts = [_]usize{ 10, 100, 1000, 10000 };

    for (target_lengths) |target_len| {
        for (counts) |count| {
            const elapsed = fun(allocator, count, input, pad_char, target_len);
            std.debug.print("{s} | count: {d}, target_len: {d}, time: {d} ms\n", .{ name, count, target_len, elapsed });
        }
    }
}

pub fn main() void {
    const allocator = &std.heap.page_allocator;
    testSpeed(allocator, "leftpad");
}
