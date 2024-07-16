package kr.co.movio.review;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ReviewDAO {

    // SqlSession 주입
    @Autowired
    private SqlSession sqlSession;

    // 리뷰 추가 메서드
    public int addReview(ReviewDTO review) {
        return sqlSession.insert("review.addReview", review);
    }

    // 특정 영화의 모든 리뷰를 가져오는 메서드
    public List<ReviewDTO> getReviewsByMovieId(String movie_id) {
        return sqlSession.selectList("review.getReviewsByMovieId", movie_id);
    }

    // 특정 영화의 리뷰를 최신순으로 가져오는 메서드
    public List<ReviewDTO> getReviewsByMovieIdSortedByDate(String movie_id) {
        return sqlSession.selectList("review.getReviewsByMovieIdSortedByDate", movie_id);
    }

    // 특정 영화의 리뷰를 평점순으로 가져오는 메서드
    public List<ReviewDTO> getReviewsByMovieIdSortedByRating(String movie_id) {
        return sqlSession.selectList("review.getReviewsByMovieIdSortedByRating", movie_id);
    }

    // 특정 영화의 리뷰를 페이징 처리하여 가져오는 메서드
    public List<ReviewDTO> getReviewsByMovieIdPaged(String movie_id, int offset, int limit) {
        Map<String, Object> params = new HashMap<>();
        params.put("movie_id", movie_id);
        params.put("offset", offset);
        params.put("limit", limit);
        return sqlSession.selectList("review.getReviewsByMovieIdPaged", params);
    }

    // 특정 영화의 리뷰를 평점순으로 페이징 처리하여 가져오는 메서드
    public List<ReviewDTO> getReviewsByMovieIdSortedByRatingPaged(String movie_id, int offset, int limit) {
        Map<String, Object> params = new HashMap<>();
        params.put("movie_id", movie_id);
        params.put("offset", offset);
        params.put("limit", limit);
        return sqlSession.selectList("review.getReviewsByMovieIdSortedByRatingPaged", params);
    }

    // 특정 영화의 리뷰를 날짜순으로 페이징 처리하여 가져오는 메서드
    public List<ReviewDTO> getReviewsByMovieIdSortedByDatePaged(String movie_id, int offset, int limit) {
        Map<String, Object> params = new HashMap<>();
        params.put("movie_id", movie_id);
        params.put("offset", offset);
        params.put("limit", limit);
        return sqlSession.selectList("review.getReviewsByMovieIdSortedByDatePaged", params);
    }

    // 특정 영화의 리뷰 총 개수를 가져오는 메서드
    public int getTotalReviewCountByMovieId(String movie_id) {
        return sqlSession.selectOne("review.getTotalReviewCountByMovieId", movie_id);
    }

    // 리뷰 삭제 메서드
    public int deleteReview(ReviewDTO review) {
        return sqlSession.delete("review.deleteReview", review);
    }

    // 리뷰 수정 메서드
    public int updateReview(ReviewDTO review) {
        return sqlSession.update("review.updateReview", review);
    }
}
