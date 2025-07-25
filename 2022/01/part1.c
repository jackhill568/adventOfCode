#include "stringman.h"
#include "util.h"
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
  char *file = read_file("../2022/01/test.txt");
  char **fileList = splitOn(file, '\n');
  free(file);

  int highest = 0;
  int current_total = 0;

  for (int i = 0; fileList[i] != NULL; i++) {
    if (strcmp(fileList[i], "") != 0) {
      current_total += atoi(fileList[i]);
    } else {
      if (highest < current_total) {
        highest = current_total;
      }
      current_total = 0;
    }
    free(fileList[i]);
  }
  free(fileList);

  printf("%d\n", highest);
  return 0;
}
