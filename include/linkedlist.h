#ifndef LINKEDLIST_H
#define LINKEDLIST_H

typedef struct {
  void *value;
  void *next;
} LinkedNode;

LinkedNode *getLastElement(LinkedNode *lptr);

void append(LinkedNode *lptr, void *value);

void deleteLinkedNode(LinkedNode *lptr, void *dptr);

LinkedNode *search(LinkedNode *lptr, void *value);

#endif // LINKEDLIST_H
#define LINKEDLIST_H
