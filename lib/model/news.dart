class News {
  List<SentimentArticle> articles;
}

class SentimentArticle {
  String newsSourceName,
      author,
      title,
      description,
      url,
      imageUrl,
      publishedDt,
      content,
      sentimentScore,
      sentimentMagnitude;

  SentimentArticle(
      {this.newsSourceName,
      this.author,
      this.title,
      this.description,
      this.url,
      this.imageUrl,
      this.publishedDt,
      this.content,
      this.sentimentScore,
      this.sentimentMagnitude});

  factory SentimentArticle.fromJson(Map<String, dynamic> json) {
    return SentimentArticle(
        newsSourceName: json["newssourcename"],
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        imageUrl: json["imageurl"],
        publishedDt: json["publisheddt"],
        content: json["content"],
        sentimentScore: json["sentimentscore"],
        sentimentMagnitude: json["sentimentmagnitude"]);
  }
}
