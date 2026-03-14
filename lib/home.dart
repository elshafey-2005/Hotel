import 'package:flutter/material.dart';

class HotelBookingScreen extends StatefulWidget {
  const HotelBookingScreen({super.key});

  @override
  State<HotelBookingScreen> createState() => _HotelBookingScreenState();
}

class _HotelBookingScreenState extends State<HotelBookingScreen> {
  bool isOffersSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black87),
        title: const Text(
          'Smart Hotel Booking',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // 1. Hotel Card Animation
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black12.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  children: [
                    Image.network(
                      'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&q=80&w=800',
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    AnimatedCrossFade(
                      firstChild: const SizedBox(width: double.infinity),
                      secondChild: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Grand Hyatt Manila',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                Row(
                                  children: List.generate(
                                      5, (index) => const Icon(Icons.star_outline, color: Colors.orangeAccent, size: 18)),
                                ),
                              ],
                            ),
                            const Text('Deluxe King Room', style: TextStyle(color: Colors.grey)),
                            const Text('Deluxe King Roome a to din I Ansor', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      crossFadeState: isOffersSelected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                      duration: const Duration(milliseconds: 500),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              height: 55,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(30)),
              child: Stack(
                children: [
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 300),
                    alignment: isOffersSelected ? Alignment.centerLeft : Alignment.centerRight,
                    child: FractionallySizedBox(
                      widthFactor: 0.5,
                      child: Container(
                        decoration: BoxDecoration(color: const Color(0xFF1D7EDC), borderRadius: BorderRadius.circular(26)),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      _buildTabButton('Offers', isOffersSelected, () => setState(() => isOffersSelected = true)),
                      _buildTabButton('Guest Reviews', !isOffersSelected, () => setState(() => isOffersSelected = false)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),


            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(animation),
                    child: child,
                  ),
                );
              },
              child: isOffersSelected ? const OffersView() : const ReviewsView(),
            ),
            const SizedBox(height: 25),

            // 4. Price Range Section
            const Text('Price Range:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: isOffersSelected ? _buildPriceBefore() : _buildPriceAfter(),
            ),
            const SizedBox(height: 30),            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D7EDC),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Book Now', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1D7EDC),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Text(text,
              style: TextStyle(color: isSelected ? Colors.white : Colors.grey, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildPriceBefore() {
    return Container(
      key: const ValueKey('before'),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: const [
          Text('\$ 1', style: TextStyle(fontSize: 16)),
          Spacer(),
          Icon(Icons.show_chart, color: Colors.blueAccent),
        ],
      ),
    );
  }

  Widget _buildPriceAfter() {
    return Column(
      key: const ValueKey('after'),
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black12),
          ),
          child: const Text('5000', style: TextStyle(fontSize: 16)),
        ),
        const SizedBox(height: 15),
        LinearProgressIndicator(
          value: 0.5,
          backgroundColor: Colors.black12,
          color: const Color(0xFF1D7EDC),
          minHeight: 6,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('\$1', style: TextStyle(color: Colors.grey, fontSize: 12)),
            Text('\$10k', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        )
      ],
    );
  }
}

class OffersView extends StatelessWidget {
  const OffersView({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1551882547-ff43c63ef53e?auto=format&fit=crop&q=80&w=800'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.7)]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text('20% off this weekend!', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            Text('Book now and save big on your stay.', style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

class ReviewsView extends StatelessWidget {
  const ReviewsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ReviewCard(name: 'John D.', comment: 'Amazing stay, highly recommend the spa!', stars: 3),
        SizedBox(height: 10),
        ReviewCard(name: 'Sarah K.', comment: 'Great service, room was very clean.', stars: 4),
      ],
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String name;
  final String comment;
  final int stars;
  const ReviewCard({super.key, required this.name, required this.comment, required this.stars});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Row(children: List.generate(5, (i) => Icon(Icons.star, size: 16, color: i < stars ? Colors.green : Colors.grey[300]))),
            ],
          ),
          const SizedBox(height: 5),
          Text(comment, style: const TextStyle(color: Colors.black54, fontSize: 13)),
        ],
      ),
    );
  }
}
