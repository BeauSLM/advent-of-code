main :: () {
    lines: []string = ---;
    {
        file, success := read_entire_file("puzzles/1-1.txt");

        if !success {
            print("Failed to read file");
            return;
        }

        // print("File: %\n", file);

        lines = split(file, "\n");

        // HACK: for some reason an empty line is added to the array
        lines.count -= 1;
    }

    // print("Lines: %\n", lines);

    sum := 0;

    for line: lines {
        line_lim := line.count - 1;
        num: s16 = ---;
        for 0..line_lim {
            letter := line[it];
            if is_digit(letter) {
                num = (letter - #char "0");
                break;
            }
            success, digit := check_for_word_digit(line, it);
            if !success then continue;
            num = digit;
            break;
        }
        for 0..line_lim {
            ix := line_lim - it;
            letter := line[ix];
            if is_digit(letter) {
                num = num * 10 + (letter - #char "0");
                break;
            }

            success, digit := check_for_word_digit(line, ix);
            if !success then continue;
            num = num * 10 + digit;
            break;
        }

        // print("num: %\n", num);
        sum += num;
    }

    print("Sum: %\n", sum);
}

check_for_word_digit :: (s: string, index: s64) -> bool, s16 {
    str := slice( s, index, s.count - index );

    strnumpair :: struct {
        str: string;
        num: u8;
    };

    for strnumpair.[
        .{ str = "zero",  num = 0 },
        .{ str = "one",   num = 1 },
        .{ str = "two",   num = 2 },
        .{ str = "three", num = 3 },
        .{ str = "four",  num = 4 },
        .{ str = "five",  num = 5 },
        .{ str = "six",   num = 6 },
        .{ str = "seven", num = 7 },
        .{ str = "eight", num = 8 },
        .{ str = "nine",  num = 9 },
    ] {
        if begins_with(str, it.str) {
            return true, it.num;
        }
    }

    return false, 255;
}

#import "File";
#import "Basic";
#import "String";
