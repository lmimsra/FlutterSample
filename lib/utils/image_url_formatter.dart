class ImageUrlFormatter {
  // アイコン画質をオリジナルのものを利用するようにする
  static String getOriginalImageUrl(String imageUrl) {
    return imageUrl.replaceAll('_normal', '');
  }
}