#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  int *array;
  size_t used;
  size_t size;
} Array;

void initArray(Array *a, size_t initialSize) {
  a->array = malloc(initialSize * sizeof(long long int));
  a->used = 0;
  a->size = initialSize;
}

void insertArray(Array *a, long long int element) {
  // a->used is the number of used entries, because a->array[a->used++] updates
  // a->used only *after* the array has been accessed. Therefore a->used can go
  // up to a->size
  if (a->used == a->size) {
    a->size *= 2;
    a->array = realloc(a->array, a->size * sizeof(long long int));
  }
  a->array[a->used++] = element;
}

void freeArray(Array *a) {
  free(a->array);
  a->array = NULL;
  a->used = a->size = 0;
}
int main() {
  char *filename = "input.txt";
  FILE *fp = fopen(filename, "r");

  if (fp == NULL) {

    printf("Error, could not open file\n");
    return 1;
  }
  const unsigned MAX_LENGTH = 256u;
  char buffer[MAX_LENGTH];

  Array listOfCals;
  initArray(&listOfCals, 1);
  int pointer = 0;
  long long int max = 0;

  while (fgets(buffer, MAX_LENGTH, fp)) {
    if (listOfCals.array[pointer] > max) {
      max = listOfCals.array[pointer];
    }
    if (strcmp(buffer, "\n") != 0) {
      listOfCals.array[pointer] = listOfCals.array[pointer] + atoi(buffer);
    } else {
      insertArray(&listOfCals, 0);
      pointer += 1;
    }
  }
  fclose(fp);
  printf("the max calories is: %lld\n", max);
  return 0;
}
