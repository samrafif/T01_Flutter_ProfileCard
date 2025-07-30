import 'package:flutter/material.dart';

class EcommerceScreen extends StatelessWidget {
  // Sample product data
  final List<Product> featuredProducts = [
    Product("Wireless Headphones", "\$99.99", "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=300"),
    Product("Smart Watch", "\$249.99", "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=300"),
    Product("Laptop", "\$899.99", "https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=300"),
    Product("Phone Case", "\$19.99", "https://images.unsplash.com/photo-1601593346740-925612772716?w=300"),
  ];

  final List<Product> categoryProducts = [
    Product("Running Shoes", "\$79.99", "https://xsgames.co/randomusers/avatar.php?g=male"),
    Product("Sunglasses", "\$59.99", "https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=300"),
    Product("Backpack", "\$49.99", "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=300"),
    Product("Plant Pot", "\$24.99", "https://images.unsplash.com/photo-1485955900006-10f4d324d411?w=300"),
    Product("Desk Lamp", "\$39.99", "https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=300"),
  ];

  final List<Category> categories = [
    Category("Electronics", Icons.devices, Colors.blue),
    Category("Fashion", Icons.shopping_bag, Colors.pink),
    Category("Home", Icons.home, Colors.green),
    Category("Sports", Icons.sports_soccer, Colors.orange),
    Category("Books", Icons.book, Colors.purple),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Shop Demo', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Banner Card
            _buildHeroBanner(),
            
            SizedBox(height: 20),
            
            // Categories Row (Horizontal Scroll)
            _buildCategoriesSection(),
            
            SizedBox(height: 25),
            
            // Featured Products (Horizontal Scroll)
            _buildFeaturedSection(),
            
            SizedBox(height: 25),
            
            // Product Grid
            _buildProductGrid(),
            
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Wishlist'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [Colors.blue.shade400, Colors.blue.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -20,
                top: -20,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Summer Sale',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Up to 50% off on selected items',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue.shade600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text('Shop Now'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: Text('See All'),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Container(
                width: 100,
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        category.icon,
                        color: category.color,
                        size: 28,
                      ),
                      SizedBox(height: 8),
                      Text(
                        category.name,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Products',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: Text('View All'),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12),
            itemCount: featuredProducts.length,
            itemBuilder: (context, index) {
              final product = featuredProducts[index];
              return Container(
                width: 160,
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(product.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      product.price,
                                      style: TextStyle(
                                        color: Colors.blue.shade600,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Icon(
                                      Icons.favorite_border,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'All Products',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: categoryProducts.length,
            itemBuilder: (context, index) {
              final product = categoryProducts[index];
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(product.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: Colors.grey,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.price,
                                    style: TextStyle(
                                      color: Colors.blue.shade600,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade600,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class Product {
  final String name;
  final String price;
  final String imageUrl;

  Product(this.name, this.price, this.imageUrl);
}

class Category {
  final String name;
  final IconData icon;
  final Color color;

  Category(this.name, this.icon, this.color);
}
