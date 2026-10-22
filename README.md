# Vector X SAST comparison fixtures (2026-10-22)

Synthetic benchmark fixtures written for this comparison. Contains intentionally
vulnerable code. Do not deploy. All secret-like strings are synthetic
(`synthetic-XX-0000-...`) and are not real credentials.

Case IDs: `XX-Vnn` = known vulnerable, `XX-Bnn` = benign lookalike,
`XX-Cnn` = clean control. Each case is delimited by `FX-BEGIN <id>` / `FX-END <id>`
comments. Ground truth is in `../ground_truth/ground_truth.csv`.
