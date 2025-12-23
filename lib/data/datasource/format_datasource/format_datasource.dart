class FormatDataSource {
  String formatCount(String? viewCount) {
    if (viewCount == null) return "No views";

    final count = int.tryParse(viewCount);
    if (count == null) return "No views";

    if (count < 1000) {
      return count.toString();
    }

    if (count < 10_000) {
      // 1.2K, 9.8K
      return "${(count / 1000).toStringAsFixed(1)}K".replaceAll(".0", "");
    }

    if (count < 1_000_000) {
      // 26K, 999K
      return "${(count ~/ 1000)}K";
    }

    if (count < 10_000_000) {
      // 1.2M, 9.9M
      return "${(count / 1_000_000).toStringAsFixed(1)}M".replaceAll(".0", "");
    }

    if (count < 1_000_000_000) {
      // 12M, 999M
      return "${(count ~/ 1_000_000)}M";
    }

    return "${(count / 1_000_000_000).toStringAsFixed(1)}B".replaceAll(
      ".0",
      "",
    );
  }

  String formatDate(DateTime? publishedAt) {
    if (publishedAt == null) return "Unknown";

    final now = DateTime.now();
    final difference = now.difference(publishedAt);

    if (difference.inSeconds < 60) {
      return "just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} minutes ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hours ago";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} days ago";
    } else if (difference.inDays < 30) {
      return "${(difference.inDays / 7).floor()} weeks ago";
    } else if (difference.inDays < 365) {
      return "${(difference.inDays / 30).floor()} months ago";
    } else {
      return "${(difference.inDays / 365).floor()} years ago";
    }
  }
}
