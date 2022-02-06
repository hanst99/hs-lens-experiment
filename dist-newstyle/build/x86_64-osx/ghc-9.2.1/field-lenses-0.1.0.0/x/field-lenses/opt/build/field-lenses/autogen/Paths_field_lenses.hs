{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_field_lenses (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/hannessteffenhagen/.cabal/bin"
libdir     = "/Users/hannessteffenhagen/.cabal/lib/x86_64-osx-ghc-9.2.1/field-lenses-0.1.0.0-inplace-field-lenses"
dynlibdir  = "/Users/hannessteffenhagen/.cabal/lib/x86_64-osx-ghc-9.2.1"
datadir    = "/Users/hannessteffenhagen/.cabal/share/x86_64-osx-ghc-9.2.1/field-lenses-0.1.0.0"
libexecdir = "/Users/hannessteffenhagen/.cabal/libexec/x86_64-osx-ghc-9.2.1/field-lenses-0.1.0.0"
sysconfdir = "/Users/hannessteffenhagen/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "field_lenses_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "field_lenses_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "field_lenses_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "field_lenses_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "field_lenses_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "field_lenses_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
