const express = require('express');
const app = express();
app.use(express.json());

app.post('/order/insert', async (req, res) => {
    const { imp_uid, merchant_uid, paid_amount, apply_num, buyer_email, buyer_name, orderDetails } = req.body;

    const db = require('./db'); // DB 설정 파일 임포트

    try {
        await db.beginTransaction(); // 트랜잭션 시작

        // orders 테이블에 데이터 삽입
        await db.query(`
            INSERT INTO orders (order_no, mem_id, order_total, order_state, order_date)
            VALUES (?, ?, ?, 'P', NOW())
        `, [merchant_uid, buyer_email, paid_amount]);

        // orderdetail 테이블에 데이터 삽입
        for (let detail of orderDetails) {
            await db.query(`
                INSERT INTO orderdetail (order_no, pro_detail_code, order_detail_amount, order_detail_price)
                VALUES (?, ?, ?, ?)
            `, [merchant_uid, detail.pro_detail_code, detail.quantity, detail.pro_price]);
        }

        await db.commit(); // 트랜잭션 커밋

        res.json({ success: true });
    } catch (error) {
        await db.rollback(); // 트랜잭션 롤백
        console.error(error);
        res.status(500).json({ success: false, message: '주문 처리 중 오류가 발생했습니다.' });
    }
});

app.listen(3000, () => {
    console.log('서버가 3000 포트에서 실행 중입니다.');
});
