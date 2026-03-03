import 'package:flutter/material.dart';
import '../data/books.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _searchCtrl = TextEditingController();
  String _selected = 'Tất cả sách';

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
    final query = _searchCtrl.text.trim();

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
          const SizedBox(height: 14),
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
            child: _chips(),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _emptyState(query: query),
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

  Widget _chips() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _categories.map((c) {
        final selected = c == _selected;
        return GestureDetector(
          onTap: () => setState(() => _selected = c),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? const Color(0xFF26A69A) : Colors.white,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: selected ? const Color(0xFF26A69A) : const Color(0xFFE5E7EB),
              ),
            ),
            child: Text(
              '#$c',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: selected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _emptyState({required String query}) {
    final hint = query.isNotEmpty
        ? 'Không tìm thấy kết quả cho "$query"'
        : 'Tìm kiếm sách hoặc chọn danh mục để\nkhám phá';

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_rounded, size: 70, color: Colors.black.withOpacity(0.2)),
          const SizedBox(height: 14),
          Text(
            hint,
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