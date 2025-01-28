#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {

  char *filename = "input.txt";
  FILE *fp = fopen(filename, "r");

  if (fp == NULL) {

    printf("Error, could not open file\n");
    return 1;
  }
  const unsigned MAX_LENGTH = 256u;
  char buffer[MAX_LENGTH];

  unsigned total_calibration_code = 0;

  int strlength = 0;
  int pos_in_lst = 0;

  while (fgets(buffer, MAX_LENGTH, fp)) {
    strlength = strlen(buffer);
    char foundInt[strlength];
    for (int i = 0; i < strlength; i++) {
      if (buffer[i] <= '9' && buffer[i] >= '0') {
        foundInt[pos_in_lst] = buffer[i];
        pos_in_lst++;
      }
    }
    foundInt[pos_in_lst] = '\0';

    char num[2] = {foundInt[0], foundInt[pos_in_lst - 1]};
    total_calibration_code += atoi(num);
    pos_in_lst = 0;
  }
  fclose(fp);
  printf("The total calibration value is: %d\n", total_calibration_code);
  return 0;
}
