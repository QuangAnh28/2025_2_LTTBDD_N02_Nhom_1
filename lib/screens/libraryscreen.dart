import 'package:flutter/material.dart';
import '../data/books.dart';
import '../models/book.dart';
import 'bookdetailscreen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.blue,
            tabs: [
              Tab(text: "Yêu thích"),
              Tab(text: "Đánh dấu"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [_buildFavoriteBooks(), _buildBookmarkBooks()],
            ),
          ),
        ],
      ),
    );
  }

  // ================= YÊU THÍCH =================
  Widget _buildFavoriteBooks() {
    final favoriteBooks = fakeBooks.where((book) => book.isFavorite).toList();

    if (favoriteBooks.isEmpty) {
      return const Center(child: Text("Chưa có sách yêu thích"));
    }

    return ListView.builder(
      itemCount: favoriteBooks.length,
      itemBuilder: (context, index) {
        final book = favoriteBooks[index];

        return ListTile(
          leading: Image.asset(
            book.coverUrl,
            width: 50,
            height: 70,
            fit: BoxFit.cover,
          ),
          title: Text(book.title),
          subtitle: Text(book.author),
          trailing: IconButton(
            icon: const Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              setState(() {
                book.isFavorite = false;
              });
            },
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => BookDetailScreen(book: book)),
            ).then((_) => setState(() {}));
          },
        );
      },
    );
  }

  // ================= ĐÁNH DẤU =================
  Widget _buildBookmarkBooks() {
    final bookmarkedBooks = fakeBooks
        .where((book) => book.isBookmarked)
        .toList();

    if (bookmarkedBooks.isEmpty) {
      return const Center(child: Text("Chưa có sách đánh dấu"));
    }

    return ListView.builder(
      itemCount: bookmarkedBooks.length,
      itemBuilder: (context, index) {
        final book = bookmarkedBooks[index];

        return ListTile(
          leading: Image.asset(
            book.coverUrl,
            width: 50,
            height: 70,
            fit: BoxFit.cover,
          ),
          title: Text(book.title),

          // PROGRESS BAR
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              LinearProgressIndicator(value: book.progress, minHeight: 6),
              const SizedBox(height: 4),
              Text(
                "${(book.progress * 100).toStringAsFixed(0)}% đã đọc",
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),

          trailing: IconButton(
            icon: const Icon(Icons.bookmark, color: Colors.blue),
            onPressed: () {
              setState(() {
                book.isBookmarked = false;
              });
            },
          ),

          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => BookDetailScreen(book: book)),
            ).then((_) => setState(() {}));
          },
        );
      },
    );
  }
}
