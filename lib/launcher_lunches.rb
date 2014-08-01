def meal_data
  meal_data = {}
  restaurants.each do |restaurant_name, restaurant_hash|
    meal_data[restaurant_name] = { 
      hours: restaurant_hash[:hours],
      items: {},
      ingredients: {}
    }
    restaurants[restaurant_name][:meals].each do |meal_name, meal_hash|
      meal_hash.each do |item_name, item_hash|
        item_ingredients = item_hash[:ingredients]
        meal_data[restaurant_name][:ingredients][item_name] = item_ingredients
        item_price = item_hash[:price_in_cents]
        item_name = item_name.to_s.gsub('_', ' ').capitalize
        meal_data[restaurant_name][:items][item_name]= item_price
      end
    end
  end
  meal_data
end

def prices
  prices = []
  meal_data.each do |restaurant_name, hash|
    prices << hash[:items].values
  end
  prices
end

def most_expensive
  highest_price = prices.flatten.max
  meal_data.each do |restaurant_name, hash|
    meal_data[restaurant_name][:items].each do |item_name, price|
      return "#{item_name} from #{restaurant_name}" if price == highest_price
    end
  end
end

def one_of_everything_from(name)
  pennies = meal_data[name][:items].values.reduce(0) do |sum, element|
    sum + element
  end
  "#{pennies/100}.#{pennies%100}".to_f  
end

def monthly_egg_count
  eggs = 0
  meal_data.each do |restaurant_name, hash|
    eggs += hash[:hours] * 16 * 30
  end
  eggs
end

def lactose_free_items
  items = []
  meal_data.each do |restaurant_name, restaurant_hash|
    meal_data[restaurant_name][:ingredients].each do |item_name, array|
      items << item_name unless array.any? do |ingr| 
        ingr == 'cheese' || ingr == 'milk'
      end
      puts array
    end
  end
  items
end



# restaurant data
def restaurants
  {
    "Sam's Sandwhiches" => {
      hours: 7,
      meals: {
        breakfast: {
          hamncheese: {
            price_in_cents: 499,
            ingredients: ["ham", "cheese", "english muffin"]
          },
          mcwaffle: {
            price_in_cents: 525,
            ingredients: ["waffles", "syrup", "sausage", "cheese"]
          }
        },
        lunch: {
          meatball_rollup: {
            price_in_cents: 709,
            ingredients: ["meatballs", "cheese", "tortilla"]
          },
          fluffer_nutter_with_bacon: {
            price_in_cents: 639,
            ingredients: ["bread", "fluff", "peanutbutter", "bacon"]
          }
        }
      }
    },
    "Adam's Veggie Express" => {
      hours: 10,
      meals: {
        breakfast: {
          asparagus_omlette: {
            price_in_cents: 688,
            ingredients: ["eggs", "cheese", "asparagus"]
          },
          fajita_frittata: {
            price_in_cents: 500,
            ingredients: ["eggs", "green peppers", "red peppers", "yellow peppers", "onions", "cheese"]
          }
        },
        lunch: {
          veggie_surprise_bag: {
            price_in_cents: 925,
            ingredients: ["tomato", "onion", "squash", "other stuff"]
          },
          corn_on_the_cob: {
            price_in_cents: 229,
            ingredients: ["corn"]
          }
        }
      }
    },
    "Eric's Emo Eats" => {
      hours: 4,
      meals: {
        breakfast: {
          sad_cereal: {
            price_in_cents: 277,
            ingredients: ["cereal", "milk"]
          },
          apathetic_eggs: {
            price_in_cents: 320,
            ingredients: ["eggs"]
          }
        },
        lunch: {
          mopey_falafels: {
            price_in_cents: 625,
            ingredients: ["pita", "falafel", "tahini"]
          },
          tearful_tacos: {
            price_in_cents: 719,
            ingredients: ["beef", "taco shells", "cheese", ]
          }
        }
      }
    }
  }
end
