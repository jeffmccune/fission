require File.expand_path('../../spec_helper.rb', __FILE__)

describe Fission::Response do
  describe 'initialize' do
    it 'should allow you to set the code' do
      Fission::Response.new(:code => 1).code.should == 1
    end

    it 'should set the code to 1 if not provided' do
      Fission::Response.new.code.should == 1
    end

    it 'should allow you to set the message' do
      Fission::Response.new(:message => 'foobar').message.should == 'foobar'
    end

    it 'should set the message to an empty string if not provided' do
      Fission::Response.new.message.should == ''
    end

    it 'should set the data to nil if not provided' do
      Fission::Response.new.data.should be_nil
    end

  end

  describe 'code' do
    it 'should allow you to set the code' do
      @response = Fission::Response.new
      @response.code = 4
      @response.code.should == 4
    end
  end

  describe 'successful?' do
    it 'should return true if the code is 0' do
      Fission::Response.new(:code => 0).successful?.should == true
    end

    it 'should return false if the code is not 0' do
      Fission::Response.new(:code => 1).successful?.should == false
    end
  end

  describe 'message' do
    it 'should allow you to set the message' do
      @response = Fission::Response.new
      @response.message = 'foobar'
      @response.message.should == 'foobar'
    end
  end

  describe 'data' do
    it 'should allow you to set the data' do
      @response = Fission::Response.new
      @response.data = [1, 2, 3]
      @response.data.should == [1, 2, 3]
    end
  end

  describe 'self.from_command' do
    it 'should return a response object' do
      Fission::Response.from_command('').should be_a Fission::Response
    end

    it 'should set the code to the exit status' do
      $?.should_receive(:exitstatus).and_return(55)
      Fission::Response.from_command('').code.should == 55
    end

    it 'should set the message if the command was unsuccessful' do
      $?.should_receive(:exitstatus).and_return(55)
      Fission::Response.from_command('foo').message.should == 'foo'
    end
    it 'should not set the message if the command was successful' do
      $?.should_receive(:exitstatus).and_return(0)
      Fission::Response.from_command('foo').message.should == ''
    end

  end
end
