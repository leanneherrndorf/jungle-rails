require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "User clicks on add to cart" do
    # ACT
    visit root_path

    find('.product .btn-primary', :match => :first).click
    # DEBUG / VERIFY
    #save_screenshot
    #puts page.html

    cart = find('.nav:last-child')

    expect(cart).to have_content("My Cart  (1)")
  end

end
