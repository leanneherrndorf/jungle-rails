require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "is saved successfully" do
      @catTest = Category.find_or_create_by! name: 'testcat'
      product = @catTest.products.create!({
        name:  'test',
        description: 'test',
        quantity: 1,
        price: 1
      })
      puts product.errors.full_messages
      expect(product).to be_persisted
    end

    it "is not valid without a name" do
      catTest = Category.find_or_create_by! name: 'testcat'
      product = catTest.products.create!({
        name:  nil,
        description: 'test',
        quantity: 1,
        price: 1
      })
      puts product.errors.full_messages
      expect(product).to_not be_valid
    end

    it "is not valid without a price" do
      catTest = Category.find_or_create_by! name: 'testcat'
      product = catTest.products.create!({
        name:  'test',
        description: 'test',
        quantity: 'test',
        price: nil
      })
      puts product.errors.full_messages
      expect(product).to_not be_valid
    end

    it "is not valid without a quantity" do
      catTest = Category.find_or_create_by! name: 'testcat'
      product = catTest.products.create!({
        name:  'test',
        description: 'test',
        quantity: nil,
        price: 1
      })
      puts product.errors.full_messages
      expect(product).to_not be_valid
    end

    it "is not valid without a category" do
      catTest = Category.find_or_create_by! name: 'testcat'
      product = catTest.products.create!({
        name:  'test',
        category_id: 1,
        description: 'test',
        quantity: 1,
        price: 1
      })
      puts product.errors.full_messages
      expect(product).to_not be_valid
    end

  end
end
