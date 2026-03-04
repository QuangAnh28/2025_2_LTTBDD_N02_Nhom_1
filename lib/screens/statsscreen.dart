import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../main.dart';
import '../data/books.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vi = MyApp.of(context).isVietnamese;

    final totalBooks = fakeBooks.length;

    final totalChaptersRead =
        fakeBooks.fold<int>(0, (sum, book) => sum + book.currentChapter);

    final completedBooks = fakeBooks.where((book) => book.isCompleted).length;

    final totalMinutes =
        fakeBooks.fold<int>(0, (sum, book) => sum + book.minutesRead);

    final avgMinutesPerDay = totalMinutes == 0 ? 0 : (totalMinutes / 7).round();

    final avgProgress = totalBooks == 0
        ? 0.0
        : fakeBooks.fold<double>(0.0, (sum, book) => sum + book.progress) /
            totalBooks;

    final progressPercent = (avgProgress * 100).clamp(0.0, 100.0);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTotalChaptersCard(totalChaptersRead, vi),
            const SizedBox(height: 20),
            if (fakeBooks.isNotEmpty) _buildChartCard(vi),
            const SizedBox(height: 20),
            _buildTimeAndBooksCard(avgMinutesPerDay, completedBooks, vi),
            const SizedBox(height: 20),
            _buildGoalCard(completedBooks, vi),
            const SizedBox(height: 20),
            _buildInfoCard(
              vi ? "📚 Tổng số sách" : "📚 Total books",
              totalBooks.toString(),
            ),
            _buildInfoCard(
              vi ? "⏳ Tổng phút đọc" : "⏳ Total minutes",
              vi ? "$totalMinutes phút" : "$totalMinutes min",
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                vi ? "📈 Tiến trình trung bình" : "📈 Average progress",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              "${progressPercent.toStringAsFixed(1)}%",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // =======================
  // CARD: TOTAL CHAPTERS
  // =======================
  Widget _buildTotalChaptersCard(int totalChaptersRead, bool vi) {
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
              Text(
                vi ? "Tổng số chương đã đọc" : "Total chapters read",
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                vi ? "$totalChaptersRead chương" : "$totalChaptersRead chapters",
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
  // BAR CHART
  // =======================
  Widget _buildChartCard(bool vi) {
    final takeN = fakeBooks.length > 4 ? 4 : fakeBooks.length;

    final maxChapter = fakeBooks
        .take(takeN)
        .map((b) => b.currentChapter)
        .fold<int>(0, (m, v) => v > m ? v : m);

    final maxY = (maxChapter + 5).toDouble().clamp(5.0, 9999.0);

    return Container(
      height: 270,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            vi ? "📊 Chương đã đọc (Top $takeN)" : "📊 Chapters read (Top $takeN)",
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxY,
                gridData: FlGridData(show: true),
                borderData: FlBorderData(show: false),
                barTouchData: BarTouchData(enabled: true),
                titlesData: FlTitlesData(
                  topTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: (maxY / 4).clamp(1, 10),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: (value, meta) {
                        final i = value.toInt();
                        if (i < 0 || i >= takeN) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            "B${i + 1}",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: List.generate(
                  takeN,
                  (index) => _makeGroup(
                    index,
                    fakeBooks[index].currentChapter.toDouble(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _makeGroup(int x, double y) {
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
  // TIME & COMPLETED
  // =======================
  Widget _buildTimeAndBooksCard(int avgMinutes, int completedBooks, bool vi) {
    return Row(
      children: [
        Expanded(
          child: _buildSmallCard(
            vi ? "Thời Gian Đọc" : "Reading time",
            vi ? "$avgMinutes phút/ngày" : "$avgMinutes min/day",
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildSmallCard(
            vi ? "Sách Đã Đọc" : "Completed books",
            vi ? "$completedBooks cuốn" : "$completedBooks books",
          ),
        ),
      ],
    );
  }

  Widget _buildSmallCard(String title, String value) {
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
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
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
  // GOAL
  // =======================
  Widget _buildGoalCard(int completedBooks, bool vi) {
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
          Text(
            vi ? "🎯 Mục tiêu năm" : "🎯 Year goal",
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: percent,
            minHeight: 10,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 8),
          Text(
            vi
                ? "${(percent * 100).toInt()}% hoàn thành"
                : "${(percent * 100).toInt()}% completed",
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  // =======================
  // INFO CARD
  // =======================
  Widget _buildInfoCard(String title, String value) {
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