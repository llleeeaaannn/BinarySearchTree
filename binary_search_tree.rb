# Node class which stores a value alongside its left and right children (which are nil by default)
class Node

  attr_accessor :value, :left_child, :right_child

  def initialize(value, left_child = nil, right_child = nil)
    @value = value
    @left_child = left_child
    @right_child = right_child
  end

end

# Class for a balanced binary tree which accepts an array and turns it into said binary tree.
class Tree

  attr_accessor :root, :array

  def initialize(array)
    @array = array.sort.uniq
    @root = build_tree(@array)
  end

  # Method which accepts an array as an argument and turns it into a balancd binary tree of Node objects.
  def build_tree(array)
    return nil if array.empty?

    half = array.length / 2
    middle = array.delete_at(half)

    node = Node.new(middle)

    node.left_child = build_tree(array[0, half])
    node.right_child = build_tree(array[half, half * 2])

    node
  end

  # This method accepts a value and inserts a node with the given value while keeping the binary tree ordered.
  def insert(value)
    node = Node.new(value)

    current = root
    while !current.left_child.nil? || !current.right_child.nil?
      if current.left_child.nil?
        return current.left_child = node if value < current.value

        current = current.right_child
      elsif current.right_child.nil?
        return current.right_child = node if value > current.value

        current = current.left_child
      else
        current = value < current.value ? current.left_child : current.right_child
      end
    end

    value < current.value ? current.left_child = node : current.right_child = node
  end

  # This method accepts a value and deletes a node with the given value while keeping the binary tree ordered. Where there is no node with the given value, the method simply returns nil.
  def delete(value)
    current = root
    until current.value == value || current.nil?
      previous = current
      current = value < current.value ? current.left_child : current.right_child
    end

    return nil if current.nil?

    if current.left_child.nil? && current.right_child.nil?
      current.value < previous.value ? previous.left_child = nil : previous.right_child = nil
    elsif current.left_child.nil? && !current.right_child.nil?
      previous.right_child = current.right_child
    elsif !current.left_child.nil? && current.right_child.nil?
      previous.left_child = current.left_child
    else
      next_biggest = current.right_child
      until next_biggest.left_child.nil?
        previous_biggest = next_biggest
        next_biggest = next_biggest.left_child
      end
      next_biggest.left_child = current.left_child
      previous_biggest.left_child = nil
      if current == root
        next_biggest.right_child = current.right_child
        @root = next_biggest
      else
        value < previous.value ? previous.left_child = next_biggest : previous.right_child = next_biggest
      end
    end

  end

  # Method which accepts a value and returns a node with the passed value. If there is no node with the given value the method returns nil. This method can be used for getting nodes to pass to the 'height' and 'depth' functions below
  def find(value)
    current = root
    until current.nil? || current.value == value
      current = value < current.value ? current.left_child : current.right_child
    end
    current.nil? ? nil : current
  end

  # Method which accepts a block and traverses the tree in breadth first level order while passing each node to the block. Where no block is given, the method simply returns an array of all node values in breadth first order.
  def level_order(&block)
    current = root
    queue = [current]
    data = []
    until queue.empty?
      queue.push(current.left_child) unless current.left_child.nil?
      queue.push(current.right_child) unless current.right_child.nil?
      block_given? ? block.call(current) : data.push(current.value)
      queue.shift
      current = queue[0]
    end
    return data unless block_given?
  end

  # Method which accepts a block and traverses the tree through depth-first pre-order. Each node is passed to the block. If no block is given then the method simply returns an array of node values in pre-order
  def preorder(node = root, data = [], &block)
    return if node.nil?

    block_given? ? block.call(node) : data.push(node.value)
    preorder(node.left_child, data, &block)
    preorder(node.right_child, data, &block)

    return data unless block_given?
  end

  # Method which accepts a block and traverses the tree through depth-first in-order. Each node is passed to the block. If no block is given then the method simply returns an array of node values in in-order
  def inorder(node = root, data = [], &block)
    return if node.nil?

    inorder(node.left_child, data, &block)
    block_given? ? block.call(node) : data.push(node.value)
    inorder(node.right_child, data, &block)

    return data unless block_given?
  end

  # Method which accepts a block and traverses the tree through depth-first post-order. Each node is passed to the block. If no block is given then the method simply returns an array of node values in post-order
  def postorder(node = root, data = [], &block)
    return if node.nil?

    postorder(node.left_child, data, &block)
    postorder(node.right_child, data, &block)
    block_given? ? block.call(node) : data.push(node.value)

    return data unless block_given?
  end

  # Method which accepts a node and returns its height in the tree.
  def height(node = root)
    return -1 if node.nil?

    left = height(node.left_child)
    right = height(node.right_child)

    if left > right
      left + 1
    else
      right + 1
    end
  end

  # Method which accepts a node and returns its depth in the tree.
  def depth(node)
    i = 0
    current = root
    until node == current
      current = node.value < current.value ? current.left_child : current.right_child
      i += 1
    end
    i
  end

  # Method which returns true if the tree it is called on is balanced and false if the tree is not balanced
  def balanced?(node = root)
    return true if node.nil?

    left_height = height(node.left_child)
    right_height = height(node.right_child)

    return true if (left_height - right_height).abs <= 1 && balanced?(node.left_child) && balanced?(node.right_child)

    false
  end

  # Method which rebalances the tree it is called on by rebuilding the tree from a sorted array of its node values which is acquired through the 'inorder' function
  def rebalance
    self.array = inorder
    self.root = build_tree(@array)
  end

  # Method which prints the binary tree in an easy to visualise format
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

end

def demonstrate
  # Creates array of 15 random numbers between 1 and 100
  array = (Array.new(15) { rand(1..100) })
  # Creates binary search tree from the array
  mytree = Tree.new(array)
  # Prints visulaisation of the tree
  mytree.pretty_print
  # Checks if tree is balanced (it is in this case as it has just been created)
  puts mytree.balanced?
  # Prints out array of node values in preorder
  print mytree.preorder
  puts ' '
  # Prints out array of node values in order
  print mytree.inorder
  puts ' '
  # Prints out array of node values in postorder
  print mytree.postorder
  puts ' '
  # Inserts nodes with values larger than the largest value ion the current tree to make the tree unbalanced
  mytree.insert(101)
  mytree.insert(102)
  mytree.insert(103)
  mytree.insert(104)
  mytree.insert(105)
  # Prints visulaisation of the tree (clearly unbalanced)
  mytree.pretty_print
  # Checks if tree is balanced (it is not)
  puts mytree.balanced?
  # Rebalance tree
  mytree.rebalance
  # Prints visulaisation of the now rebalanced tree
  mytree.pretty_print
  # Checks if tree is balanced, it is again
  puts mytree.balanced?
end

demonstrate()
