# frozen_string_literal: true

require 'pry-byebug'

# Defines a node.
class Node
  attr_accessor :data, :left_child, :right_child

  def initialize(data, left_child = nil, right_child = nil)
    @data = data
    @left_child = left_child
    @right_child = right_child
  end
end

# Defines a binary search tree.
class Tree
  attr_accessor :data, :root

  def initialize(array)
    @data = array.sort.uniq
    @root = build_tree(data)
  end

  def build_tree(array)
    return nil if array.empty?

    mid = (array.size - 1) / 2
    root = Node.new(array[mid])
    root.left_child = build_tree(array[0...mid])
    root.right_child = build_tree(array[(mid + 1)..-1])
    root
  end

  def insert(value, current_node = root)
    if value < current_node.data
      if current_node.left_child.nil?
        current_node.left_child = Node.new(value)
      else
        insert(value, current_node.left_child)
      end
    elsif value > current_node.data
      if current_node.right_child.nil?
        current_node.right_child = Node.new(value)
      else
        insert(value, current_node.right_child)
      end
    end
  end

  def delete(value, current_node = root)
    return nil if current_node.nil?

    if value < current_node.data
      current_node.left_child = delete(value, current_node.left_child)
      current_node
    elsif value > current_node.data
      current_node.right_child = delete(value, current_node.right_child)
      current_node
    # the value to delete is found
    elsif value == current_node.data
      if current_node.left_child.nil?
        current_node.right_child
      elsif current_node.right_child.nil?
        current_node.left_child
      else
        current_node.right_child = lift(current_node.right_child, current_node)
        current_node
      end
    end
  end

  def lift(current_node, node_to_delete)
    if current_node.left_child
      current_node.left_child = lift(current_node.left_child, node_to_delete)
      current_node
    else
      node_to_delete.data = current_node.data
      current_node.right_child
    end
  end

  def find(value, current_node = root)
    return nil if current_node.nil?
    return current_node if current_node.data == value

    if value > current_node.data
      find(value, current_node.right_child)
    else
      find(value, current_node.left_child)
    end
  end

  # yields each node to the block or returns array of nodes if no block is given.
  def level_order(&block)
    nodes = level_order_traversal(root)
    return nodes unless block_given?

    nodes.each(&block)
  end

  # traverse tree in breadth-first level order.
  def level_order_traversal(current_node, nodes = [], queue = [])
    queue.unshift(current_node) if current_node == root
    nodes << current_node
    queue.unshift(current_node.left_child) if current_node.left_child
    queue.unshift(current_node.right_child) if current_node.right_child
    queue.pop

    return nodes if queue.empty?

    current_node = queue.last
    level_order_traversal(current_node, nodes, queue)
  end

  def preorder(&block)
    nodes = preorder_traversal(root)
    return nodes unless block_given?

    nodes.each(&block)
  end

  # root, left, right
  def preorder_traversal(current_node, nodes = [])
    return if current_node.nil?

    nodes << current_node
    preorder_traversal(current_node.left_child, nodes)
    preorder_traversal(current_node.right_child, nodes)
    nodes
  end

  def inorder(&block)
    nodes = inorder_traversal(root)
    return nodes unless block_given?

    nodes.each(&block)
  end

  # left, root, right (sorted order)
  def inorder_traversal(current_node, nodes = [])
    return if current_node.nil?

    inorder_traversal(current_node.left_child, nodes)
    nodes << current_node
    inorder_traversal(current_node.right_child, nodes)
    nodes
  end

  def postorder(&block)
    nodes = postorder_traversal(root)
    return nodes unless block_given?

    nodes.each(&block)
  end

  # left, right, root
  def postorder_traversal(current_node, nodes = [])
    return if current_node.nil?

    postorder_traversal(current_node.left_child, nodes)
    postorder_traversal(current_node.right_child, nodes)
    nodes << current_node
    nodes
  end

  # number of edges in longest path from node to a leaf node
  def height(node = root)
    return -1 if node.nil?

    left = height(node.left_child)
    right = height(node.right_child)
    [left, right].max + 1
  end

  # number of edges in path from node up to root node.
  def depth(node, current_node = root, edges = 0)
    return 0 if node == root
    return nil if current_node.nil?
    return edges if current_node == node

    edges += 1
    if node > current_node
      depth(node, current_node.right_child, edges)
    else
      depth(node, current_node.left_child, edges)
    end
  end

  # returns true if the difference in heights of left and right subtree
  # of every node is not more than 1.
  def balanced?(current_node = root)
    return true if current_node.nil?

    left = height(current_node.left_child)
    right = height(current_node.right_child)
    if (left - right).abs <= 1 &&
       balanced?(current_node.left_child) &&
       balanced?(current_node.right_child)
      true
    else
      false
    end
  end

  def rebalance
    nodes = inorder.map(&:data)
    self.data = nodes
    self.root = build_tree(data)
  end

  # copied from another student:
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end
