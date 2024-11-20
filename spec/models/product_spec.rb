require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.create(name: 'Test category')
    end

    it 'saves successfully with all fields set' do
      product = Product.new(
        name: 'Test product',
        price_cents: 1000,
        quantity: 5,
        category: @category
      )
      expect(product).to be_valid
    end

    it 'is invalid without a name' do
      product = Product.new(
        name: nil,
        price_cents: 1000,
        quantity: 5,
        category: @category
      )
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end
    
    it 'is invalid without a price' do
      product = Product.new(
        name: 'Test product',
        price_cents: nil,
        quantity: 5,
        category: @category
      )
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Price can't be blank")
    end
    
    it 'is invalid without a quantity' do
      product = Product.new(
        name: 'Test product',
        price_cents: 10000,
        quantity: nil,
        category: @category
      )
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end
    
    it 'is invalid without a category' do
      product = Product.new(
        name: 'Test product',
        price_cents: 10000,
        quantity: 5,
        category: nil
      )
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end