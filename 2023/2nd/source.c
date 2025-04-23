

#include <ctype.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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

int main() {
  FILE *fp;
  char *line = NULL;
  size_t len = 0;
  ssize_t read;

  fp = fopen("input.txt", "r");

  int currentSum;
  int num;

  int red = 0;
  int blue = 0;
  int green = 0;

  while ((read = getline(&line, &len, fp)) != -1) {
    strip(line);

    for (int i = 0; line[i] != '\0'; i++) {
      if ((line[i] - '0') * ('9' - line[i]) >= 0) {
        num = num * 10 + (line[i] - '0');
      } else if (num != 0) {
        switch (line[i]) {
        case 'r':
          red = num > red ? num : red;
          break;
        case 'b':
          blue = num > blue ? num : blue;
          break;
        case 'g':
          green = num > green ? num : green;
          break;
        default:
          break;
        }
      }
      if (!isdigit(line[i])) {
        num = 0;
      }
    }
    currentSum += red * green * blue;
    red = 0;
    blue = 0;
    green = 0;
  }

  fclose(fp);

  printf("final value: %d\n", currentSum);
  return 0;
}
