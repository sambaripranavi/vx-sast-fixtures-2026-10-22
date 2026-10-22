'use strict';
// Benign lookalikes: same APIs as vulnerable.js, used safely.
const express = require('express');
const { execFile } = require('child_process');
const crypto = require('crypto');
const fs = require('fs');
const db = require('./db');

const app = express();

// FX-BEGIN JS-B01
app.get('/calc', (req, res) => {
  res.json(JSON.parse(req.query.payload));
});
// FX-END JS-B01

// FX-BEGIN JS-B02
app.get('/reports', (req, res) => {
  execFile('ls', ['-l', '/srv/reports'], (err, out) => res.send(out));
});
// FX-END JS-B02

// FX-BEGIN JS-B03
app.get('/terms', (req, res) => {
  fs.readFile('/srv/static/terms.txt', 'utf8', (err, data) => res.send(data));
});
// FX-END JS-B03

// FX-BEGIN JS-B04
app.get('/user/:id', async (req, res) => {
  const rows = await db.query('SELECT * FROM users WHERE id = $1', [req.params.id]);
  res.json(rows);
});
// FX-END JS-B04

// FX-BEGIN JS-B05
const SLUG_RE = /^[a-z0-9-]{1,64}$/;
app.get('/slug', (req, res) => res.json({ ok: SLUG_RE.test(req.query.slug) }));
// FX-END JS-B05

// FX-BEGIN JS-B06
app.post('/hook', (req, res) => {
  const given = Buffer.from(String(req.headers['x-token'] || ''));
  const expected = Buffer.from(String(process.env.HOOK_TOKEN || ''));
  const ok = given.length === expected.length && crypto.timingSafeEqual(given, expected);
  res.sendStatus(ok ? 200 : 403);
});
// FX-END JS-B06

// FX-BEGIN JS-B07
const LABELS = { en: 'Hello', fr: 'Bonjour' };
app.get('/label', (req, res) => {
  const lang = ['en', 'fr'].includes(req.query.lang) ? req.query.lang : 'en';
  res.send(LABELS[lang]);
});
// FX-END JS-B07

// FX-BEGIN JS-B08
app.get('/token', (req, res) => {
  res.send(crypto.randomBytes(16).toString('hex'));
});
// FX-END JS-B08

module.exports.app = app;
