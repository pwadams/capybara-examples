require 'rails_helper'

describe Sandwich do
    before do
      tuna = Sandwich.new(name: "Terrible Tuna", price: 3.50, notes: "shop special")
    end

  it 'is valid with a name and price' do
    tuna.valid?
    expect(tuna).to be_valid
  end

  it 'is invalid without a name' do
    tuna.name = nil
    task.valid?
    expect(task.errors[:name]).to eq(["can't be blank"])
  end

  it 'is invalid without a price' do
    tuna.price = nil
    tuna.valid?
    expect(tuna.errors[:price]).to eq(["can't be blank"])
  end
end
