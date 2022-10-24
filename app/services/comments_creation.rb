class CommentsCreation
  def initialize(original_comments, translated_comments, article_id)
    @original_comments = original_comments
    @translated_comments = translated_comments
    @article_id = article_id
  end

  def rating
    common_rating = 0
    request, http = ApiRequest.call(API_TEXTPROBE_PATH, TEXTPROBE_HOST).values_at(:request, :http)

    (@original_comments.length).times do |i|
      request.body = "{
          \"text\": \"#{@translated_comments[i]}\",
          \"lang\": \"en\"
      }"

      response = http.request(request)
      scores = JSON.parse(response.read_body)['sentiment_scores']
      rating = ((scores['Positive'] * 100) - (scores['Negative'] * 100)).ceil(2)
      common_rating += rating
      Comment.create(text: @original_comments[i], rating: rating, article_id: @article_id)
    end
    article_rating(common_rating, @article_id, @original_comments.length)
  end

  def article_rating(common_rating, article_id, comments_amount)
    final_rating = (common_rating/comments_amount).ceil(2)
    Article.find(article_id).update(rating: final_rating)
  end
end
