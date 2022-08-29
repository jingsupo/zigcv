const std = @import("std");
const c = @import("c_api.zig");
const core = @import("core.zig");
const Mat = core.Mat;

pub const AsyncArray = struct {
    ptr: c.AsyncArray,

    const Self = @This();

    pub fn init() Self {
        return .{ .ptr = c.AsyncArray_New() };
    }

    pub fn initFromC(ptr: c.AsyncArray) Self {
        return Self{ .ptr = ptr };
    }

    pub fn deinit(self: *Self) void {
        c.AsyncArray_Close(self.ptr);
    }

    pub fn get(self: Self, mat: *Mat) !void {
        const result = c.AsyncArray_GetAsync(self.ptr, mat.*.ptr);
        if (result[0] != 0) {
            return error.RuntimeError;
        }
    }
};

//*    implementation done
//*    pub const AsyncArray = ?*anyopaque;
//*    pub extern fn AsyncArray_New(...) AsyncArray;
//*    pub extern fn AsyncArray_GetAsync(async_out: AsyncArray, out: Mat) [*c]const u8;
//*    pub extern fn AsyncArray_Close(a: AsyncArray) void;
//*    pub extern fn Net_forwardAsync(net: Net, outputName: [*c]const u8) AsyncArray;