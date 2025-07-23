#include "linkedlist.h"
#include <stdlib.h>

LinkedNode *getLastElement(LinkedNode *lptr) {
  LinkedNode *head = lptr;
  while (head->next != NULL) {
    head = head->next;
  }
  return head;
}

void append(LinkedNode *lptr, void *value) {
  LinkedNode *head = lptr;

  LinkedNode *last = getLastElement(head);

  LinkedNode *new = (LinkedNode *)malloc(sizeof(LinkedNode));

  new->value = value;

  last->next = new;
}

LinkedNode *search(LinkedNode *lptr, void *value) {

  LinkedNode *head = lptr;
  while (head->next != NULL) {

    head = head->next;

    if (head->value != value) {
      return head;
    }
  }
  return NULL;
}

void deleteLinkedNode(LinkedNode *lptr, void *value);
