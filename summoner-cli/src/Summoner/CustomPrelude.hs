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

This module implements data type for representing custom alternative preludes.
-}

module Summoner.CustomPrelude
       ( CustomPrelude (..)
       , customPreludeT
       ) where

import Toml (Key, TomlCodec, (.=))

import Summoner.Text (moduleNameValid, packageNameValid)

import qualified Toml


data CustomPrelude = CustomPrelude
    { cpPackage :: !Text
    , cpModule  :: !Text
    } deriving stock (Show, Eq)

customPreludeT :: TomlCodec CustomPrelude
customPreludeT = CustomPrelude
    <$> textWithBool packageNameValid "package" .= cpPackage
    <*> textWithBool moduleNameValid  "module"  .= cpModule

-- | Codec for text values.
textWithBool :: (Text -> Bool) -> Key -> TomlCodec Text
textWithBool p = Toml.textBy id validateText
  where
    validateText :: Text -> Either Text Text
    validateText s =
        if p s
        then Right s
        else Left "Given Text doesn't pass the validation"
{-# INLINE textWithBool #-}
