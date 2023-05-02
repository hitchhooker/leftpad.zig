const std = @import("std");

const PaddedString = struct {
    padding: []const u8,
    input: []const u8,
};

inline fn leftpad(input: []const u8, pad_char: u8, target_len: usize) PaddedString {
    const input_len = input.len;
    if (input_len >= target_len) {
        return PaddedString{ .padding = "", .input = input };
    }

    var padding_buf: [256]u8 = undefined;
    const pad_len = target_len - input_len;
    std.mem.set(u8, padding_buf[0..pad_len], pad_char);
    return PaddedString{ .padding = padding_buf[0..pad_len], .input = input };
}

pub fn main() void {
    const input = "leftpad";
    const pad_char = ' ';
    const target_len = 42;

    const result = leftpad(input, pad_char, target_len);
    std.debug.print("Padded string: '{s}{s}'\n", .{ result.padding, result.input });
}
