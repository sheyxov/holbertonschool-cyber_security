#!/usr/bin/python3
import sys


def usage():
    print("Usage: read_write_heap.py pid search_string replace_string")
    sys.exit(1)


if len(sys.argv) != 4:
    usage()

pid = sys.argv[1]
search_string = sys.argv[2].encode()
replace_string = sys.argv[3].encode()

if len(replace_string) > len(search_string):
    print("Replace string must not be longer than search string")
    sys.exit(1)

maps_path = f"/proc/{pid}/maps"
mem_path = f"/proc/{pid}/mem"

heap_start = None
heap_end = None

# 1. Heap range tap
with open(maps_path, "r") as maps_file:
    for line in maps_file:
        if "[heap]" in line:
            addr_range = line.split(" ")[0]
            start, end = addr_range.split("-")
            heap_start = int(start, 16)
            heap_end = int(end, 16)
            break

if heap_start is None:
    print("Heap not found")
    sys.exit(1)

# 2. Memory read/write
with open(mem_path, "rb+") as mem_file:
    mem_file.seek(heap_start)
    heap_size = heap_end - heap_start
    heap_data = mem_file.read(heap_size)

    offset = heap_data.find(search_string)

    if offset == -1:
        print("String not found in heap")
        sys.exit(1)

    print(f"Found at offset: {offset}")

    # absolute address
    addr = heap_start + offset

    # 3. Write replacement
    mem_file.seek(addr)
    mem_file.write(replace_string)

    # padding (if shorter)
    padding = b"\x00" * (len(search_string) - len(replace_string))
    mem_file.write(padding)

    print("Replacement done")
