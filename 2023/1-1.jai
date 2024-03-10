main :: () {
    lines: []string = ---;
    {
        file, success := read_entire_file("puzzles/1-1.txt");

        if !success {
            // print("Failed to read file");
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
        num: u8 = ---;
        for 0..line_lim {
            letter := line[it];
            if !is_digit(letter) then continue;
            num = (letter - #char "0");
            break;
        }
        for 0..line_lim {
            letter := line[line_lim-it];
            if !is_digit(letter) then continue;
            num = num * 10 + (letter - #char "0");
            break;
        }

        // print("num: %\n", num);
        sum += num;
    }

    print("Sum: %\n", sum);
}

#import "File";
#import "Basic";
#import "String";
