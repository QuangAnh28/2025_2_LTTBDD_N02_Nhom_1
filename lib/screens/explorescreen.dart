import 'package:flutter/material.dart';
import '../data/books.dart';
import '../widgets/categorychip.dart';
import '../widgets/bookcard.dart';
import 'bookdetailscreen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _selectedCategory = 'Tất cả sách';

  List<String> get _categories {
    final set = fakeBooks.map((e) => e.category).toSet().toList();
    set.sort();
    return ['Tất cả sách', ...set];
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _topBar(),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _searchBox(),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: const [
                Icon(Icons.folder_open_rounded, size: 18),
                SizedBox(width: 8),
                Text(
                  'Tìm theo Danh Mục',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildChips(),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _topBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      child: Row(
        children: const [
          Icon(Icons.explore_rounded, size: 22),
          SizedBox(width: 10),
          Text(
            'Khám Phá',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  Widget _searchBox() {
    return TextField(
      controller: _searchCtrl,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        hintText: 'Tìm kiếm sách...',
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

  Widget _buildChips() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _categories.map((category) {
        final selected = category == _selectedCategory;

        return CategoryChip(
          label: category,
          selected: selected,
          onTap: () {
            setState(() {
              _selectedCategory = category;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildContent() {
    final query = _searchCtrl.text.trim().toLowerCase();

    final filteredBooks = fakeBooks.where((book) {
      final matchCategory =
          _selectedCategory == 'Tất cả sách' ||
              book.category == _selectedCategory;

      final matchSearch = query.isEmpty ||
          book.title.toLowerCase().contains(query) ||
          book.author.toLowerCase().contains(query);

      return matchCategory && matchSearch;
    }).toList();

    if (filteredBooks.isEmpty) {
      return _emptyState(query);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        itemCount: filteredBooks.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 0.72,
        ),
        itemBuilder: (context, index) {
          final book = filteredBooks[index];

          return BookCard(
            book: book,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookDetailScreen(book: book),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _emptyState(String query) {
    final message = query.isNotEmpty
        ? 'Không tìm thấy kết quả cho "$query"'
        : 'Tìm kiếm sách hoặc chọn danh mục để khám phá';

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_rounded,
            size: 70,
            color: Colors.black.withOpacity(0.2),
          ),
          const SizedBox(height: 14),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.black.withOpacity(0.35),
            ),
          ),
        ],
      ),
    );
  }
}