
class FraudService {
  bool suspiciousSession({
    required int impressions,
    required int clicks,
    required Duration sessionDuration,
  }) {
    if (impressions > 500 && sessionDuration.inMinutes < 2) return true;
    if (clicks > impressions) return true;
    return false;
  }
}
