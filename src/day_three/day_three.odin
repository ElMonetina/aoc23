package day_three

import "core:fmt"
import "core:os"
import "core:strings"

load_input :: proc (path: string) -> string {
    input, ok := os.read_entire_file(path)

    if !ok {
        fmt.eprintln("Failed to read file")
        os.exit(int(os.ERROR_FILE_NOT_FOUND)) 
    }
    return string(input)
}

print_solution :: proc(part, input: string, solution_proc: proc(string) -> int) {
    solution := solution_proc(input)
    fmt.println(part, solution)
}

run :: proc() {
    input := load_input("src/day_three/input.txt")
}