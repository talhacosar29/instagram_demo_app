class Sabitler {
  // Home Page Firestore Degiskenleri
  static List<String> FirebasePhotos = [];
  static List<String> FirebaseUsernames = [];
  static List<int> FirebasePhotoLikes = [];
  static List<String> FirebaseUserNamesList = [];

  // Profile Page Firestore Degiskenleri
  static List<String> currentFirebasePhotos = [];
  static List<int> currentFirebasePhotoLikes = [];
  static List<String> currentFirebaseUserNames = [];

  // Giriş Yapılan Hesabın Kullanıcı Adı
  static String currentUser = "";

  // BottomNavigator Value Degiskeni
  static int page_num = 0;

  // Giriş Yap / Kayıt Ol Gesture Detector Kontrol
  static int login = 1;

  // Kayıt Sayısı FireStore
  static int userLength = 0;
}
