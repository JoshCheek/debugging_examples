require_relative 'comment_formatter'

describe SeeingIsBelieving::Binary::CommentFormatter do
  def result_for(line, separator, result, options={})
    described_class.new(line, separator, result, options).call
  end

  def assert_equal(a, b)
    expect(a).to eq(b)
  end

  specify 'it returns the consolidated result if there are no truncations' do
    assert_equal result_for(1, '=>', '12345'), '=>12345'
  end

  specify 'result_length truncates a result to the specified length, using elipses up to that length if appropriate'  do
    line_length = 1
    separator   = '=>'
    result      = '12345'
    assert_equal result_for(line_length, separator, result, max_result_length: Float::INFINITY), '=>12345'
    assert_equal result_for(line_length, separator, result, max_result_length: 7), '=>12345'
    assert_equal result_for(line_length, separator, result, max_result_length: 6), '=>1...'
    assert_equal result_for(line_length, separator, result, max_result_length: 5), '=>...'
    assert_equal result_for(line_length, separator, result, max_result_length: 4), ''
    assert_equal result_for(line_length, separator, result, max_result_length: 0), ''
  end

  specify 'line_length truncates a result to the specified length, minus the length of the line' do
    line_length = 1
    separator   = '=>'
    result      = '12345'
    assert_equal result_for(line_length, separator, result), '=>12345'
    assert_equal result_for(line_length, separator, result, max_line_length: Float::INFINITY), '=>12345'
    assert_equal result_for(line_length, separator, result, max_line_length: 8), '=>12345'
    assert_equal result_for(line_length, separator, result, max_line_length: 7), '=>1...'
    assert_equal result_for(line_length, separator, result, max_line_length: 6), '=>...'
    assert_equal result_for(line_length, separator, result, max_line_length: 5), ''
    assert_equal result_for(line_length, separator, result, max_line_length: 0), ''
  end

  specify 'pad_to will pad the length that the line is displayed in' do
    assert_equal result_for(1, '=>', '2', pad_to: 0), '=>2'
    assert_equal result_for(1, '=>', '2', pad_to: 1), '=>2'
    assert_equal result_for(1, '=>', '2', pad_to: 2), ' =>2'
  end

  specify 'pad_to is ignored when separator/result will not be printed' do
    assert_equal result_for(1, '=>', '12345', pad_to: 2,   max_line_length: 2), ''
    assert_equal result_for(1, '=>', '12345', pad_to: 2, max_result_length: 2), ''
  end

  specify 'they can all work together' do
    assert_equal result_for(1, '=>', '12345', max_line_length: 100, max_result_length: 100, pad_to: 2), ' =>12345'
    assert_equal result_for(1, '=>', '12345', max_line_length:   8, max_result_length: 100, pad_to: 2), ' =>1...'
    assert_equal result_for(1, '=>', '12345', max_line_length: 100, max_result_length:   6, pad_to: 2), ' =>1...'
    assert_equal result_for(1, '=>', '12345', max_line_length: 100, max_result_length:   6, pad_to: 2), ' =>1...'
  end
end

