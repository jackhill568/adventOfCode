#include "stringman.h"
#include "util.h"
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void change_highest_array(int array[3], int new_val) {
  for (int j = 0; j < 3; j++) {
    if (array[j] < new_val) {
      change_highest_array(array, array[j]);
      array[j] = new_val;
      break;
    }
  }
}

int main() {
  char *file = read_file("../2022/01/input.txt");
  char **fileList = splitOn(file, '\n');
  free(file);

  int highest[3] = {0, 0, 0};
  int current_total = 0;

  for (int i = 0; fileList[i] != NULL; i++) {
    if (strcmp(fileList[i], "") != 0) {
      current_total += atoi(fileList[i]);
    } else {
      change_highest_array(highest, current_total);
      current_total = 0;
    }
    free(fileList[i]);
  }
  free(fileList);

  for (int i = 0; i < 3; i++) {
    printf("%d\n", highest[i]);
  }

  printf("%d\n", highest[0] + highest[1] + highest[2]);
  return 0;
}
