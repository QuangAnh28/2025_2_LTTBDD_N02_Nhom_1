import 'package:flutter/material.dart';
import '../main.dart';
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

  String _selectedCategory = 'ALL_VI';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  String _allKey(bool vi) => vi ? 'ALL_VI' : 'ALL_EN';

  String _allLabel(bool vi) => vi ? 'Tất cả sách' : 'All books';

  String _tCategory(String category, bool vi) {
    if (vi) return category;

    switch (category) {
      case 'Tiểu thuyết':
        return 'Novel';
      case 'Kinh điển':
        return 'Classics';
      case 'Khoa học':
        return 'Science';
      case 'Phiêu lưu':
        return 'Adventure';
      default:
        return category;
    }
  }

  List<String> get _categoriesVi {
    final set = fakeBooks.map((e) => e.category).toSet().toList();
    set.sort();
    return set;
  }

  @override
  Widget build(BuildContext context) {
    final vi = MyApp.of(context).isVietnamese;

    if (_selectedCategory != 'ALL_VI' &&
        _selectedCategory != 'ALL_EN' &&
        !_categoriesVi.contains(_selectedCategory)) {
      _selectedCategory = _allKey(vi);
    }

    if (_selectedCategory == 'ALL_VI' || _selectedCategory == 'ALL_EN') {
      _selectedCategory = _allKey(vi);
    }

    final allLabel = _allLabel(vi);
    final categories = [allLabel, ..._categoriesVi];

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _topBar(vi),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _searchBox(vi),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.folder_open_rounded, size: 18),
                const SizedBox(width: 8),
                Text(
                  vi ? 'Tìm theo Danh Mục' : 'Browse by Category',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildChips(categories, vi),
          ),
          const SizedBox(height: 10),
          Expanded(child: _buildContent(vi)),
        ],
      ),
    );
  }

  Widget _topBar(bool vi) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      child: Row(
        children: [
          const Icon(Icons.explore_rounded, size: 22),
          const SizedBox(width: 10),
          Text(
            vi ? 'Khám Phá' : 'Explore',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
        ],
      ),
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

  Widget _buildChips(List<String> categories, bool vi) {
    final allLabel = _allLabel(vi);

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: categories.map((category) {
        final isAllChip = category == allLabel;

        final selected = isAllChip
            ? (_selectedCategory == 'ALL_VI' || _selectedCategory == 'ALL_EN')
            : (_selectedCategory == category);

        final displayLabel = isAllChip ? category : _tCategory(category, vi);

        return CategoryChip(
          label: displayLabel,
          selected: selected,
          onTap: () {
            setState(() {
              _selectedCategory = isAllChip ? _allKey(vi) : category;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildContent(bool vi) {
    final query = _searchCtrl.text.trim().toLowerCase();
    final selectedAll = (_selectedCategory == 'ALL_VI' || _selectedCategory == 'ALL_EN');

    final filteredBooks = fakeBooks.where((book) {
      final matchCategory = selectedAll || book.category == _selectedCategory;

      final matchSearch = query.isEmpty ||
          book.title.toLowerCase().contains(query) ||
          book.author.toLowerCase().contains(query);

      return matchCategory && matchSearch;
    }).toList();

    if (filteredBooks.isEmpty) {
      return _emptyState(vi, query);
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

  Widget _emptyState(bool vi, String query) {
    final message = query.isNotEmpty
        ? (vi ? 'Không tìm thấy kết quả cho "$query"' : 'No results found for "$query"')
        : (vi ? 'Tìm kiếm sách hoặc chọn danh mục để khám phá' : 'Search books or choose a category to explore');

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