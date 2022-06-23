enum AppPage {

  login,
  home,
  error,

  authorList,
  authorCreate,
  authorUpdate,

  articles,
  articleCreate,
  articleUpdate,

  categoryList,
  categoryCreate,
  categoryUpdate,

}

extension AppPageExtension on AppPage {
  String get path {
    switch (this) {

      case AppPage.home:
        return "/";
      case AppPage.login:
        return "/login";
      case AppPage.error:
        return "/error";

      case AppPage.authorList:
        return "/authors";
      case AppPage.authorCreate:
        return "create";
      case AppPage.authorUpdate:
        return "update/:authorId";

      case AppPage.articles:
        return "/articles";
      case AppPage.articleCreate:
        return "create";
      case AppPage.articleUpdate:
        return "update/:articleId";

      case AppPage.categoryList:
        return "/categories";
      case AppPage.categoryCreate:
        return "create";
      case AppPage.categoryUpdate:
        return "update/:categoryId";

      default:
        return "/";
    }
  }

  String get name {
    switch (this) {

      case AppPage.home:
        return "HOME";
      case AppPage.login:
        return "LOGIN";
      case AppPage.error:
        return "ERROR";

      case AppPage.authorList:
        return "AUTHORS_LIST";
      case AppPage.authorUpdate:
        return "AUTHOR_UPDATE";
      case AppPage.authorCreate:
        return "AUTHOR_CREATE";

      case AppPage.articles:
        return "ARTICLES_LIST";
      case AppPage.articleCreate:
        return "ARTICLE_UPDATE";
      case AppPage.articleUpdate:
        return "ARTICLE_CREATE";

      case AppPage.categoryList:
        return "CATEGORIES_LIST";
      case AppPage.categoryCreate:
        return "CATEGORY_UPDATE";
      case AppPage.categoryUpdate:
        return "CATEGORY_CREATE";

      default:
        return "HOME";

    }
  }

  String get title {
    switch (this) {

      case AppPage.home:
        return "Lazíts! Admin";
      case AppPage.login:
        return "Lazíts! Admin - Login";
      case AppPage.error:
        return "Lazíts! Admin - Error";


      case AppPage.authorList:
        return "Lazíts! Admin - Author List";
      case AppPage.authorCreate:
        return "Lazíts! Admin - Create Author";
      case AppPage.authorUpdate:
        return "Lazíts! Admin - Update Author";

      case AppPage.articles:
        return "Lazíts! Admin - Article List";
      case AppPage.articleCreate:
        return "Lazíts! Admin - Create Article";
      case AppPage.articleUpdate:
        return "Lazíts! Admin - Update Article";

      case AppPage.categoryList:
        return "Lazíts! Admin - Category List";
      case AppPage.categoryCreate:
        return "Lazíts! Admin - Create Category";
      case AppPage.categoryUpdate:
        return "Lazíts! Admin - Update Category";

      default:
        return "Lazíts! Admin";

    }
  }
}