# encoding=utf-8
require 'spec_helper'

describe 'truncate_utf8' do

  context 'ASCII only' do

    let (:a120) { 'A' * 120 }

    it 'leaves untouched if max_size is larger' do
      a120.truncate_utf8(140).should == a120
    end

    it 'leaves untouched if max_size is equal' do
      a120.truncate_utf8(120).should == a120
    end

    it 'cuts-off if max_size is smaller' do
      a120.truncate_utf8(100).should == 'A'*100
    end
  end

  context 'UTF-8' do

    let (:a120) { 'A' * 100 + 'üÜêéàèûôëï' }

    it 'leaves untouched if max_size is larger' do
      a120.truncate_utf8(140).should == a120
    end

    it 'leaves untouched if max_size is equal' do
      a120.truncate_utf8(120).should == a120
    end

    it 'cuts-off if max_size is smaller' do
      a120.truncate_utf8(100).should == 'A' * 100
    end

    context 'cut-off falls in the UTF-8 region' do
      it 'on utf-8 boundary' do
        a120.truncate_utf8(104).should == 'A' * 100 + 'üÜ'
      end

      context 'halfway in a utf-8 character' do
        it 'keeps all up to one less' do
          a120.truncate_utf8(103).should == 'A' * 100 + 'ü'
        end

        it 'is valid encoding' do
          a120.truncate_utf8(103).should be_valid_encoding
        end
      end
    end
  end
end
