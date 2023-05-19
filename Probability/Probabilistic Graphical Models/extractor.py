import json

with open("input.txt") as f:
    lines = f.readlines()

content = {}
curr = content
stack = []

for line in lines:
    title, page = line.strip().split(" ")
    depth = title.count(".")
    title = title[depth + 1 :]
    page = int(page)

    node = {"title": title, "page": page}

    while len(stack) > depth:
        stack.pop()
        curr = content
        for i in range(len(stack)):
            curr = curr[stack[i]]["subsections"]

    if len(stack) == depth:
        if depth == 0:
            content[title] = node
        else:
            curr[title] = node
            stack.append(title)
    else:
        raise ValueError("Invalid depth")

with open('output.json', 'w') as f:
    json.dump(content, f, indent=4)
