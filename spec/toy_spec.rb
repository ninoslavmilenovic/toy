# encoding: utf-8

require 'spec_helper'

describe Toy do
  it 'has a VERSION constant' do
    expect(subject.const_get('VERSION')).not_to be_empty
  end
end
