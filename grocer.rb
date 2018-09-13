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
  total = 0
  cart = consolidate_cart(cart)
  coupons_applied = apply_coupons(cart, coupon)
  clearance_applied = apply_clearance(coupons_applied)
  clearance_applied.each do |item, info|
    if info[:count] < 0
      info[:count] = -(info[:count])
    end
    if !item.include?("W/COUPON")
      if clearance_applied[item][:count] < clearance_applied["#{item} W/COUPON"][:count]
        clearance_applied["#{item} W/COUPON"][:count] = clearance_applied[item][:count]
      end
    end
    total += (info[:price] * info[:count])
    puts total
  end
    it total >=100
    total = total - (total*.10)
  else
    total
  end
end
