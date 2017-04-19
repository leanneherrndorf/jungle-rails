require 'rails_helper'

RSpec.feature "Visitor navigates from home page to product detail pages", type: :feature, js: true do
    # SETUP
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

  scenario "They click on a product" do
    # ACT
    visit root_path

    first('.product .btn-default').click
    #wnd = window_opened_by { click_on '.btn-default' }
    # DEBUG / VERIFY
    #save_screenshot
    #puts page.html

    expect(page).to have_css '.product-detail'
  end

end
