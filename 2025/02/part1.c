#include "stringman.h"
#include "util.h"

#include <stdio.h>


int checkValidId() {


	return 0;
}



int main() {

  char *data = read_file("../2025/02/test.txt");
  char **ids = splitOn(data, ",");
	
	int i =0;
 	while (ids[i] != NULL) { 

    free(ids[i]);
  }
  free(data);
  free(ids);
}
