

with open("input.txt", "r") as file:
    contents =file.read().strip().split("\n")

    contents = [x.split("   ") for x in contents]
    # print(contents)

# contents is a now a 2D array with the values in each of the lists
# next step is to unpack them and sort them
# sorting with heap sort 
left_list = []
right_list = []
for x,y in contents:
    left_list.append(int(x))
    right_list.append(int(y))

def heapify(arr, n, i): # recursively places largest number at the end of the array
      largest = i
      l = 2 * i + 1
      r = 2 * i + 2

      if l < n and arr[i] < arr[l]:
          largest = l

      if r < n and arr[largest] < arr[r]:
          largest = r

      if largest != i:
          arr[i], arr[largest] = arr[largest], arr[i]
          heapify(arr, n, largest)

def heap_sort(arr):
    n = len(arr)

    for i in range(n // 2 - 1, -1, -1):
        heapify(arr, n, i)

    for i in range(n - 1, 0, -1):
        arr[i], arr[0] = arr[0], arr[i]
        heapify(arr, i, 0)

    return arr

heap_sort(left_list)
heap_sort(right_list)

with open("output.txt", "w") as file:

    file.write(str(sum([abs(x-y) for x, y in zip(left_list, right_list)])))
