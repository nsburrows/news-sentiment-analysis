// Holds a list of all New Categories and the id's associated with them
class NewsCategories {

  // Returns a list object that has all of the news categories
  static String getNewsCategory(int i) {
    List<String> list = new List(7);

    //Build up the list of categories
    list[0] = 'Business';
    list[1] = 'Entertainment';
    list[2] = 'General';
    list[3] = 'Health';
    list[4] = 'Science';
    list[5] = 'Sports';
    list[6] = 'Technology';

    // Return the desired category
    return list[i];
  }
}
