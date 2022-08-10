import 'dart:math';
import 'package:dezmente/utils/levenshtein_dist.dart';

double getSimilarity(String a, String b) {
  double similarity;
  a = a.toUpperCase();
  b = b.toUpperCase();
  similarity =
      1 - (levenshteinDist(a, b) / (max(a.length, b.length)).toDouble());
  return (similarity);
}
