
const express = require('express');
const cors = require('cors');
const mysql = require('mysql2');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME
});

// GET /products
app.get('/products', (req, res) => {
  const { search = '', sort, page = 1, limit = 10 } = req.query;
  const offset = (page - 1) * limit;
  let sql = `SELECT * FROM products WHERE productName LIKE ?`;

  if (sort === 'price') sql += ` ORDER BY price`;
  else if (sort === 'stock') sql += ` ORDER BY stock`;

  sql += ` LIMIT ? OFFSET ?`;
  db.query(sql, [`%${search}%`, +limit, +offset], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(result);
  });
});

// GET /products/:id
app.get('/products/:id', (req, res) => {
  db.query('SELECT * FROM products WHERE productId = ?', [req.params.id], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(result[0]);
  });
});

// POST
app.post('/products', (req, res) => {
  const { productName, price, stock, image } = req.body;
  db.query(
    'INSERT INTO products (productName, price, stock, image) VALUES (?, ?, ?, ?)',
    [productName, price, stock, image],
    (err, result) => {
      if (err) return res.status(500).json({ error: err.message });
      res.status(201).json({ id: result.insertId });
    }
  );
});

// PUT
app.put('/products/:id', (req, res) => {
  const { productName, price, stock, image } = req.body;
  const { id } = req.params;

  console.log('Update request:', { id, productName, price, stock, image });

  db.query(
    'UPDATE products SET productName=?, price=?, stock=?, image=? WHERE productId=?',
    [productName, price, stock, image, id],
    (err, result) => {
      if (err) {
        console.error('SQL error:', err.message);
        return res.status(500).json({ error: err.message });
      }
      console.log('Update result:', result); // log affectedRows, etc.
      res.sendStatus(204);
    }
  );
});


// DELETE
app.delete('/products/:id', (req, res) => {
  db.query('DELETE FROM products WHERE productId = ?', [req.params.id], (err) => {
    if (err) return res.status(500).json({ error: err.message });
    res.sendStatus(204);
  });
});

//app.listen(3000, () => console.log('Server running on http://localhost:3000'));
app.listen(3000, '0.0.0.0', () => {
  console.log('Server running on http://0.0.0.0:3000');
});



