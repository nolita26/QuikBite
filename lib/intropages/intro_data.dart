class IntroModel {
  String imageAssetPath;
  String title;
  String content;

  IntroModel({this.imageAssetPath, this.title, this.content});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setContent(String getContent) {
    content = getContent;
  }

  String getImageAssetPath() {
    return imageAssetPath;
  }

  String getTitle() {
    return title;
  }

  String getContent() {
    return content;
  }
}

List<IntroModel> getSlides() {
  List<IntroModel> slides = new List<IntroModel>();

  IntroModel introModel = new IntroModel();

  introModel.setImageAssetPath("images/sanfer.jpeg");
  introModel.setTitle("Sanfer");
  introModel.setContent("Team Leader OP");
  slides.add(introModel);

  introModel = new IntroModel();

  introModel.setImageAssetPath("images/princeton.jpeg");
  introModel.setTitle("Princeton");
  introModel.setContent("Backend express");
  slides.add(introModel);

  introModel = new IntroModel();

  introModel.setImageAssetPath("images/benita.jpeg");
  introModel.setTitle("Benita");
  introModel.setContent("The dark horse");
  slides.add(introModel);

  introModel = new IntroModel();

  return slides;
}
