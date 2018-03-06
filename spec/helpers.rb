def stub_generate_products(product)
  mock_products = [:product, product]
  allow_any_instance_of(Merchandise).to receive(:generate_products) { mock_products }
  Merchandise.new
end

def stub_generate_coins(coin)
  allow(coin).to receive(:value) { 1 }
  mock_coins = [coin]
  allow_any_instance_of(Change).to receive(:generate_coins) { mock_coins }
  Change.new
end
