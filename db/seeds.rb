# db/seeds.rb

# Clear existing data
puts "Clearing existing data..."
ProductCategory.destroy_all
CartItem.destroy_all
OrderItem.destroy_all
Order.destroy_all
Product.destroy_all
Category.destroy_all
User.destroy_all

# Create admin user
puts "Creating admin user..."
unless AdminUser.find_by(email: 'admin@example.com')
  AdminUser.create!(
    email: 'admin@example.com', 
    password: 'password', 
    password_confirmation: 'password'
  )
end

# Create sample regular user
puts "Creating sample user..."
User.create!(
  email: 'customer@example.com',
  password: 'password',
  password_confirmation: 'password',
  first_name: 'John',
  last_name: 'Doe',
  address: '123 Main Street',
  city: 'Toronto',
  province: 'ON',
  postal_code: 'M5V 3A8'
) if Rails.env.development?

# Create categories
puts "Creating categories..."
categories = [
  {
    name: "Electronics",
    description: "Latest gadgets and electronic devices"
  },
  {
    name: "Books",
    description: "Fiction, non-fiction, and educational books"
  },
  {
    name: "Clothing",
    description: "Fashion and apparel for all occasions"
  },
  {
    name: "Home & Garden",
    description: "Everything for your home and garden"
  },
  {
    name: "Sports & Outdoors",
    description: "Sports equipment and outdoor gear"
  },
  {
    name: "Health & Beauty",
    description: "Personal care and beauty products"
  }
]

created_categories = categories.map do |cat_data|
  Category.create!(cat_data)
end



# Create products
puts "Creating products..."
products_data = [
  # Electronics
  {
    name: "Wireless Bluetooth Headphones",
    description: "High-quality wireless headphones with noise cancellation and 30-hour battery life. Perfect for music lovers and professionals who need clear audio for calls.",
    price: 149.99,
    stock_quantity: 25,
    categories: ["Electronics"]
  },
  {
    name: "Smartphone 128GB",
    description: "Latest smartphone with advanced camera system, fast processor, and all-day battery life. Features include facial recognition and wireless charging.",
    price: 699.99,
    stock_quantity: 15,
    categories: ["Electronics"]
  },
  {
    name: "4K Smart TV 55-inch",
    description: "Ultra HD smart TV with streaming apps built-in. HDR support and voice control make this the perfect centerpiece for your living room.",
    price: 599.99,
    stock_quantity: 8,
    categories: ["Electronics"]
  },
  
  # Books
  {
    name: "The Art of Programming",
    description: "Comprehensive guide to software development best practices. Covers design patterns, algorithms, and modern development methodologies.",
    price: 45.99,
    stock_quantity: 50,
    categories: ["Books"]
  },
  {
    name: "Mystery Novel: The Hidden Truth",
    description: "A gripping mystery novel that will keep you on the edge of your seat. Follow detective Sarah Chen as she unravels a complex conspiracy.",
    price: 12.99,
    stock_quantity: 75,
    categories: ["Books"]
  },
  {
    name: "Cookbook: Healthy Living",
    description: "150 nutritious and delicious recipes for a healthier lifestyle. Includes meal planning tips and nutritional information for each recipe.",
    price: 29.99,
    stock_quantity: 40,
    categories: ["Books"]
  },
  
  # Clothing
  {
    name: "Premium Cotton T-Shirt",
    description: "Soft, comfortable 100% cotton t-shirt available in multiple colors. Pre-shrunk and machine washable for easy care.",
    price: 24.99,
    stock_quantity: 100,
    categories: ["Clothing"]
  },
  {
    name: "Denim Jeans - Classic Fit",
    description: "Timeless denim jeans with a comfortable classic fit. Made from high-quality denim that gets better with age.",
    price: 79.99,
    stock_quantity: 60,
    categories: ["Clothing"]
  },
  {
    name: "Winter Jacket - Waterproof",
    description: "Warm and waterproof winter jacket perfect for harsh weather conditions. Features multiple pockets and adjustable hood.",
    price: 199.99,
    stock_quantity: 20,
    categories: ["Clothing"]
  },
  
  # Home & Garden
  {
    name: "Coffee Maker - Programmable",
    description: "12-cup programmable coffee maker with auto-shutoff and brew strength control. Wake up to fresh coffee every morning.",
    price: 89.99,
    stock_quantity: 30,
    categories: ["Home & Garden"]
  },
  {
    name: "Garden Tool Set",
    description: "Complete 10-piece garden tool set with ergonomic handles. Includes shovel, rake, pruning shears, and storage bag.",
    price: 119.99,
    stock_quantity: 25,
    categories: ["Home & Garden"]
  },
  {
    name: "LED Desk Lamp",
    description: "Adjustable LED desk lamp with multiple brightness levels and color temperatures. USB charging port included.",
    price: 49.99,
    stock_quantity: 45,
    categories: ["Home & Garden"]
  },
  
  # Sports & Outdoors
  {
    name: "Yoga Mat - Extra Thick",
    description: "Premium 8mm thick yoga mat with excellent grip and cushioning. Includes carrying strap and alignment guides.",
    price: 39.99,
    stock_quantity: 35,
    categories: ["Sports & Outdoors"]
  },
  {
    name: "Camping Tent - 4 Person",
    description: "Spacious 4-person camping tent with easy setup and weather-resistant materials. Perfect for family camping trips.",
    price: 299.99,
    stock_quantity: 12,
    categories: ["Sports & Outdoors"]
  },
  {
    name: "Mountain Bike Helmet",
    description: "Lightweight and ventilated mountain bike helmet with adjustable fit system. CPSC and CE certified for safety.",
    price: 69.99,
    stock_quantity: 28,
    categories: ["Sports & Outdoors"]
  },
  
  # Health & Beauty
  {
    name: "Organic Face Moisturizer",
    description: "Nourishing organic face moisturizer with natural ingredients. Suitable for all skin types and cruelty-free.",
    price: 34.99,
    stock_quantity: 55,
    categories: ["Health & Beauty"]
  },
  {
    name: "Essential Oils Set",
    description: "Set of 6 therapeutic grade essential oils including lavender, eucalyptus, and peppermint. Perfect for aromatherapy.",
    price: 59.99,
    stock_quantity: 42,
    categories: ["Health & Beauty"]
  }
]

products_data.each do |product_data|
  category_names = product_data.delete(:categories)
  product = Product.create!(product_data)
  
  # Assign categories
  category_names.each do |cat_name|
    category = created_categories.find { |c| c.name == cat_name }
    product.categories << category if category
  end
end

# Add products to reach 100 total (we have 17, need 83 more)
puts "Creating additional products to reach 100..."

additional_products = [
  # Electronics (25 more)
  { name: "Gaming Laptop 16GB RAM", description: "High-performance gaming laptop with dedicated graphics card, 16GB RAM, and 1TB SSD storage for serious gamers.", price: 1299.99, stock_quantity: 5, categories: ["Electronics"] },
  { name: "Wireless Gaming Mouse", description: "Precision wireless gaming mouse with customizable RGB lighting and 16,000 DPI sensor for competitive gaming.", price: 79.99, stock_quantity: 30, categories: ["Electronics"] },
  { name: "Mechanical Keyboard RGB", description: "Professional mechanical keyboard with RGB backlighting and tactile switches for gaming and productivity.", price: 129.99, stock_quantity: 22, categories: ["Electronics"] },
  { name: "USB-C Hub 7-in-1", description: "Versatile USB-C hub with HDMI, USB 3.0, SD card reader, and power delivery for modern laptops.", price: 49.99, stock_quantity: 40, categories: ["Electronics"] },
  { name: "Wireless Earbuds Pro", description: "Premium wireless earbuds with active noise cancellation and 8-hour battery life for audiophiles.", price: 199.99, stock_quantity: 18, categories: ["Electronics"] },
  { name: "Tablet 10-inch Android", description: "High-resolution 10-inch Android tablet with fast processor and all-day battery life.", price: 299.99, stock_quantity: 15, categories: ["Electronics"] },
  { name: "Smart Watch Fitness", description: "Advanced fitness smartwatch with heart rate monitoring, GPS, and 7-day battery life.", price: 249.99, stock_quantity: 20, categories: ["Electronics"] },
  { name: "Webcam 4K Ultra HD", description: "Professional 4K webcam with auto-focus and noise-canceling microphone for streaming.", price: 159.99, stock_quantity: 12, categories: ["Electronics"] },
  { name: "Portable SSD 1TB", description: "Ultra-fast portable SSD with USB-C connectivity and military-grade durability.", price: 129.99, stock_quantity: 25, categories: ["Electronics"] },
  { name: "Gaming Headset 7.1", description: "Surround sound gaming headset with crystal-clear microphone and comfortable design.", price: 89.99, stock_quantity: 28, categories: ["Electronics"] },
  { name: "Smartphone Wireless Charger", description: "Fast wireless charging pad compatible with all Qi-enabled devices and safety features.", price: 34.99, stock_quantity: 45, categories: ["Electronics"] },
  { name: "Bluetooth Speaker Waterproof", description: "Portable waterproof Bluetooth speaker with 360-degree sound and 12-hour battery.", price: 79.99, stock_quantity: 35, categories: ["Electronics"] },
  { name: "Desktop Monitor 27-inch", description: "4K UHD 27-inch monitor with HDR support and multiple connectivity options.", price: 399.99, stock_quantity: 8, categories: ["Electronics"] },
  { name: "Router WiFi 6 Gigabit", description: "Next-generation WiFi 6 router with gigabit speeds and advanced security features.", price: 199.99, stock_quantity: 15, categories: ["Electronics"] },
  { name: "Action Camera 4K", description: "Compact 4K action camera with image stabilization and waterproof housing.", price: 179.99, stock_quantity: 20, categories: ["Electronics"] },
  { name: "Power Bank 20000mAh", description: "High-capacity power bank with fast charging and multiple USB ports for devices.", price: 39.99, stock_quantity: 50, categories: ["Electronics"] },
  { name: "Smart Home Hub", description: "Central smart home hub compatible with Alexa, Google Assistant, and hundreds of devices.", price: 89.99, stock_quantity: 18, categories: ["Electronics"] },
  { name: "Dash Cam Front Rear", description: "Dual camera dash cam system with night vision and automatic emergency recording.", price: 129.99, stock_quantity: 22, categories: ["Electronics"] },
  { name: "VR Headset Standalone", description: "All-in-one VR headset with wireless freedom and extensive game library.", price: 299.99, stock_quantity: 10, categories: ["Electronics"] },
  { name: "Drone with 4K Camera", description: "Professional drone with 4K camera, GPS positioning, and intelligent flight modes.", price: 599.99, stock_quantity: 6, categories: ["Electronics"] },
  { name: "Smart Doorbell Camera", description: "WiFi-enabled doorbell camera with two-way audio and motion detection alerts.", price: 149.99, stock_quantity: 16, categories: ["Electronics"] },
  { name: "Fitness Tracker Band", description: "Affordable fitness tracker with heart rate monitoring and smartphone notifications.", price: 59.99, stock_quantity: 40, categories: ["Electronics"] },
  { name: "Electric Toothbrush Smart", description: "Smart electric toothbrush with app connectivity and pressure sensor technology.", price: 99.99, stock_quantity: 25, categories: ["Electronics"] },
  { name: "Car Phone Mount Magnetic", description: "Strong magnetic car phone mount with 360-degree rotation and one-hand operation.", price: 24.99, stock_quantity: 60, categories: ["Electronics"] },
  { name: "Security Camera Indoor", description: "Indoor security camera with 1080p video, night vision, and cloud storage.", price: 79.99, stock_quantity: 30, categories: ["Electronics"] },

  # Books (20 more)
  { name: "Learn JavaScript Today", description: "Complete beginner's guide to JavaScript programming with practical examples and hands-on projects.", price: 34.99, stock_quantity: 45, categories: ["Books"] },
  { name: "Digital Photography Guide", description: "Master digital photography techniques with this comprehensive guide for beginners and professionals.", price: 42.99, stock_quantity: 35, categories: ["Books"] },
  { name: "Business Strategy 101", description: "Essential business strategy concepts and frameworks for entrepreneurs and business managers.", price: 39.99, stock_quantity: 28, categories: ["Books"] },
  { name: "Healthy Meal Prep", description: "Weekly meal preparation recipes and tips for busy professionals and health-conscious families.", price: 24.99, stock_quantity: 50, categories: ["Books"] },
  { name: "Travel Photography", description: "Capture stunning travel photos with professional techniques and location scouting tips.", price: 29.99, stock_quantity: 32, categories: ["Books"] },
  { name: "Python Programming Bible", description: "Comprehensive Python programming guide from basics to advanced topics with real-world examples.", price: 49.99, stock_quantity: 38, categories: ["Books"] },
  { name: "Mindfulness Meditation", description: "Practical guide to mindfulness and meditation techniques for stress reduction and mental clarity.", price: 19.99, stock_quantity: 55, categories: ["Books"] },
  { name: "Financial Freedom Blueprint", description: "Step-by-step guide to achieving financial independence through smart investing and budgeting.", price: 32.99, stock_quantity: 40, categories: ["Books"] },
  { name: "Home Organization Hacks", description: "Creative solutions and systems for organizing every room in your home efficiently.", price: 22.99, stock_quantity: 45, categories: ["Books"] },
  { name: "Leadership Excellence", description: "Transform your leadership skills with proven strategies from successful business leaders.", price: 36.99, stock_quantity: 30, categories: ["Books"] },
  { name: "Yoga for Beginners", description: "Complete yoga guide with step-by-step poses, breathing techniques, and meditation practices.", price: 25.99, stock_quantity: 42, categories: ["Books"] },
  { name: "Weight Loss Revolution", description: "Science-based approach to sustainable weight loss with meal plans and exercise routines.", price: 28.99, stock_quantity: 38, categories: ["Books"] },
  { name: "Graphic Design Fundamentals", description: "Learn the principles of graphic design with practical exercises and professional tips.", price: 44.99, stock_quantity: 25, categories: ["Books"] },
  { name: "Cryptocurrency Investing", description: "Navigate the world of cryptocurrency investing with expert strategies and risk management.", price: 33.99, stock_quantity: 35, categories: ["Books"] },
  { name: "Public Speaking Mastery", description: "Overcome fear and deliver powerful presentations with confidence-building techniques.", price: 26.99, stock_quantity: 40, categories: ["Books"] },
  { name: "Garden Design Ideas", description: "Create beautiful outdoor spaces with landscape design principles and plant selection guides.", price: 31.99, stock_quantity: 30, categories: ["Books"] },
  { name: "Data Science Handbook", description: "Comprehensive guide to data science with Python, machine learning, and statistical analysis.", price: 52.99, stock_quantity: 20, categories: ["Books"] },
  { name: "Creative Writing Workshop", description: "Develop your creative writing skills with exercises, prompts, and publishing guidance.", price: 23.99, stock_quantity: 48, categories: ["Books"] },
  { name: "Time Management Secrets", description: "Proven strategies for managing time effectively and increasing productivity in work and life.", price: 21.99, stock_quantity: 50, categories: ["Books"] },
  { name: "Marketing Psychology", description: "Understand consumer behavior and apply psychological principles to marketing campaigns.", price: 37.99, stock_quantity: 32, categories: ["Books"] },

  # Clothing (20 more)
  { name: "Casual Button-Down Shirt", description: "Versatile cotton button-down shirt perfect for casual or business-casual occasions in multiple colors.", price: 49.99, stock_quantity: 60, categories: ["Clothing"] },
  { name: "Athletic Performance Shorts", description: "Moisture-wicking athletic shorts with built-in compression liner for running and training.", price: 34.99, stock_quantity: 45, categories: ["Clothing"] },
  { name: "Knit Sweater Pullover", description: "Soft knit pullover sweater available in multiple colors, perfect for layering in cool weather.", price: 64.99, stock_quantity: 38, categories: ["Clothing"] },
  { name: "Designer Sunglasses", description: "Stylish polarized sunglasses with UV protection and durable frame construction.", price: 89.99, stock_quantity: 25, categories: ["Clothing"] },
  { name: "Leather Belt Classic", description: "Genuine leather belt with brushed metal buckle, available in brown and black colors.", price: 39.99, stock_quantity: 50, categories: ["Clothing"] },
  { name: "Running Shoes Professional", description: "High-performance running shoes with advanced cushioning and breathable mesh construction.", price: 129.99, stock_quantity: 35, categories: ["Clothing"] },
  { name: "Dress Pants Slim Fit", description: "Professional slim-fit dress pants in wrinkle-resistant fabric for business wear.", price: 79.99, stock_quantity: 40, categories: ["Clothing"] },
  { name: "Polo Shirt Cotton", description: "Classic cotton polo shirt with moisture-wicking properties and comfortable fit.", price: 42.99, stock_quantity: 55, categories: ["Clothing"] },
  { name: "Hoodie Zip-Up Fleece", description: "Comfortable zip-up fleece hoodie with kangaroo pocket and adjustable drawstring hood.", price: 54.99, stock_quantity: 48, categories: ["Clothing"] },
  { name: "Dress Shirt Formal", description: "Crisp formal dress shirt with French cuffs and classic collar for business occasions.", price: 69.99, stock_quantity: 30, categories: ["Clothing"] },
  { name: "Yoga Pants High-Waist", description: "High-waisted yoga pants with four-way stretch fabric and side pockets for phones.", price: 44.99, stock_quantity: 50, categories: ["Clothing"] },
  { name: "Baseball Cap Adjustable", description: "Classic baseball cap with adjustable strap and embroidered logo in various colors.", price: 24.99, stock_quantity: 70, categories: ["Clothing"] },
  { name: "Cardigan Wool Blend", description: "Elegant wool blend cardigan with button closure and ribbed cuffs for professional wear.", price: 74.99, stock_quantity: 32, categories: ["Clothing"] },
  { name: "Swimwear Bikini Set", description: "Stylish two-piece bikini set with removable padding and adjustable straps.", price: 39.99, stock_quantity: 42, categories: ["Clothing"] },
  { name: "Scarf Silk Luxury", description: "Premium silk scarf with elegant patterns and soft texture for sophisticated styling.", price: 59.99, stock_quantity: 28, categories: ["Clothing"] },
  { name: "Gloves Winter Touchscreen", description: "Warm winter gloves with touchscreen-compatible fingertips and thermal lining.", price: 29.99, stock_quantity: 45, categories: ["Clothing"] },
  { name: "Socks Athletic Performance", description: "Moisture-wicking athletic socks with cushioned sole and arch support for sports.", price: 16.99, stock_quantity: 80, categories: ["Clothing"] },
  { name: "Tie Silk Professional", description: "Professional silk tie with classic patterns for business and formal occasions.", price: 34.99, stock_quantity: 40, categories: ["Clothing"] },
  { name: "Underwear Cotton Boxers", description: "Comfortable cotton boxer shorts with breathable fabric and flexible waistband.", price: 19.99, stock_quantity: 65, categories: ["Clothing"] },
  { name: "Watch Sports Digital", description: "Durable sports watch with digital display, stopwatch, and water resistance.", price: 49.99, stock_quantity: 35, categories: ["Clothing"] },

  # Home & Garden (18 more)
  { name: "Air Purifier HEPA Filter", description: "Advanced air purifier with HEPA filter removes 99.97% of allergens and pollutants from indoor air.", price: 199.99, stock_quantity: 15, categories: ["Home & Garden"] },
  { name: "Robot Vacuum Cleaner", description: "Smart robot vacuum with mapping technology and smartphone app control for automated cleaning.", price: 299.99, stock_quantity: 12, categories: ["Home & Garden"] },
  { name: "Essential Oil Diffuser", description: "Ultrasonic essential oil diffuser with LED lighting and timer settings for aromatherapy.", price: 39.99, stock_quantity: 40, categories: ["Home & Garden"] },
  { name: "Memory Foam Mattress Topper", description: "Luxury memory foam mattress topper provides extra comfort and pressure point relief.", price: 149.99, stock_quantity: 20, categories: ["Home & Garden"] },
  { name: "Kitchen Knife Set Professional", description: "Professional kitchen knife set with high-carbon steel blades and ergonomic handles.", price: 89.99, stock_quantity: 25, categories: ["Home & Garden"] },
  { name: "Throw Pillows Decorative", description: "Set of decorative throw pillows with removable covers in contemporary patterns.", price: 34.99, stock_quantity: 50, categories: ["Home & Garden"] },
  { name: "Plant Pot Set Ceramic", description: "Set of ceramic plant pots with drainage holes and matching saucers for indoor plants.", price: 29.99, stock_quantity: 45, categories: ["Home & Garden"] },
  { name: "Shower Curtain Waterproof", description: "Elegant waterproof shower curtain with reinforced grommets and fade-resistant fabric.", price: 24.99, stock_quantity: 35, categories: ["Home & Garden"] },
  { name: "Candle Set Scented Soy", description: "Set of natural soy candles with relaxing scents and 40-hour burn time each.", price: 44.99, stock_quantity: 30, categories: ["Home & Garden"] },
  { name: "Cutting Board Bamboo Large", description: "Eco-friendly bamboo cutting board with juice groove and non-slip feet.", price: 32.99, stock_quantity: 40, categories: ["Home & Garden"] },
  { name: "Storage Baskets Woven", description: "Set of decorative woven storage baskets perfect for organizing closets and shelves.", price: 39.99, stock_quantity: 35, categories: ["Home & Garden"] },
  { name: "Blanket Throw Fleece", description: "Ultra-soft fleece throw blanket perfect for couch snuggling and bedroom decor.", price: 27.99, stock_quantity: 55, categories: ["Home & Garden"] },
  { name: "Wall Art Canvas Print", description: "Modern canvas wall art print with contemporary design and ready-to-hang hardware.", price: 49.99, stock_quantity: 25, categories: ["Home & Garden"] },
  { name: "Desk Organizer Bamboo", description: "Multi-compartment bamboo desk organizer keeps office supplies neat and accessible.", price: 26.99, stock_quantity: 42, categories: ["Home & Garden"] },
  { name: "Doormat Coir Natural", description: "Natural coir doormat with decorative design and excellent dirt-trapping properties.", price: 19.99, stock_quantity: 50, categories: ["Home & Garden"] },
  { name: "Mirror Bathroom Round", description: "Stylish round bathroom mirror with beveled edge and easy-mount hardware.", price: 64.99, stock_quantity: 18, categories: ["Home & Garden"] },
  { name: "Spice Rack Rotating", description: "Space-saving rotating spice rack holds 20 spice jars with clear labeling system.", price: 34.99, stock_quantity: 30, categories: ["Home & Garden"] },
  { name: "Nightlight Motion Sensor", description: "LED motion sensor nightlight with adjustable brightness and energy-efficient design.", price: 22.99, stock_quantity: 45, categories: ["Home & Garden"] }
]

additional_products.each do |product_data|
  category_names = product_data.delete(:categories)
  product = Product.create!(product_data)
  
  category_names.each do |cat_name|
    category = created_categories.find { |c| c.name == cat_name }
    product.categories << category if category
  end
end

puts "Additional products created. Total products: #{Product.count}"

puts "Created #{Category.count} categories"
puts "Created #{Product.count} products"
puts "Seed data creation completed!"

# Create some sample orders if in development
if Rails.env.development? && User.exists?
  puts "Creating sample orders..."
  
  user = User.first
  product1 = Product.first
  product2 = Product.second
  
  if user && product1 && product2
    # Create a sample order
    order = Order.create!(
      user: nil,  # Set to nil since foreign key points to admin_users
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name,
      address: user.address,
      city: user.city,
      province: user.province,
      postal_code: user.postal_code,
      status: 'delivered',
      total_amount: (product1.price * 2) + product2.price + ((product1.price * 2) + product2.price) * 0.13
    )
    
    # Create order items
    OrderItem.create!(
      order: order,
      product: product1,
      quantity: 2,
      price_at_time: product1.price
    )
    
    OrderItem.create!(
      order: order,
      product: product2,
      quantity: 1,
      price_at_time: product2.price
    )
    
    puts "Created sample order with #{order.order_items.count} items"
  else
    puts "Skipping sample order creation - missing user or products"
  end
end

# Create pages
puts "Creating pages..."
unless Page.find_by(slug: 'about')
  Page.create!(
    title: "About Us",
    slug: "about",
    content: "Welcome to our store! We are passionate about providing high-quality products at great prices. Our team is dedicated to excellent customer service and fast shipping.\n\nOur mission is to make online shopping easy and enjoyable for everyone. We carefully curate our product selection to ensure we offer only the best items at competitive prices.\n\nThank you for choosing us for your shopping needs!"
  )
end

unless Page.find_by(slug: 'contact')
  Page.create!(
    title: "Contact Us",
    slug: "contact",
    content: "Get in touch with us!\n\nEmail: support@mystore.com\nPhone: (555) 123-4567\nAddress: 123 Main Street, Toronto, ON M5V 3A8\n\nBusiness Hours:\nMonday - Friday: 9AM - 6PM\nSaturday: 10AM - 4PM\nSunday: Closed\n\nWe're here to help! Don't hesitate to reach out with any questions about our products or services."
  )
end

puts "Pages created successfully!"
