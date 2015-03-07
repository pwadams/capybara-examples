def create_user(options = {})
  User.create!({
    name: 'Test',
    email: 'test@example.com',
    password: '1234'
  }.merge(options))
end

def create_cat(options = {})
  Cat.create!({
    name: "Midnight #{random(1..999)}",
    age: '4.25',
    friendly: true
  }.merge(options))
end

def create_kitten(cat, options = {})
  Kitten.create!({
    name: "Rocky #{rand(1..999)}",
    cat_id: cat.id
  }.merge(options))
end
