package kr.co.movio.movie;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MovieDAO {

    @Autowired
    private SqlSession sqlSession;

    public int addMovie(MovieDTO movie) {
        return sqlSession.insert("movie.addMovie", movie);
    }

    public List<MovieDTO> getMovies() {
        return sqlSession.selectList("movie.getMovies");
    }

    public MovieDTO getMovieById(String movie_id) {
        return sqlSession.selectOne("movie.getMovieById", movie_id);
    }

    public int updateMovie(MovieDTO movie) {
        return sqlSession.update("movie.updateMovie", movie);
    }

    public int deleteMovie(int movie_id) {
        return sqlSession.delete("movie.deleteMovie", movie_id);
    }

    public String getMaxMovieId() {
        return sqlSession.selectOne("movie.getMaxMovieId");
    }
    
}
