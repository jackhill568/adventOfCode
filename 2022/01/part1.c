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

  int highest[3] = {0, 0, 0};
  int current_total = 0;

  for (int i = 0; fileList[i] != NULL; i++) {
    if (strcmp(fileList[i], "") != 0) {
      current_total += atoi(fileList[i]);
    } else {
      for (int j = 0; j < 3; j++) {
        if (highest[j] < current_total) {
          highest[j] = current_total;
          break;
        }
      }

      current_total = 0;
    }
    free(fileList[i]);
  }
  free(fileList);
  int sum = 0;
  for (int i = 0; i < 3; i++) {

    printf("%d\n", highest[i]);
    sum += highest[i];
  }

  printf("%d\n", sum);
  return 0;
}
