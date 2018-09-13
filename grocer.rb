def consolidate_cart(cart)
  result = {}
  cart.each do |item, value|
    item.each do |food, info|
      if result[food]
        result[food][:count] +=1
      else result[food] = info
        result[food][:count] = 1
      end
    end
  end
  result
end

def apply_coupons(cart, coupons)
  result ={}
  cart.each do |item, info|
    coupons.each do |coupon|
      if item == coupon[:item] && info[:count] >= coupon[:num]
        info[:count] = info[:count] - coupon[:num]
        if result["#{item} W/COUPON"]
          result["#{item} W/COUPON"][:count] +=1
        else result["#{item} W/COUPON"] = {:price => coupon[:cost],
        :clearance => info[:clearance], :count => 1}
      end
    end
  end
  result[item] = info
end
result
end

def apply_clearance(cart)
  clearance_cart = {}
  cart.each do |item, info|
    clearance_cart[item] = {}
    if info[:clearance] == true
      clearance_cart[item][:price] = info[:price] * 4/5
    else clearance_cart[item][:price] = info[:price]
    end
    clearance_cart[item][:clearance] = info[:clearance]
    clearance_cart[item][:count] = info[:count]
  end
  clearance_cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(:cart cart)
  cart = apply_coupons(cart: cart, coupons: coupons)
  cart = apply_clearance(cart: cart)
  result = 0
  cart.each do |food, info|
    result += (info[:price] * info[:count]).to_f
  end
  result > 100 ? result * 0.10 : result
end
