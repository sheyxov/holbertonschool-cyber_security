#!/usr/bin/python3
"""
Reads a process heap and replaces a given string inside it.
"""

import sys


def usage():
    print("Usage: read_write_heap.py pid search_string replace_string")
    sys.exit(1)


def find_heap_range(pid):
    heap_start = None
    heap_end = None

    try:
        with open(f"/proc/{pid}/maps", "r") as f:
            for line in f:
                if "[heap]" in line:
                    addr_range = line.split(" ")[0]
                    start, end = addr_range.split("-")
                    heap_start = int(start, 16)
                    heap_end = int(end, 16)
                    break
    except Exception:
        return None, None

    return heap_start, heap_end


def main():
    if len(sys.argv) != 4:
        usage()

    pid = sys.argv[1]
    search_string = sys.argv[2].encode()
    replace_string = sys.argv[3].encode()

    if len(replace_string) > len(search_string):
        print("Error")
        sys.exit(1)

    heap_start, heap_end = find_heap_range(pid)

    if heap_start is None:
        print("Error")
        sys.exit(1)

    try:
        with open(f"/proc/{pid}/mem", "rb+") as mem_file:
            mem_file.seek(heap_start)
            heap_size = heap_end - heap_start
            heap_data = mem_file.read(heap_size)

            offset = heap_data.find(search_string)

            if offset == -1:
                print("Error")
                sys.exit(1)

            addr = heap_start + offset

            mem_file.seek(addr)
            mem_file.write(replace_string)

            # padding if needed
            padding = b"\x00" * (len(search_string) - len(replace_string))
            mem_file.write(padding)

    except Exception:
        print("Error")
        sys.exit(1)

    print("SUCCESS!")


if __name__ == "__main__":
    main()
