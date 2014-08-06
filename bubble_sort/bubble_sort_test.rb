require_relative 'bubble_sort'

describe 'bubble_sort' do
  it 'sorts length 0' do
    expect(bubble_sort([])).to eq []
  end

  it 'sorts length 1' do
    expect(bubble_sort([1])).to eq [1]
  end

  it 'sorts length 2 in order' do
    expect(bubble_sort([1, 2])).to eq [1, 2]
  end

  it 'sorts length 2 out of order' do
    expect(bubble_sort([1, 2])).to eq [1, 2]
  end

  it 'sorts length 3' do
    expect(bubble_sort([1, 2, 3])).to eq [1, 2, 3]
    expect(bubble_sort([1, 3, 2])).to eq [1, 2, 3]
    expect(bubble_sort([2, 1, 3])).to eq [1, 2, 3]
    expect(bubble_sort([2, 3, 1])).to eq [1, 2, 3]
    expect(bubble_sort([3, 1, 2])).to eq [1, 2, 3]
    expect(bubble_sort([3, 2, 1])).to eq [1, 2, 3]
  end

  it 'sorts other objs' do
    expect(bubble_sort(['a', 'c', 'b'])).to eq ['a', 'b', 'c']
  end
end
