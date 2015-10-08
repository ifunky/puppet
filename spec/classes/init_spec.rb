require 'spec_helper'

describe 'puppet', :type => :class do
  let(:facts) { {
      :osfamily  => 'Redhat'
  } }
  #let(:params) {{
  #    :ensure       => 'present',
  #    :example_path	=> 'c:\Temp'
  #}}

  it { should contain_class('puppet::install').that_comes_before('puppet::config') }

  context 'should compile with default values' do
    it {
      is_expected.to compile.with_all_deps
      should contain_class('puppet')
    }
  end

  context 'when trying to install on a non RHEL server' do
    let(:facts) { {:osfamily => 'Windows'} }

    it { should compile.and_raise_error(/ERROR:: This module only works on RHEL based systems./) }
  end

end