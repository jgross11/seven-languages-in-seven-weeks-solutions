% author, book relations
wrote(a1, b1).
wrote(a2, b2).
wrote(a3, b3).
wrote(a1, b4).

% write book title if author wrote book
book_query(A) :- wrote(A, X), write(X).

% musician, instrument relations
plays(m1, i1).
plays(m1, i2).
plays(m2, i2).
plays(m3, i1).
plays(m3, i3).

% musician, genre relations
genre(m1, g1).
genre(m1, g2).
genre(m2, g3).
genre(m3, g3).

% write musician name if musician plays instrument
instrument_query(I) :- plays(X, I), write(X).