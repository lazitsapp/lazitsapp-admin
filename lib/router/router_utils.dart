enum AppPage {

  login,
  home,
  error,

  authors,
  authorCreate,
  authorUpdate,

  articles,
  articleCreate,
  articleUpdate,

  categories,
  categoryCreate,
  categoryUpdate,

}

extension AppPageExtension on AppPage {
  String get toPath {
    switch (this) {

      case AppPage.home:
        return "/";
      case AppPage.login:
        return "/login";
      case AppPage.error:
        return "/error";

      case AppPage.authors:
        return "/authors";
      case AppPage.authorCreate:
        return "update/:authorId";
      case AppPage.authorUpdate:
        return "create";

      default:
        return "/";
    }
  }

  String get toName {
    switch (this) {
      case AppPage.home:
        return "HOME";
      case AppPage.login:
        return "LOGIN";
      case AppPage.error:
        return "ERROR";
      case AppPage.authors:
        return "AUTHORS_LIST";
      case AppPage.authorUpdate:
        return "AUTHOR_UPDATE";
      case AppPage.authorCreate:
        return "AUTHOR_CREATE";

      default:
        return "HOME";
    }
  }

  String get toTitle {
    switch (this) {
      case AppPage.home:
        return "Lazíts! Admin";
      case AppPage.login:
        return "Lazíts! Admin - Login";
      default:
        return "Lazíts! Admin";
    }
  }
}