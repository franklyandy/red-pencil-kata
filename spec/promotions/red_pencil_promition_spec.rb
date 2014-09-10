require 'spec_helper'

describe 'a simple test' do
  Given(:first_num) { 1 }
  Given(:second_num) { 2 }
  When(:result) { first_num + second_num }
  Then { result == 3 }
end
