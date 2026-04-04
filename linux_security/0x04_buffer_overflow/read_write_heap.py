#!/usr/bin/python3
import sys

if len(sys.argv) != 4:
    sys.exit(1)

pid = sys.argv[1]
search_string = sys.argv[2].encode()
replace_string = sys.argv[3].encode()

if len(replace_string) > len(search_string):
    sys.exit(1)

maps_path = f"/proc/{pid}/maps"
mem_path = f"/proc/{pid}/mem"

heap_start = None
heap_end = None

with open(maps_path, "r") as maps_file:
    for line in maps_file:
        if "[heap]" in line:
            addr_range = line.split(" ")[0]
            start, end = addr_range.split("-")
            heap_start = int(start, 16)
            heap_end = int(end, 16)
            break

if heap_start is None:
    sys.exit(1)

with open(mem_path, "rb+") as mem_file:
    mem_file.seek(heap_start)
    heap_data = mem_file.read(heap_end - heap_start)

    offset = heap_data.find(search_string)

    if offset == -1:
        sys.exit(1)

    addr = heap_start + offset

    mem_file.seek(addr)
    mem_file.write(replace_string)

    padding = b"\x00" * (len(search_string) - len(replace_string))
    mem_file.write(padding)

print("SUCCESS!")
