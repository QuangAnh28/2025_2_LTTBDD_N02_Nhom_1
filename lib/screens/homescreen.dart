import 'package:flutter/material.dart';
import '../main.dart';
import '../data/books.dart';
import '../models/book.dart';
import 'bookdetailscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchCtrl = TextEditingController();

  final PageController _featuredCtrl = PageController();
  int _featuredIndex = 0;

  @override
  void dispose() {
    _searchCtrl.dispose();
    _featuredCtrl.dispose();
    super.dispose();
  }

  void _openDetail(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookDetailScreen(book: book),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vi = MyApp.of(context).isVietnamese;

    final featuredBooks = fakeBooks.take(3).toList();

    final query = _searchCtrl.text.trim().toLowerCase();
    final filtered = fakeBooks.where((b) {
      if (query.isEmpty) return true;
      return b.title.toLowerCase().contains(query) ||
          b.author.toLowerCase().contains(query);
    }).toList();

    final recommended = filtered.toList();
    final popularBooks = filtered.toList();

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(vi),
                    const SizedBox(height: 12),
                    _searchBox(vi),
                    const SizedBox(height: 12),
                    _featuredSlider(featuredBooks, vi),
                    const SizedBox(height: 14),
                    _sectionTitle(
                      title: vi ? 'Sách Đề Xuất' : 'Recommended',
                      trailing: GestureDetector(
                        onTap: () {},
                        child: Text(
                          vi ? 'Xem tất cả ›' : 'See all ›',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _bookRow(recommended),
                    const SizedBox(height: 14),
                    _sectionTitle(
                      title: vi ? 'Sách Phổ Biến' : 'Popular',
                      trailing: GestureDetector(
                        onTap: () {},
                        child: Text(
                          vi ? 'Xem tất cả ›' : 'See all ›',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _bookRow(popularBooks),
                    const SizedBox(height: 14),
                    _sectionTitle(
                      title: vi ? 'Thể Loại Phổ Biến' : 'Popular Categories',
                      trailing: GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.double_arrow_rounded,
                          color: Color(0xFF1E88E5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _popularCategories(vi),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _header(bool vi) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage('assets/images/logobookify.png'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            vi ? 'Xin chào!' : 'Hello!',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none),
        ),
      ],
    );
  }

  Widget _searchBox(bool vi) {
    return TextField(
      controller: _searchCtrl,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        hintText: vi ? 'Tìm kiếm sách...' : 'Search books...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: const Color(0xFFF3F4F6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _featuredSlider(List<Book> books, bool vi) {
    return Column(
      children: [
        SizedBox(
          height: 175,
          child: PageView.builder(
            controller: _featuredCtrl,
            itemCount: books.length,
            onPageChanged: (i) => setState(() => _featuredIndex = i),
            itemBuilder: (context, i) => _featuredCard(books[i], vi),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              List.generate(books.length, (i) => _dot(i == _featuredIndex)),
        ),
      ],
    );
  }

  Widget _featuredCard(Book book, bool vi) {
    return GestureDetector(
      onTap: () => _openDetail(book),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          image: DecorationImage(
            image: AssetImage(book.coverUrl),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.black.withOpacity(0.65),
                        Colors.black.withOpacity(0.08),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      book.author,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Text(
                      vi
                          ? 'Đọc tới Chương ${book.currentPage}'
                          : 'Continue at Chapter ${book.currentPage}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: book.progress,
                              minHeight: 7,
                              backgroundColor: Colors.white24,
                              valueColor: const AlwaysStoppedAnimation(
                                Color(0xFFFFA64D),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () => _openDetail(book),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFA64D),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              vi ? 'Tiếp tục' : 'Continue',
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
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

  Widget _dot(bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: active ? 16 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: active ? Colors.black87 : Colors.black26,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }

  Widget _sectionTitle({required String title, required Widget trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),
        trailing,
      ],
    );
  }

  Widget _bookRow(List<Book> books) {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(right: 8),
        itemCount: books.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          final b = books[i];
          return GestureDetector(
            onTap: () => _openDetail(b),
            child: Container(
              width: 98,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Image.asset(b.coverUrl, fit: BoxFit.cover),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _popularCategories(bool vi) {
    final items = vi
        ? const [
            _CatItem(
                'Tiểu\nThuyết', Icons.menu_book_rounded, Color(0xFFFFE6D5)),
            _CatItem('Khoa Học', Icons.science_rounded, Color(0xFFE6EDFF)),
            _CatItem('Kinh Dị', Icons.visibility_rounded, Color(0xFFE7F7FF)),
            _CatItem('Phiêu\nLưu', Icons.explore_rounded, Color(0xFFF1E7FF)),
          ]
        : const [
            _CatItem('Novel', Icons.menu_book_rounded, Color(0xFFFFE6D5)),
            _CatItem('Science', Icons.science_rounded, Color(0xFFE6EDFF)),
            _CatItem('Horror', Icons.visibility_rounded, Color(0xFFE7F7FF)),
            _CatItem('Adventure', Icons.explore_rounded, Color(0xFFF1E7FF)),
          ];

    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) => _categoryTile(items[i]),
      ),
    );
  }

  Widget _categoryTile(_CatItem item) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 118,
        height: 92,
        decoration: BoxDecoration(
          color: item.bg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, size: 30, color: Colors.black87),
            const SizedBox(height: 8),
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}

class _CatItem {
  final String title;
  final IconData icon;
  final Color bg;
  const _CatItem(this.title, this.icon, this.bg);
}
