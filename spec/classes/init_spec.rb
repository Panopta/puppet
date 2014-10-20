require 'spec_helper'
describe 'panopta' do

  context 'with defaults for all parameters' do
    it { should contain_class('panopta') }
  end
end
