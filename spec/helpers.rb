def stub_generate_products(product)
  mock_products = [:product, product]
  allow_any_instance_of(Merchandise).to receive(:generate_products) { mock_products }
  Merchandise.new
end
