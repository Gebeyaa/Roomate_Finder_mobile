import 'package:flutter/material.dart';

class GetstartedScreen extends StatefulWidget {
  const GetstartedScreen({super.key});

  @override
  State<GetstartedScreen> createState() => _GetstartedScreenState();
}

class _GetstartedScreenState extends State<GetstartedScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Roomates',
      // 'desc':
      //     'Welcome to Arhibu, the easiest way to find and connect with compatible roommates. Start your journey to a better living experience!',
    },
    {
      'image': 'images/logo.jpg',
      'title': 'Find Your compatible Roommate',
      'desc':
          'Browse profiles, filter by preferences, and discover people who match your lifestyle and needs.',
    },
    {
      'image': 'images/arhibu.jpg',
      'title': 'Choose yours from multiple options.',
      'desc':
          'Message potential roommates securely within the app and get to know them before making a decision.',
    },
    {
      'image': 'images/arhibu.jpg',
      'title': 'Meet the user which you verfied.',
      'desc':
          'All users are verified for your safety and peace of mind. Find trustworthy roommates with confidence.',
    },
    {
      'title': 'Get Started Now!',
      'desc':
          'Sign up and join the Arhibu community to find your ideal roommate today!',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: _pages.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final page = _pages[index];
                      return Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (page['image'] != null &&
                                page['image']!.isNotEmpty)
                              Image.asset(page['image']!, height: 200),
                            if (page['image'] != null &&
                                page['image']!.isNotEmpty)
                              const SizedBox(height: 40),
                            if (page['title'] != null &&
                                page['title']!.isNotEmpty)
                              Text(
                                page['title']!,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            const SizedBox(height: 20),
                            if (page['desc'] != null &&
                                page['desc']!.isNotEmpty)
                              Text(
                                page['desc']!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 16,
                  ),
                  width: _currentPage == index ? 16 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color:
                        _currentPage == index ? Colors.blue : Colors.grey[400],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage == 0)
                    const SizedBox.shrink()
                  else ...[
                    if (_currentPage != _pages.length - 1)
                      TextButton(
                        onPressed: () {
                          _pageController.animateToPage(
                            _pages.length - 1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: const Text('Skip'),
                      ),
                    if (_currentPage == _pages.length - 1)
                      const SizedBox(width: 64),
                    ElevatedButton(
                      onPressed: () {
                        if (_currentPage == _pages.length - 1) {
                          Navigator.pushReplacementNamed(context, '/signup');
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Text(
                        _currentPage == _pages.length - 1
                            ? 'Get Started'
                            : 'Next',
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
