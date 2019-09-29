module SomeProject
  ( factorial,
  )
where

factorial :: Int -> Int
factorial n = product [1 .. n]
