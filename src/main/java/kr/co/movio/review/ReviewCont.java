package kr.co.movio.review;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.MediaType;
import jakarta.servlet.http.HttpSession;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/review")
public class ReviewCont {

    // 생성자
    public ReviewCont() {
        System.out.println("-----ReviewCont() 객체 생성됨");
    }

    // ReviewDAO 주입
    @Autowired
    private ReviewDAO reviewDao;

    // 리뷰 추가 메서드
    @PostMapping(value = "/insert", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public String insertReview(@RequestParam Map<String, String> params, HttpSession session) {
        String movie_id = params.get("movie_id");
        String review_text = params.get("review_text");
        BigDecimal rating = new BigDecimal(params.get("rating"));
        String mem_id = params.get("mem_id");

        System.out.println("movie_id: " + movie_id);
        System.out.println("mem_id: " + mem_id);
        System.out.println("review_text: " + review_text);
        System.out.println("rating: " + rating);

        // mem_id가 없을 경우 에러 처리
        if (mem_id == null || mem_id.isEmpty()) {
            System.out.println("mem_id is null or empty!");
            return "redirect:/movie/comment?id=" + movie_id + "&error=mem_id_missing";
        }

        // ReviewDTO 객체 생성 및 값 설정
        ReviewDTO reviewDto = new ReviewDTO();
        reviewDto.setMovie_id(movie_id);
        reviewDto.setMem_id(mem_id);
        reviewDto.setReview_text(review_text);
        reviewDto.setRating(rating);
        reviewDto.setReview_date(new Timestamp(System.currentTimeMillis()));

        // 리뷰 추가 DAO 호출
        try {
            reviewDao.addReview(reviewDto);
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/movie/comment?id=" + movie_id + "&error=sql_exception";
        }

        return "redirect:/movie/comment?id=" + movie_id;
    }

 // 리뷰 수정 메서드
    @PostMapping(value = "/update", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public String updateReview(@RequestParam Map<String, String> params, HttpSession session) {
        String review_id = params.get("review_id");
        String review_text = params.get("review_text");
        String ratingStr = params.get("rating");
        String review_date = params.get("review_date");
        String movie_id = params.get("movie_id");

        String mem_id = (String) session.getAttribute("mem_id");

        System.out.println("review_id: " + review_id);
        System.out.println("mem_id: " + mem_id);
        System.out.println("review_text: " + review_text);
        System.out.println("rating: " + ratingStr);
        System.out.println("review_date: " + review_date);
        System.out.println("movie_id: " + movie_id);

        // mem_id가 없을 경우 에러 처리
        if (mem_id == null || mem_id.isEmpty()) {
            System.out.println("mem_id is null or empty!");
            return "redirect:/movie/comment?id=" + movie_id + "&error=mem_id_missing";
        }

        // rating 값이 null인지 체크하고 기본값 설정
        BigDecimal rating;
        try {
            if (ratingStr == null || ratingStr.isEmpty()) {
                rating = BigDecimal.ZERO;
            } else {
                rating = new BigDecimal(ratingStr);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return "redirect:/movie/comment?id=" + movie_id + "&error=invalid_rating";
        }

        // ReviewDTO 객체 생성 및 값 설정
        ReviewDTO reviewDto = new ReviewDTO();
        reviewDto.setReview_id(review_id);
        reviewDto.setMem_id(mem_id);
        reviewDto.setReview_text(review_text);
        reviewDto.setRating(rating);
        reviewDto.setMovie_id(movie_id);

        // 리뷰 날짜 설정
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Timestamp timestamp;
            if (review_date == null || review_date.isEmpty()) {
                timestamp = new Timestamp(System.currentTimeMillis());
            } else {
                timestamp = new Timestamp(dateFormat.parse(review_date).getTime());
            }
            reviewDto.setReview_date(timestamp);
        } catch (ParseException e) {
            e.printStackTrace();
            return "redirect:/movie/comment?id=" + movie_id + "&error=date_format";
        }

        // 리뷰 수정 DAO 호출
        try {
            reviewDao.updateReview(reviewDto);
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/movie/comment?id=" + movie_id + "&error=sql_exception";
        }

        return "redirect:/movie/comment?id=" + movie_id;
    }


    // 리뷰 삭제 메서드
    @PostMapping(value = "/delete", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public String deleteReview(@RequestParam Map<String, String> params, HttpSession session) {
        String review_id = params.get("review_id");
        String mem_id = (String) session.getAttribute("mem_id");

        System.out.println("review_id: " + review_id);
        System.out.println("mem_id: " + mem_id);

        // mem_id가 없을 경우 에러 처리
        if (mem_id == null || mem_id.isEmpty()) {
            System.out.println("mem_id is null or empty!");
            return "redirect:/movie/comment?id=" + review_id + "&error=mem_id_missing";
        }

        // ReviewDTO 객체 생성 및 값 설정
        ReviewDTO reviewDto = new ReviewDTO();
        reviewDto.setReview_id(review_id);
        reviewDto.setMem_id(mem_id);

        // 리뷰 삭제 DAO 호출
        try {
            reviewDao.deleteReview(reviewDto);
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/movie/comment?id=" + review_id + "&error=sql_exception";
        }

        return "redirect:/movie/comment?id=" + review_id;
    }

    // 영화 댓글 페이지를 반환하는 메서드 (페이징 포함)
    @GetMapping("/comment")
    public String movieComment(@RequestParam("id") String movieId,
                               @RequestParam(value = "sort", required = false) String sort,
                               @RequestParam(value = "page", defaultValue = "1") int page, 
                               Model model) {
        int pageSize = 5;  // 페이지당 리뷰 수
        int offset = (page - 1) * pageSize;

        try {
            // 리뷰 목록을 페이징 및 정렬 기준에 따라 가져와서 모델에 추가
            List<ReviewDTO> reviewList;
            if ("rating".equals(sort)) {
                reviewList = reviewDao.getReviewsByMovieIdSortedByRatingPaged(movieId, offset, pageSize);
            } else {
                reviewList = reviewDao.getReviewsByMovieIdPaged(movieId, offset, pageSize);
            }

            int totalReviews = reviewDao.getTotalReviewCountByMovieId(movieId);
            int totalPages = (int) Math.ceil((double) totalReviews / pageSize);

            System.out.println("Total reviews: " + totalReviews);
            System.out.println("Review list: " + reviewList);
            System.out.println("Current page: " + page);
            System.out.println("Total pages: " + totalPages);

            model.addAttribute("reviewCount", totalReviews);
            model.addAttribute("reviewList", reviewList);
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("movieId", movieId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "movie/moviedetail_review";
    }
}
