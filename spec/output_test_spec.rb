require "./spec/spec_helper"

describe "describe block 1" do
  5.times do |i|
    it "runs test #{i}" do
      expect(true).to eq([true, true, true, false].sample)
      #sleep(rand(0.8) + 0.5)
    end
  end

  xit "is pending" do
    raise "pending"
  end

  it "shows a stack trace" do
    method_a
  end

  def method_a; method_b; end
  def method_b; method_c; end
  def method_c; method_d; end
  def method_e; method_f; end
  def method f; raise "Oops a failure!"; end


end
