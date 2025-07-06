class ApiEndpoint {
  static String baseUrl = "https://api.honarisho.com/api";
  static final String login = '/login';
  static final String logout = '/logout';
  static final String charts = '/charts';
  static final String chats = '/chats';
  static final String messages = '/messages';
  static final String sendMessage = '/messages';
  static final String getAllLessons = '/lessons';
  static final String getAllNews = '/news';
  static final String creteNewNews = '/news';
  static String updateNews(int id) => "/news/$id";
  static String deleteNews(int id) => "/news/$id";

}
