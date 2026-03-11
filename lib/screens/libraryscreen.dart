import 'package:flutter/material.dart';
import '../main.dart';
import '../data/books.dart';
import '../models/book.dart';
import 'bookdetailscreen.dart';
import 'readerscreen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  static const Color bgColor = Color(0xFFF6EEE8);
  static const Color primaryBrown = Color(0xFF9C6B4F);
  static const Color darkBrown = Color(0xFF5E4032);
  static const Color softBrown = Color(0xFFD8C2B3);
  static const Color cardColor = Color(0xFFFFFAF6);
  static const Color borderColor = Color(0xFFE8D9CF);
  static const Color textSoft = Color(0xFF8A6F60);
  static const Color chipBg = Color(0xFFF1E4DB);

  void _openDetail(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => BookDetailScreen(book: book)),
    ).then((_) => setState(() {}));
  }

  void _openReader(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ReaderScreen(book: book)),
    ).then((_) => setState(() {}));
  }

  void _toggleFavorite(Book book, bool value) {
    setState(() {
      final index = fakeBooks.indexWhere((b) => b.id == book.id);
      if (index == -1) return;
      fakeBooks[index] = fakeBooks[index].copyWith(isFavorite: value);
    });
  }

  void _toggleBookmark(Book book, bool value) {
    setState(() {
      final index = fakeBooks.indexWhere((b) => b.id == book.id);
      if (index == -1) return;
      fakeBooks[index] = fakeBooks[index].copyWith(isBookmarked: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vi = MyApp.of(context).isVietnamese;

    return DefaultTabController(
      length: 2,
      child: Container(
        color: bgColor,
        child: Column(
          children: [
            Container(
              color: bgColor,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: chipBg,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.library_books_rounded,
                      size: 22,
                      color: primaryBrown,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    vi ? "Thư viện" : "Library",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: darkBrown,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor),
                ),
                child: TabBar(
                  labelColor: primaryBrown,
                  unselectedLabelColor: textSoft,
                  indicatorColor: primaryBrown,
                  dividerColor: Colors.transparent,
                  labelStyle: const TextStyle(fontWeight: FontWeight.w900),
                  tabs: [
                    Tab(text: vi ? "Yêu thích" : "Favorites"),
                    Tab(text: vi ? "Đánh dấu" : "Bookmarks"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TabBarView(
                children: [
                  _buildFavoriteBooks(vi),
                  _buildBookmarkBooks(vi),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteBooks(bool vi) {
    final favoriteBooks = fakeBooks.where((book) => book.isFavorite).toList();

    if (favoriteBooks.isEmpty) {
      return _emptyState(
        icon: Icons.favorite_border_rounded,
        message: vi ? "Chưa có sách yêu thích" : "No favorite books yet",
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      itemCount: favoriteBooks.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final book = favoriteBooks[index];

        return Material(
          color: cardColor,
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () => _openDetail(book),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
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
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      book.coverUrl,
                      width: 58,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 58,
                          height: 80,
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
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                            color: darkBrown,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          book.author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: textSoft,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: chipBg,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            book.category,
                            style: const TextStyle(
                              color: primaryBrown,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.favorite_rounded,
                      color: Color(0xFFD87C7C),
                    ),
                    onPressed: () => _toggleFavorite(book, false),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBookmarkBooks(bool vi) {
    final bookmarkedBooks =
        fakeBooks.where((book) => book.isBookmarked).toList();

    if (bookmarkedBooks.isEmpty) {
      return _emptyState(
        icon: Icons.bookmark_border_rounded,
        message: vi ? "Chưa có sách đánh dấu" : "No bookmarked books yet",
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      itemCount: bookmarkedBooks.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final book = bookmarkedBooks[index];
        final currentPage = book.currentPage <= 0 ? 1 : book.currentPage;
        final totalPages = book.totalPages <= 0 ? currentPage : book.totalPages;

        return Material(
          color: cardColor,
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () => _openReader(book),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      book.coverUrl,
                      width: 58,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 58,
                          height: 80,
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
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                            color: darkBrown,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          book.author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: textSoft,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          vi
                              ? 'Đã đánh dấu ở trang $currentPage/$totalPages'
                              : 'Bookmarked at page $currentPage/$totalPages',
                          style: const TextStyle(
                            fontSize: 13,
                            color: textSoft,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            value: totalPages == 0 ? 0 : currentPage / totalPages,
                            minHeight: 6,
                            backgroundColor: chipBg,
                            valueColor: const AlwaysStoppedAnimation(
                              Color(0xFFE0A85A),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.bookmark_rounded,
                      color: primaryBrown,
                    ),
                    onPressed: () => _toggleBookmark(book, false),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _emptyState({
    required IconData icon,
    required String message,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: chipBg,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                icon,
                size: 40,
                color: primaryBrown,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: textSoft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}