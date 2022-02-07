# Binary Search Tree

My implementation of the node based data structure per guidance on theodinproject.com.

[Project: Binary Search Trees](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-programming/lessons/binary-search-trees)

## Uses

With a time complexity of O(log N) in the best case to average case scenarios, this data structure is most efficient for storing and manipulating ordered data. Keeping the tree balanced is key to efficiency. 

## Callable methods on bst object:

#build_tree(array)

#insert(value)

#delete(value)

#find(value); returns the node

#level_order; returns array in breadth first level order unles block given.

#preorder(&block); returns array in preorder unless block given.

#inorder(&block); returns array in inorder unless block given.

#postorder(&block); returns array in postorder unless block given.

#height(node); returns tree height if arg not supplied.

#depth(node)

#balanced?

#rebalance

