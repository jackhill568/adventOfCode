
#include <ctype.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_BLUE 14
#define MAX_RED 12
#define MAX_GREEN 13

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
  int score = 0;
  int badScore = 0;
  bool validGame = true;
  int num;

  for (int game = 1; (read = getline(&line, &len, fp)) != -1; game++) {
    strip(line);

    for (int i = 0; line[i] != '\0'; i++) {
      if ((line[i] - '0') * ('9' - line[i]) >= 0) {
        num = num * 10 + (line[i] - '0');
      } else if (num != 0) {
        switch (line[i]) {
        case 'r':
          if (num > MAX_RED) {
            validGame = false;
          }
          break;
        case 'b':
          if (num > MAX_BLUE) {
            validGame = false;
          }
          break;
        case 'g':
          if (num > MAX_GREEN)
            validGame = false;
          break;
        default:
          break;
        }
      }
      if (!isdigit(line[i])) {
        num = 0;
      }
    }

    if (validGame == false) {
      badScore += game;
      validGame = true;
    } else {
      score += game;
    }
  }

  fclose(fp);

  printf("final Score: %d\n", score);
  return 0;
}
