'use strict';
// Known-vulnerable benchmark cases. All secrets are synthetic.
const express = require('express');
const childProcess = require('child_process');
const crypto = require('crypto');
const fs = require('fs');
const path = require('path');
const db = require('./db');

const app = express();

// FX-BEGIN JS-V01
app.get('/calc', (req, res) => {
  res.send(String(eval(req.query.expr)));
});
// FX-END JS-V01

// FX-BEGIN JS-V02
app.get('/ping', (req, res) => {
  childProcess.exec('ping -c 1 ' + req.query.host, (err, out) => res.send(out));
});
// FX-END JS-V02

// FX-BEGIN JS-V03
app.get('/file', (req, res) => {
  fs.readFile(path.join('/srv/data', req.query.name), (err, data) => res.send(data));
});
// FX-END JS-V03

// FX-BEGIN JS-V04
app.get('/user/:id', async (req, res) => {
  const rows = await db.query('SELECT * FROM users WHERE id = ' + req.params.id);
  res.json(rows);
});
// FX-END JS-V04

// FX-BEGIN JS-V05
const EMAIL_RE = /^([a-zA-Z0-9]+)+@example\.com$/;
app.get('/validate', (req, res) => res.json({ ok: EMAIL_RE.test(req.query.email) }));
// FX-END JS-V05

// FX-BEGIN JS-V06
app.post('/hook', (req, res) => {
  if (req.headers['x-token'] === process.env.HOOK_TOKEN) {
    res.sendStatus(200);
  } else {
    res.sendStatus(403);
  }
});
// FX-END JS-V06

// FX-BEGIN JS-V07
const JWT_SECRET = 'synthetic-JS-0000-not-a-real-secret';
module.exports.jwtSecret = JWT_SECRET;
// FX-END JS-V07

// FX-BEGIN JS-V08
app.get('/hello', (req, res) => {
  res.send('<h1>Hello ' + req.query.name + '</h1>');
});
// FX-END JS-V08

// FX-BEGIN JS-V09
app.get('/token', (req, res) => {
  res.send(crypto.pseudoRandomBytes(16).toString('hex'));
});
// FX-END JS-V09

module.exports.app = app;
