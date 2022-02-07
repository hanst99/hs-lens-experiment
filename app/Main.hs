{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified SDL
import SDL(($=), Rectangle(..), Point(..), V2(..))
import Debug.Trace
import System.IO
import GHC.IO.Handle(hDuplicate, hDuplicateTo)
import GHC.IO.Unsafe
import Data.Text(Text)
import qualified Data.Text as T
import Control.Concurrent

import Control.Monad(unless, forM_, replicateM_)
import GHC.IO.Handle (hDuplicate)
import Control.Concurrent (threadDelay)

equals :: Eq a => a -> a -> Bool
equals = (==)

sdlTrace :: Text -> a -> a
sdlTrace message x = unsafePerformIO $ do
   SDL.showSimpleMessageBox Nothing SDL.Information "trace" message
   return x

sdlTraceThis :: Show a => a -> a
sdlTraceThis x = sdlTrace (T.pack $ show x) x

untilM_ :: Monad m => m Bool -> m ()
untilM_ m = do
  stop <- m
  unless stop (untilM_ m)

mainLoop :: SDL.Renderer -> IO ()
mainLoop renderer = go where
  go = replicateM_ 1200 $ do
    render
    checkForHasQuit
  checkForHasQuit :: IO Bool
  checkForHasQuit =
    any (equals SDL.QuitEvent . SDL.eventPayload) <$> SDL.pollEvents
  render = do
    SDL.rendererDrawColor renderer $= SDL.V4 200 155 75 255
    SDL.clear renderer
    SDL.rendererDrawColor renderer $= SDL.V4 75 175 125 255
    let xOff = 100
        yOff = 100
        s = 5
        off = 5
    forM_ [0..100] $ \row -> do
      forM_ [0..100] $ \column -> do
        let rect = Rectangle (P $ V2 (xOff + (s+off)*column) (yOff + (s+off)*row)) (V2 s s)
        SDL.fillRect renderer $ Just rect
    SDL.present renderer

main :: IO ()
main = do
  SDL.initializeAll
  oldStdout <- hDuplicate stdout
  withFile "out.log" WriteMode $ \hLog -> do
    hDuplicateTo hLog stdout
    putStrLn "starting program"
    w <- SDL.createWindow "Hello" SDL.defaultWindow
    r <- SDL.createRenderer w (-1) SDL.defaultRenderer
    mainLoop r
    SDL.destroyRenderer r
    SDL.destroyWindow w
    putStrLn "stopping program"
  hDuplicateTo stdout oldStdout
