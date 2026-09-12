Codex independent source review of exact `968c249b7bc61bad48dd39bcfdc4a325b71c1905` against adopted cutoff 111 `6f989eeb17b4826d43925efe6fa7a0e178efcc76`: no blocking findings.

The source difference is byte-for-byte the original PR #18 bound change from `76d82c2`; all marking and support files match development. Corrections use division to avoid squaring overflow, produce the exact integer root, and safely retain zero for nonpositive limits. The root is recomputed inside each pass. Existing boundary checks cover the changed condition; no additional targeted case was identified. Classification and benchmark workload remain unchanged. Candidate sieve SHA256: `a193b04bfba33cd517578ef91e271f2c6ea285632d456c58ed566c4181eb09b0`.

The new candidate's full local verification and assembly checks are running. Timing is gated on those results and a final admission comment; no timing has run yet.
