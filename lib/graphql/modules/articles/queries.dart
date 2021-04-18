const getArticles = """
  query getArticles {
    getArticles {
      title,
      author,
      image,
      date
    }
  }
""";

const getTrendingArticles = """
  query getTrendings {
    getTrendings {
      title,
      author,
      image,
      date
    }
  }
""";

const getLatestArticles = """
  query getLatests {
    getLatests {
      title,
      author,
      image,
      date
    }
  }
""";

const getRecommendedArticles = """
  query getRecommendations {
    getRecommendations {
      title,
      author,
      image,
      date
    }
  }
""";

const getArticleData = """
  query searchArticle(\$title: String!) {
  searchArticle(title: \$title) {
    data
  }
}
""";
