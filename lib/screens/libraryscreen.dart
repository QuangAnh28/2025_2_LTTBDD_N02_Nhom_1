import 'package:flutter/material.dart';
import '../main.dart';
import '../data/books.dart';
import '../models/book.dart';
import 'bookdetailscreen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  void _openDetail(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => BookDetailScreen(book: book)),
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
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
            child: Row(
              children: [
                const Icon(Icons.library_books_rounded, size: 22),
                const SizedBox(width: 10),
                Text(
                  vi ? "Thư viện" : "Library",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Material(
            color: Colors.white,
            child: TabBar(
              labelColor: const Color(0xFF1976D2),
              unselectedLabelColor: Colors.black54,
              indicatorColor: const Color(0xFF1976D2),
              labelStyle: const TextStyle(fontWeight: FontWeight.w900),
              tabs: [
                Tab(text: vi ? "Yêu thích" : "Favorites"),
                Tab(text: vi ? "Đánh dấu" : "Bookmarks"),
              ],
            ),
          ),
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
    );
  }

  // ================= FAVORITES =================
  Widget _buildFavoriteBooks(bool vi) {
    final favoriteBooks = fakeBooks.where((book) => book.isFavorite).toList();

    if (favoriteBooks.isEmpty) {
      return Center(
        child: Text(
          vi ? "Chưa có sách yêu thích" : "No favorite books yet",
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      itemCount: favoriteBooks.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final book = favoriteBooks[index];

        return Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => _openDetail(book),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      book.coverUrl,
                      width: 56,
                      height: 76,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
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
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          book.author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
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

  // ================= BOOKMARKS =================
  Widget _buildBookmarkBooks(bool vi) {
    final bookmarkedBooks = fakeBooks.where((book) => book.isBookmarked).toList();

    if (bookmarkedBooks.isEmpty) {
      return Center(
        child: Text(
          vi ? "Chưa có sách đánh dấu" : "No bookmarked books yet",
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      itemCount: bookmarkedBooks.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final book = bookmarkedBooks[index];
        final percent = (book.progress * 100).clamp(0, 100).toStringAsFixed(0);

        return Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => _openDetail(book),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      book.coverUrl,
                      width: 56,
                      height: 76,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
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
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            value: book.progress,
                            minHeight: 7,
                            backgroundColor: const Color(0xFFE5E7EB),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          vi ? "$percent% đã đọc" : "$percent% read",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.bookmark, color: Color(0xFF1976D2)),
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
}