package kr.co.movio;

import javax.sql.DataSource;


import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

@SpringBootApplication
@ComponentScan(basePackages = "kr.co.movio")
public class MovioProjectApplication {

	public static void main(String[] args) {
		SpringApplication.run(MovioProjectApplication.class, args);
	}

    @Bean
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
        System.out.println("-----sqlSessionFactory() 호출됨");

        SqlSessionFactoryBean bean = new SqlSessionFactoryBean();
        bean.setDataSource(dataSource);
        
        //mapper 폴더의 모든.xml에 접근
        Resource[] res = new PathMatchingResourcePatternResolver().getResources("classpath:mappers/*.xml");
        bean.setMapperLocations(res);

        return bean.getObject();
    }

    @Bean
    public SqlSessionTemplate sqlSession(SqlSessionFactory factory) {
        System.out.println("-----sqlSession() 호출됨");
        return new SqlSessionTemplate(factory);
    }
}

