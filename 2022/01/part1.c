#include "stringman.h"
#include "util.h"
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>

int main() {
  char *file = read_file("test.txt");
  char **fileList = splitOn(file, '\n');
  free(fileList);
  // free(file);

  // print_string(fileList);

  return 0;
}
