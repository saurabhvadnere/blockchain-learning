const express = require('express');
const jwt = require('jsonwebtoken');
const bodyParser = require('body-parser');

const app = express();
const PORT = 4000;
const tokenSecret = 'my-key';

// ---------------- USERS ----------------
const users = [
  { id: '1', username: 'admin', password: '1234', role: 'admin' },
  { id: '2', username: 'user', password: '1234', role: 'customer' }
];

// ---------------- CAR DATA ----------------
const cars = [
  { id: '1', brand: 'Maruti', year: 2021, drivenKm: 35000, price: 550000 },
  { id: '2', brand: 'Hyundai', year: 2020, drivenKm: 42000, price: 620000 },
  { id: '3', brand: 'Honda', year: 2019, drivenKm: 60000, price: 480000 }
];

// ---------------- MIDDLEWARE ----------------
app.use(bodyParser.json());

// ---------------- LOGIN ----------------
app.post('/login', (req, res) => {
  const { username, password } = req.body;

  const user = users.find(u => u.username === username);
  if (!user || user.password !== password) {
    return res.status(400).send({ message: 'Invalid username or password' });
  }

  const token = jwt.sign(
    { role: user.role },
    tokenSecret,
    {
      expiresIn: '10m',
      issuer: 'car24-api',
      subject: user.id
    }
  );

  res.send({ token });
});

// ---------------- ROLE MIDDLEWARE ----------------
const validateAnyRole = (roles) => {
  return (req, res, next) => {
    const authHeader = req.headers.authorization;
    if (!authHeader) return res.sendStatus(403);

    const token = authHeader.replace('Bearer ', '');

    try {
      const decoded = jwt.verify(token, tokenSecret);

      if (roles.includes(decoded.role) && decoded.iss === 'car24-api') {
        next();
        return;
      }
      res.sendStatus(403);
    } catch {
      res.sendStatus(403);
    }
  };
};

// ---------------- CAR ROUTES ----------------

// 🔓 ADMIN + USER → VIEW CARS
app.get('/cars', validateAnyRole(['admin', 'customer']), (req, res) => {
  res.send({ cars });
});

app.get('/cars/:carId', validateAnyRole(['admin', 'customer']), (req, res) => {
  const car = cars.find(c => c.id === req.params.carId);
  if (!car) return res.sendStatus(404);
  res.send({ car });
});

// 🔐 ADMIN ONLY → ADD CAR
app.post('/cars', validateAnyRole(['admin']), (req, res) => {
  const { brand, year, drivenKm, price } = req.body;

  const newCar = {
    id: String(cars.length + 1),
    brand,
    year,
    drivenKm,
    price
  };

  cars.push(newCar);
  res.send({ message: 'Car added', car: newCar });
});

// 🔐 ADMIN ONLY → UPDATE CAR
app.put('/cars/:carId', validateAnyRole(['admin']), (req, res) => {
  const car = cars.find(c => c.id === req.params.carId);
  if (!car) return res.sendStatus(404);

  const { brand, year, drivenKm, price } = req.body;
  if (brand) car.brand = brand;
  if (year) car.year = year;
  if (drivenKm) car.drivenKm = drivenKm;
  if (price) car.price = price;

  res.send({ message: 'Car updated', car });
});

// 🔐 ADMIN ONLY → DELETE CAR
app.delete('/cars/:carId', validateAnyRole(['admin']), (req, res) => {
  const index = cars.findIndex(c => c.id === req.params.carId);
  if (index === -1) return res.sendStatus(404);

  cars.splice(index, 1);
  res.send({ message: 'Car deleted' });
});

// ---------------- SERVER ----------------
app.listen(PORT, () => {
  console.log(`Car24 API running on http://localhost:${PORT}`);
});
