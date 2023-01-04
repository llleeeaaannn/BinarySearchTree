# BinarySearchTree
This repository is my implementation of a Binary Search Tree data structure through Ruby which I undertook as part of The Odin Project. I implemented a class for the tree itself while also creating a class representing the nodes found in the tree. I also added several useful methods to the linked list class as shown below.

# Guide for use
To use this data structure, simply include it in your file or project, and create an instance of it with an array as an argument. All methods can be called directly on the instance of the class.

# Methods
| Methods           | Functionality |
| ----------------- | :---------- |
| #build_tree(array)         | Creates a balanced binary search tree from an array, this is called automatically when creating an instance of the tree object |
| #insert(value)             | Adds a new node containing value to the tree |
| #delete(value)             | Removes a node containing the given value from the tree while keeping said nodes children intact in the tree (and moving them if necessary) |
| #find(value)               | Method which accepts a value and returns a node with the passed value. If there is no node with the given value the method returns nil |
| #level_order(&block)       | Method which accepts a block and traverses the tree in breadth first level order while passing each node to the block. Where no block is given, the method simply returns an array of all node values in breadth first order. |
| #preorder(&block)          | Method which accepts a block and traverses the tree through depth-first pre-order (root, left, right). Each node is passed to the block. If no block is given then the method simply returns an array of node values in pre-order |
| #inorder(&block)           | Method which accepts a block and traverses the tree through depth-first in-order (left, root, right). Each node is passed to the block. If no block is given then the method simply returns an array of node values in in-order |
| #postorder(&block)         | Method which accepts a block and traverses the tree through depth-first post-order (left, right, root). Each node is passed to the block. If no block is given then the method simply returns an array of node values in post-order |
| #height(node)              | Method which accepts a node and returns its height in the tree |
| #depth(node)               | Method which accepts a node and returns its depth in the tree |
| #balanced?                 | Method which returns true if the tree it is called on is balanced and false if the tree is not balanced |
| #rebalance                 | Method which rebalances the tree it is called on by rebuilding the tree from a sorted array of its node values which is acquired through the 'inorder' function |
| #pretty_print               | Method which prints the binary tree in an easy to visualise format. Found online, not mine |
