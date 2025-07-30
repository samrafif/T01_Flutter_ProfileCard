import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    final List<Map<String, dynamic>> products = const [
    {
      'name': 'Wireless Headphones',
      'price': '\$99.99',
      'imageUrl': 'https://placehold.co/150x150/E0E0E0/333333/png?text=Headphones',
    },
    {
      'name': 'Smartwatch',
      'price': '\$199.99',
      'imageUrl': 'https://placehold.co/150x150/E0E0E0/333333/png?text=Smartwatch',
    },
    {
      'name': 'Portable Speaker',
      'price': '\$49.99',
      'imageUrl': 'https://placehold.co/150x150/E0E0E0/333333/png?text=Speaker',
    },
    {
      'name': 'Gaming Mouse',
      'price': '\$35.00',
      'imageUrl': 'https://placehold.co/150x150/E0E0E0/333333/png?text=Mouse',
    },
    {
      'name': 'Mechanical Keyboard',
      'price': '\$120.00',
      'imageUrl': 'https://placehold.co/150x150/E0E0E0/333333/png?text=Keyboard',
    },
    {
      'name': 'USB-C Hub',
      'price': '\$25.00',
      'imageUrl': 'https://placehold.co/150x150/E0E0E0/333333/png?text=USB+Hub',
    },
    {
      'name': 'External SSD',
      'price': '\$80.00',
      'imageUrl': 'https://placehold.co/150x150/E0E0E0/333333/png?text=SSD',
    },
    {
      'name': 'Webcam Full HD',
      'price': '\$60.00',
      'imageUrl': 'https://placehold.co/150x150/E0E0E0/333333/png?text=Webcam',
    },
    {
      'name': 'Monitor Stand',
      'price': '\$40.00',
      'imageUrl': 'https://placehold.co/150x150/E0E0E0/333333/png?text=Stand',
    },
    {
      'name': 'Ergonomic Chair',
      'price': '\$350.00',
      'imageUrl': 'https://placehold.co/150x150/E0E0E0/333333/png?text=Chair',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-commerce Demo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Grid View for Featured Products
              const Text(
                'Featured Products',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true, // Important to make GridView work inside SingleChildScrollView
                physics: const NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.75, // Adjust as needed
                ),
                itemCount: products.length > 6 ? 6 : products.length, // Show up to 6 featured products
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductGridItem(product: product);
                },
              ),
              const SizedBox(height: 32),

              // Section 2: Horizontal Scroll View for Categories/Banners
              const Text(
                'Popular Categories',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 150, // Fixed height for horizontal list
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length, // Using products for demo, could be separate categories
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return CategoryCard(product: product);
                  },
                ),
              ),
              const SizedBox(height: 32),

              // Section 3: List View for All Products
              const Text(
                'All Products',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true, // Important to make ListView work inside SingleChildScrollView
                physics: const NeverScrollableScrollPhysics(), // Disable ListView's own scrolling
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductListItem(product: product);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget for a single product item in the Grid View
class ProductGridItem extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductGridItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product['imageUrl'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 50), // Fallback icon
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              product['price'],
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  // Handle add to cart or view details
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Added ${product['name']} to cart!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for a single category card in the Horizontal Scroll View
class CategoryCard extends StatelessWidget {
  final Map<String, dynamic> product; // Reusing product data for simplicity

  const CategoryCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product['imageUrl'],
                height: 80,
                width: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.category, size: 50), // Fallback icon
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product['name'], // Using product name as category name
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for a single product item in the List View
class ProductListItem extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductListItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product['imageUrl'],
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image, size: 80), // Fallback icon
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product['price'],
                    style: TextStyle(
                      color: Colors.green[700],
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: OutlinedButton(
                      onPressed: () {
                        // Handle view details
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Viewing details for ${product['name']}')),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('View Details'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
