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

  static const Color bgColor = Color(0xFFF6EEE8);
  static const Color primaryBrown = Color(0xFF9C6B4F);
  static const Color darkBrown = Color(0xFF5E4032);
  static const Color softBrown = Color(0xFFD8C2B3);
  static const Color cardColor = Color(0xFFFFFAF6);
  static const Color borderColor = Color(0xFFE8D9CF);
  static const Color textSoft = Color(0xFF8A6F60);
  static const Color chipBg = Color(0xFFF1E4DB);

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

    return Container(
      color: bgColor,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _header(vi),
                      const SizedBox(height: 14),
                      _searchBox(vi),
                      const SizedBox(height: 16),
                      _featuredSlider(featuredBooks, vi),
                      const SizedBox(height: 18),
                      _sectionTitle(
                        title: vi ? 'Sách đề xuất' : 'Recommended',
                        trailing: GestureDetector(
                          onTap: () {},
                          child: Text(
                            vi ? 'Xem tất cả' : 'See all',
                            style: const TextStyle(
                              color: textSoft,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _bookRow(recommended),
                      const SizedBox(height: 18),
                      _sectionTitle(
                        title: vi ? 'Sách phổ biến' : 'Popular',
                        trailing: GestureDetector(
                          onTap: () {},
                          child: Text(
                            vi ? 'Xem tất cả' : 'See all',
                            style: const TextStyle(
                              color: textSoft,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _bookRow(popularBooks),
                      const SizedBox(height: 18),
                      _sectionTitle(
                        title: vi ? 'Thể loại phổ biến' : 'Popular Categories',
                        trailing: GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.double_arrow_rounded,
                            color: primaryBrown,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _popularCategories(vi),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _header(bool vi) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: const Image(
              image: AssetImage('assets/images/logobookify.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            vi ? 'Xin chào!' : 'Hello!',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: darkBrown,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: borderColor),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: primaryBrown,
            ),
          ),
        ),
      ],
    );
  }

  Widget _searchBox(bool vi) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: _searchCtrl,
        onChanged: (_) => setState(() {}),
        style: const TextStyle(
          color: darkBrown,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: vi ? 'Tìm kiếm sách...' : 'Search books...',
          hintStyle: const TextStyle(
            color: textSoft,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: const Icon(Icons.search, color: primaryBrown),
          filled: true,
          fillColor: cardColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: softBrown, width: 1.2),
          ),
        ),
      ),
    );
  }

  Widget _featuredSlider(List<Book> books, bool vi) {
    return Column(
      children: [
        SizedBox(
          height: 185,
          child: PageView.builder(
            controller: _featuredCtrl,
            itemCount: books.length,
            onPageChanged: (i) => setState(() => _featuredIndex = i),
            itemBuilder: (context, i) => _featuredCard(books[i], vi),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(books.length, (i) => _dot(i == _featuredIndex)),
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
          borderRadius: BorderRadius.circular(22),
          image: DecorationImage(
            image: AssetImage(book.coverUrl),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 16,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.black.withOpacity(0.62),
                        Colors.black.withOpacity(0.12),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
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
                          ? 'Đọc tới trang ${book.currentPage}'
                          : 'Continue at page ${book.currentPage}',
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
                            borderRadius: BorderRadius.circular(999),
                            child: LinearProgressIndicator(
                              value: book.progress,
                              minHeight: 7,
                              backgroundColor: Colors.white24,
                              valueColor: const AlwaysStoppedAnimation(
                                Color(0xFFE0A85A),
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
                              color: const Color(0xFFE0A85A),
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
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 18 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: active ? primaryBrown : softBrown,
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
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: darkBrown,
          ),
        ),
        trailing,
      ],
    );
  }

  Widget _bookRow(List<Book> books) {
    return SizedBox(
      height: 152,
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
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Image.asset(
                    b.coverUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: chipBg,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.image_not_supported_outlined,
                          color: primaryBrown,
                        ),
                      );
                    },
                  ),
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
            _CatItem('Tiểu\nthuyết', Icons.menu_book_rounded, Color(0xFFF2E1D6)),
            _CatItem('Khoa học', Icons.science_rounded, Color(0xFFEADFD7)),
            _CatItem('Kinh dị', Icons.visibility_rounded, Color(0xFFF4E8DE)),
            _CatItem('Phiêu\nlưu', Icons.explore_rounded, Color(0xFFEFE3D8)),
          ]
        : const [
            _CatItem('Novel', Icons.menu_book_rounded, Color(0xFFF2E1D6)),
            _CatItem('Science', Icons.science_rounded, Color(0xFFEADFD7)),
            _CatItem('Horror', Icons.visibility_rounded, Color(0xFFF4E8DE)),
            _CatItem('Adventure', Icons.explore_rounded, Color(0xFFEFE3D8)),
          ];

    return SizedBox(
      height: 100,
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
        width: 120,
        height: 96,
        decoration: BoxDecoration(
          color: item.bg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, size: 30, color: primaryBrown),
            const SizedBox(height: 8),
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                color: darkBrown,
              ),
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