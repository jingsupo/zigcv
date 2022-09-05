const std = @import("std");
const testing = std.testing;
const core = @import("core.zig");
const Mat = core.Mat;

test "mat" {
    var mat = Mat.init();
    defer mat.deinit();
    try testing.expect(
        mat.isEmpty(),
    );
}

test "mat size" {
    const size: c_int = 10;
    var mat = Mat.initSize(10, 10, .cv8uc1);
    defer mat.deinit();
    const mat_size = mat.size();
    try testing.expectEqual(size, mat_size[0]);
    try testing.expectEqual(size, mat_size[1]);
    try testing.expectEqual(@intCast(usize, 2), mat_size.len);

    try testing.expectEqual(size, mat.rows());
    try testing.expectEqual(size, mat.cols());
}

test "mat channnel" {
    var mat = Mat.initSize(1, 1, .cv8uc1);
    defer mat.deinit();

    try testing.expectEqual(@intCast(i32, 1), mat.channels());
}

test "mat type" {
    var mat = Mat.initSize(1, 1, .cv8uc1);
    defer mat.deinit();

    try testing.expectEqual(core.Mat.MatType.cv8uc1, mat.getType());

    var mat2 = Mat.initSize(1, 1, .cv16sc2);
    defer mat2.deinit();

    try testing.expectEqual(Mat.MatType.cv16sc2, mat2.getType());
}
