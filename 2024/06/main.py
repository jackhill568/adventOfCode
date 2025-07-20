def getVerLine(xs: list, x: int) -> list[str]:
    return [i[x] for i in xs]


def getHorLine(xs: list, y: int):
    return xs[y]


def findGuard(xs):
    for i in xs:
        for e in i:
            if e in "v<>^":
                return (i.index(e), xs.index(i))
    return None


def getThingOnGrid(xs, x, y):
    return xs[y][x]


with open("test.txt") as file:
    lines = file.read().strip().split("\n")


print(getThingOnGrid(lines, *findGuard(lines)))
