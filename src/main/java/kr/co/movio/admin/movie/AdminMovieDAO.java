package kr.co.movio.admin.movie;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AdminMovieDAO {
    @Autowired
    private SqlSession sqlSession;

    public List<AdminMovieDTO> getAllMovies() {
        return sqlSession.selectList("adminMovie.getAllMovies");
    }
    
    public void addMovie(AdminMovieDTO movie) {
        sqlSession.insert("adminMovie.addMovie", movie);
    }

    public void updateMovieStatus(AdminMovieDTO movie) {
        sqlSession.update("adminMovie.updateMovieStatus", movie);
    }

    public void deleteMovie(int movieId) {
        sqlSession.delete("adminMovie.deleteMovie", movieId);
    }
}
