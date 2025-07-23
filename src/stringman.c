
#include "stringman.h"
#include <ctype.h>
#include <stdlib.h>
#include <string.h>

char **splitOn(char *input, char splitter) {
  int count = 0, length = 0, start = 0;
  char **output = NULL;
  int size = strlen(input);
  for (int i = 0; i < size + 1; i++) {
    if (input[i] == splitter || input[i] == '\0') {
      length = i - start;
      char *temp = malloc(length + 1);
      strncpy(temp, input + start, length);
      temp[length] = '\0';
      output = realloc(output, (count + 1) * sizeof(char *));
      output[count++] = temp;
      start = i + 1;
    }
  }
  output = realloc(output, (count + 1) * sizeof(char *));
  output[count] = NULL;
  return output;
}

void strip(char *input) {
  int readptr = 0;
  int writeptr = 0;
  while (input[readptr] != '\0') {
    if (!isspace((unsigned char)input[readptr])) {
      input[writeptr++] = input[readptr];
    }
    readptr++;
  }
  input[writeptr] = '\0';
  while (input[writeptr]) {
    input[writeptr++] = '\0';
  }
}
