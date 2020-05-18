{-# LANGUAGE QuasiQuotes #-}

{- |
Module                  : MODULE_NAME
Copyright               : (c) 2020 Kowainik
SPDX-License-Identifier : MPL-2.0
Maintainer              : Kowainik <xrom.xkov@gmail.com>
Stability               : Stable
Portability             : Portable

LONG_DESC
-}

{- |
Copyright: (c) 2017-2019 Kowainik
SPDX-License-Identifier: MPL-2.0
Maintainer: Kowainik <xrom.xkov@gmail.com>

This module contains some default values to use.
-}

module Summoner.Default
       ( defaultGHC
       , defaultCabal
       , defaultLicenseName
       , defaultOwner
       , defaultFullName
       , defaultEmail
       , defaultTomlFile
       , defaultConfigFile
       , defaultConfigFileContent
       , defaultDescription
       , currentYear
       ) where

import Data.Time (getCurrentTime, toGregorian, utctDay)
import NeatInterpolation (text)
import System.Directory (getHomeDirectory)
import System.FilePath ((</>))

import Summoner.GhcVer (GhcVer, showGhcVer)
import Summoner.License (LicenseName (MIT))


-- | Default GHC version is the latest available.
defaultGHC :: GhcVer
defaultGHC = maxBound

-- | Default version of the Cabal.
defaultCabal :: Text
defaultCabal = "2.4"

defaultLicenseName :: LicenseName
defaultLicenseName = MIT

defaultOwner :: Text
defaultOwner = "kowainik"

defaultFullName :: Text
defaultFullName = "Kowainik"

defaultEmail :: Text
defaultEmail = "xrom.xkov@gmail.com"

defaultTomlFile :: FilePath
defaultTomlFile = ".summoner.toml"

defaultConfigFile :: IO FilePath
defaultConfigFile = (</> defaultTomlFile) <$> getHomeDirectory

defaultDescription :: Text
defaultDescription = "See README for more info"

currentYear :: IO Text
currentYear = do
    now <- getCurrentTime
    let (year, _, _) = toGregorian $ utctDay now
    pure $ show year

{- | Default content of the @~/summoner.toml@ file to be generated by
the @summon config@ command.
-}
defaultConfigFileContent :: Text
defaultConfigFileContent = [text|
    # This file is automatically generated by Summoner.
    # Edit required fields, uncomment additional settings or delete irrelevant
    # lines for the personalized configuration.

    # GitHub user name
    owner = "$defaultOwner"

    # First and last name
    fullName = "$defaultFullName"

    # Email used at GitHub
    email = "$defaultEmail"

    # Default OSS license for your projects.
    # Run the 'summon show license' command to see the list of supported licenses.
    license = "$licenseName"

    # Create projects with the Cabal support
    # cabal = true

    # Create projects with the Stack support
    # stack = true

    # Should your projects have the library stanza by default?
    # lib = true

    # Should your projects have an executable stanza by default?
    # exe = true

    # Should your projects have the test-suite stanza by default?
    # test = true

    # Should your projects have the benchmark stanza by default?
    # bench = true

    # Summoner suports 'git' version control system and GitHub as a platform for
    # hosting 'git' repos. The following set of flags controls integration with GitHub.
    # github = true    # enabled GitHub integration
    # noUpload = true  # Init git repo, but don't create it on GitHub
    # private = true  # create private repos by default
    # gitignore =      # list of additional entries to be added in .gitignore
    #     [ "build"
    #     , "result"
    #     ]

    # Summoner supports various CI services. Uncomment those you want to use by default.
    # githubActions = true  # GitHub Actions CI
    # travis = true         # Travis CI
    # appveyor = true       # AppVeyor CI

    # List of additional GHC versions to support besides $defaultGhcVer.
    # Run the 'summon show ghc' command to see the list of all supported GHC versions.
    # ghcVersions = ["8.4.4", "8.6.5"]

    # List of default-extensions in the .cabal file
    # extensions = [ "ConstraintKinds"
    #              , "DeriveGeneric"
    #              , "GeneralizedNewtypeDeriving"
    #              , "InstanceSigs"
    #              , "KindSignatures"
    #              , "LambdaCase"
    #              , "OverloadedStrings"
    #              , "RecordWildCards"
    #              , "ScopedTypeVariables"
    #              , "StandaloneDeriving"
    #              , "TupleSections"
    #              , "TypeApplications"
    #              , "ViewPatterns"
    #              ]

    # List of additional files to add after creating the project
    # files =
    #     [ { path = ".stylish-haskell.yaml"
    #       , url  = "https://raw.githubusercontent.com/kowainik/org/master/.stylish-haskell.yaml"
    #       }
    #     , { path = ".github/CODEOWNERS"
    #       , raw  = "*  @$defaultOwner"
    #       }
    #     , { path  = "src/Foo.hs"
    #       , local = "/home/user/.default/Foo.hs"
    #       }
    #     ]

    # Alternative Prelude to be used instead of the default one if you prefer
    # [prelude]
    #     package = "relude"
    #     module  = "Relude"
|]
  where
    licenseName :: Text
    licenseName = show defaultLicenseName

    defaultGhcVer :: Text
    defaultGhcVer = showGhcVer defaultGHC
