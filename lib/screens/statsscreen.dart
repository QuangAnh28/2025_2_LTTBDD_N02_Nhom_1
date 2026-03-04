import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../data/books.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final totalBooks = fakeBooks.length;

    final totalChaptersRead = fakeBooks.fold(
      0,
      (sum, book) => sum + book.currentChapter,
    );

    final completedBooks = fakeBooks.where((book) => book.isCompleted).length;

    final totalMinutes = fakeBooks.fold(
      0,
      (sum, book) => sum + book.minutesRead,
    );

    final avgMinutesPerDay = totalMinutes == 0 ? 0 : (totalMinutes / 7).round();

    final avgProgress = totalBooks == 0
        ? 0.0
        : fakeBooks.fold(0.0, (sum, book) => sum + book.progress) / totalBooks;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildTotalPagesCard(totalChaptersRead),

            const SizedBox(height: 20),

            if (fakeBooks.isNotEmpty) buildChartCard(),

            const SizedBox(height: 20),

            buildTimeAndBooksCard(avgMinutesPerDay, completedBooks),

            const SizedBox(height: 20),

            buildGoalCard(completedBooks),

            const SizedBox(height: 20),

            buildInfoCard("📚 Tổng số sách", totalBooks.toString()),
            buildInfoCard("⏳ Tổng phút đọc", "$totalMinutes phút"),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                "📈 Tiến trình trung bình",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            LinearProgressIndicator(
              value: avgProgress.clamp(0.0, 1.0),
              minHeight: 10,
              borderRadius: BorderRadius.circular(10),
            ),

            const SizedBox(height: 6),

            Text(
              "${(avgProgress * 100).toStringAsFixed(1)}%",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // =======================
  // CARD TỔNG CHƯƠNG
  // =======================
  Widget buildTotalPagesCard(int totalPagesRead) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF9800), Color(0xFFFFB74D)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tổng số chương đã đọc",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                "$totalPagesRead chương",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Icon(Icons.menu_book, size: 60, color: Colors.white),
        ],
      ),
    );
  }

  // =======================
  // BIỂU ĐỒ CỘT
  // =======================
  Widget buildChartCard() {
    final maxChapter = fakeBooks
        .map((book) => book.currentChapter)
        .reduce((a, b) => a > b ? a : b);

    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: (maxChapter + 5).toDouble(),
          barGroups: List.generate(
            fakeBooks.length > 4 ? 4 : fakeBooks.length,
            (index) =>
                makeGroup(index, fakeBooks[index].currentChapter.toDouble()),
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 18,
          borderRadius: BorderRadius.circular(4),
          color: Colors.orange,
        ),
      ],
    );
  }

  // =======================
  // BƯỚC 5 — CARD THỜI GIAN & SÁCH
  // =======================
  Widget buildTimeAndBooksCard(int avgMinutes, int completedBooks) {
    return Row(
      children: [
        Expanded(
          child: buildSmallCard("Thời Gian Đọc", "$avgMinutes phút/ngày"),
        ),
        const SizedBox(width: 12),
        Expanded(child: buildSmallCard("Sách Đã Đọc", "$completedBooks cuốn")),
      ],
    );
  }

  Widget buildSmallCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // =======================
  // BƯỚC 6 — MỤC TIÊU
  // =======================
  Widget buildGoalCard(int completedBooks) {
    const int goal = 20;
    final double percent = (completedBooks / goal).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("🎯 Mục tiêu năm"),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: percent,
            minHeight: 10,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 8),
          Text("${(percent * 100).toInt()}% hoàn thành"),
        ],
      ),
    );
  }

  // =======================
  // CARD INFO NHỎ
  // =======================
  Widget buildInfoCard(String title, String value) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
