def bubble_sort(array)
  array.size.times do
    index = 1
    until array.size <= index
      if array[index] < array[index-1]
        a = array[index]
        b = array[index-1]
        array[index]   = a
        array[index-1] = b
      end
      index += 1
    end
  end
  array
end

def bubble(array)
end
