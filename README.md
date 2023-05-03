# leftpad.zig
because rust sucks
## Leftpad
Defines a function called leftpad that takes a string (in this case, a sequence of characters called input),
a character used for padding (pad_char), and a target length (target_len). The function pads the input string
from the left with the specified padding character so that the length of the padded string is equal
to the target length. If the input string is already equal to or longer than the target length,
no padding is added.

## Zig
Zig is a statically-typed, general-purpose programming language designed for robustness,
optimality, and clarity. In our implementation, we use a struct called PaddedString to store
the padding and the input string separately, avoiding unnecessary memory copying.

## Logic
1. Calculate the length of the input string.
2. If the input string's length is greater than or equal to the target length, return the input string unchanged.
3. If the input string's length is less than the target length, calculate the number of padding characters required.
4. Create a buffer to store the padding characters and fill it with the specified padding character.
5. Return a PaddedString struct containing the padding and input slices.

The code is more efficient than other implementations that involve memory allocation and copying because it operates
directly on slices without needing to allocate memory or make unnecessary copies. The primary trade-off is that the padding
buffer is fixed in size, which may not be suitable for all use cases. However, you can easily increase the buffer size if needed.

## Complexity
Regarding the time complexity of this implementation, the leftpad function's complexity is O(n),
where n is the difference between the target length and the input length. This complexity comes
from initializing the padding buffer, as the other operations, such as calculating the input length
or returning the struct, are constant-time operations.

## Performance
```bash
9334 ± zig build -Drelease-small
9335 ± ./zig-out/bin/leftpad.zig
leftpad | count: 10, target_len: 10, time: 0 ms
leftpad | count: 100, target_len: 10, time: 0 ms
leftpad | count: 1000, target_len: 10, time: 0 ms
leftpad | count: 10000, target_len: 10, time: 0 ms
leftpad | count: 10, target_len: 100, time: 0 ms
leftpad | count: 100, target_len: 100, time: 0 ms
leftpad | count: 1000, target_len: 100, time: 0 ms
leftpad | count: 10000, target_len: 100, time: 0 ms
leftpad | count: 10, target_len: 1000, time: 1 ms
leftpad | count: 100, target_len: 1000, time: 2 ms
leftpad | count: 1000, target_len: 1000, time: 15 ms
leftpad | count: 10000, target_len: 1000, time: 56 ms
leftpad | count: 10, target_len: 10000, time: 0 ms
leftpad | count: 100, target_len: 10000, time: 2 ms
leftpad | count: 1000, target_len: 10000, time: 14 ms
leftpad | count: 10000, target_len: 10000, time: 147 ms
```
this is clearly asking for compiling into wasm and publishing 
as blazingly fast leftpad.npm
