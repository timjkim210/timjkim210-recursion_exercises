def range(min, max)
    return [] if max <= min

    range(min, max-1) << max - 1
end

# # p range(1, 5)

def iterative_sum(arr)
    sum = 0
    arr.each {|num| sum += num}
    sum
end

def recursive_sum(arr)
    return 0 if arr.empty?
    arr[0] + recursive_sum(arr.drop(1))
end

# p iterative_sum([1, 2, 3, 4])

# p recursive_sum([1, 2, 3, 4])

def exp_1(base, power)
    return 1 if power == 0
    return base if power == 1
    base * exp_1(base, power-1)
end

# p exp_1(2, 4) #16

def exp_2(base, power)
    return 1 if power == 0
    return base if power == 1

    if power.even?
        exp_2(base, power/2)**2 
    else
        base*(exp_2(base, (power-1)/2)**2)
    end
end

# p exp_2(2, 4) #16
# p exp_2(2, 5) #32

class Array
    def deep_dup
        new_arr = []
        self.each do |el|
            if el.is_a?(Array)
                 new_arr << el.deep_dup 
            else
                new_arr << el
            end
        end
        new_arr
    end
end

# arr = [1, [2], [3, [4]]]
# p arr.deep_dup

def iterative_fibonacci(n)
    return [] if n == 0
    return 0 if n == 1

    numbers = [0, 1]
    while numbers.length - 1 < n
        numbers << numbers[-2] + numbers[-1]
    end
    numbers
end

# p iterative_fibonacci(5)

def recursive_fibonacci(n)
    return [] if n == 0
    return [0] if n == 1
    return [0,1] if n == 2
    fibonacci = recursive_fibonacci(n-1) 
    fibonacci << fibonacci[-2] + fibonacci[-1]
end
#p recursive_fibonacci(5)

def bsearch(arr, target)
    return nil if arr.empty?

    middle = (arr.length)/2
    if arr[middle] == target
        return middle
    elsif arr[middle] < target
        # bsearch(arr[middle..-1], target)
        return nil if bsearch(arr[middle+1..-1], target) == nil 
        return middle + 1 + bsearch(arr[middle+1..-1], target)
    else
        bsearch(arr[0...middle], target)
    end 
end

# p bsearch([1, 2, 3], 1) # => 0 [1] + [2,3]
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

cla  ss Array

def merge_sort
    return self if count < 2 #[65318724]
    middle = count / 2  #4

    left_side = self[0...middle] #[6531]
    right_side = self[middle..-1] #[8724]

    left_sort = left_side.merge_sort
    right_sort = right_side.merge_sort
    merge(left_sort, right_sort)

end

def merge(left_sort, right_sort)
    arr = []

    until left_sort.empty? || right_sort.empty?
        if left_sort[0] < right_sort[0]
            arr << left_sort[0]
            left_sort.shift
        else
            arr << right_sort[0]
            right_sort.shift
        end
    end
    arr + left_sort + right_sort
end

def subsets
    return [[]] if self.length == 0   
    return [[], [self[0]]] if self.length == 1 
    subset1 = self.take(length-1).subsets 
    subset2 = subset1.map {|arr| arr + [last]} 
    subset1 + subset2
end

end

# arr = [6,5,3,1,8,7,2,4]
# arr = [1,3,4,6,2,5,7]
# p arr.merge_sort

# arr = [1, 2, 3] 
# p arr.subsets

def permutations(array)
    return [array] if array.length <= 1

    first_ele = array.shift
    small_perms = permutations(array)

    total = []

    small_perms.each do |perm|
        (0..perm.length).each do |i|
           total << perm[0...i] + [first_ele] + perm[i..-1]
        end
    end
    total
end

# p permutations([1, 2, 3])
# p permutations([1, 2, 3, 4])


def make_change(coins, target)#array of coins and a target
    return nil if coins.empty? 
    return [] if target == 0

    #want to keep track of the best solution so we can store this in a variable and update it
    best_solution = nil

    #we want to iterate through the coins 
    coins.each_with_index do |coin, i|
        #and if the coin is greater than the target, we dont to use it, go next coin
        if coin > target
            next
        end

        #else, we want to use it this is for recursion
        #we want to constantly be updating the remainder of the target left 
        # ex: 26-> 1 quarter bc
        #its the largest -> next target is 1, we dont want to use other things
        # we put this value as the stored variable 
        #and then keep iterating with lower coins 
 
        new_target = target - coin
        remainder = make_change(coins.drop(i), new_target) #moves to next coin, is the remainder of the target

        a_solution = [coin] + remainder

        #and compare solutons
        if best_solution == nil || best_solution.length > a_solution.length 
            best_solution = a_solution
        end
    end
   
    best_solution

end

coins = [25, 10, 7, 1]``
p make_change(coins, 24)