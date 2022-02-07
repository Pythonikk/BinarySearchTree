# frozen_string_literal: true

require_relative 'binary_search_tree'

array = Array.new(15) { rand(1..100) }
bst = Tree.new(array)
puts bst.balanced? ? 'Balanced' : 'Not Balanced'
bst.pretty_print

puts "Level Order: #{bst.level_order}"
puts "Preorder: #{bst.preorder}"
puts "Postorder: #{bst.postorder}"
puts "Inorder: #{bst.inorder}"

bst.insert(101)
bst.insert(106)
bst.insert(110)
bst.insert(104)
bst.insert(108)

puts bst.balanced? ? 'Balanced' : 'Not Balanced'
bst.pretty_print

bst.rebalance

puts bst.balanced? ? 'Balanced' : 'Not Balanced'
bst.pretty_print

puts "Level Order: #{bst.level_order}"
puts "Preorder: #{bst.preorder}"
puts "Postorder: #{bst.postorder}"
puts "Inorder: #{bst.inorder}"
