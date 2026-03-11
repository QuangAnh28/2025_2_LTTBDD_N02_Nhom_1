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
      case 'Lịch sử':
        return 'History';
      case 'Công nghệ':
        return 'Technology';
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

    return Container(
      color: bgColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topBar(vi),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _searchBox(vi),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: chipBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.folder_open_rounded,
                      size: 18,
                      color: primaryBrown,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    vi ? 'Tìm theo danh mục' : 'Browse by Category',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: darkBrown,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildChips(categories, vi),
            ),
            const SizedBox(height: 12),
            Expanded(child: _buildContent(vi)),
          ],
        ),
      ),
    );
  }

  Widget _topBar(bool vi) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
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
              Icons.explore_rounded,
              size: 22,
              color: primaryBrown,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            vi ? 'Khám phá' : 'Explore',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: darkBrown,
            ),
          ),
        ],
      ),
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

        return _buildCustomChip(
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

  Widget _buildCustomChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: selected ? primaryBrown : chipBg,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? primaryBrown : borderColor,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : darkBrown,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(bool vi) {
    final query = _searchCtrl.text.trim().toLowerCase();
    final selectedAll =
        (_selectedCategory == 'ALL_VI' || _selectedCategory == 'ALL_EN');

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
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: GridView.builder(
        itemCount: filteredBooks.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 0.68,
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
        ? (vi
            ? 'Không tìm thấy kết quả cho "$query"'
            : 'No results found for "$query"')
        : (vi
            ? 'Tìm kiếm sách hoặc chọn danh mục để khám phá'
            : 'Search books or choose a category to explore');

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
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
              child: const Icon(
                Icons.search_rounded,
                size: 42,
                color: primaryBrown,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: textSoft,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}